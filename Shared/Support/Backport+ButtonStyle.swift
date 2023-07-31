import SwiftUI

extension ButtonStyle where Self == BackportStyle {
    static var backport: Self { .init() }
}

struct BackportStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            if #available(iOS 14, macOS 11, *) {
                Image(systemName: "curlybraces").foregroundColor(.accentColor)
            }
            configuration.label
        }
    }
}
