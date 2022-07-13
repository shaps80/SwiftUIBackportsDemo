import SwiftUI

extension Animation {
    static var interactive: Self {
        .interactiveSpring(response: 0.3, dampingFraction: 0.9, blendDuration: 0.4)
    }
}
