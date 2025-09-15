//
//  ECommerceAppApp.swift
//  ECommerceApp
//
//  Created by saurabh chaudhari on 21/08/25.
//

import SwiftUI

@main
struct ECommerceAppApp: App {
    
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            Group {
                RootView()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            }
        }
    }
}
