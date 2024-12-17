import SwiftUI

private struct Constants {
    static let height: CGFloat = 40
    static let cornerRadius: CGFloat = 10
    static let backgroundColor = Color(.systemGray5)
    
    static let iconSize: CGFloat = 16
    static let iconLeadingPadding: CGFloat = 8
    static let iconTrailingPadding: CGFloat = 8
    static let textTrailingPadding: CGFloat = 8
    
    static let placeholderColor = Color(red: 60/255, green: 60/255, blue: 67/255, opacity: 0.6)
    static let textColor = Color(red: 60/255, green: 60/255, blue: 67/255, opacity: 1.0)
    
    static let inactiveIconColor = Color(red: 60/255, green: 60/255, blue: 67/255, opacity: 0.6)
    static let activeIconColor = Color(red: 60/255, green: 60/255, blue: 67/255, opacity: 1.0)
}

struct TextFieldView: View {
    private let iconName: String
    private let placeholder: String
    @Binding private var text: String
    private let isSecure: Bool
    @FocusState private var isFocused: Bool
    
    init(
        iconName: String,
        placeholder: String,
        text: Binding<String>,
        isSecure: Bool = false
    ) {
        self.iconName = iconName
        self.placeholder = placeholder
        self._text = text
        self.isSecure = isSecure
    }
    
    var body: some View {
        HStack(spacing: 0) {
            iconView
            textField
        }
        .frame(height: Constants.height)
        .background(Constants.backgroundColor)
        .cornerRadius(Constants.cornerRadius)
    }
}

private extension TextFieldView {
    @ViewBuilder
    var iconView: some View {
        Image(iconName)
            .resizable()
            .renderingMode(.template)
            .aspectRatio(contentMode: .fit)
            .foregroundColor(isFocused ? Constants.activeIconColor : Constants.inactiveIconColor)
            .frame(width: Constants.iconSize, height: Constants.iconSize)
            .padding(.leading, Constants.iconLeadingPadding)
            .padding(.trailing, Constants.iconTrailingPadding)
    }
    
    var textField: some View {
        Group {
            if isSecure {
                SecureField(placeholder, text: $text)
                    .textContentType(.oneTimeCode)
                    .autocapitalization(.none)
                    .autocorrectionDisabled(true)

            } else {
                TextField(placeholder, text: $text)
                    .textContentType(.oneTimeCode)
                    .autocapitalization(.none)
                    .autocorrectionDisabled(true)
            }
        }
        .focused($isFocused)
        .foregroundColor(Constants.textColor)
        .tint(Constants.textColor)
        .padding(.trailing, Constants.textTrailingPadding)
    }
}

#Preview {
    VStack(spacing: 16) {
        TextFieldView(
            iconName: "user_icon",
            placeholder: "Username",
            text: .constant("")
        )
        
        TextFieldView(
            iconName: "lock_icon",
            placeholder: "Password",
            text: .constant(""),
            isSecure: true
        )
    }
    .padding()
}
