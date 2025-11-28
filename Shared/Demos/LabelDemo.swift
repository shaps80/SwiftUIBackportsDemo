import SwiftUI
import SwiftUIBackports

struct LabelDemo: Demonstrable {
    let title = "Person"
    let icon = "person.fill"

    var body: some View {
        VStack {
            List {
                Backport.Section("Backport") {
                    if #available(iOS 14, macOS 11, *) {
                        Menu("Menu") {
                            Button { } label: {
                                Backport.Label(title, systemImage: icon)
                            }
                        }

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
                    } else {
                        #if os(iOS)
                        Backport.Label(title, systemImage: icon)
                        #endif
                    }
                }
            }
            .toolbar(title: title, systemName: icon)
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
                }
            }
        }
        #else
        if #available(iOS 14, *) {
            toolbar {
                Button { } label: {
                    Backport.Label(title, systemImage: systemName)
                }
            }
        } else {
            navigationBarItems(
                trailing:
                    Button { } label: {
                        Backport.Label(title, systemImage: systemName)
                    }
            )
        }
        #endif
    }
}
