import SwiftUI
import SwiftUIBackports
import PhotosUI

struct RootView: View {
    var body: some View {
        NavigationView {
            List {
                Backport.Section("Backports") {
                    Group {
                        AsyncImageDemo()
                        AppStorageDemo()
                        DismissDemo()
                        LabelDemo()
                        LabeledContentDemo()
                        NavigationDemo()
                    }

                    Group {
                        LinkDemo()
                        OpenURLDemo()
                        ProgressDemo()
                        QuicklookDemo()
                        RequestReviewDemo()
                        RefreshableDemo()
                        ShareLinkDemo()
                        StateObjectDemo()
//                        ToolBarBackgroundDemo()
                        UniformTypesDemo()
                    }
                }

#if os(iOS)
                Backport.Section("iOS Only") {
                    DynamicTypeDemo()
                    PasteButtonDemo()
                    PhotosPickerDemo()
                    ScaledMetricDemo()
                    ScrollViewDemo()
                    FocusState()
                    TextEditorDemo()
                }
#endif

#if os(iOS)
                if #available(iOS 14, *) {
                    Backport.Section("iOS 14+") {
                        TextDemos()
                        HostingCollectionDemo()
                        HostingTableDemo()
                    }
                }

                if #available(iOS 15, *) {
                    Backport.Section("iOS 15+") {
                        PresentationDemo()
                    }
                }
#endif

                Backport.Section("Extras") {
                    FittingGeometryReaderDemo()
                    FittingScrollViewDemo()
                }
            }
            .backport.navigationTitle("Demos")

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
        window?.rootViewController = UIHostingController(rootView: RootView())
        window?.makeKeyAndVisible()
    }
}
#else
@available(macOS 11, *)
@main struct DemoApp: App {
    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
}
#endif
