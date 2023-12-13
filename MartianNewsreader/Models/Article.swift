import Foundation

struct Article: Codable, Identifiable, Equatable {
    var id: String
    var title: String
    var images: [Image]
    var body: String
}

extension Article {
    var topImage: Image? {
        images.first(where: { $0.topImage })
    }
}

extension Article {
    static let mock = Article(id: "1", title: "Facebook plans to raise $10.6 billion in mega IPO ", images: [Image.mock], body: "The eight-year-old social network that began as Mark Zuckerberg's Harvard dorm room project indicated an initial public offering price range of between $28 and $35 a share on Thursday, which would value the company at $77 billion to $96 billion.")
}
