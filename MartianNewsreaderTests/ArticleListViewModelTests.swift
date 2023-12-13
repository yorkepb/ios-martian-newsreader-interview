import XCTest
@testable import MartianNewsreader

@MainActor
final class ArticleListViewModelTests: XCTestCase {
    func testSuccess() async throws {
        var passedLanguage: Language?
        let sut = ArticleListViewModel(networkClient: .init(makeRequest: { language in
            passedLanguage = language
            return [Article.mock]
        }))

        XCTAssertEqual(sut.state, .initial)

        await sut.load(language: .english)

        XCTAssertEqual(passedLanguage, .english)
        XCTAssertEqual(sut.state, .articles([Article.mock]))
    }

    func testError() async throws {
        var passedLanguage: Language?
        let sut = ArticleListViewModel(networkClient: .init(makeRequest: { language in
            passedLanguage = language
            throw NSError(domain: "FakeNetworkDomain", code: 1729)
        }))

        XCTAssertEqual(sut.state, .initial)

        await sut.load(language: .english)

        XCTAssertEqual(passedLanguage, .english)
        XCTAssertEqual(sut.state, .error("The operation couldn’t be completed. (FakeNetworkDomain error 1729.)"))
    }
}
