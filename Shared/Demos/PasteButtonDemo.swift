import SwiftUI
import SwiftUIBackports

import UniformTypeIdentifiers
import CoreServices

#if os(iOS)


struct PasteButtonDemo: View {
    @State private var text: String = ""

    var body: some View {
        List {
            Section("TextField") {
                TextField("", text: $text)
            }

            Section("Backport") {
                HStack {
                    Backport.PasteButton(supportedContentTypes: [UTType.text]) { providers in
                        providers.first?.loadObject(ofClass: NSString.self) { value, _ in
                            let string = value as? String ?? (value as? NSString).map(String.init) ?? ""

                            DispatchQueue.main.async {
                                text = string
                            }
                        }
                    }

                    PasteAsStringButton()
                }
            }

            if #available(iOS 16, macOS 13, *) {
                Section("Test") {
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
        .navigationTitle("PasteButton")
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
