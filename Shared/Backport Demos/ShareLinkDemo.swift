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
                ShareLink(item: "Can I share this?") {
                    VStack {
                        Image(systemName: "globe")
                            .imageScale(.large)
                            .foregroundColor(.accentColor)
                        Text("Hello, world!")
                    }
                }
                .buttonStyle(.plain)

                ShareLink(item: "Some text to share")

                ShareLink("Benkau", item: URL(string: "https://benkau.com")!)

                ShareLink(item: "", preview: SharePreview("Nice one!"))

                ShareLink(
                    item: Image(systemName: "circle.fill"),
                    preview: SharePreview(
                        "Preview",
                        image: Image(systemName: "circle"),
                        icon: Image(systemName: "square")
                    )
                ) {
                    Backport.Label("Custom label", systemImage: "arrow.up")
                }
            }
            .frame(maxWidth: .infinity)
            .padding(20)
        }
        .backport.navigationTitle("Sharing")
        #if os(iOS)
        .navigationBarItems(trailing: ShareLink(item: URL(string: "https://benkau.com")!))
        #endif
    }
}
