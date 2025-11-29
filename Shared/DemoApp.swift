import SwiftUI
import SwiftUIBackports
import Demo

struct RootView: View {
    var body: some View {
        NavigationView {
            List {
                Demo(AsyncImageDemo())
                Demo(AppStorageDemo())
                Demo(DismissDemo())
                Demo(LabelDemo())
                Demo(LabeledContentDemo())
                Demo(NavigationDemo())
                Demo(LinkDemo())
                Demo(OpenURLDemo())
                Demo(ProgressDemo())
                Demo(QuicklookDemo())
                Demo(RequestReviewDemo())
                Demo(RefreshableDemo())
                Demo(ShareLinkDemo())
                Demo(StateObjectDemo())
                Demo(UniformTypesDemo())

#if os(iOS)
                Demo(DynamicTypeDemo())
                Demo(PasteButtonDemo())
                Demo(ScaledMetricDemo())
                Demo(ScrollViewDemo())
                Demo(FocusStateDemo())
                Demo(TextEditorDemo())


                if #available(iOS 14, *) {
                    Demo(TextDemos())
                    Demo(HostingCollectionDemo())
                    Demo(HostingTableDemo())
                }

                if #available(iOS 15, *) {
                    Demo(PresentationDemo())

                }
#endif
            }
            .inlineTitle("Demos")

            Text("Select a Demo")
                .foregroundColor(.secondary)
        }
    }
}

#if os(iOS)
@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool { true }
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
}

final class SceneDelegate: UIResponder, UISceneDelegate {
    var window: UIWindow?
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = scene as? UIWindowScene else { return }
        window = UIWindow(windowScene: scene)
        window?.rootViewController = UIHostingController(
            rootView: RootView()
        )
        window?.makeKeyAndVisible()
    }
}
#else
@available(macOS 11, *)
@main struct DemoApp: App {
    var body: some Scene {
        WindowGroup {
            RootView()
                .hiddenToolbarBackground()
        }
    }
}

extension View {
    @ViewBuilder
    func hiddenToolbarBackground() -> some View {
        if #available(iOS 18, tvOS 18, macOS 15, watchOS 11, *) {
            toolbarBackgroundVisibility(.hidden, for: .windowToolbar)
        } else {
            self
        }
    }
}
#endif
