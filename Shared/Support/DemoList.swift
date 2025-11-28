import SwiftUI
import SwiftUIBackports

public struct DemoList<Content: View>: View {
    public let content: Content

    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    public var body: some View {
        Backport.ForEach(subviewOf: content) { subview in
            subview
        }
    }
}
