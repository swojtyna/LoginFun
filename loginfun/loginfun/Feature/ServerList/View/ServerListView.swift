import SwiftUI

struct ServerListView: View {
    @StateObject var viewModel: ServerListViewModel
    
    var body: some View {
        List(0..<10) { index in
            Text("Server \(index)")
        }
        .navigationTitle("Servers")
    }
}
