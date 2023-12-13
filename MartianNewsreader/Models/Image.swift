import Foundation

extension Article {
    struct Image: Codable, Equatable {
        let topImage: Bool
        let url: URL
        let width, height: Int

        var size: CGSize {
            .init(width: width, height: height)
        }

        enum CodingKeys: String, CodingKey {
            case topImage = "top_image"
            case url, width, height
        }
    }
}

extension Article.Image {
    static let mock = Article.Image(topImage: true, url: URL(string: "https://s1.nyt.com/ios-newsreader/candidates/images/img1.jpg")!, width: 450, height: 284)
}
