import SwiftUI
import SwiftUIBackports

struct ScrollDismissDemo: View {
    var body: some View {
        NavigationLink {
            Demo()
                .backport.navigationTitle("Scroll Dismiss")
        } label: {
            Text("Scroll Dismiss")
        }
    }
}

private struct Demo: View {
    @State private var text: String = ""

    var body: some View {
        List {
            TextField("Placeholder", text: $text)
        }
        .backport.scrollDismissesKeyboard(.immediately)
    }
}
