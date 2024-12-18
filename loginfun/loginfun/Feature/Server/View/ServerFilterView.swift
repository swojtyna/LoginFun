import SwiftUI
import Combine

struct ServerFilterView: View {
    @ObservedObject var listViewModel: Server.ListViewModel
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 16) {
                Text("Filter Servers")
                    .font(.title2)
                    .bold()

                Divider()

                // Filter options bound to ListViewModel
                FilterOption(title: "By Distance") {
                    listViewModel.filterByDistance()
                }

                FilterOption(title: "Alphabetical") {
                    listViewModel.filterAlphabetically()
                }

                Spacer()

                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Apply")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(8)
                }
            }
            .padding()
            .background(Color(UIColor.systemBackground))
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarItems(
                leading: Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Cancel")
                }
            )
        }
        .presentationDetents([.medium, .large])
    }
}

struct FilterOption: View {
    let title: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Text(title)
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }
        }
    }
}
