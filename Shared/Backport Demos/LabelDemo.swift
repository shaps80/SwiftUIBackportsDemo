import SwiftUI
import SwiftUIBackports

struct LabelDemo: View {
    var body: some View {
        NavigationLink {
            Demo()
                .backport.navigationTitle("Label")
        } label: {
            Text("Label")
        }
    }
}

private struct Demo: View {
    let title = "Person"
    let icon = "person.fill"

    var body: some View {
        VStack {
            List {
                Backport.Section("Backport") {
                    backports

                    if #available(iOS 14, macOS 11, *) {
                        Menu("Menu") {
                            Button {

                            } label: {
                                Backport.Label(title, systemImage: icon)
                            }
                        }
                    }
                }
            }
            .toolbar(title: title, systemName: icon)
        }
    }

    @available(iOS 13, macOS 11, *)
    @ViewBuilder
    private var backports: some View {
        Backport.Label(title, systemImage: icon)
            .backport.labelStyle(.titleOnly)

        Backport.Label(title, systemImage: icon)
            .backport.labelStyle(.iconOnly)

        Backport.Label(title, systemImage: icon)
            .backport.labelStyle(.titleAndIcon)

        Backport.Label {
            Text("Custom title and icon")
                .foregroundColor(.accentColor)
        } icon: {
            Image(systemName: icon)
                .foregroundColor(.secondary)
        }
    }
}

extension View {
    @ViewBuilder
    func toolbar(title: String, systemName: String) -> some View {
        #if os(macOS)
        if #available(macOS 11, *) {
            toolbar {
                Button { } label: {
                    Backport.Label(title, systemImage: systemName)
                        .backport.labelStyle(.iconOnly)
                }
            }
        }
        #else
        if #available(iOS 14, *) {
            toolbar {
                Button { } label: {
                    Backport.Label(title, systemImage: systemName)
                        .backport.labelStyle(.iconOnly)
                }
            }
        } else {
            navigationBarItems(
                trailing:
                    Button { } label: {
                        Backport.Label(title, systemImage: systemName)
                            .backport.labelStyle(.iconOnly)
                    }
            )
        }
        #endif
    }
}
