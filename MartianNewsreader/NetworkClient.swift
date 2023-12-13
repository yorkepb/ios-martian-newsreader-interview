import Foundation
import Combine

struct NetworkClient {
    static let live = NetworkClient(makeRequest: { language in
        let (data, _) = try await URLSession.shared.data(from: language.articlesURL)
        return try JSONDecoder().decode([Article].self, from: data)
    })

    let makeRequest: (Language) async throws -> [Article]
}

private extension Language {
    static var englishURL = URL(string: "https://gist.githubusercontent.com/ZevEisenberg/8e11206b276a491d0074d86ef519f1bd/raw/6349ba05144fc8400d13f95fe0737c729191109c/English.json")!
    static var martianURL = URL(string: "https://gist.githubusercontent.com/ZevEisenberg/8e11206b276a491d0074d86ef519f1bd/raw/6349ba05144fc8400d13f95fe0737c729191109c/Martian.json")!

    var articlesURL: URL {
        switch self {
        case .english:
            return Language.englishURL
        case .martian:
            return Language.martianURL
        }
    }
}
