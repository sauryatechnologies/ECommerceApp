//
//  ParallaxScrollView.swift
//  ECommerceApp
//
//  Created by saurabh chaudhari on 26/08/25.
//

import SwiftUI

struct ParallaxScrollView: View {
    var body: some View {
        ScrollView {
                    GeometryReader { geometry in
                        let offset = geometry.frame(in: .global).minY
                        
                        Image(systemName: "lock.shield.fill") // replace with your image
                            .resizable()
                            .scaledToFill()
                            .frame(width: geometry.size.width,
                                   height: offset > 0 ? 300 + offset : 300) // expand if pulled
                            .clipped()
                            .offset(y: offset > 0 ? -offset : offset / 2)
                            // 👆 Key trick: background moves slower
                    }
                    .frame(height: 300)
                    
                    VStack(spacing: 20) {
                        ForEach(1...30, id: \.self) { i in
                            Text("Row \(i)")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(10)
                        }
                    }
                    .padding()
                }
                .edgesIgnoringSafeArea(.top)
    }
}

struct ParallaxScrollView_Previews: PreviewProvider {
    static var previews: some View {
        ParallaxScrollView()
    }
}
