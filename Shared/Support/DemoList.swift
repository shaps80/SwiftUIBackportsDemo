//import SwiftUI
//import SwiftUIBackports
//import Demo
//
//public struct DemoList<Content: View>: View {
//    public let content: Content
//
//    public init(@ViewBuilder content: () -> Content) {
//        self.content = content()
//    }
//
//    public var body: some View {
//        List {
//            Backport.ForEach(subviewOf: content) { subview in
//                Demo { subview }
//            }
//        }
//    }
//}
