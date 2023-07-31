import SwiftUI
import SwiftUIBackports

struct LinkDemo: View {
    var body: some View {
        NavigationLink {
            Demo()
                .backport.navigationTitle("Link")
        } label: {
            if #available(iOS 14, macOS 11, *) {
                Image(systemName: "curlybraces").foregroundColor(.accentColor)
            }
            Text("Link")
        }
    }
}

private struct Demo: View {
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
