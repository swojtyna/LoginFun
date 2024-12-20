import Combine
import SwiftUI

extension Login {
    final class ViewModel: ObservableObject {
        @MainActor @Published var username = ""
        @MainActor @Published var password = ""
        @MainActor @Published private(set) var state: ViewModelState = .idle
        
        var route: AnyPublisher<Login.Route, Never> {
            routeSubject.eraseToAnyPublisher()
        }

        private let routeSubject = PassthroughSubject<Login.Route, Never>()
        
        @LazyInjected private var loginUseCase: UserLoginUseCase
        
        func onLoginTapped() {
            Task {
                await login()
            }
        }
        
        @MainActor
        func onTapDismissErrorAction() {
            state = .idle
        }
    }
}

private extension Login.ViewModel {
    @MainActor
    func login() async {
        state = .loading
        
        do {
            try await loginUseCase.execute(
                username: username,
                password: password
            )
            routeSubject.send(.loginSuccess)
        } catch {
            state = .error(error)
        }
    }
}
