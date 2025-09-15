import SwiftUI

enum Tab {
    case products, cart, profile, users
}

struct HomeView: View {
    @EnvironmentObject var cartVM: CartViewModel
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false
    @State private var selectedTab: Tab = .products
    
    var body: some View {
        
        TabView(selection: $selectedTab) {
            NavigationStack {
                ProductListView(selectedTab: $selectedTab)
            }
            .tabItem {
                Label("Products", systemImage: "cart.fill.badge.plus")
            }
            .tag(Tab.products)
            
            NavigationStack {
                CartView()
            }
            .tabItem {
                Label("Cart", systemImage: "cart.fill")
            }
            .tag(Tab.cart)
            
            NavigationStack {
                ProfileView()
            }
            .tabItem {
                Label("Profile", systemImage: "person.crop.circle.fill")
            }
            .tag(Tab.profile)
            
            NavigationStack {
                UserListView()
            }
            .tabItem { Label("Users", systemImage: "person.3") }
            .tag(Tab.users)
        }
        .navigationTitle(navigationTitle(for: selectedTab))
        
    }
    
    private func navigationTitle(for tab: Tab) -> String {
        switch tab {
        case .products: return "Products"
        case .cart: return "Cart"
        case .profile: return "Profile"
        case .users: return "User"
        }
    }
}



struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
