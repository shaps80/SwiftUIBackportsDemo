import SwiftUI
import SwiftUIBackports

@available(iOS 14, *)
struct TextEditorDemo: View {
    var body: some View {
        NavigationLink {
            Demo()
                .backport.navigationTitle("Text Editor")
        } label: {
            Text("Text Editor")
        }
    }
}

@available(iOS 14, *)
private struct Demo: View {
    @State private var text: String = """
    A longer piece of text that can displace itself across new lines as needed.
    The behaviour and properties should match similary to the official
    SwiftUI.TextEditor and act as a great backport. Note, not all features are supported.
    """

    var body: some View {
        Backport.TextEditor(text: $text)
            .foregroundColor(.accentColor)
            .font(
                .system(.title, design: .serif)
                .italic()
                .leading(.loose)
                .weight(.black)
            )
            .lineSpacing(10)
            .multilineTextAlignment(.center)
    }
}
