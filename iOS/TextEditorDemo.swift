import SwiftUI
import SwiftUIBackports

struct TextEditorDemo: Demonstrable {
    @State private var text: String = """
    A longer piece of text that can displace itself across new lines as needed.
    The behaviour and properties should match similary to the official
    SwiftUI.TextEditor and act as a great backport. Note, not all features are supported.
    """

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Section {
                Backport.TextEditor(text: $text)
                    .frame(minHeight: 100)
                    .padding()
                    .backport.background {
                        RoundedRectangle(cornerRadius: 20, style: .continuous)
                            .foregroundColor(Color.primary.opacity(0.05))
                    }
            } header: {
                Text("Backport")
                    .font(.headline)
                    .foregroundColor(.secondary)
            }

            if #available(iOS 16, *) {
                Section {
                    TextEditor(text: $text)
                        .frame(minHeight: 100)
                        .padding()
                        .scrollContentBackground(.hidden)
                        .backport.background {
                            RoundedRectangle(cornerRadius: 20, style: .continuous)
                                .foregroundColor(Color.primary.opacity(0.05))
                        }
                } header: {
                    Text("Native")
                        .font(.headline)
                        .foregroundColor(.secondary)
                }
            }
        }
        .foregroundColor(.accentColor)
        .font(
            .system(.title, design: .serif)
            .italic()
            .weight(.black)
        )
        .lineSpacing(10)
        .multilineTextAlignment(.leading)
        .padding()
    }
}
