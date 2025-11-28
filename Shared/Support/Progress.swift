import SwiftUI
import SwiftUIBackports

struct Progress: View {
    let visibility: Backport<Any>.Visibility

    var body: some View {
        if visibility == .visible {
            Backport.ProgressView()
                .backport.progressViewStyle(.linear)
        }
    }
}

private struct ProgressModifier: ViewModifier {
    let visibility: Backport<Any>.Visibility

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
    func progress(_ visibility: Backport<Any>.Visibility) -> some View {
        modifier(ProgressModifier(visibility: visibility))
    }
}
