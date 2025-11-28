import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest

#if canImport(DemoMacrosMacros)
import DemoMacrosMacros

let testMacros: [String: Macro.Type] = [
    "Demo": DemoMacro.self,
]
#endif

final class DemoMacrosTests: XCTestCase {
    func testMacro() throws {
        #if canImport(DemoMacrosMacros)
        assertMacroExpansion(
            """
            @Demo
            struct DemoView: View {
                var body: some View {
                    Color.clear
                }
            }
            """,
            expandedSource: """
            struct DemoView: View {
                var body: some View {
                    Color.clear
                }
            }
            """,
            macros: testMacros
        )
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }
}
