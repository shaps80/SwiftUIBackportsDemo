import SwiftUI
import SwiftUIBackports
import SwiftBackports

struct TipsDemo: View {
    var body: some View {
        NavigationLink("TipKit") {
            Demo()
                .backport.navigationTitle("TipKit")
        }
    }
}

private struct Demo: View {
    var body: some View {
        Text("Tips")
            .onAppear {
                let tip = Tip1()
                print(tip.actions)
            }
    }
}

struct Tip1: BackportTip {
    var title: Text = .init("")
    var actions: [Action] { [
        .init(id: nil, title: "Action 1")
    ] }
}
