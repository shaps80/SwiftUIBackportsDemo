import SwiftUI
import SwiftUIBackports

public struct ContainerRelativeDemo: View {
    public var body: some View {
        ScrollView {
            if #available(iOS 18, macOS 15, *) {
                Color.red
                    .backport.containerRelativeFrame(.vertical)
            } else {
                Color.red
            }
        }
    }
}
