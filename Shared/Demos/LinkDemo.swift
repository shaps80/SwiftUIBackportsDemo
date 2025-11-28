import SwiftUI
import SwiftUIBackports
import Demo

@Demo
struct LinkDemo {
    var body: some View {
        List {
            Backport.Link("Shaps Benkau", destination: URL(string: "https://benkau.com")!)
                .environment(\.backportOpenURL, Backport.OpenURLAction { url in
                    print("Open \(url)")
                    return .systemAction
                })

            if #available(iOS 14, macOS 11, *) {
                Section {
                    SwiftUI.Link("Shaps Benkau", destination: URL(string: "https://benkau.com")!)
                } header: {
                    Text("Native")
                }
            }
        }
    }
}
