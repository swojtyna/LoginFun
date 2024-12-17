import SwiftUI

private enum Constants {
    static let fontSize: CGFloat = 17
}

struct ServerRowView: View {
    let displayable: Server.ServerRowDisplayable

    var body: some View {
        HStack {
            Text(displayable.name)
                .font(.system(size: Constants.fontSize))
            Spacer()
            Text(displayable.distance)
                .font(.system(size: Constants.fontSize))
        }
    }
}
