import SwiftUI

extension View {
    func titled(_ title: String) -> some View {
        HStack {
            Text(title)
            Spacer()
            self
        }
    }
}
