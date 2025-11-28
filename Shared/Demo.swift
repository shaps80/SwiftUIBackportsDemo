import SwiftUI

protocol Demonstrable: View {
    init()
}

struct Demo<Content: Demonstrable>: View {
    private var title: Text

    init(_ content: Content.Type) {
        let title = String(describing: Content.self)
        self.title = Text(title.dropLast(title.hasSuffix("Demo") ? 4 : 0))
    }

    var body: some View {
        NavigationLink {
            Content()
                .inlineTitle(title)
        } label: {
            title
        }
    }

}
