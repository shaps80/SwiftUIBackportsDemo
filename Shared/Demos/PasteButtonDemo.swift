import SwiftUI
import SwiftUIBackports
import CoreServices

#if os(iOS)
struct PasteButtonDemo: Demonstrable {
    @State private var text: String = ""

    var body: some View {
        List {
            Backport.Section("TextField") {
                TextField("", text: $text)
            }

            if #available(iOS 14, *) {
                Backport.Section("Backport") {
                    HStack {
                        Backport.PasteButton(supportedContentTypes: [String(kUTTypeText)]) { providers in
                            Task {
                                do {
                                    text = try await providers.first?.loadObject(of: String.self) ?? ""
                                }
                            }
                        }

                        PasteAsStringButton()
                    }
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
                                .foregroundColor(.white)
                                .imageScale(.small)
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
        .navigationBarItems(trailing: PasteAsStringButton())
    }

    @ViewBuilder
    private func PasteAsStringButton() -> some View {
        Backport.PasteButton(payloadType: String.self) { strings in
            text = strings[0]
        }
    }
}
#endif
