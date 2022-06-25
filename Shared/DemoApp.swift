import SwiftUI
import SwiftUIBackports

@available(iOS 14, macOS 10.15, *)
@main struct DemoApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                List {
                    AppStorageDemo()
                    PresentationDemo()
                    RefreshableDemo()
                    ScaledMetricDemo()
                }
                .navigationBarTitle("Demos")
            }
        }
    }
}
