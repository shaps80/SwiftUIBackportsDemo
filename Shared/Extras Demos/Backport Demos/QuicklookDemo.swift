import SwiftUI
import SwiftUIBackports

struct QuicklookDemo: View {
    var body: some View {
        NavigationLink {
            Demo()
                .backport.navigationTitle("Quicklook")
        } label: {
            Text("Quicklook")
        }
    }
}

private struct Demo: View {
    @State private var nativeUrl: URL?
    @State private var nativeSelection: URL?

    @State private var url: URL?
    @State private var selection: URL?
    let urls = Bundle.main.quicklookUrls

    var body: some View {
        List {
            Backport.Section("Backport") {
                Button {
                    url = urls.randomElement()!
                } label: {
                    Text("Quicklook URL")
                }
                .backport.quickLookPreview($url)

                Button {
                    selection = urls.randomElement()!
                } label: {
                    Text("Quicklook Collection")
                }
                .backport.quickLookPreview($selection, in: urls)
            }
        }
    }
}

extension Bundle {
    var quicklookUrls: [URL] {
        urls(forResourcesWithExtension: "jpg", subdirectory: nil)?
            .sorted(by: { $0.lastPathComponent < $1.lastPathComponent })
        ?? []
    }
}
