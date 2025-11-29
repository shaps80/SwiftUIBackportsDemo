import SwiftUI
import SwiftUIBackports


struct RequestReviewDemo: View {
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
