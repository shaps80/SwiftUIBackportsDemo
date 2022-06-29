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
    let url = URL(string: "https://picsum.photos/200/200")!
    @Backport.ScaledMetric private var padding: CGFloat = 5

    @MainActor
    var body: some View {
        if #available(iOS 15, *) {
            List {
//                Backport.Section("Backport") {
//                    Backport.ShareLink("URL with label", item: url)
//                    Backport.ShareLink("Text with label", item: "SwiftUI Backports")
//                    Backport.ShareLink(item: url)
//                    Backport.ShareLink(items: [url]) { item in
//                        Backport.SharePreview("Preview", icon: Image(systemName: "circle"))
//                    }
//                }
//
//                if #available(iOS 16, *) {
//                    Backport.Section("Native") {
//                        ShareLink("URL with label", item: url)
//                        ShareLink("Text with label", item: "SwiftUI Backports")
//                        ShareLink(item: url)
//                        ShareLink(items: ["Share Text"]) { item in
//                            SharePreview("Preview", icon: Image(systemName: "safari"))
//                        }
//                    }
//                }
            }
        }
    }
}
//
//struct BackportTest {
//    struct ImageDocumentLayer: BackportTransferable {
//        init(data: Data) throws { }
//
//        func data() -> Data { .init() }
//        func pngData() -> Data { .init() }
//
//        static var transferRepresentation: some BackportTransferRepresentation {
//            Backport.DataRepresentation(contentType: "") { layer in
//                layer.data()
//            } importing: { data in
//                try ImageDocumentLayer(data: data)
//            }
//
//            Backport.DataRepresentation(exportedContentType: "") { layer in
//                layer.pngData()
//            }
//        }
//    }
//}
//
//@available(iOS 16, *)
//struct NativeTest {
//    struct ImageDocumentLayer: Transferable {
//        init(data: Data) throws { }
//
//        func data() -> Data { .init() }
//        func pngData() -> Data { .init() }
//
//        static var transferRepresentation: some TransferRepresentation {
//            DataRepresentation(exportedContentType: "") { layer in
//                layer
//            }
//            DataRepresentation(contentType: .image) { layer in
//                layer.data()
//            } importing: { data in
//                try ImageDocumentLayer(data: data)
//            }
//
//            DataRepresentation(exportedContentType: .png) { layer in
//                layer.pngData()
//            }
//        }
//    }
//}
