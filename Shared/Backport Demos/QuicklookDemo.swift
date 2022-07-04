import SwiftUI
import SwiftUIBackports
import QuickLook

@available(iOS 14, macOS 11, *)
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

@available(iOS 14, macOS 11, *)
private struct Demo: View {
    @State private var url: URL?
    @State private var selection: URL?
    let urls = Bundle.main.quicklookUrls

    var body: some View {
        List {
            Button {
                url = urls.randomElement()!
            } label: {
                Text("Quicklook URL")
            }
            .quickLookPreview($url)

            Button {
                selection = urls.first
            } label: {
                Text("Quicklook Collection")
            }
        }
        .quickLookPreview($selection, in: urls)
    }
}

extension Bundle {
    var quicklookUrls: [URL] {
        urls(forResourcesWithExtension: "jpg", subdirectory: nil)?
            .sorted(by: { $0.lastPathComponent < $1.lastPathComponent })
        ?? []
    }
}
