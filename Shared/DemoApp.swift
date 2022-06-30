import SwiftUI
import SwiftUIBackports

@available(iOS 14, macOS 11, *)
@main struct DemoApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                List {
                    Backport.Section("Backports") {
                        AsyncImageDemo()
                        AppStorageDemo()
                        LabelDemo()
                        NavigationDemo()
                        ProgressDemo()
                        #if os(iOS)
                        PresentationDemo()
                        #endif
                        RefreshableDemo()
                        #if os(iOS)
                        ScaledMetricDemo()
                        #endif
                    }

                    Backport.Section("Extras") {
                        FittingGeometryReaderDemo()
                        FittingScrollViewDemo()
                    }
                }
                .backport.navigationTitle("Demos")
                .listStyle(.sidebar)
            }
            #if os(macOS)
            .frame(maxWidth: 800, maxHeight: 800)
            #endif
        }
    }
}
