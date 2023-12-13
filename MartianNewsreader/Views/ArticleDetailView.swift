import SwiftUI

struct ArticleDetailView: View {

    let article: Article

    @AppStorage(Language.appStorageKey) var language = Language.english
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text(article.title)
                    .font(.headline)
                if let topImage = article.topImage {
                    ImageView(image: topImage)
                        .accessibilityElement(children: .ignore)
                        .accessibilityLabel(photoString)
                }
                Text(article.body)
                    .font(.body)
            }.padding()
        }
        .navigationBarItems(trailing: LanguagePicker())
    }

    var photoString: String {
        switch language {
        case .english:
            return "Photo"
        case .martian:
            return "Boinga"
        }
    }
}

struct ArticleDetailView_Previews: PreviewProvider {

    static var previews: some View {
        HStack {
            ForEach(0..<Language.allCases.count, id: \.self) { languageIndex in
                NavigationView {
                    ArticleDetailView(
                        article: Article.mock
                    )
                }
            }
        }
        .previewLayout(.fixed(width: 640, height: 800))
    }
}
