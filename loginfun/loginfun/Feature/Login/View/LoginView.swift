import SwiftUI

private enum Constants {
    // Dimensions
    static let width: CGFloat = 366
    static let formHeight: CGFloat = 40
    static let logoWidth: CGFloat = 186
    static let logoHeight: CGFloat = 48
    
    // Spacing
    static let topPadding: CGFloat = {
        UIScreen.main.bounds.height * 0.2293853073
    }()
    static let horizontalPadding: CGFloat = 32
    static let bottomSpacing: CGFloat = 40
    static let formSpacing: CGFloat = 16
    static let buttonSpacing: CGFloat = 24
    
    // UI
    static let cornerRadius: CGFloat = 10
}

struct LoginView: View {
    @StateObject var viewModel: Login.ViewModel
    
    var body: some View {
        ZStack {
            BackgroundImage()
            ScrollView {
                VStack {
                    mainContent
                        .padding(.top, Constants.topPadding)
                    Spacer()
                }
            }
            .toolbar(.hidden, for: .navigationBar)
        }
        .loginErrorAlert(viewModel.state.error) {
            viewModel.onTapDismissErrorAction()
        }
    }
}

private extension LoginView {
    var mainContent: some View {
        VStack(spacing: 0) {
            logo
                .padding(.bottom, Constants.bottomSpacing)
            loginForm
        }
        .padding(.horizontal, Constants.horizontalPadding)
    }
    
    var logo: some View {
        Image("logo")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: Constants.logoWidth, height: Constants.logoHeight)
    }
    
    var loginForm: some View {
        VStack(spacing: 0) {
            TextFieldView(
                iconName: "user_icon",
                placeholder: "Username",
                text: $viewModel.username
            )
            .padding(.bottom, Constants.formSpacing)
            
            TextFieldView(
                iconName: "lock_icon",
                placeholder: "Password",
                text: $viewModel.password,
                isSecure: true
            )
            .padding(.bottom, Constants.buttonSpacing)
            
            loginButton
        }
    }
    
    var loginButton: some View {
        Button(action: {
            viewModel.onLoginTapped()
        }) {
            Text("Log in")
        }
        .frame(height: Constants.formHeight)
        .frame(maxWidth: .infinity)
        .background(Color.blue)
        .foregroundColor(.white)
        .cornerRadius(Constants.cornerRadius)
    }
}

#Preview {
    LoginView(viewModel: .init())
}
