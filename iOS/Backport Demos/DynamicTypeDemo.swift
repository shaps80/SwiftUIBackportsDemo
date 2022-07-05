import SwiftUI
import SwiftUIBackports

struct DynamicTypeDemo: View {
    var body: some View {
        NavigationLink {
            Demo()
                .backport.navigationTitle("Dynamic Type")
        } label: {
            Text("Dynamic Type")
        }
    }
}

private struct Demo: View {
    @State private var isOverriden: Bool = false
    @State private var size: Backport.DynamicTypeSize = .large
    @State private var minSize: Backport.DynamicTypeSize = .xSmall
    @State private var maxSize: Backport.DynamicTypeSize = .accessibility5

    var body: some View {
        List {
            Section {
                ScalingText()
            }

            Section {
                Picker("Current Size", selection: $size) {
                    ForEach(Backport.DynamicTypeSize.allCases, id: \.self) { size in
                        Text(String(describing: size))
                            .tag(size)
                    }
                }

                Toggle("Override min/max", isOn: $isOverriden)

                HStack {
                    VStack {
                        Picker(selection: $minSize) {
                            ForEach(Backport.DynamicTypeSize.allCases, id: \.self) { size in
                                Text(String(describing: size))
                                    .tag(size)
                            }
                        } label: { }
                        .labelsHidden()

                        Text("Minimum")
                    }

                    Spacer()

                    VStack {
                        Picker(selection: $maxSize) {
                            ForEach(Backport.DynamicTypeSize.allCases, id: \.self) { size in
                                Text(String(describing: size))
                                    .tag(size)
                            }
                        } label: { }
                        .labelsHidden()

                        Text("Maximum")
                    }
                }
                .foregroundColor(.secondary)
                .font(.footnote)
            }
            .backport.dynamicTypeSize(.large)
        }
        .menuPickerStyle()
        .backport.dynamicTypeSize(isOverriden ? size : min(maxSize, max(minSize, size)))
        .backport.dynamicTypeSize(minSize...)
        .backport.dynamicTypeSize(...maxSize)
        .backport.dynamicTypeSize(size)
    }
}

private struct ScalingText: View {
    @Environment(\.backportDynamicTypeSize) private var size

    var body: some View {
        Text(String(describing: size))
            .backport.dynamicTypeSize(size)
    }
}
