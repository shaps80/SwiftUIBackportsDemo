import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros
import SwiftDiagnostics

@main
struct DemoMacrosPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        DemoMacro.self
    ]
}
