@_exported import Foundation

@attached(
    member,
    names:
    named(init)
)
@attached(memberAttribute)
@attached(extension)
public macro Demo() = #externalMacro(
    module: "DemoMacrosMacros",
    type: "DemoMacro"
)
