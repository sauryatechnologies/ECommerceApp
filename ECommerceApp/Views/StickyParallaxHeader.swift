//
//  StickyParallaxHeader.swift
//  ECommerceApp
//
//  Created by saurabh chaudhari on 26/08/25.
//

import SwiftUI

struct StickyParallaxHeader: View {
    var body: some View {
        ScrollView {
                    GeometryReader { geometry in
                        let offset = geometry.frame(in: .global).minY
                        
                        ZStack(alignment: .bottomLeading) {
                            // Background image with parallax & sticky effect
                            Image("img-1") // replace with your asset
                                .resizable()
                                .scaledToFill()
                                .frame(width: geometry.size.width,
                                       height: offset > 0 ? 300 + offset : 300)
                                .clipped()
                                .offset(y: offset > 0 ? -offset : offset / 2)
                            
                            // Gradient overlay (bottom to transparent)
                            LinearGradient(
                                gradient: Gradient(colors: [Color.black.opacity(0.6), .clear]),
                                startPoint: .bottom,
                                endPoint: .top
                            )
                            .frame(height: 200)
                            
                            // Title text (sticky on bottom)
                            Text("Album Title")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding()
                                .shadow(radius: 10)
                        }
                    }
                    .frame(height: 300)
                    
                    // Foreground content
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Album Description")
                            .font(.headline)
                        
                        Text("This layout combines sticky header, parallax effect, blur & gradient overlay, and sticky title text. Perfect for music, news, or photo apps.")
                            .font(.body)
                            .foregroundColor(.secondary)
                        
                        ForEach(1...20, id: \.self) { i in
                            Text("Row \(i)")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.gray.opacity(0.15))
                                .cornerRadius(10)
                        }
                    }
                    .padding()
                }
                .edgesIgnoringSafeArea(.top)
    }
}

struct StickyParallaxHeader_Previews: PreviewProvider {
    static var previews: some View {
        StickyParallaxHeader()
    }
}
