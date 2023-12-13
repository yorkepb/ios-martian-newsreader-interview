import XCTest
import Combine
@testable import MartianNewsreader

final class NetworkClientTests: XCTestCase {
    var sut: NetworkClient!

    override func setUpWithError() throws {
        sut = NetworkClient(makeRequest: { language in
            let fileURL: URL
            switch language {
            case .english:
                fileURL = URL(fileURLWithPath: try XCTUnwrap(Bundle(for: Self.self).path(forResource: "articles-response-english", ofType: "json")))
            case .martian:
                fileURL = URL(fileURLWithPath: try XCTUnwrap(Bundle(for: Self.self).path(forResource: "articles-response-martian", ofType: "json")))
            }
            let (data, _) = try await URLSession.shared.data(from: fileURL)
            return try JSONDecoder().decode([Article].self, from: data)
        })
    }

    func testEnglishArticles() async throws {
        let articles = try await sut.makeRequest(.english)
        XCTAssertEqual(articles.count, 3)

        let articleOne = try XCTUnwrap(articles.first)
        XCTAssertEqual(articleOne.title, "Facebook plans to raise $10.6 billion in mega IPO ")
    }

    func testMartianArticles() async throws {
        let articles = try await sut.makeRequest(.martian)
        XCTAssertEqual(articles.count, 3)

        let articleOne = try XCTUnwrap(articles.first)
        XCTAssertEqual(articleOne.title, "Boinga boinga to boinga $10.6 boinga in boinga IPO ")
    }
}
