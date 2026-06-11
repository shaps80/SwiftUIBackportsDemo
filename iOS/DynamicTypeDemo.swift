import SwiftUI
import SwiftUIBackports


struct DynamicTypeDemo: View {
    @State private var isOverriden: Bool = false
    @State private var size: DynamicTypeSize = .large
    @State private var minSize: DynamicTypeSize = .xSmall
    @State private var maxSize: DynamicTypeSize = .accessibility5

    var body: some View {
        List {
            Section {
                ScalingText()
            }

            Section {
                Picker("Current Size", selection: $size) {
                    ForEach(DynamicTypeSize.allCases, id: \.self) { size in
                        Text(String(describing: size))
                            .tag(size)
                    }
                }

                Toggle("Override min/max", isOn: $isOverriden)

                VStack {
                    VStack {
                        Picker(selection: $minSize) {
                            ForEach(DynamicTypeSize.allCases, id: \.self) { size in
                                Text(String(describing: size))
                                    .tag(size)
                            }
                        } label: { }
                        .labelsHidden()

                        Text("Minimum")
                        
                        Picker(selection: $maxSize) {
                            ForEach(DynamicTypeSize.allCases, id: \.self) { size in
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
            .dynamicTypeSize(.large)
        }
        .menuPickerStyle()
        .dynamicTypeSize(isOverriden ? size : min(maxSize, max(minSize, size)))
        .dynamicTypeSize(minSize...)
        .dynamicTypeSize(...maxSize)
        .dynamicTypeSize(size)
    }
}


private extension View {
    @ViewBuilder
    func menuPickerStyle() -> some View {
        if #available(iOS 14, macOS 11, *) {
            pickerStyle(.menu)
        } else {
            pickerStyle(.segmented)
        }
    }
}

private struct ScalingText: View {
    @Environment(\.dynamicTypeSize) private var size

    var body: some View {
        Text(String(describing: size))
            .dynamicTypeSize(size)
    }
}
