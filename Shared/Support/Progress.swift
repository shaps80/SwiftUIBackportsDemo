import SwiftUI
import SwiftUIBackports

struct Progress: View {
    let visibility: Visibility

    var body: some View {
        if visibility == .visible {
            ProgressView()
                .progressViewStyle(.linear)
        }
    }
}

private struct ProgressModifier: ViewModifier {
    let visibility: Visibility

    func body(content: Content) -> some View {
        switch visibility {
        case .visible:
            HStack {
                content
                Spacer()
                Progress(visibility: visibility)
            }
        default:
            content
        }
    }
}

extension View {
    func progress(_ visibility: Visibility) -> some View {
        modifier(ProgressModifier(visibility: visibility))
    }
}
