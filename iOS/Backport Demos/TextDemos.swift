import SwiftUI
import SwiftUIBackports

@available(iOS 14, *)
struct TextDemos: View {
    var body: some View {
        NavigationLink {
            Demo()
        } label: {
            Text("Text Additions")
        }
    }
}

@available(iOS 14, *)
private struct Demo: View {
    @State private var textField: String = "TextField"
    @State private var backportEditor: String = "Backport TextEditor"
    @State private var textEditor: String = "iOS 16 TextEditor"

    var body: some View {
        Form {
            Section {
                TextField("Placeholder", text: $textField)
                    .backport.onSubmit {
                        print("Submitted")
                    }

                Backport.TextEditor(text: $backportEditor)

                if #available(iOS 16, *) {
                    TextEditor(text: $textEditor)
                }
            } footer: {
                Text("\nAdds the following features:\n\n").font(.body)
                + Text("- onSubmit\n").font(.system(.body, design: .monospaced))
                + Text("- submitLabel\n").font(.system(.body, design: .monospaced))
                + Text("- FocusState").font(.system(.body, design: .monospaced))
            }
        }
        .backport.submitLabel(.join)
        .backport.textInputAutocapitalization(.characters)
        .navigationTitle("Text Additions")
        .navigationBarTitleDisplayMode(.inline)
    }
}
