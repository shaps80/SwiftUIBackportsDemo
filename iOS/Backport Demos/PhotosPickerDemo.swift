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
    @State private var showPicker: Bool = false
    @State private var selection: [Backport<Any>.PhotosPickerItem] = []
    
    var body: some View {
        List {
            Backport.Section("Backport") {
                if #available(iOS 15, *) {
                    Backport.PhotosPicker(selection: $selection, maxSelectionCount: 3, selectionBehavior: .ordered, matching: .all(of: [.slomoVideos, .videos])) {
                        Label("Choose Photos", systemImage: "photo")
                    }
                } else if #available(iOS 14, *) {
                    Button {
                        showPicker = true
                    } label: {
                        Text("Show iOS 14 Picker")
                    }
                    .backport.photosPicker(isPresented: $showPicker, selection: $selection, maxSelectionCount: 3, matching: .any(of: [.images, .videos]))
                } else {
                    Button {
                        showPicker = true
                    } label: {
                        Text("Show iOS 13 Picker")
                    }
                    .backport.photosPicker(isPresented: $showPicker, selection: $selection)
                }
            }

            if #available(iOS 16, *) {
                Backport.Section("Native") {
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
