import SwiftUI
import SwiftUIBackports

struct LabeledContentDemo: View {
    var body: some View {
        NavigationLink {
            Demo()
                .backport.navigationTitle("Labeled Content")
        } label: {
            Text("Labeled Content")
        }
    }
}

private struct Demo: View {
    var people: [Person] = [
        .init(name: "Shaps", age: 42, pets: [
            .init(name: "Scruffy", species: "Dog"),
            .init(name: "Lippy", species: "Cat")
        ]),
        .init(name: "Anton", age: 5, pets: [
            .init(name: "Polly", species: "Alpaca"),
            .init(name: "Mr Bear", species: "Teddy")
        ])
    ]

    @Backport.AppStorage("hide-labels") private var hideLabels: Bool = false

    var body: some View {
        Form {
            Section {
                Toggle("Hide Labels", isOn: $hideLabels)
            }

            ForEach(people) { person in
                if !person.pets.isEmpty {
                    Section {
                        ForEach(person.pets) { pet in
                            Backport.LabeledContent(pet.species, value: pet.name)
                        }
                    } header: {
                        HStack {
                            Text(person.name)
                            Spacer()
                            Text("\(person.age) years old")
                                .font(.footnote)
                        }
                    }
                    .noTextCasing()
                }
            }
            .hideLabels(hideLabels)

            Section {
                Backport.LabeledContent("Title", value: "Value")
                    .backport.labeledContentStyle(.vertical)
            }
            .hideLabels(hideLabels)
        }
        .backport.navigationTitle("People")
    }
}

private extension View {
    @ViewBuilder
    func noTextCasing() -> some View {
        if #available(iOS 14, macOS 11, *) {
            textCase(.none)
        } else {
            self
        }
    }
}

private extension View {
    @ViewBuilder
    func hideLabels(_ isHidden: Bool) -> some View {
        if isHidden {
            labelsHidden()
        } else {
            self
        }
    }
}

private struct Person: Identifiable {
    var id: String { name }

    var name: String
    var age: Int
    var pets: [Pet]

    struct Pet: Identifiable {
        var id: String { name }
        var name: String
        var species: String
    }
}

private struct VerticalLabeledContentStyle: BackportLabeledContentStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack(alignment: .leading, spacing: 5) {
            configuration.label
                .font(.footnote)
                .foregroundColor(.secondary)
            configuration.content
        }
    }
}
extension BackportLabeledContentStyle where Self == VerticalLabeledContentStyle {
    static var vertical: Self { .init() }
}
