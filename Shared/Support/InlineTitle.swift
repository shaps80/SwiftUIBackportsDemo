import SwiftUI

extension View {
    nonisolated public func inlineTitle(_ title: some StringProtocol) -> some View {
        inlineTitle(.init(title))
    }

    @ViewBuilder
    nonisolated public func inlineTitle(_ title: Text) -> some View {
        if #available(iOS 14, macOS 11, *) {
            navigationTitle(title)
                .navigationBarTitleDisplayMode(.inline)
        } else {
            navigationBarTitle(title, displayMode: .inline)
        }
    }
}
