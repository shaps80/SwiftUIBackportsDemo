import SwiftUI
import SwiftUIPlus

struct WebViewDemo: View {
    var body: some View {
        NavigationLink {
            Demo()
#if os(iOS)
                .navigationBarTitle(Text("Web View"), displayMode: .inline)
#endif
        } label: {
            if #available(iOS 14, macOS 11, *) {
                Image(systemName: "curlybraces").foregroundColor(.accentColor)
            }
            Text("Web View")
        }
    }
}

#if os(iOS)
private struct Demo: View {
    @State private var url: URL = .init(string: "https://github.com/shaps80/SwiftUIBackports")!
//    @State private var url: URL = .init(string: "https://benkau.com")!
    var body: some View {
        Text("TBD")
//        WebView(url: $url)
//            .navigationBarHidden(true)
    }
}
#else
private struct Demo: View {
    var body: some View {
        Text("TBD")
    }
}
#endif
