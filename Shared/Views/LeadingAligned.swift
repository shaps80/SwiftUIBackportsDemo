import SwiftUI

extension View {
    func leadingAligned() -> some View {
        modifier(LeadingAligned())
    }
}

private struct LeadingAligned: ViewModifier {
    func body(content: Content) -> some View {
        HStack {
            content
            Spacer(minLength: 0)
        }
    }
}
