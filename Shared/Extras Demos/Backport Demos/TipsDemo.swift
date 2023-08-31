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
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                if #available(iOS 17, macOS 14, *) {
//                    TipView(Tip1())
//                    TipView(Tip2())
//                        .popoverTip(PopoverTip())
                }



                if #available(iOS 15, macOS 12, *) {
                    Backport.TipView(BackportTip1())
                        .backport.popoverTip(BackportTip1())
                } else {
                    Backport.TipView(BackportTip1())
                }
            }
            .padding()
            .backport.task {
                do {
                    try Backport.Tips.resetDatastore()
                    try Backport.Tips.configure([
                        .displayFrequency(.immediate),
                        .datastoreLocation(.applicationDefault),
                    ])

                    if #available(iOS 17, macOS 14, *) {
                        try Tips.resetDatastore()
                        try Tips.configure([
                            .displayFrequency(.immediate),
                            .datastoreLocation(.applicationDefault),
                        ])
                    }
                } catch {
                    print(error)
                }
            }
        }
    }
}

#if canImport(TipKit)
import TipKit
#endif
@available(iOS 17, macOS 14, *)
struct PopoverTip: TipKit.Tip {
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
}

@available(iOS 17, macOS 14, *)
struct Tip1: TipKit.Tip {
    var id: String { "get.started.1" }
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
}

@available(iOS 17, macOS 14, *)
struct Tip2: TipKit.Tip {
    var id: String { "get.started.2" }
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
}

struct BackportTip1: BackportTip {
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
