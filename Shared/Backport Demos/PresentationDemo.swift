import SwiftUI
import SwiftUIBackports

#if os(iOS)
@available(iOS 14, *)
struct PresentationDemo: View {

    @State private var showSheet: Bool = false

    var body: some View {
        Button {
            showSheet = true
        } label: {
            Text("Presentation")
        }
        .sheet(isPresented: $showSheet) {
            DemoView()
        }
    }

}

@available(iOS 14, *)
private struct DemoView: View {
    @Environment(\.presentationMode) private var presentation

    @State private var selection: Backport.PresentationDetent = .medium
    @State private var visible: Backport.Visibility = .hidden
    @State private var detents: Set<Backport.PresentationDetent> = [.medium, .large]
    @State private var isModal: Bool = false
    @State private var enablePrompt: Bool = true
    @State private var showPrompt: Bool = false
    @State private var undimmedDetent: Backport<Any>.PresentationDetent?

    var body: some View {
        NavigationView {
            List {
                Section {
                    Button {
                        visible = visible == .hidden ? .visible : .hidden
                    } label: {
                        Text(visible == .visible ? "Hide Grabber" : "Show Grabber")
                    }

                    Button {
                        selection = selection == .medium ? .large : .medium
                    } label: {
                        Text(selection == .medium ? "Expand" : "Collapse")
                    }
                    .disabled(detents.count == 1)

                    Button {
                        undimmedDetent = undimmedDetent == .medium ? nil : .medium
                    } label: {
                        Text("Passthrough")
                            .checkmark(undimmedDetent != nil ? .visible : .hidden)
                    }
                }

                Section {
                    Button {
                        detents = [.large]
                        selection = .large
                    } label: {
                        Text("Expanded Only")
                            .checkmark(detents == [.large] ? .visible : .hidden)
                    }

                    Button {
                        detents = [.medium]
                        selection = .medium
                    } label: {
                        Text("Collapsed Only")
                            .checkmark(detents == [.medium] ? .visible : .hidden)
                    }

                    Button {
                        detents = [.medium, .large]
                    } label: {
                        Text("Both")
                            .checkmark(detents == [.medium, .large] ? .visible : .hidden)
                    }
                }

                Section {
                    Button {
                        withAnimation { isModal.toggle() }
                    } label: {
                        Text("Modal")
                            .checkmark(isModal ? .visible : .hidden)
                    }

                    if isModal {
                        Button {
                            enablePrompt.toggle()
                        } label: {
                            Text("Prompt on Dismiss")
                                .checkmark(enablePrompt ? .visible : .hidden)
                        }
                    }
                }
            }
            .listStyle(.insetGrouped)
            .backport.navigationTitle("Sheet")
            .navigationBarItems(trailing: Button {
                presentation.wrappedValue.dismiss()
            } label: {
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(.primary)
            })
        }
        .backport.presentationDragIndicator(visible)
        .backport.presentationDetents(detents, selection: $selection, largestUndimmedDetent: undimmedDetent)
        .backport.interactiveDismissDisabled(isModal) {
            if enablePrompt { showPrompt = true }
        }
        .actionSheet(isPresented: $showPrompt, content: {
            ActionSheet(title: Text("Dismiss"), buttons: [
                .default(Text("OK")) {
                    presentation.wrappedValue.dismiss()
                },
                .cancel()
            ])
        })
    }
}
#endif
