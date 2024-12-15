import SwiftUI

struct ServerListView: View {
    @StateObject var viewModel: ServerListViewModel
    
    var body: some View {
        Group {
            switch viewModel.state {
            case .loading:
                ProgressView()
            case .loaded(let servers):
                List(servers, id: \.name) { server in
                    ServerRowView(server: server)
                }
            case .error(let error):
                Text(error.localizedDescription)
            }
        }
        .navigationTitle("Servers")
        .onAppear {
            Task {
                await viewModel.fetchServers()
            }
        }
    }
}

struct ServerRowView: View {
    let server: Server.Model
    
    var body: some View {
        HStack {
            Text(server.name)
            Spacer()
            Text(String(format: "%.1f km", server.distance))
                .foregroundColor(.secondary)
        }
    }
}
