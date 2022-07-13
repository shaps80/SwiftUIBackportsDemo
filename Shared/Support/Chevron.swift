import SwiftUI

struct Chevron: View {
    var body: some View {
        Group {
            #if os(iOS)
            Image(systemName: "chevron.right")
            #else
            Text("̕▸")
            #endif
        }
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
