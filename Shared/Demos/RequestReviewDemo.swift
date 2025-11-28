import SwiftUI
import SwiftUIBackports
import Demo

@Demo
struct RequestReviewDemo {
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
