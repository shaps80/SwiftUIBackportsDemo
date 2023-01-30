import SwiftUI
import SwiftUIBackports
import PhotosUI

#if os(iOS)
struct PhotosPickerDemo: View {
    var body: some View {
        NavigationLink {
            PhotosDemoView()
        } label: {
            Text("PhotosPicker")
        }
    }
}

struct PhotosDemoView: View {
    @State private var backportSelection: Backport<Any>.PhotosPickerItem? = nil
    
    var body: some View {
        List {
            if #available(iOS 14, *) {
            } else {
                Backport.Section("iOS 13") {
                    Backport.PhotosPicker(
                        selection: $backportSelection,
                        matching: .images
                    ) {
                        Backport.Label("Choose Photo", systemImage: "photo")
                    }
                }
            }

            if #available(iOS 14, *) {
                Backport.Section("iOS 14+") {
                    Backport.PhotosPicker(
                        selection: $backportSelection,
                        matching: .images
                    ) {
                        Label("Choose Photos", systemImage: "photo")
                    }
                }
            }

            if #available(iOS 16, *) {
                Backport.Section("iOS 16+") {
                    PhotosPicker(
                        selection: .constant(nil),
                        matching: .images
                    ) {
                        Label("Choose Photos", systemImage: "photo")
                    }
                }
            }
        }
        .backport.navigationTitle("Photos Picker")
    }
}
#endif
