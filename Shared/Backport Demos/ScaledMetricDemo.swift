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
    @State private var size: Backport.DynamicTypeSize = .large

    var body: some View {
        List {
            Section {
                ScalableView()
            }

            Section {
                ForEach(Backport.DynamicTypeSize.allCases, id: \.self) { size in
                    Button {
                        self.size = size
                    } label: {
                        Text("\(String(describing: size))")
                            .checkmark(self.size == size ? .visible : .hidden)
                    }
                }
            }
        }
        .backport.dynamicTypeSize(size)
        .backport.navigationTitle("ScaledMetric")
    }

}

private struct ScalableView: View {
    @Backport.ScaledMetric private var size: CGFloat = 17

    var body: some View {
        Text("You can change your dynamic type size to see this text scale automatically.")
            .multilineTextAlignment(.center)
    }
}
#endif
