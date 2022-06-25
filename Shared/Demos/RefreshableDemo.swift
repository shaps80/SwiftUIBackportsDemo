import SwiftUI
import SwiftUIBackports

struct RefreshableDemo: View {

    var body: some View {
        NavigationLink {
            DemoView()
        } label: {
            Text("Refreshable")
        }
    }
}

struct RefreshableView: View {
    @Environment(\.backportRefresh) private var refresh
    @State private var isRefreshing: Bool = false

    var body: some View {
        Button {
            Task {
                isRefreshing = true
                await refresh?()
                isRefreshing = false
            }
        } label: {
            Text("Refresh")
        }
        .disabled(refresh == nil || isRefreshing)
    }
}

private struct DemoView: View {
    @State private var isRefreshing: Bool = false

    var body: some View {
        List {
            RefreshableView()
                .backport.refreshable {
                    isRefreshing = true
                    sleep(1)
                    isRefreshing = false
                }
        }
        .navigationBarTitle("Refreshable")
        .navigationBarItems(trailing: Progress(visibility: isRefreshing ? .visible : .hidden))
    }
}

struct RefreshableDemo_Previews: PreviewProvider {
    static var previews: some View {
        RefreshableDemo()
    }
}
