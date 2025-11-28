import SwiftUI
import SwiftUIBackports

struct RefreshableDemo: Demonstrable {
    @State private var isRefreshing: Bool = false

    var body: some View {
        List {
            RefreshableView(isRefreshing: $isRefreshing)
        }
        .backport.refreshable {
            isRefreshing = true
            sleep(2)
            isRefreshing = false
        }
        .backport.navigationTitle("Refreshable")
    }
}

struct RefreshableView: View {
    @Environment(\.backportRefresh) private var refresh
    @Binding var isRefreshing: Bool

    var body: some View {
        Button {
            guard !isRefreshing else { return }
            isRefreshing = true
        } label: {
            HStack {
                Text(isRefreshing ? "Refreshing..." : "Refresh")
                    .padding(.vertical, 5)
                Spacer()
                Progress(visibility: isRefreshing ? .visible : .hidden)
                    .frame(maxWidth: 150)
            }
        }
        .disabled(refresh == nil || isRefreshing)
        .backport.task(id: isRefreshing) {
            guard isRefreshing else { return }
            await refresh?()
            isRefreshing = false
        }
    }
}
