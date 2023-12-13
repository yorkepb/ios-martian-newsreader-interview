import SwiftUI

struct LanguagePicker: View {
    
    @State private var presented: Bool = false

    @AppStorage(Language.appStorageKey) var language = Language.english

    var body: some View {
        Button(action: {
            presented = true
        }, label: {
            Image(systemName: "globe")
        })
        .sheet(isPresented: $presented) {
            NavigationView {
                VStack(spacing: 11.0) {
                    ForEach(Language.allCases, id: \.self) { thisLang in
                        Button(action: {
                            language = thisLang
                        }, label: {
                            Text(emoji(for: thisLang))
                        })
                        .padding()
                        .background(thisLang == language ? Color.red : Color.clear)
                        .cornerRadius(13.0)
                    }
                }
                .navigationTitle(navTitle)
                .navigationBarItems(trailing: Button(doneButtonTitle) {
                    presented = false
                })
            }
        }
    }

    var navTitle: String {
        switch language {
        case .english:
            return "Pick a language"
        case .martian:
            return "Boinga a boinga"
        }
    }

    var doneButtonTitle: String {
        switch language {
        case .english:
            return "Done"
        case .martian:
            return "Boinga"
        }
    }

    var saveButtonTitle: String {
        switch language {
        case .english:
            return "Save"
        case .martian:
            return "Boinga"
        }
    }

    func emoji(for lang: Language) -> String {
        switch lang {
        case .english:
            return "🌏"
        case .martian:
            return "🪐"
        }
    }
}

struct LanguagePicker_Previews : PreviewProvider {
    @State static var language = Language.martian
    static var previews: some View {
        LanguagePicker()
    }
}
