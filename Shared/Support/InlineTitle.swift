import SwiftUI

extension View {
    nonisolated public func inlineTitle(_ title: some StringProtocol) -> some View {
        inlineTitle(.init(title))
    }

    @ViewBuilder
    nonisolated public func inlineTitle(_ title: Text) -> some View {
        if #available(iOS 17, tvOS 17, macOS 14, watchOS 10, *) {
            navigationTitle(title)
                .toolbarTitleDisplayMode(.inline)
        } else if #available(iOS 14, macOS 11, *) {
#if os(macOS)
            navigationTitle(title)
#else
            navigationTitle(title)
                .navigationBarTitleDisplayMode(.inline)
#endif
        } else {
#if os(macOS)
            navigationTitle(title)
#else
            navigationBarTitle(title, displayMode: .inline)
#endif
        }
    }
}
