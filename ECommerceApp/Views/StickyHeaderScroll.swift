//
//  StickyHeaderScroll.swift
//  ECommerceApp
//
//  Created by saurabh chaudhari on 26/08/25.
//

import SwiftUI

struct StickyHeaderScroll: View {
    var body: some View {
        //Sticky header inside scroll view
        ScrollView {
                    GeometryReader { geometry in
                        let offset = geometry.frame(in: .global).minY
                        
                        Image(systemName: "lock.shield.fill") // replace with your asset
                            .resizable()
                            .scaledToFit()
                            .frame(width: geometry.size.width,
                                   height: offset > 0 ? 100 + offset : 100) // expand on pull
                            .clipped()
                            .offset(y: offset > 0 ? -offset : 0) // stick at top
                    }
                    .frame(height: 100) // fixed height for header
                    
                    VStack(spacing: 20) {
                        ForEach(0..<30) { i in
                            Text("Row \(i)")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue.opacity(0.2))
                                .cornerRadius(10)
                        }
                    }
                    .padding()
                }
                .edgesIgnoringSafeArea(.top)
    }
}

struct StickyHeaderScroll_Previews: PreviewProvider {
    static var previews: some View {
        StickyHeaderScroll()
    }
}
