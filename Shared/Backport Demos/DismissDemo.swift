import SwiftUI

struct DismissDemo: View {
    var body: some View {
        NavigationLink {
            Presenting()
                .backport.navigationTitle("Dismiss")
        } label: {
            Text("Dismiss")
        }
    }
}

private struct Presenting: View {
    @State private var showSheet: Bool = false

    var body: some View {
        List {
            Button {
                showSheet = true
            } label: {
                Text("Present Sheet")
            }
        }
        .sheet(isPresented: $showSheet) {
            Presented()
        }
    }
}

struct Presented: View {
    @Environment(\.backportDismiss) private var dismiss
    @Environment(\.backportIsPresented) private var isPresented

    var body: some View {
        NavigationView {
            List {
                HStack {
                    Text("Presented")
                        .foregroundColor(.secondary)
                    Spacer()
                    Text("\(isPresented ? "true" : "false")")
                }

                Button {
                    dismiss()
                } label: {
                    Text("Dismiss")
                }
            }
            .backport.navigationTitle("Presented")
        }
    }
}
