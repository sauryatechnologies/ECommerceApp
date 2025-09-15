import SwiftUI

struct ForgotPasswordView: View {
    @State private var email: String = ""
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Forgot Password")
                .font(.title2).bold()
            
            Text("Enter your email to reset your password")
                .font(.subheadline)
                .foregroundColor(.gray)
            
            TextField("Email", text: $email)
                .textInputAutocapitalization(.never)
                .keyboardType(.emailAddress)
                .autocorrectionDisabled()
                .padding(12)
                .background(Color(.secondarySystemBackground))
                .cornerRadius(12)
            
            Button("Reset Password") {
                // Action will come later
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(12)
            
            Spacer()
        }
        .padding()
    }
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView()
    }
}
