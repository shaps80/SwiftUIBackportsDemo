import SwiftUI
import SwiftUIBackports

struct ShareLinkDemo: Demonstrable {
    var body: some View {
        List {
            Backport.ShareLink(item: "Can I share this?") {
                VStack {
#if os(macOS)
                    if #available(macOS 11, *) {
                        Image(systemName: "globe")
                            .imageScale(.large)
                            .foregroundColor(.accentColor)
                    }
#endif
                    Text("Hello, world!")
                }
            }
            .buttonStyle(.plain)

            Backport.ShareLink(item: "Some text to share")
            Backport.ShareLink("Benkau", item: URL(string: "https://benkau.com")!)
        }
    }
}
