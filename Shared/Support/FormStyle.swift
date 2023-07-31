import SwiftUI

extension View {
    @ViewBuilder
    func formStyle() -> some View {
        if #available(iOS 16, macOS 13, *) {
            scrollContentBackground(.hidden)
                .background(.quaternary.opacity(0.3))
                .listStyle(.sidebar)
        } else if #available(iOS 14, macOS 11, *) {
            listStyle(.sidebar)
        } else {
            self
        }
    }
}
