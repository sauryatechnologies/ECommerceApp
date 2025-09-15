import SwiftUI

struct SignupView: View {
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Create Account")
                .font(.title2).bold()
            
            TextField("Name", text: $name)
                .padding(12)
                .background(Color(.secondarySystemBackground))
                .cornerRadius(12)
            
            TextField("Email", text: $email)
                .textInputAutocapitalization(.never)
                .keyboardType(.emailAddress)
                .autocorrectionDisabled()
                .padding(12)
                .background(Color(.secondarySystemBackground))
                .cornerRadius(12)
            
            SecureField("Password", text: $password)
                .padding(12)
                .background(Color(.secondarySystemBackground))
                .cornerRadius(12)
            
            Button("Sign Up") {
                // Action will come later
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.green)
            .foregroundColor(.white)
            .cornerRadius(12)
            
            Spacer()
        }
        .padding()
    }
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
    }
}
