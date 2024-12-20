import XCTest
import Combine
@testable import loginfun

final class ServerListViewModelTests: UnitTestCase {
   private var sut: Server.ListViewModel!
   private var mockAPI: MockAPIClient!
   private var mockStorage: MockSecureStorage!
   private var mockServersStorage: MockServersStorage!
   
   override func setUp() {
       super.setUp()
       mockAPI = MockAPIClient()
       mockStorage = MockSecureStorage()
       mockServersStorage = MockServersStorage()
       
       DIContainer.replace(APIClient.self, scope: .unique(self.mockAPI))
       DIContainer.replace(SecureStorage.self, scope: .unique(self.mockStorage))
       DIContainer.replace(ServersStorage.self, scope: .unique(self.mockServersStorage))
       
       sut = Server.ListViewModel()
   }
   
   override func tearDown() {
       mockAPI = nil
       mockStorage = nil
       mockServersStorage = nil
       sut = nil
       super.tearDown()
   }
   
   func test_filterByDistance_shouldSortServersByDistance() async throws {
       // given
       let servers = [
           Server.ServersEndpoint.ServerDTO(name: "Far Server", distance: 200),
           Server.ServersEndpoint.ServerDTO(name: "Close Server", distance: 50)
       ]
       let endpoint = Server.ServersEndpoint.servers
       mockAPI.mockResponse(servers, for: endpoint)
       mockStorage.set("test_token", forKey: "user.token")

       // when/then
       await sut.fetchServers()
       let state = try await awaitState(
           from: sut.$state,
           where: assertState(containsServerNames: ["Close Server", "Far Server"]),
           afterAction: { await MainActor.run { self.sut.filterByDistance() } }
       )
       
       XCTAssertTrue(state.isLoaded)
   }
   
   func test_filterAlphabetically_shouldSortServersByName() async throws {
       // given
       let servers = [
           Server.ServersEndpoint.ServerDTO(name: "Zeus", distance: 100),
           Server.ServersEndpoint.ServerDTO(name: "Apollo", distance: 200)
       ]
       let endpoint = Server.ServersEndpoint.servers
       mockAPI.mockResponse(servers, for: endpoint)
       mockStorage.set("test_token", forKey: "user.token")

       // when/then
       await sut.fetchServers()
       let state = try await awaitState(
           from: sut.$state,
           where: assertState(containsServerNames: ["Apollo", "Zeus"]),
           afterAction: { await MainActor.run { self.sut.filterAlphabetically() } }
       )
       
       XCTAssertTrue(state.isLoaded)
   }

   func test_fetchServers_whenTokenExists_shouldLoadServers() async throws {
       // given
       let servers = [
           Server.ServersEndpoint.ServerDTO(name: "Server A", distance: 100),
           Server.ServersEndpoint.ServerDTO(name: "Server B", distance: 200)
       ]
       let endpoint = Server.ServersEndpoint.servers
       mockAPI.mockResponse(servers, for: endpoint)
       mockStorage.set("test_token", forKey: "user.token")
       
       // when/then
       await sut.fetchServers()
       let state = try await awaitState(
           from: sut.$state,
           where: { $0.isLoaded }
       )
       
       if case let .loaded(displayableServers) = state {
           XCTAssertEqual(displayableServers.map { $0.name }, ["Server A", "Server B"])
       } else {
           XCTFail("Expected loaded state with servers")
       }
   }

   func test_fetchServers_whenTokenDoesNotExist_shouldReturnError() async throws {
       // given
       mockStorage.delete("user.token")

       // when/then
       await sut.fetchServers()
       let state = try await awaitState(
           from: sut.$state,
           where: { $0.isError }
       )
       
       if case .error(let error) = state {
           XCTAssertTrue(error is Server.Error)
           if let serverError = error as? Server.Error {
               XCTAssertEqual(serverError, .unauthorized)
           }
       } else {
           XCTFail("Expected error state")
       }
   }

   func test_logout_shouldSendLogoutRoute() async throws {
       let route = try await awaitState(
           from: sut.route,
           where: { $0.isLogout },
           afterAction: { self.sut.logout() }
       )

       XCTAssertTrue(route.isLogout)
   }
}

private extension ServerListViewModelTests {
   func assertState(containsServerNames names: [String]) -> (Server.ViewModelState) -> Bool {
       { state in
           guard case let .loaded(servers) = state else { return false }
           return servers.map { $0.name } == names
       }
   }
}

private extension Server.ViewModelState {
   var isLoading: Bool {
       if case .loading = self { return true }
       return false
   }
   
   var isLoaded: Bool {
       if case .loaded = self { return true }
       return false
   }
   
   var isError: Bool {
       if case .error = self { return true }
       return false
   }
}

private extension Server.Route {
   var isLogout: Bool {
       self == .logout
   }
}
