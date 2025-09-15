//
//  AddEditUserView.swift
//  ECommerceApp
//
//  Created by saurabh chaudhari on 05/09/25.
//

import SwiftUI

struct AddEditUserView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    
    var user: User?  // existing user (edit mode)
    
    @State private var name: String = ""
    @State private var email: String = ""
    
    var body: some View {
        NavigationStack {
            Form {
                Section("User Info") {
                    TextField("Name", text: $name)
                    TextField("Email", text: $email)
                }
            }
            .navigationTitle(user == nil ? "Add User" : "Edit User")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") { saveUser() }
                }
            }
            .onAppear {
                print("user is :: \(String(describing: user))")
                if let user = user {
                    name = user.name ?? ""
                    email = user.email ?? ""
                }
            }
        }
    }
    
    private func saveUser() {
        if let user = user {
            // Edit existing
            user.name = name
            user.email = email
        } else {
            // Add new
            let newUser = User(context: viewContext)
            newUser.uid = UUID()
            newUser.name = name
            newUser.email = email
            newUser.createdAt = Date()
        }
        
        do {
            try viewContext.save()
            dismiss()
        } catch {
            print("Error saving: \(error.localizedDescription)")
        }
    }
}


struct AddEditUserView_Previews: PreviewProvider {
    static var previews: some View {
        AddEditUserView()
    }
}
