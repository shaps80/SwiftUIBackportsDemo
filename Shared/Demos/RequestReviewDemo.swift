import SwiftUI
import SwiftUIBackports

struct RequestReviewDemo: Demonstrable {
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
