import SwiftUI
import SwiftUIBackports
import SafariServices
import Demo

@Demo
struct OpenURLDemo {
    @Environment(\.backportOpenURL) private var openURL
    @State private var showDiscarded: Bool = false
    @State private var showHandled: Bool = false

    var body: some View {
        List {
            Backport.Section("Backports") {
                Button {
                    openURL(URL(string: "https://benkau.com")!)
                } label: {
                    Text("Shaps Benkau")
                }

                if #available(iOS 15, tvOS 15, macOS 12, watchOS 8, *) {
                    Backport.Link("In-app Safari", destination: URL(string: "https://github.com/shaps80/SwiftUIBackports")!)
                        .environment(\.backportOpenURL, .init { url in
#if os(iOS)
                                .safari(url) { config in
                                    config.tintColor = .red
                                    config.dismissStyle = .close
                                    config.prefersReader = true
                                    config.barCollapsingEnabled = false
                                }
#else
                                .systemAction
#endif
                        })
                }

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

            if #available(iOS 15, macOS 11, *) {
                Section {
                    Link("Backports", destination: URL(string: "https://github.com/shaps80/SwiftUIPlus")!)
#if os(iOS)
                        .environment(\.backportOpenURL, .init { url in
                                .safari(url) { config in
                                    config.tintColor = .red
                                    config.dismissStyle = .close
                                    config.prefersReader = true
                                    config.barCollapsingEnabled = false
                                }
                        })
#endif
                }
            }
        }
    }
}
