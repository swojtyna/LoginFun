import Foundation

extension DIContainer {
    static func registerNetworkingClient() {
        registerAPIClient()
    }
}

private extension DIContainer {
    static func registerAPIClient() {
        register(
            APIClient.self,
            scope: .unique(Networking.APIClientImpl())
        )
    }
}
