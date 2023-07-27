//import SwiftUI
//import SwiftUIBackports
//
//struct InspectorDemo: View {
//    @Binding var showInspectorOutsideNavigation: Bool
//    var body: some View {
//        NavigationLink {
//            Demo(outside: $showInspectorOutsideNavigation)
//                .backport.navigationTitle("Inspector")
//        } label: {
//            Text("Inspector")
//        }
//    }
//}
//
//private struct Demo: View {
//    @State private var inside: Bool = false
//    @State private var showCustom: Bool = false
//    @Binding var outside: Bool
//
//    var body: some View {
//        Form {
//            NavigationLink("Inside Navigation") {
//                InspectorDetailDemo(isPresented: $inside)
//                    .backport.inspector(isPresented: $inside) {
//                        InspectorDetail()
//                    }
//            }
//
//            NavigationLink("Ouside Navigation") {
//                InspectorDetailDemo(isPresented: $outside)
//            }
//
//            Button("Custom") {
//                showCustom = true
//            }
//        }
//        .formStyle()
//        .sheet(isPresented: $showCustom) {
//            GeometryReader { _ in
//                ZStack {
//                    Color.clear
//                    Custom(isPresented: $inside)
//                }
//            }
//            .backport.overlay(alignment: .topTrailing) {
//                Button {
//                    showCustom = false
//                } label: {
//                    Image(systemName: "xmark.circle.fill")
//                        .imageScale(.large)
//                }
//                .padding(20)
//            }
//        }
//    }
//
//    struct Custom: View {
//        @Binding var isPresented: Bool
//        var body: some View {
//            InspectorDetailDemo(isPresented: $isPresented)
//                .backport.inspector(isPresented: $isPresented) {
//                    InspectorDetail()
//                }
//        }
//    }
//
//    struct OutsideNavigation: View {
//        @Binding var isPresented: Bool
//
//        var body: some View {
//            InspectorDetailDemo(isPresented: $isPresented)
//        }
//    }
//}
//
//private struct InspectorDetailDemo: View {
//    @Binding var isPresented: Bool
//    var body: some View {
//        Button("Toggle Inspector") {
//            isPresented.toggle()
//        }
//    }
//}
//
//struct InspectorDetail: View {
//    var body: some View {
//        Form {
//            ForEach(0...100, id: \.self) { index in
//                Text("Item \(index + 1)")
//            }
//        }
//        .formStyle()
//        .extendedPresentation()
//        .navigationBarItems(trailing: Image(systemName: "info.circle"))
//    }
//}
//
//private extension View {
//    @ViewBuilder
//    func extendedPresentation() -> some View {
//        if #available(iOS 15, macOS 12, *) {
//            self
//                .backport.presentationBackgroundInteraction(.enabled)
//                .backport.presentationDetents([.medium])
//        } else {
//            self
//        }
//    }
//}
