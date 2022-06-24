import SwiftUIBackports

struct ContentView: View {
    var body: some View {
        NavigationView {
            List {
                PresentationDemo()
            }
            .navigationBarTitle("Demos")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
