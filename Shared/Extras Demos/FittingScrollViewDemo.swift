import SwiftUI
import SwiftUIPlus

struct FittingScrollViewDemo: View {
    var body: some View {
        NavigationLink {
            DemoView()
        } label: {
            if #available(iOS 14, macOS 11, *) {
                Image(systemName: "curlybraces").foregroundColor(.accentColor)
            }
            Text("FittingScrollView")
        }
    }
}

private struct DemoView: View {
    var body: some View {
        VScrollStack {
            VStack {
                Text("Aligned to the top")
                Spacer()
                Text("Aligned to the bottom")
            }
            .frame(maxWidth: .infinity)
            .backport.overlay {
                Text("Scroll up and down to observe the bottom text behaviour.")
                    .padding(.horizontal, 20)
            }
        }
        .backport.navigationTitle("FittingScrollView")
        .multilineTextAlignment(.center)
    }
}
