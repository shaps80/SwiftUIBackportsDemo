import SwiftUI
import SwiftUIBackports

struct NavigationDemo: Demonstrable {
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
                NavigationDemo(title: "Normal")
            }
        }
        .backport.navigationDestination(for: String.self) { value in
            NavigationDemo(title: "Number")
        }
        .backport.navigationDestination(for: Int.self) { value in
            NavigationDemo(title: "String")
        }
        .backport.navigationDestination(for: Person.self) { person in
            NavigationDemo(title: "Person")
        }
        .backport.navigationTitle(title)
    }
}

private struct Person: Hashable {
    let name: String
}
