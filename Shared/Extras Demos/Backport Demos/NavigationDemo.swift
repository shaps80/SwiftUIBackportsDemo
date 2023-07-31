import SwiftUI
import SwiftUIBackports

struct NavigationDemo: View {
    var body: some View {
        NavigationLink {
            Demo()
        } label: {
            if #available(iOS 14, macOS 11, *) {
                Image(systemName: "curlybraces").foregroundColor(.accentColor)
            }
            Text("Navigation")
        }
    }
}

private struct Demo: View {
    var title: String = "Navigation"

    var body: some View {
        List {
            Backport.NavigationLink(value: "It worked!") {
                Text("Push some text")
            }

            Backport.NavigationLink(value: 123456789) {
                Text("Push a number")
            }

            Backport.NavigationLink(value: Person(name: "Shaps")) {
                Text("Push a person")
            }

            NavigationLink("Normal Link") {
                Demo(title: "Normal")
            }
        }
        .backport.navigationDestination(for: String.self) { value in
            Demo(title: "Number")
        }
        .backport.navigationDestination(for: Int.self) { value in
            Demo(title: "String")
        }
        .backport.navigationDestination(for: Person.self) { person in
            Demo(title: "Person")
        }
        .backport.navigationTitle(title)
    }
}

private struct Person: Hashable {
    let name: String
}
