import SwiftUI
import SwiftUIBackports
import Demo

struct RootView: View {
    var body: some View {
        NavigationView {
            List {
                Demo(ContainerRelativeDemo())
                Demo(ContentUnavailableDemo())
                Demo(GeometryChangeDemo())
                Demo(LabeledContentDemo())
                Demo(NavigationDemo())
                Demo(RequestReviewDemo())
                Demo(ShareLinkDemo())

#if os(iOS)
                Demo(DynamicTypeDemo())
                Demo(PasteButtonDemo())
                Demo(ScrollViewDemo())
                Demo(TextEditorDemo())
                Demo(SensoryFeedbackDemo())

                Demo(HostingCollectionDemo())
                Demo(HostingTableDemo())
                Demo(PresentationDemo())
#endif
            }
            .inlineTitle("Demos")

            Text("Select a Demo")
                .foregroundColor(.secondary)
        }
    }
}

@main struct DemoApp: App {
    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
}
