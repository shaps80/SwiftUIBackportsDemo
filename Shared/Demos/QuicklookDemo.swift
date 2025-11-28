import SwiftUI
import SwiftUIBackports
import Demo

@Demo
struct QuicklookDemo {
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
