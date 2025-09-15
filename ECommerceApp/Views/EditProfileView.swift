//
//  EditProfileView.swift
//  ECommerceApp
//
//  Created by saurabh chaudhari on 04/09/25.
//

import SwiftUI

struct EditProfileView: View {
    
    @ObservedObject var vm: ProfileViewModel
    @Environment(\.dismiss) var dismiss
    
    @State private var fullName: String = ""
    @State private var email: String = ""
    @State private var memberSince: String = ""
    
    
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Edit Info") {
                    TextField("Full Name", text: $fullName)
                    TextField("Email", text: $email)
                    TextField("Member Since", text: $memberSince)
                }
            }
            .navigationTitle("Edit Profile")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        vm.fullName = fullName   // update ViewModel
                        dismiss()
                    }
                }
            }
        }
        .onAppear {
            print("edit profile view")
            fullName = vm.fullName   // preload current value
            email = vm.email
            memberSince = vm.memberSince
        }
    }
}


struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        let mockVM = ProfileViewModel()
        mockVM.fullName = "Saurabh Chaudhari"
        mockVM.memberSince = "Jan 2024"
        
        return EditProfileView(vm: mockVM)
    }
}
