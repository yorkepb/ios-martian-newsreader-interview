import SwiftUI
import Combine

actor ImageProvider {
    static let shared = ImageProvider()

    private var requests = [URL: Task<UIImage, Error>]()

    func image(for url: URL) async throws -> UIImage {
        if let task = requests[url] {
            return try await task.value
        } else {
            let task = Task {
                let (data, _) = try await URLSession.shared.data(from: url)
                guard let image = UIImage(data: data) else {
                    throw NSError(domain: "Invalid Image", code: 0)
                }
                return image
            }
            requests[url] = task
            defer {
                requests[url] = nil
            }
            return try await task.value
        }
    }
}

@MainActor
final class ImageLoader: ObservableObject {
    @Published var image: UIImage?

    func load(url: URL) {
        Task {
            self.image = try await ImageProvider.shared.image(for: url)
        }
    }
}

struct ImageView: View {
    let url: URL
    let size: CGSize
    let contentMode: ContentMode

    @StateObject
    private var loader = ImageLoader()

    init(url: URL, size: CGSize, contentMode: ContentMode = .fit) {
        self.url = url
        self.size = size
        self.contentMode = contentMode
    }

    init(image: Article.Image, contentMode: ContentMode = .fit) {
        self.init(url: image.url, size: image.size, contentMode: contentMode)
    }

    var body: some View {
        Group {
            if let loaderImage = loader.image {
                Image(uiImage: loaderImage)
                    .resizable()
            } else {
                let placeholder = Image(systemName: "photo")
                    .imageScale(.large)
                    .opacity(0.5)
                Color(UIColor.tertiarySystemFill)
                    .overlay(placeholder)
            }
        }
        .aspectRatio(size, contentMode: contentMode)
        .onAppear {
            loader.load(url: url)
        }
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView(image: Article.Image.mock)
    }
}
