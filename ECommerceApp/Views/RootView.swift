import SwiftUI

struct RootView: View {
    @StateObject private var cartVM = CartViewModel()
    @StateObject private var authVM = AuthViewModel()
    @StateObject private var profileVM = ProfileViewModel()
    
    var body: some View {
        Group {
                   if authVM.isLoggedIn {
                       HomeView()
                           .transition(.slide)
                           .environmentObject(cartVM)
                           .environmentObject(authVM)
                           .environmentObject(profileVM)
                   } else {
                       LoginView()
                           .transition(.slide)
                           .environmentObject(cartVM)
                           .environmentObject(authVM)
                   }
               }
               .animation(.easeInOut, value: authVM.isLoggedIn)
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}

