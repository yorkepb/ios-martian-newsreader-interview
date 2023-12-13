import SwiftUI

struct ArticlesList: View {

    @StateObject var viewModel = ArticleListViewModel()

    @AppStorage(Language.appStorageKey) var language = Language.english

    var body: some View {
        List {
            switch viewModel.state {
            case let .articles(articles):
                articleRows(articles)
            case .initial:
                ProgressView()
                    .progressViewStyle(.circular)
                    .frame(maxWidth: .infinity)
            case let .error(message):
                Text(message)
            }
        }
        .navigationTitle(articlesString)
        .navigationBarItems(trailing: LanguagePicker())
        .task {
            await viewModel.load(language: language)
        }
        .refreshable {
            await viewModel.load(language: language)
        }
        .onChange(of: language) { newValue in
            Task {
                await viewModel.load(language: newValue)
            }
        }
    }

    func articleRows(_ articles: [Article]) -> some View {
        ForEach(articles) { article in
            NavigationLink(
                destination: ArticleDetailView(article: article)
            ) {
                VStack(alignment: .leading) {
                    Text(verbatim: article.title)
                    if let topImage = article.topImage {
                        ImageView(image: topImage)
                    }
                }
            }
        }
    }

    var articlesString: String {
        switch language {
        case .english:
            return "Articles"
        case .martian:
            return "Boinga"
        }
    }
}

struct ArticlesList_Previews: PreviewProvider {
    static var previews: some View {
        ArticlesList()
    }
}
