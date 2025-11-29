import SwiftUI
import SwiftUIBackports

struct SensoryFeedbackDemo: View {
    @State private var success: Bool = false
    @State private var warning: Bool = false
    @State private var error: Bool = false
    @State private var selection: Bool = false
    @State private var light: Bool = false
    @State private var medium: Bool = false
    @State private var heavy: Bool = false
    @State private var soft: Bool = false
    @State private var solid: Bool = false
    @State private var rigid: Bool = false

    var body: some View {
        List {
            Toggle("Selection", isOn: $selection)
                .backport.sensoryFeedback(.selection, trigger: selection)

            Backport.Section("Notifications") {
                Toggle("Success", isOn: $success)
                    .backport.sensoryFeedback(.success, trigger: success)
                    .foregroundColor(.green)

                Toggle("Warning", isOn: $warning)
                    .backport.sensoryFeedback(.warning, trigger: warning)
                    .foregroundColor(.orange)

                Toggle("Error", isOn: $error)
                    .backport.sensoryFeedback(.error, trigger: error)
                    .foregroundColor(.red)
            }

            Backport.Section("Weight") {
                Toggle("Light", isOn: $light)
                    .backport.sensoryFeedback(.impact(weight: .light, intensity: 1), trigger: light)

                Toggle("Medium", isOn: $medium)
                    .backport.sensoryFeedback(.impact(weight: .medium, intensity: 1), trigger: medium)

                Toggle("Heavy", isOn: $heavy)
                    .backport.sensoryFeedback(.impact(weight: .heavy, intensity: 1), trigger: heavy)
            }

            Backport.Section("Flexibility") {
                Toggle("Soft", isOn: $soft)
                    .backport.sensoryFeedback(.impact(flexibility: .soft, intensity: 1), trigger: soft)

                Toggle("Solid", isOn: $solid)
                    .backport.sensoryFeedback(.impact(flexibility: .solid, intensity: 1), trigger: solid)

                Toggle("Rigid - _only when **on**_", isOn: $rigid)
                    .backport.sensoryFeedback(.impact(flexibility: .rigid), trigger: rigid) { _, newValue in
                        // only if `true`
                        return newValue
                    }
            }
        }
        .toggleStyle(NoImplicitHapticToggleStyle())
    }
}

private struct NoImplicitHapticToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button {
            configuration.isOn.toggle()
        } label: {
            HStack {
                configuration.label
                Spacer()
                Text(configuration.isOn ? "ON" : "FALSE")
                    .foregroundColor(.secondary)
            }
        }
    }
}
