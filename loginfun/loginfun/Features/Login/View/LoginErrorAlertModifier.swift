import SwiftUI

struct LoginErrorAlertModifier: ViewModifier {
    let error: Error?
    let onDismiss: () -> Void

    func body(content: Content) -> some View {
        content.alert(
            title,
            isPresented: .constant(error != nil),
            actions: {
                Button("OK") { onDismiss() }
            },
            message: {
                Text(message)
            }
        )
    }
}

extension View {
    func loginErrorAlert(_ error: Error?, onDismiss: @escaping () -> Void) -> some View {
        modifier(LoginErrorAlertModifier(error: error, onDismiss: onDismiss))
    }
}

private extension LoginErrorAlertModifier {
   var title: String {
       switch error as? Networking.Error {
       case let error? where error.isUnauthorized:
           return "Verification Failed"
       default:
           return "Error"
       }
   }
   
   var message: String {
       switch error as? Networking.Error {
       case let error? where error.isUnauthorized:
           return "Your username or password is incorrect."
       case .some:
           return "Please check your internet connection and try again."
       case .none:
           return "Something went wrong. Please try again."
       }
   }
}
