import SwiftUI
import SwiftUIBackports
import SwiftBackports

@available(iOS 13, macOS 11, *)
struct TipsDemo: View {
    var body: some View {
        NavigationLink {
            Demo()
                .backport.navigationTitle("TipKit")
        } label: {
            if #available(iOS 14, *) {
                Image(systemName: "curlybraces").foregroundColor(.accentColor)
            }
            Text("TipKit")
        }
    }
}

@available(iOS 13, macOS 11, *)
private struct Demo: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Backport.TipView(Tip1())
        }
        .padding()
        .backport.task {
            try? await Backport.Tips.configure {
                DisplayFrequency(.daily)
                DatastoreLocation(.applicationDefault, shouldReset: true)
            }
        }
    }
}

struct Tip1: BackportTip {
    var id: String { "get.started" }
    var title: Text { .init("Welcome") }

    var message: Text? {
        Text("Foobar?")
    }

    var actions: [Action] {
        Action(title: "Foo 1")
        Action(title: "Bar 2")
    }

    var options: [Option] {
        MaxDisplayCount(.max)
        IgnoresDisplayFrequency(true)
    }

//    @Parameter(isTransient: true, customID: "foo")
//    static var isSignedIn: Bool = true

//    var rules: [Rule] {
//        #Rule(Self.$isSignedIn) { $0 }
//    }
}
