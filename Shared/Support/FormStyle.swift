import SwiftUI

extension View {
    @ViewBuilder
    func formStyle() -> some View {
        if #available(iOS 16, macOS 13, *) {
            scrollContentBackground(.hidden)
                .background(.quaternary.opacity(0.3))
        } else {
            self
        }
    }
}
