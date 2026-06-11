import SwiftUI
import SwiftUIBackports

struct Checkmark: ViewModifier {
    let visibility: Visibility
    func body(content: Content) -> some View {
        switch visibility {
        case .visible:
            HStack {
                content
                Spacer()
                Group {
                    if #available(iOS 14, macOS 11, *) {
                        Image(systemName: "checkmark")
                    } else {
                        Text("✓")
                    }
                }
                .foregroundColor(.accentColor)
                .font(.callout.weight(.semibold))
            }
        default:
            content
        }
    }
}

extension View {
    func checkmark(_ visibility: Visibility) -> some View {
        modifier(Checkmark(visibility: visibility))
    }
}
