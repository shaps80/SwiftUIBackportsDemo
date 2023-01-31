import SwiftUI
import SwiftUIBackports

struct ToolBarBackgroundDemo: View {
    @State private var showDemo: Bool = false
    @State private var showNative: Bool = false

    var body: some View {
        Button {
            showDemo = true
        } label: {
            Text("Toolbar Background")
        }
        .sheet(isPresented: $showDemo) {
            Demo()
        }

        if #available(iOS 16, macOS 13, *) {
            Button {
                showNative = true
            } label: {
                Text("Toolbar Background (Native)")
            }
            .sheet(isPresented: $showNative) {
                Native()
            }
        }
    }
}

private struct Demo: View {
    @Environment(\.backportDismiss) private var dismiss

    var body: some View {
        TabView {
            NavigationView {
                ScrollView {
                    Rectangle()
                        .foregroundColor(.primary.opacity(0.1))
                        .frame(height: 1000)
                }
                .backport.navigationTitle("Hidden")
                .backport.toolbar {
                    Backport.ToolbarItem(placement: .cancellationAction) {
                        Button {
                            dismiss()
                        } label: {
                            Text("Close")
                        }
                    }
                }
            }
            .tabItem {
                Text("Hidden")
            }

            NavigationView {
                List {
                    ForEach(0..<100, id: \.self) { index in
                        NavigationLink {
                            Text("Item \(index + 1)")
                                .navigationBarTitle(Text("Item"), displayMode: .inline)
                        } label: {
                            Text("Item \(index + 1)")
                        }
                    }
                }
                .backport.navigationTitle("Backport")
                .backport.toolbar {
                    Backport.ToolbarItem {
                        Button {
                            dismiss()
                        } label: {
                            Text("Close")
                        }
                    }
                }
            }
            .navigationViewStyle(.stack)
            .tabItem {
                Text("Red")
            }

            NavigationView {
                ScrollView {
                    Rectangle()
                        .foregroundColor(.primary.opacity(0.1))
                        .frame(height: 1000)
                }
                .navigationBarTitle(Text("Blue"), displayMode: .inline)
                .backport.toolbar {
                    Backport.ToolbarItem(placement: .principal) {
                        Button {
                            dismiss()
                        } label: {
                            Text("Close")
                        }
                    }
                }
            }
            .tabItem {
                Text("Blue")
            }
        }
    }
}

@available(iOS 16, macOS 13, *)
private struct Native: View {
    @Environment(\.backportDismiss) private var dismiss

    var body: some View {
        TabView {
            NavigationStack {
                List {
                    ForEach(0..<100, id: \.self) { index in
                        Text("Item \(index + 1)")
                    }
                }
                .toolbarBackground(.red, for: .navigationBar, .tabBar, .bottomBar)
                .toolbarBackground(.hidden, for: .tabBar)
                .navigationTitle("Native")
                .toolbar {
                    ToolbarItem(placement: .bottomBar) {
                        Button {

                        } label: {
                            Image(systemName: "circle")
                        }
                    }

                    ToolbarItem {
                        Button {
                            dismiss()
                        } label: {
                            Text("Close")
                        }
                    }
                }
            }
            .tabItem {
                Label("Backport", systemImage: "square")
            }
        }
    }
}
