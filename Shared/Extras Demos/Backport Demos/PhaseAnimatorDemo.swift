//import SwiftUI
//import SwiftUIBackports
//
//struct PhaseAnimatorDemo: View {
//    var body: some View {
//        NavigationLink {
//            Demo()
//                .navigationBarTitle(Text("Phase Animator"), displayMode: .inline)
//        } label: {
//            Text("Phase Animator")
//        }
//    }
//}
//
//private struct Demo: View {
//    @State private var trigger: Bool = false
//
//    var body: some View {
//        Form {
//            Text("TBD")
////            Backport.PhaseAnimator([false, true], trigger: trigger) { phase in
////                Backport.Label(phase.description, systemImage: "globe")
////                    .scaleEffect(phase ? 1.2 : 1)
////            } animation: { phase in
////                phase ? .easeOut(duration: 1) : .spring()
////            }
////            .onTapGesture {
////                trigger.toggle()
////            }
////
////            Backport.Label("Modifier", systemImage: "globe")
////                .backport.phaseAnimator([false, true], trigger: trigger) { content, phase in
////                    content
////                        .scaleEffect(phase ? 1.2 : 1)
////                } animation: { phase in
////                    phase ? .easeOut(duration: 1) : .spring()
////                }
////                .onTapGesture {
////                    trigger.toggle()
////                }
//        }
//    }
//}
