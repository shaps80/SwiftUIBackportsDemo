import SwiftUI
import SwiftUIBackports

#if os(iOS)
@available(iOS 14, *)
struct PresentationDemo: View {
    @State private var showSheet: Bool = false
    @State private var backgroundInteraction: Backport<Any>.PresentationBackgroundInteraction = .disabled
    @State private var contentInteraction: Backport<Any>.PresentationContentInteraction = .resizes
    @State private var detents: Set<Backport.PresentationDetent> = [.medium, .large]
    @State private var selection: Backport.PresentationDetent = .medium
    @State private var customRadius: Bool = false
    @State private var cornerRadius: CGFloat = 20

    var body: some View {
        NavigationLink {
            List {
                Section {
                    Picker("Background Interaction", selection: $backgroundInteraction) {
                        Text("Disabled")
                            .tag(Backport<Any>.PresentationBackgroundInteraction.disabled)

                        Text("Enabled")
                            .tag(Backport<Any>.PresentationBackgroundInteraction.enabled)

                        Text("Up to Medium")
                            .tag(Backport<Any>.PresentationBackgroundInteraction.enabled(upThrough: .medium))

                        Text("Up to Large")
                            .tag(Backport<Any>.PresentationBackgroundInteraction.enabled(upThrough: .large))
                    }
                    .pickerStyle(.menu)

                    Picker("Content Interaction", selection: $contentInteraction) {
                        Text("Resizes")
                            .tag(Backport<Any>.PresentationContentInteraction.resizes)

                        Text("Scrolls")
                            .tag(Backport<Any>.PresentationContentInteraction.scrolls)
                    }
                    .pickerStyle(.menu)
                }

                Section {
                    Button {
                        showSheet = true
                    } label: {
                        Text("Show Sheet")
                    }
                }
                .sheet(isPresented: $showSheet) {
                    DemoView(detents: $detents, selection: $selection, customRadius: $customRadius, cornerRadius: $cornerRadius)
                        .presentationDetentsIfAvailable(
                            detents: detents,
                            selection: $selection,
                            backgroundInteraction: backgroundInteraction,
                            contentInteraction: contentInteraction,
                            cornerRadius: customRadius ? cornerRadius : nil
                        )
                }
            }
        } label: {
            Text("Presentation")
        }
    }
}

@available(iOS 14, *)
private struct DemoView: View {
    @Environment(\.backportDismiss) private var dismiss

    @State private var visible: Backport.Visibility = .hidden
    @State private var isModal: Bool = false
    @State private var enablePrompt: Bool = true
    @State private var showPrompt: Bool = false

    @Binding var detents: Set<Backport<Any>.PresentationDetent>
    @Binding var selection: Backport<Any>.PresentationDetent
    @Binding var customRadius: Bool
    @Binding var cornerRadius: CGFloat

    var body: some View {
        NavigationView {
            List {
                Section {
                    Toggle("Custom Radius", isOn: $customRadius.animation())

                    if customRadius {
                        Slider(value: $cornerRadius, in: 0...100)
                    }
                }

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
                        .actionSheet(isPresented: $showPrompt) {
                            ActionSheet(title: Text("Dismiss"), buttons: [
                                .default(Text("OK")) {
                                    dismiss()
                                },
                                .cancel()
                            ])
                        }
                    }
                }
            }
            .listStyle(.insetGrouped)
            .backport.navigationTitle("Sheet")
            .backport.toolbar {
                Backport.ToolbarItem {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.primary)
                    }
                }
            }
        }
        .backport.presentationDragIndicator(visible)
        .backport.interactiveDismissDisabled(isModal) {
            if enablePrompt { showPrompt = true }
        }
    }
}

extension View {
    @ViewBuilder
    func presentationDetentsIfAvailable(
        detents: Set<Backport<Any>.PresentationDetent>,
        selection: Binding<Backport<Any>.PresentationDetent>,
        backgroundInteraction: Backport<Any>.PresentationBackgroundInteraction,
        contentInteraction: Backport<Any>.PresentationContentInteraction,
        cornerRadius: CGFloat?
    ) -> some View {
        if #available(iOS 15, *) {
            backport.presentationDetents(detents, selection: selection)
                .backport.presentationBackgroundInteraction(backgroundInteraction)
                .backport.presentationContentInteraction(contentInteraction)
                .backport.presentationCornerRadius(cornerRadius)
        } else {
            self
        }
    }
}
#endif
