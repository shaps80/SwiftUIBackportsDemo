import SwiftUI
import SwiftUIBackports

import PhotosUI
import Demo

struct RootView: View {
    var body: some View {
        NavigationView {
            DemoList {
                AsyncImageDemo()
                AppStorageDemo()
                DismissDemo()
                LabelDemo()
                LabeledContentDemo()
                NavigationDemo()
                LinkDemo()
                OpenURLDemo()
                ProgressDemo()
                QuicklookDemo()
                RequestReviewDemo()
                RefreshableDemo()
                ShareLinkDemo()
                StateObjectDemo()
                UniformTypesDemo()

#if os(iOS)
                DynamicTypeDemo()
                PasteButtonDemo()
                ScaledMetricDemo()
                ScrollViewDemo()
                FocusStateDemo()
                TextEditorDemo()


                if #available(iOS 14, *) {
                    TextDemos()
                    HostingCollectionDemo()
                    HostingTableDemo()
                }

                if #available(iOS 15, *) {
                    PresentationDemo()

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
