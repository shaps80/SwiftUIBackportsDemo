import SwiftUI
import SwiftUIBackports

struct ScrollViewDemo: View {
    var body: some View {
        NavigationLink {
            Demo()
                .backport.navigationTitle("ScrollView")
        } label: {
            if #available(iOS 14, macOS 11, *) {
                Image(systemName: "curlybraces").foregroundColor(.accentColor)
            }
            Text("ScrollView")
        }
    }
}

private struct Demo: View {
    @State private var scrollEnabled: Bool = true
    @State private var indicatorVisibility: Backport.ScrollIndicatorVisibility = .automatic
    @State private var dismissMode: Backport.ScrollDismissesKeyboardMode = .automatic

    var body: some View {
        List {
            Toggle("Scroll Enabled", isOn: $scrollEnabled)

            HStack {
                Text("Scroll Indicators")
                Spacer()
                Picker("", selection: $indicatorVisibility) {
                    ForEach(Backport.ScrollIndicatorVisibility.all, id: \.self) { value in
                        Text(String(describing: value))
                            .tag(value)
                    }
                }
            }

            #if os(iOS)
            Section {
                HStack {
                    Text("Dismiss Mode")
                    Spacer()
                    Picker("", selection: $dismissMode) {
                        ForEach(Backport.ScrollDismissesKeyboardMode.all, id: \.self) { value in
                            Text(String(describing: value))
                                .tag(value)
                        }
                    }
                }

                TextField("Placeholder", text: .constant(""))
            }
            #endif


            Section { } footer: {
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(height: 500)
            }
        }
        .pickerStyle(.segmented)
        .background(Color.accentColor)
        .backport.scrollDismissesKeyboard(dismissMode)
        .backport.scrollIndicators(indicatorVisibility)
        .backport.scrollDisabled(!scrollEnabled)
    }
}

extension Backport.ScrollIndicatorVisibility {
    static var all: [Self] {
        [.automatic, .visible, .hidden]
    }
}

extension Backport.ScrollDismissesKeyboardMode {
    static var all: [Self] {
        [.automatic, .immediately, .interactively]
    }
}
