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

    var body: some View {
        Form {
            Backport.Section("Backport") {
                ForEach(people) { person in
                    Backport.LabeledContent("Name", value: person.name)

                    if !person.pets.isEmpty {
                        ForEach(person.pets) { pet in
                            Backport.LabeledContent(pet.species, value: pet.name)
                        }
                    }
                }
            }
//            .labelsHidden()

            if #available(iOS 16, macOS 13, *) {
                Section("Native") {
                    ForEach(people) { person in
                        LabeledContent("Name", value: person.name)

                        if !person.pets.isEmpty {
                            ForEach(person.pets) { pet in
                                LabeledContent(pet.species, value: pet.name)
                            }
                        }
                    }
                }
//                .labelsHidden()
            }
        }
        .backport.navigationTitle("People")
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
