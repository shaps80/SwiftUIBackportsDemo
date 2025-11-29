import SwiftUI

public protocol Demonstrable: View { }

public struct Demo<Content: View>: View {
    private var title: Text
    let content: () -> Content

    public init(@ViewBuilder _ content: @escaping () -> Content) {
        let title = String(describing: Content.self)
        self.title = Text(title.dropLast(title.hasSuffix("Demo") ? 4 : 0))
        self.content = content
    }

    public var body: some View {
        NavigationLink {
            content()
                .inlineTitle(title)
        } label: {
            title
        }
    }
}
