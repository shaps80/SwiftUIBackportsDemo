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
    @State private var selection: [Backport<Any>.PhotosPickerItem] = []
    
    var body: some View {
        List {
            Backport.Section("iOS 13+") {
                Backport.PhotosPicker(
                    selection: $selection,
                    matching: nil
                ) {
                    Backport.Label("Choose Photo", systemImage: "photo")
                }
            }

            if #available(iOS 16, *) {
                Backport.Section("iOS 16+") {
                    PhotosPicker(
                        selection: .constant([]),
                        matching: nil
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
