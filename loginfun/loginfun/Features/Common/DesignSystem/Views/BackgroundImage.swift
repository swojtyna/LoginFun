import SwiftUI

struct BackgroundImage: View {
    var body: some View {
        VStack(spacing: 0) {
            Color.white
                .frame(maxHeight: .infinity)
            Image("background")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: .infinity)
        }
        .ignoresSafeArea()
    }
}
