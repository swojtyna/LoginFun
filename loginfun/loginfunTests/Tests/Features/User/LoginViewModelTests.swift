import Combine
@testable import loginfun
import XCTest

final class LoginViewModelTests: UnitTestCase {
    private var sut: Login.ViewModel!
    private var mockAPI: MockAPIClient!
    private var mockStorage: MockSecureStorage!
    
    override func setUp() {
        super.setUp()
        mockAPI = MockAPIClient()
        mockStorage = MockSecureStorage()
        
        DIContainer.replace(APIClient.self, scope: .unique(self.mockAPI))
        DIContainer.replace(SecureStorage.self, scope: .unique(self.mockStorage))
        
        sut = Login.ViewModel()
    }
    
    override func tearDown() {
        mockAPI = nil
        mockStorage = nil
        sut = nil
        super.tearDown()
    }
    
    func test_onLoginTapped_whenCredentialsAreValid_shouldEmitSuccessRoute() async throws {
        // given
        let token = User.TokenEndpoint.TokenDTO(token: "test_token")
        let endpoint = User.TokenEndpoint.login(.init(username: "test_user", password: "test_pass"))
        mockAPI.mockResponse(token, for: endpoint)
        
        await MainActor.run {
            sut.username = "test_user"
            sut.password = "test_pass"
        }
        
        // when/then
        let route = try await awaitState(
            from: sut.route,
            where: { $0 == .loginSuccess },
            afterAction: {
                self.sut.onLoginTapped()
            }
        )
        
        XCTAssertEqual(route, .loginSuccess)
    }

    func test_onLoginTapped_whenLoginFails_shouldUpdateStateToError() async throws {
        // given
        let endpoint = User.TokenEndpoint.login(.init(username: "test_user", password: "test_pass"))
        mockAPI.mockError(Networking.Error.networkError(Networking.Error.unauthorized), for: endpoint)
       
        await MainActor.run {
            sut.username = "test_user"
            sut.password = "test_pass"
        }
       
        // when/then
        let state = try await awaitState(
            from: sut.$state,
            where: { $0.isError },
            afterAction: {
                self.sut.onLoginTapped()
            }
        )
       
        if case .error(let error) = state {
            XCTAssertTrue(error is Networking.Error)
            if let networkError = error as? Networking.Error {
                XCTAssertTrue(networkError.isUnauthorized)
            }
        } else {
            XCTFail("Expected error state")
        }
    }

    func test_onLoginTapped_shouldUpdateStateToLoading() async throws {
        // given
        let endpoint = User.TokenEndpoint.login(.init(username: "test_user", password: "test_pass"))
        mockAPI.mockResponse(User.TokenEndpoint.TokenDTO(token: "test_token"), for: endpoint)
       
        await MainActor.run {
            sut.username = "test_user"
            sut.password = "test_pass"
        }
       
        // when/then
        let state = try await awaitState(
            from: sut.$state,
            where: { $0.isLoading },
            afterAction: {
                self.sut.onLoginTapped()
            }
        )
       
        XCTAssertTrue(state.isLoading)
    }

    func test_onTapDismissErrorAction_shouldUpdateStateToIdle() async throws {
        // given
        let endpoint = User.TokenEndpoint.login(.init(username: "test_user", password: "test_pass"))
        mockAPI.mockError(Networking.Error.unauthorized, for: endpoint)
       
        await MainActor.run {
            sut.username = "test_user"
            sut.password = "test_pass"
        }
       
        // Get to error state first
        _ = try await awaitState(
            from: sut.$state,
            where: { $0.isError },
            afterAction: {
                self.sut.onLoginTapped()
            }
        )
       
        // when/then
        let state = try await awaitState(
            from: sut.$state,
            where: { $0.isIdle },
            afterAction: {
                await MainActor.run {
                    self.sut.onTapDismissErrorAction()
                }
            }
        )
       
        XCTAssertTrue(state.isIdle)
    }
}

// Helpers
private extension Login.ViewModelState {
    var isLoading: Bool {
        if case .loading = self { return true }
        return false
    }
    
    var isError: Bool {
        if case .error = self { return true }
        return false
    }
    
    var isIdle: Bool {
        if case .idle = self { return true }
        return false
    }
}
