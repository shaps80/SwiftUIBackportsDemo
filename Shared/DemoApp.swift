import SwiftUIBackports

@available(iOS 14, macOS 10.15, *)
@main struct DemoApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                List {
                    PresentationDemo()
                    AppStorageDemo()
                }
                .navigationBarTitle("Demos")
            }
        }
    }
}
