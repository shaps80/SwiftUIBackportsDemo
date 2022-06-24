import SwiftUI

struct Chevron: View {
    var body: some View {
        Image(systemName: "chevron.right")
            .foregroundColor(.secondary)
            .font(.callout.weight(.semibold))
    }
}

extension View {
    func chevron() -> some View {
        HStack {
            self
            Spacer()
            Chevron()
        }
    }
}
