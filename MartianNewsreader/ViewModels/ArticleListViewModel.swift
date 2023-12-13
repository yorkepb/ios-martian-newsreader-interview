import Foundation
import SwiftUI

@MainActor
final class ArticleListViewModel: ObservableObject {
    enum State: Equatable {
        case initial
        case articles([Article])
        case error(String)
    }

    @Published var state: State = .initial

    let networkClient: NetworkClient

    init(
        networkClient: NetworkClient = .live
    ) {
        self.networkClient = networkClient
    }

    func load(language: Language) async {
        do {
            let articles = try await networkClient.makeRequest(language)
            withAnimation {
                state = .articles(articles)
            }
        } catch {
            withAnimation {
                state = .error(error.localizedDescription)
            }
        }
    }
}
