import SwiftUI

@main
struct MartianNewsreaderApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ArticlesList()
            }
            .navigationViewStyle(.columns)
        }
    }
}
