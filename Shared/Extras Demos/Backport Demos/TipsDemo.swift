import SwiftUI
import SwiftUIBackports
import SwiftBackports

import CoreData
import CloudKit

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
            VStack(alignment: .leading) {
                Backport.TipView(BackportTip1())
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            BackportTip1().invalidate(reason: .tipClosed)
                        }
                    }

#if canImport(TipKit)
//                if #available(iOS 17, macOS 14, *) {
//                    TipView(Tip1())
//                }
#endif

                Text("Content goes here...")
            }
            .frame(maxWidth: .infinity)
            .padding()
        }
        .onAppear {
            do {
                try Backport.Tips.resetDatastore()
                try Backport.Tips.configure()

//                if #available(iOS 17, macOS 14, *) {
////                    try Tips.resetDatastore()
//                    try Tips.configure()
//                }
            } catch {
                print(error)
            }
        }
    }
}

#if canImport(TipKit)
import TipKit

@available(iOS 17, macOS 14, *)
struct Tip1: TipKit.Tip {
    var id: String { "get.started.1" }
    var title: Text { .init("Welcome") }
    var image: Image? { Image(systemName: "star") }

    var message: Text? {
        Text("Foobar?")
    }

    var actions: [Action] {
        Action(title: "Foo 1")
    }

    var options: [Option] {
        MaxDisplayCount(2)
    }
}
#endif

@available(iOS 13, macOS 11, *)
struct BackportTip1: BackportTip {
    var id: String { "get.started" }
    var title: Text { .init("Welcome") }
    var image: Image? { Image(systemName: "star") }

    var message: Text? {
        Text("Foobar?")
    }

    var actions: [Action] {
        Action(title: "Foo 1")
        Action(title: "Bar 2")
    }

    var options: [Option] {
        MaxDisplayCount(2)
    }

//    @Parameter(isTransient: true, customID: "foo")
//    static var isSignedIn: Bool = true

//    var rules: [Rule] {
//        #Rule(Self.$isSignedIn) { $0 }
//    }
}
