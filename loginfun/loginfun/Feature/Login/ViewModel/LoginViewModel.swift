import Combine
import SwiftUI

class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    
    private let routeSubject = PassthroughSubject<Login.Route, Never>()
    var route: AnyPublisher<Login.Route, Never> {
        routeSubject.eraseToAnyPublisher()
    }
      
    func onLoginTapped() {
        routeSubject.send(.loginSuccess)
    }
}
