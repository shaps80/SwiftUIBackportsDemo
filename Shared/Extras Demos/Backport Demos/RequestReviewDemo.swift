import SwiftUI
import SwiftUIBackports

struct RequestReviewDemo: View {
    var body: some View {
        NavigationLink {
            Demo()
                .backport.navigationTitle("Request Review")
        } label: {
            if #available(iOS 14, macOS 11, *) {
                Image(systemName: "curlybraces").foregroundColor(.accentColor)
            }
            Text("Request Review")
        }
    }
}

private struct Demo: View {
    @Environment(\.backportRequestReview) private var requestReview

    var body: some View {
        List {
            Button {
                requestReview()
            } label: {
                Text("Request Review")
            }
        }
    }
}
