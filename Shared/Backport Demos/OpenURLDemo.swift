import SwiftUI
import SwiftUIBackports

@available(iOS 14, *)
struct OpenURLDemo: View {
    var body: some View {
        NavigationLink {
            Demo()
                .backport.navigationTitle("Open URL")
                .environment(\.backportOpenURL, .init { url in
                    switch url.host {
                    case "handled": return .handled
                    case "discarded": return .discarded
                    default: return .systemAction
                    }
                })
        } label: {
            Text("Open URL")
        }
    }
}

@available(iOS 14, *)
private struct Demo: View {
    @Environment(\.backportOpenURL) private var openURL
    @State private var showDiscarded: Bool = false
    @State private var showHandled: Bool = false

    var body: some View {
        List {
            Section {
                Button {
                    openURL(URL(string: "https://benkau.com")!)
                } label: {
                    Text("Shaps Benkau")
                }

                Button {
                    openURL(URL(string: "https://github.com/shaps80/SwiftUIBackports")!)
                } label: {
                    Text("SwiftUI Backports")
                }
            }

            Section {
                Button {
                    openURL(URL(string: "https://discarded")!) { accepted in
                        showDiscarded = !accepted
                    }
                } label: {
                    Text("Discarded")
                }
                .alert(isPresented: $showDiscarded) {
                    Alert(
                        title: Text("Discarded"),
                        message: Text("The action was discarded."),
                        dismissButton: .default(Text("OK"))
                    )
                }

                Button {
                    openURL(URL(string: "https://handled")!)
                    showHandled = true
                } label: {
                    Text("Handled")
                }
                .alert(isPresented: $showHandled) {
                    Alert(
                        title: Text("The action was intercepted by the app."),
                        message: Text("The action was intercepted by the app."),
                        dismissButton: .default(Text("OK"))
                    )
                }
            }
        }
    }
}
