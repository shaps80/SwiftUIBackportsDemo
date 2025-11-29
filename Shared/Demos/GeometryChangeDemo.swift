import SwiftUI
import SwiftUIBackports

struct GeometryChangeDemo: View {
    @State private var text: String = ""
    @State private var size: CGSize = .zero

    var body: some View {
        List {
            if #available(iOS 16, tvOS 16, macOS 13, watchOS 10, *) {
                TextField("Write here", text: $text, axis: .vertical)
            } else {
                TextField("Write here", text: $text)
            }

            Backport.LabeledContent("Size", value: "\(Int(size.width))x\(Int(size.height))")

            Text(text).foregroundColor(.secondary)
                .backport.onGeometryChange(for: CGSize.self) { proxy in
                    proxy.size
                } action: { _, newValue in
                    size = newValue
                }
        }
    }
}
