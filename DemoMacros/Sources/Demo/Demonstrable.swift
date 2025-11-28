import SwiftUI

public protocol Demonstrable: View {
    init()
}

public struct Demo<Content: Demonstrable>: View {
    private var title: Text

    public init(_ content: Content.Type) {
        let title = String(describing: Content.self)
        self.title = Text(title.dropLast(title.hasSuffix("Demo") ? 4 : 0))
    }

    public var body: some View {
        NavigationLink {
            Content()
                .inlineTitle(title)
        } label: {
            title
        }
    }
}
