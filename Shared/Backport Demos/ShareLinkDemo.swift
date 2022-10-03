import SwiftUI
import SwiftUIBackports

struct ShareLinkDemo: View {
    var body: some View {
        NavigationLink {
            DemoView()
        } label: {
            Text("ShareLink")
        }
    }
}

private struct DemoView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 40) {
                Backport.ShareLink(item: "Can I share this?") {
                    VStack {
                        Image(systemName: "globe")
                            .imageScale(.large)
                            .foregroundColor(.accentColor)
                        Text("Hello, world!")
                    }
                }
                .buttonStyle(.plain)

                Backport.ShareLink(item: "Some text to share")
                Backport.ShareLink("Benkau", item: URL(string: "https://benkau.com")!)
            }
            .frame(maxWidth: .infinity)
            .padding(20)
        }
        .backport.navigationTitle("Sharing")
        #if os(iOS)
        .navigationBarItems(trailing: Backport.ShareLink(item: URL(string: "https://benkau.com")!))
        #endif
    }
}
