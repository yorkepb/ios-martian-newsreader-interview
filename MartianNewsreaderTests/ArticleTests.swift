import XCTest
@testable import MartianNewsreader

final class ArticleTests: XCTestCase {
    func testJSONDecoding() throws {
        let fileURL = try XCTUnwrap(Bundle(for: Self.self).url(forResource: "article", withExtension: "json"))

        let data = try Data(contentsOf: fileURL)
        let jsonDecoder = JSONDecoder()
        let article = try jsonDecoder.decode(Article.self, from: data)

        XCTAssertNotNil(article)
        XCTAssertEqual(article.id, "1")
        XCTAssertEqual(article.title, "Facebook plans to raise $10.6 billion in mega IPO ")
        XCTAssertTrue(article.body.hasPrefix("The eight-year-old social network"))
        XCTAssertEqual(article.images.count, 1)
    }
}
