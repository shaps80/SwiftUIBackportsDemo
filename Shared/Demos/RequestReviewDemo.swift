import SwiftUI
import SwiftUIBackports

struct RequestReviewDemo: View {
    var body: some View {
        NavigationLink {
            Demo()
                .backport.navigationTitle("Request Review")
        } label: {
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
