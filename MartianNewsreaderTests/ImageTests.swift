import XCTest
@testable import MartianNewsreader

final class ImageTests: XCTestCase {
    func testJSONDecoding() throws {
        let fileURL = try XCTUnwrap(Bundle(for: Self.self).url(forResource: "image", withExtension: "json"))
        
        let data = try Data(contentsOf: fileURL)
        let jsonDecoder = JSONDecoder()
        let image = try jsonDecoder.decode(Article.Image.self, from: data)

        XCTAssertNotNil(image)
        XCTAssertTrue(image.topImage)
        XCTAssertEqual(image.url.absoluteString, "https://s1.nyt.com/ios-newsreader/candidates/images/img1.jpg")
        XCTAssertEqual(image.width, 450)
        XCTAssertEqual(image.height, 284)
    }
}
