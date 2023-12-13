import Foundation
import SwiftUI

enum Language: String, CaseIterable, Equatable {
    case english
    case martian
}

extension Language {
    static let appStorageKey = "language"
}
