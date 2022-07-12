import SwiftUI
import SwiftUIBackports

struct LabeledContentDemo: View {
    var body: some View {
        NavigationLink {
            Demo()
                .backport.navigationTitle("Labeled Content")
        } label: {
            Text("Labeled Content")
        }
    }
}

private struct Demo: View {
    var body: some View {
        List {
            Backport.Section("Backport") {

            }

            if #available(iOS 16, macOS 13, *) {
                Backport.Section("Native") {

                }
            }
        }
    }
}
