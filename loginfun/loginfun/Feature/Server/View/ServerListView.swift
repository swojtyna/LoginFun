import SwiftUI

private enum Constants {
    // Dimensions
    static let iconSize: CGFloat = 16
    
    // Spacing
    static let loadingTopPadding: CGFloat = 8
    
    // List
    static let rowInsets = EdgeInsets(
        top: 12,
        leading: 16,
        bottom: 12,
        trailing: 16
    )
    
    // Font
    static let loadingTextSize: CGFloat = 13
}

struct ServerListView: View {
    @StateObject var viewModel: Server.ListViewModel
    
    var body: some View {
        ZStack {
            BackgroundImage()
            
            Group {
                switch viewModel.state {
                case .loading:
                    loadingView
                case .loaded(let servers):
                    if servers.isEmpty {
                        emptyView
                    } else {
                        serversList(servers)
                    }
                case .error:
                    errorView
                }
            }
        }
        .navigationTitle("Testio.")
        .navigationBarBackButtonHidden()
        .toolbar(.visible, for: .navigationBar)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) { filterButton }
            ToolbarItem(placement: .topBarTrailing) { logoutButton }
        }
        .onAppear {
            Task {
                await viewModel.fetchServers()
            }
        }
    }
}

private extension ServerListView {
    var loadingView: some View {
        VStack {
            Spacer()
            ProgressView()
            Text("Loading list")
                .font(.system(size: Constants.loadingTextSize))
                .foregroundColor(.secondary)
                .padding(.top, Constants.loadingTopPadding)
            Spacer()
        }
    }
    
    var emptyView: some View {
        ContentUnavailableView(
            "No Servers",
            systemImage: "server.rack",
            description: Text("There are no servers available")
        )
    }
    
    var errorView: some View {
        ContentUnavailableView {
            Label("Error", systemImage: "exclamationmark.triangle")
        } description: {
            Text("Something went wrong. Please try again")
        } actions: {
            Button("Try Again") {
                Task {
                    await viewModel.fetchServers()
                }
            }
        }
    }
    
    func serversList(_ items: [Server.ServerRowDisplayable]) -> some View {
        VStack(spacing: 0) {
            ServerListHeaderView()
            List(items) { item in
                ServerRowView(displayable: item)
                    .listRowInsets(Constants.rowInsets)
            }
            .listStyle(.plain)
        }
    }
    
    var filterButton: some View {
        Button {
            viewModel.filter()
        } label: {
            HStack {
                Image(systemName: "arrow.up.arrow.down")
                    .resizable()
                    .frame(width: Constants.iconSize, height: Constants.iconSize)
                Text("Filter")
            }
            .foregroundColor(.blue)
        }
    }
    
    var logoutButton: some View {
        Button {
            viewModel.logout()
        } label: {
            Text("Logout")
            Image("logout-icon")
                .resizable()
                .frame(width: Constants.iconSize, height: Constants.iconSize)
        }
    }
}
