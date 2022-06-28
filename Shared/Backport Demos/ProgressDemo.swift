import SwiftUI
import SwiftUIBackports

struct ProgressDemo: View {
    var body: some View {
        NavigationLink {
            Demo()
        } label: {
            Text("ProgressView")
        }
    }
}

private struct Demo: View {
    @State private var downloadAmount: Float = 0.0
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()

    var body: some View {
        List {
            Backport.Section("Backport") {
                Backport.ProgressView()

                Backport.ProgressView("Title")

                Backport.ProgressView(value: 20, total: 100) {
                    Text("Circular")
                }
                .backport.progressViewStyle(.circular)

                Backport.ProgressView(value: downloadAmount) {
                    Text("Downloading...")
                } currentValueLabel: {
                    Text("Downloaded \(Int(downloadAmount * 100))%")
                }

                Backport.ProgressView("Nil value with total", value: nil, total: 1)
            }

            if #available(iOS 14, macOS 11, *) {
                Backport.Section("Native") {
                    ProgressView()

                    ProgressView("Title")

                    ProgressView(value: 20, total: 100) {
                        Text("Circular")
                    }
                    .progressViewStyle(.circular)

                    ProgressView(value: downloadAmount) {
                        Text("Downloading...")
                    } currentValueLabel: {
                        Text("Downloaded \(Int(downloadAmount * 100))%")
                    }

                    ProgressView("Nil value with total", value: nil, total: 1)
                }
            }
        }
        .backport.navigationTitle("Progress")
        .onReceive(timer) { _ in
            if downloadAmount < 1 {
                downloadAmount = min(1, downloadAmount + 0.02)
            }
        }
    }
}
