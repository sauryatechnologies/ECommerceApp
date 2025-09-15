//
//  ProfileView.swift
//  ECommerceApp
//
//  Created by saurabh chaudhari on 21/08/25.
//

import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject var authVM: AuthViewModel
    @EnvironmentObject var profileVM: ProfileViewModel
    
    
    @State private var showEdit = false   // <--- state for modal

    var body: some View {
            Form {
                Section("Profile") {
                    HStack {
                        Image(systemName: "person.crop.circle.fill")
                            .font(.system(size: 48))
                        VStack(alignment: .leading) {
                            Text(profileVM.fullName).font(.headline)
                            Text(authVM.currentUser?.email ?? "no-email").font(.subheadline).foregroundColor(.secondary)
                        }
                        Spacer()
                        Button {
                            showEdit = true
                        } label: {
                            Image(systemName: "pencil")
                                .font(.system(size: 24))
                                .foregroundColor(.primary) // optional, to set color
                        }
                        .buttonStyle(.plain) // keeps it from having extra button styling
                    }
                    HStack {
                        Text("Member since")
                        Spacer()
                        Text(profileVM.memberSince).foregroundColor(.secondary)
                    }
                    
                    Text("Decorative Text").accessibilityHidden(false)
                }

                Section {
                    Button(role: .destructive) {
                        authVM.logout()
                    } label: {
                        Label("Logout", systemImage: "rectangle.portrait.and.arrow.right")
                    }
                }
            }
            .navigationTitle("Profile")
//            .fullScreenCover(isPresented: $showEdit, content: {
//                EditProfileView(vm: profileVM)
//            })
            .sheet(isPresented: $showEdit) {   // <--- modal presentation
                EditProfileView(vm: profileVM)
            }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

