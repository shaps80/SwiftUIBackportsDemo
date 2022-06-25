import SwiftUI
import SwiftUIBackports

struct Checkmark: ViewModifier {
    let visibility: Backport<Any>.Visibility
    func body(content: Content) -> some View {
        switch visibility {
        case .visible:
            HStack {
                content
                Spacer()
                Image(systemName: "checkmark")
                    .foregroundColor(.accentColor)
                    .font(.callout.weight(.semibold))
            }
        default:
            content
        }
    }
}

extension View {
    func checkmark(_ visibility: Backport<Any>.Visibility) -> some View {
        modifier(Checkmark(visibility: visibility))
    }
}
