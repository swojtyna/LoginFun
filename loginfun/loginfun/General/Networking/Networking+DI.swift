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
            scope: .application(Networking.APIClientImpl())
        )
    }
}
