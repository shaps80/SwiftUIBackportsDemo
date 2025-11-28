import SwiftUI
import SwiftUIBackports

struct AsyncImageDemo: View {
    var body: some View {
        NavigationLink {
            Demo()
        } label: {
            Text("AsyncImage")
        }
    }
}

private struct Demo: View {
    @State private var isLoading: Bool = true
    private let seed = (0...1000).randomElement()!

    var body: some View {
        Backport.AsyncImage(url: URL(string: "https://picsum.photos/seed/\(seed)/800/800")) { image in
            image
                .resizable()
                .scaledToFill()
                .onAppear {
                    isLoading = false
                }
        } placeholder: {
            Rectangle()
                .foregroundColor(Color.gray)
                .onAppear {
                    isLoading = true
                }
        }
        .edgesIgnoringSafeArea(.all)
        .backport.navigationTitle("AsyncImage")
        .backport.overlay {
            Progress(visibility: isLoading ? .visible : .hidden)
        }
    }
}
