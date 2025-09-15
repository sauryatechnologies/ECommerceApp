import SwiftUI
import CoreData

struct UserListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \User.createdAt, ascending: true)],
        animation: .default
    )
    private var users: FetchedResults<User>
    
    @State private var showAddUser = false
    @State private var selectedUser: User?
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(users) { user in
                    VStack(alignment: .leading) {
                        Text(user.name ?? "No Name").font(.headline)
                        Text(user.email ?? "No Email").font(.subheadline).foregroundColor(.secondary)
                    }
                    .onTapGesture {
                        selectedUser = user
                    }
                    
                }
                .onDelete(perform: deleteUsers)
            }
            .navigationTitle("Users")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showAddUser = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            // 👇 Present add sheet
            .sheet(isPresented: $showAddUser) {
                AddEditUserView(user: nil)   // new user
            }
            // 👇 Present edit sheet
            .sheet(item: $selectedUser) { user in
                AddEditUserView(user: user) // edit mode
            }
        }
    }
    
    private func deleteUsers(offsets: IndexSet) {
        withAnimation {
            offsets.map { users[$0] }.forEach(viewContext.delete)
            saveContext()
        }
    }
    
    private func saveContext() {
        do {
            try viewContext.save()
        } catch {
            print("Error saving: \(error.localizedDescription)")
        }
    }
}


struct UserListView_Previews: PreviewProvider {
    static var previews: some View {
        UserListView()
    }
}
