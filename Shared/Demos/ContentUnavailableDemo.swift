import SwiftUI
import SwiftUIBackports

struct ContentUnavailableDemo: View {
    var body: some View {
        VStack {
            Backport.ContentUnavailableView {
                Backport.Label("Backport", systemImage: "star")
            } description: {
                Text("A description for the placeholder")
            } actions: {
                Button("Primary") { }
                Button("Secondary") { }
            }
            .background(Color.gray.opacity(0.3))
            .padding()

            Divider()

            if #available(iOS 17, tvOS 17, macOS 14, watchOS 10, *) {
                ContentUnavailableView {
                    Label("Native", systemImage: "star")
                } description: {
                    Text("A description for the placeholder")
                } actions: {
                    Button("Primary") { }
                    Button("Secondary") { }
                }
                .background(Color.gray.opacity(0.3))
                .padding()
            }
        }
    }
}
