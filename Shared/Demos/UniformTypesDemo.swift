import SwiftUI
import SwiftUIBackports
import UniformTypeIdentifiers

struct UniformTypesDemo: Demonstrable {
    // Registered in plist
    let foo = Backport<Any>.UTType(exportedAs: "com.benkau.foo")
    let bar = Backport<Any>.UTType(importedAs: "com.benkau.bar")

    private var custom: [Backport<Any>.UTType] {
        [foo, bar]
    }

    var body: some View {
        List {
            Section {
                section(from: custom)
            } header: {
                Text("Custom")
            }

            Section {
                section(from: Array(Backport.UTType.declared))
            } header: {
                Text("Declared")
            }
        }
    }

    func section(from list: [Backport<Any>.UTType]) -> some View {
        ForEach(list, id: \.identifier) { type in
            NavigationLink {
                TypeDetailView(type: type)
            } label: {
                Backport.Label {
                    Text(type.localizedDescription ?? type.identifier)
                        .lineLimit(1)
                } icon: {
                    #if os(iOS)
                    Image(systemName: type.systemImage)
                        .foregroundColor(.accentColor)
                        .frame(minWidth: 25)
                    #else
                    if #available(macOS 11, *) {
                        Image(systemName: type.systemImage)
                            .foregroundColor(.accentColor)
                            .frame(minWidth: 25)
                    }
                    #endif
                }
            }
        }
    }
}

struct TypeDetailView: View {
    var type: Backport<Any>.UTType

    var body: some View {
        List {
            Section {
                LabeledContent("Identifier") {
                    Text(type.identifier)
                }

                if let preferred = type.preferredFilenameExtension {
                    LabeledContent("Extension") {
                        Text(preferred)
                    }
                }

                if let preferred = type.preferredMIMEType {
                    LabeledContent("MIME Type") {
                        Text(preferred)
                    }
                }

                if !type.supertypes.isEmpty {
                    LabeledContent("Super Types") {
                        Text(type.supertypes.map { $0.identifier }.joined(separator: ", "))
                    }
                }

                LabeledContent("Declared", isOn: type.isDeclared)
                LabeledContent("Dynamic", isOn: type.isDynamic)
            } header: {
                Text("Backport")
            }
        }
        .backport.navigationTitle(type.localizedDescription ?? type.identifier)
    }
}

struct LabeledContent: View {
    var body: AnyView
}

extension LabeledContent {
    init<Content: View>(_ title: String, @ViewBuilder content: () -> Content) {
        body = AnyView(
            VStack(alignment: .leading, spacing: 5) {
                Text(title)
                    .foregroundColor(.secondary)
                content()
            }
                .padding(.vertical, 5)
        )
    }

    init(_ title: String, url: URL?) {
        self.init(title) {
            Text(url?.absoluteString ?? "None")
        }
    }

    init(_ title: String, isOn: Bool) {
        body = AnyView(
            HStack {
                Text(title)
                    .foregroundColor(.secondary)
                Spacer()
                Toggle("", isOn: .constant(isOn))
                    .toggleStyle(.checkmark)
                    .labelsHidden()
            }
        )
    }
}

struct CheckmarkStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 2)

            if configuration.isOn {
                Circle()
                    .padding(3)
            }
        }
        .frame(width: 20, height: 20)
        .foregroundColor(.secondary)
    }
}
extension ToggleStyle where Self == CheckmarkStyle {
    static var checkmark: Self { .init() }
}
