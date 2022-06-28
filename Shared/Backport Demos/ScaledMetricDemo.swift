import SwiftUI
import SwiftUIBackports

#if !os(macOS)
struct ScaledMetricDemo: View {
    var body: some View {
        NavigationLink {
            DemoView()
        } label: {
            Text("ScaledMetric")
        }
    }
}

private struct DemoView: View {
    @State private var category: ContentSizeCategory = .large

    private var filtered: [ContentSizeCategory] {
        ContentSizeCategory.allCases.filter { !$0.isAccessibilityCategory }
    }

    var body: some View {
        List {
            Section {
                ForEach(filtered, id: \.self) { size in
                    Button {
                        category = size
                    } label: {
                        Text("\(String(describing: size))")
                            .checkmark(category == size ? .visible : .hidden)
                    }
                }
            } header: {
                ScalableView()
                    .environment(\.sizeCategory, category)
            }
        }
        .backport.navigationTitle("ScaledMetric")
    }

}

struct ScalableView: View {
    @Backport.ScaledMetric private var size: CGFloat = 17

    var body: some View {
        if #available(iOS 14, *) {
            text
                .textCase(.none)
                .font(.system(size: size))
        } else {
            text
        }
    }

    private var text: some View {
        Text("You can change your dynamic type size to see this text scale automatically.")
            .multilineTextAlignment(.center)
    }
}

private extension UIContentSizeCategory {
    static var all: [UIContentSizeCategory] {
        return [
            .accessibilityExtraExtraExtraLarge,
            .accessibilityExtraExtraLarge,
            .accessibilityExtraLarge,
            .accessibilityLarge,
            .accessibilityMedium,
            .extraExtraExtraLarge,
            .extraExtraLarge,
            .extraLarge,
            .large,
            .medium,
            .small,
            .extraSmall
        ]
    }
}
#endif
