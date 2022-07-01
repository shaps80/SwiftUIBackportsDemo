import SwiftUI
import SwiftUIBackports

struct ShareLinkDemo: View {
    var body: some View {
        NavigationLink {
            Demo()
                .backport.navigationTitle("ShareLink")
        } label: {
            Text("ShareLink")
        }
    }
}

private struct Demo: View {
    let url = URL(string: "https://github.com/shaps80/SwiftUIBackports")!

    var body: some View {
        List {
            Backport.Section("Backport") {
                Backport.ShareLink(item: url)
                Backport.ShareLink("SwiftUI Backports", items: ["SwiftUI Backports"])
            }

            #if os(iOS)
            if #available(iOS 16, *) {
                Backport.Section("Native") {
                    ShareLink(item: url)
                    ShareLink("SwiftUI Backports", items: ["SwiftUI Backports"])
                }
            }
            #endif
        }
        .toolbar(url: url)
    }
}

extension View {
    @ViewBuilder
    func toolbar(url: URL) -> some View {
        #if os(macOS)
        if #available(macOS 11, *) {
            toolbar {
                Backport.ShareLink(item: url)
                    .backport.labelStyle(.iconOnly)
            }
        }
        #else
        if #available(iOS 14, *) {
            toolbar {
                Backport.ShareLink(item: url)
                    .backport.labelStyle(.iconOnly)
            }
        } else {
            navigationBarItems(
                trailing:
                    Backport.ShareLink(item: url)
                        .backport.labelStyle(.iconOnly)
            )
        }
        #endif
    }
}

struct ShareLinkDemo_Previews: PreviewProvider {
    static var previews: some View {
        ShareLinkDemo()
    }
}
