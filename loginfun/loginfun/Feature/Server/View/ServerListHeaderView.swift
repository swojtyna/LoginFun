import SwiftUI

private enum Constants {
    static let horizontalPadding: CGFloat = 16
    static let topPadding: CGFloat = 24
    static let bottomPadding: CGFloat = 8
    static let fontSize: CGFloat = 12
}

struct ServerListHeaderView: View {
    var body: some View {
        HStack {
            Text("SERVER")
                .foregroundStyle(.secondary)
                .font(.system(size: Constants.fontSize))
            Spacer()
            Text("DISTANCE")
                .foregroundStyle(.secondary)
                .font(.system(size: Constants.fontSize))
        }
        .padding(.top, Constants.topPadding)
        .padding(.bottom, Constants.bottomPadding)
        .padding(.horizontal, Constants.horizontalPadding)
        .background {
            Color(.systemGray6)
                .ignoresSafeArea(edges: .horizontal)
        }
    }
}
