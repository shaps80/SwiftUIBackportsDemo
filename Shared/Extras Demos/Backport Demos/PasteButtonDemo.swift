import SwiftUI
import SwiftUIBackports
import CoreServices

#if os(iOS)
struct PasteButtonDemo: View {
    var body: some View {
        NavigationLink {
            DemoView()
        } label: {
            if #available(iOS 14, macOS 11, *) {
                Image(systemName: "curlybraces").foregroundColor(.accentColor)
            }
            Text("PasteButton")
        }
    }
}

private struct DemoView: View {
    @State private var text: String = ""

    var body: some View {
        List {
            Backport.Section("TextField") {
                TextField("", text: $text)
            }

            if #available(iOS 14, *) {
                Backport.Section("Backport") {
                    Backport.PasteButton(supportedContentTypes: [String(kUTTypeText)]) { providers in
                        Task {
                            do {
                                text = try await providers.first?.loadObject(of: String.self) ?? ""
                            }
                        }
                    }
                    
                    button
                }
            }

            if #available(iOS 16, macOS 13, *) {
                Backport.Section("Test") {
                    HStack {
                        Button {
                            text = ""
                            UIPasteboard.general.string = "Shaps Benkau"
                        } label: {
                            Label("Copy", systemImage: "doc.on.doc")
                        }
                        .buttonBorderShape(.roundedRectangle)
                        .buttonStyle(.borderedProminent)

                        PasteButton(payloadType: String.self) { strings in
                            text = strings[0]
                        }

                        Button("Clear") {
                            text = ""
                            UIPasteboard.general.string = nil
                        }
                        .buttonBorderShape(.roundedRectangle)
                        .buttonStyle(.borderedProminent)
                    }
                }
            }
        }
        .backport.navigationTitle("PasteButton")
        .navigationBarItems(trailing: button)
    }

    @ViewBuilder
    private var button: some View {
        Backport.PasteButton(payloadType: String.self) { strings in
            text = strings[0]
        }
    }
}
#endif
