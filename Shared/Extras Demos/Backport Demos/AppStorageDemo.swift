import SwiftUI
import SwiftUIBackports

struct AppStorageDemo: View {
    var body: some View {
        NavigationLink {
            DemoView()
        } label: {
            if #available(iOS 14, macOS 11, *) {
                Image(systemName: "curlybraces").foregroundColor(.accentColor)
            }
            Text("AppStorage")
        }
    }
}

private struct DemoView: View {
    @Backport.AppStorage("isOn") private var isOn: Bool = false
    @State private var didChange: Bool = false

    var body: some View {
        List {
            Section {
                Toggle("Enabled", isOn: $isOn)
                    .backport.onChange(of: isOn) { newValue in
                        withAnimation { didChange = true }
                    }
            } footer: {
                if didChange {
                    Text("You can now dismiss this view and return to see the value persisted. You can also relaunch the app and the value will be persisted as expected.")
                }
            }
        }
        .backport.navigationTitle("AppStorage")
    }
}
