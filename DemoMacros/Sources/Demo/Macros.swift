@_exported import Foundation

@attached(
    member,
    names:
    named(init)
)
@attached(extension, conformances: Demonstrable)
public macro Demo() = #externalMacro(
    module: "DemoMacros",
    type: "DemoMacro"
)
