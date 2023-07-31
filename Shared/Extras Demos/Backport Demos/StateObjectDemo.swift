import SwiftUI
import SwiftUIBackports

struct StateObjectDemo: View {
    var body: some View {
        NavigationLink {
            Demo()
                .backport.navigationTitle("StateObject")
        } label: {
            if #available(iOS 14, macOS 11, *) {
                Image(systemName: "curlybraces").foregroundColor(.accentColor)
            }
            Text("StateObject")
        }
    }
}

private struct Demo: View {
    var body: some View {
        RandomNumberView()
    }
}

struct RandomNumberView: View {
    @State private var isOn = false

    var body: some View {
        List {
            Toggle("Refresh", isOn: $isOn)
            ChildView()
        }
    }
}

private final class Counter: ObservableObject {
    @Published var count = 0
    func incrementCounter() { count += 1 }
}

private struct ChildView: View {
    @Backport.StateObject private var owned = Counter()
    @ObservedObject private var observed = Counter()

    var body: some View {
        Section {
            HStack {
                Text("StateObject")
                Spacer()
                Text("\(owned.count)")
            }

            HStack {
                Text("ObservedObject")
                Spacer()
                Text("\(observed.count)")
            }

            Button("Increment Counter") {
                observed.incrementCounter()
                owned.incrementCounter()
            }
        }
    }
}
