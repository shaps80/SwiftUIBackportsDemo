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
    let title = "Scribble"
    let icon = "scribble.variable"

    var body: some View {
        VStack {
            List {
                Backport.Section("Backport") {
                    if #available(iOS 14, macOS 11, *) {
                        Backport.Label(title, systemImage: icon)
                            .backport.labelStyle(.titleOnly)
//
                        Backport.Label(title, systemImage: icon)
                            .backport.labelStyle(.iconOnly)
                    }

                    if #available(iOS 14, macOS 11, *) {
                        Backport.Label(title, systemImage: icon)
                            .backport.labelStyle(.titleAndIcon)
                    }

                    if #available(iOS 14, macOS 11, *) {
                        Backport.Label {
                            Text(title)
                        } icon: {
                            Image(systemName: icon)
                        }
                    }

                    if #available(iOS 14, macOS 11, *) {
                        Menu("Menu") {
                            Button {

                            } label: {
                                Backport.Label(title, systemImage: icon)
                            }
                        }
                    }
                }

                if #available(iOS 14, macOS 11, *) {
                    Backport.Section("Native") {
                        Label(title, systemImage: icon)
                            .labelStyle(.titleOnly)
                        Label(title, systemImage: icon)
                            .labelStyle(.iconOnly)

                        if #available(iOS 14.5, macOS 11.3, *) {
                            Label(title, systemImage: icon)
                                .labelStyle(.titleAndIcon)
                        }

                        Label {
                            Text(title)
                        } icon: {
                            Image(systemName: icon)
                        }

                        Menu("Menu") {
                            Button {

                            } label: {
                                Label(title, systemImage: icon)
                            }
                        }
                    }
                }
            }
#if os(iOS)
            .navigationBarItems(
                trailing:
                    HStack {
                        Button {

                        } label: {
                            Backport.Label(title, systemImage: icon)
                        }
                    }
            )
#endif
        }
    }
}
