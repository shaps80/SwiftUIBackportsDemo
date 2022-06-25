import SwiftUI
import SwiftUIBackports

struct FittingScrollViewDemo: View {
    var body: some View {
        NavigationLink {
            DemoView()
        } label: {
            Text("FittingScrollView")
        }
    }
}

private struct DemoView: View {
    var body: some View {
        FittingScrollView {
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
        .navigationBarTitle("FittingScrollView")
        .multilineTextAlignment(.center)
    }
}

struct FittingScrollViewDemo_Previews: PreviewProvider {
    static var previews: some View {
        FittingScrollViewDemo()
    }
}
