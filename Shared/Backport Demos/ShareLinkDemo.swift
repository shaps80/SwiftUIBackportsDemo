import SwiftUI

struct ShareLinkDemo: View {
    var body: some View {
        NavigationLink {
            Demo()
                .backport.navigationTitle("ShareLink")
        } label: {
            Text("ShareLink")
        }
    }
}

private struct Demo: View {
    var body: some View {
        List {
//            Backport.ShareLink
        }
    }
}
