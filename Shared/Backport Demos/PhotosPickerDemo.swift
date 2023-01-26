import SwiftUI
import PhotosUI

#if os(iOS)
@available(iOS, introduced: 16)
struct PhotosPickerDemo: View {
    var body: some View {
        NavigationLink {
            DemoView()
        } label: {
            Text("PhotosPicker")
        }
    }
}

@available(iOS, introduced: 16)
private struct DemoView: View {
    @State private var selection: [PhotosPickerItem] = []
    
    var body: some View {
        PhotosPicker(selection: $selection, preferredItemEncoding: .current, photoLibrary: PHPhotoLibrary.shared()) {
            Label("Choose Photos", systemImage: "photo")
        }
    }
}
#endif
