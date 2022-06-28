import SwiftUI
import SwiftUIBackports

@available(iOS 14, macOS 10.15, *)
@main struct DemoApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                List {
                    Backport.Section("Backports") {
                        AppStorageDemo()
                        NavigationDemo()
                        PresentationDemo()
                        RefreshableDemo()
                        ScaledMetricDemo()
                    }

                    Backport.Section("Extras") {
                        FittingGeometryReaderDemo()
                        FittingScrollViewDemo()
                    }
                }
                .backport.navigationTitle("Demos")
                .listStyle(.sidebar)
            }
        }
    }
}
