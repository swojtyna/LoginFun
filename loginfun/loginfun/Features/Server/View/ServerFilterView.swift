import SwiftUI
import Combine

private enum Constants {
   // Spacing
   static let verticalSpacing: CGFloat = 16
   static let contentPadding: CGFloat = 16
   static let buttonCornerRadius: CGFloat = 8
   
   // Font
   static let titleFont: Font = .title2.bold()
}

struct ServerFilterView: View {
   @ObservedObject var listViewModel: Server.ListViewModel
   @Environment(\.presentationMode) var presentationMode
   
   var body: some View {
       NavigationView {
           content
               .padding(Constants.contentPadding)
               .background(Color(UIColor.systemBackground))
               .navigationBarTitle("", displayMode: .inline)
               .navigationBarItems(leading: cancelButton)
       }
       .presentationDetents([.medium, .large])
   }
}

private extension ServerFilterView {
   var content: some View {
       VStack(alignment: .leading, spacing: Constants.verticalSpacing) {
           title
           Divider()
           filterOptions
           Spacer()
           applyButton
       }
   }
   
   var title: some View {
       Text("Filter Servers")
           .font(Constants.titleFont)
   }
   
   var filterOptions: some View {
       VStack(spacing: Constants.verticalSpacing) {
           FilterOption(title: "By Distance") {
               listViewModel.filterByDistance()
           }
           
           FilterOption(title: "Alphabetical") {
               listViewModel.filterAlphabetically()
           }
       }
   }
   
   var applyButton: some View {
       Button(action: dismiss) {
           Text("Apply")
               .foregroundColor(.white)
               .padding()
               .frame(maxWidth: .infinity)
               .background(Color.blue)
               .cornerRadius(Constants.buttonCornerRadius)
       }
   }
   
   var cancelButton: some View {
       Button(action: dismiss) {
           Text("Cancel")
       }
   }
   
   func dismiss() {
       presentationMode.wrappedValue.dismiss()
   }
}

private struct FilterOption: View {
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

#Preview {
   ServerFilterView(listViewModel: .init())
}
