import SwiftUI
import SwiftUIBackports
import PhotosUI

#if os(iOS)
@available(iOS, introduced: 16)
struct PhotosPickerDemo: View {
    var body: some View {
        NavigationLink {
            PhotosDemoView()
        } label: {
            Text("PhotosPicker")
        }
    }
}

@available(iOS, introduced: 16)
struct PhotosDemoView: View {
    @State private var backportSelection: Backport<Any>.PhotosPickerItem? = nil
    @State private var selection: PhotosPickerItem? = nil
    
    var body: some View {
        List {
            Backport.Section("Backport") {
                Backport.PhotosPicker(
                    selection: $backportSelection,
                    matching: .images
                ) {
                    Label("Choose Photos", systemImage: "photo")
                }
            }
            
            Backport.Section("Native") {
                PhotosPicker(
                    selection: $selection,
                    matching: .images
                ) {
                    Label("Choose Photos", systemImage: "photo")
                }
            }
        }
        .backport.navigationTitle("Photos Picker")
    }
}
#endif
