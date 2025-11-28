import SwiftUI
import SwiftUIBackports
import PhotosUI
import Demo

struct RootView: View {
    var body: some View {
        NavigationView {
            List {
                Backport.Section("Backports") {
                    Group {
                        Demo(AsyncImageDemo.self)
                        Demo(AppStorageDemo.self)
                        Demo(DismissDemo.self)
                        Demo(LabelDemo.self)
                        Demo(LabeledContentDemo.self)
                        Demo(NavigationDemo.self)
                        Demo(LinkDemo.self)
                        Demo(OpenURLDemo.self)
                    }

                    Group {
                        Demo(ProgressDemo.self)
                        Demo(QuicklookDemo.self)
                        Demo(RequestReviewDemo.self)
                        Demo(RefreshableDemo.self)
                        Demo(ShareLinkDemo.self)
                        Demo(StateObjectDemo.self)
                        Demo(UniformTypesDemo.self)
                    }
                }

#if os(iOS)
                Backport.Section("iOS Only") {
                    Demo(DynamicTypeDemo.self)
                    Demo(PasteButtonDemo.self)
                    Demo(ScaledMetricDemo.self)
                    Demo(ScrollViewDemo.self)
                    Demo(FocusStateDemo.self)
                    Demo(TextEditorDemo.self)
                }
#endif

#if os(iOS)
                if #available(iOS 14, *) {
                    Backport.Section("iOS 14+") {
                        Demo(TextDemos.self)
                        Demo(HostingCollectionDemo.self)
                        Demo(HostingTableDemo.self)
                    }
                }

                if #available(iOS 15, *) {
                    Backport.Section("iOS 15+") {
                        Demo(PresentationDemo.self)
                    }
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
