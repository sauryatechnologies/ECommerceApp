
import SwiftUI

struct FlipkartScreen: View {
    
    // Sample data
    let horizontalItems = Array(1...10).map { "H \($0)" }
    let gridItems = Array(1...4).map { "G \($0)" }
    let tableItems = Array(1...20).map { "T \($0)" }
    
    // Grid layout for 2x2
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    // Search state
    @State private var searchText = ""
    
    // Filtered table items
    var filteredTableItems: [String] {
        if searchText.isEmpty {
            return tableItems
        } else {
            return tableItems.filter { $0.lowercased().contains(searchText.lowercased()) }
        }
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    
                    // MARK: Horizontal List
                    Text("Horizontal List")
                        .font(.headline)
                        .padding(.leading)
                    
                    GeometryReader { geometry in
                        let itemWidth = geometry.size.width / 4 - 12 // 4 items per screen
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHStack(spacing: 8) {
                                ForEach(horizontalItems, id: \.self) { item in
                                    VStack {
                                        Image(systemName: "bag.fill") // placeholder icon
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: itemWidth * 0.6, height: itemWidth * 0.6)
                                            .foregroundColor(.white)
                                        
                                        Text(item)
                                            .font(.caption)
                                            .foregroundColor(.white)
                                    }
                                    .frame(width: itemWidth, height: itemWidth)
                                    .background(Color.blue.opacity(0.7))
                                    .cornerRadius(10)
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                    .frame(height: UIScreen.main.bounds.width / 4)
                    
                    Divider()
                    
                    // MARK: Grid View (2x2)
                    Text("Grid View")
                        .font(.headline)
                        .padding(.leading)
                    
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(gridItems, id: \.self) { item in
                            VStack {
                                Image(systemName: "cart.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 60)
                                    .foregroundColor(.white)
                                
                                Text(item)
                                    .font(.subheadline)
                                    .foregroundColor(.white)
                            }
                            .frame(maxWidth: .infinity, minHeight: 120)
                            .background(Color.green.opacity(0.7))
                            .cornerRadius(10)
                        }
                    }
                    .padding(.horizontal)
                    
                    Divider()
                    
                    // MARK: Table View (List-like)
                    Text("Table View")
                        .font(.headline)
                        .padding(.leading)
                    
                    LazyVStack(spacing: 12) {
                        ForEach(tableItems, id: \.self) { item in
                            HStack(spacing: 12) {
                                Image(systemName: "shippingbox.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50, height: 50)
                                    .foregroundColor(.blue)
                                
                                Text(item)
                                    .font(.body)
                                    .foregroundColor(.black)
                                
                                Spacer()
                            }
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(10)
                            .padding(.horizontal)
                        }
                    }
                }
                .padding(.vertical)
            }
            .navigationTitle("Flipkart Screen")
            .navigationBarTitleDisplayMode(.inline)
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search items...")
        }
        
    }
}

struct FlipkartScreen_Previews: PreviewProvider {
    static var previews: some View {
        FlipkartScreen()
    }
}
