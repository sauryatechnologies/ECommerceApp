import SwiftUI

enum AuthDestination: Hashable {
    case forgotPassword
    case signUp
}

struct LoginView: View {
    @EnvironmentObject var cartVM: CartViewModel
    @EnvironmentObject var authVM: AuthViewModel
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var path: [AuthDestination] = []

    var body: some View {
        NavigationStack(path: $path) {
            VStack(spacing: 18) {
                Image(systemName: "lock.shield.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .padding(.bottom, 8)
                
                Text("Welcome Back")
                    .font(.title2).bold()
                
                VStack(spacing: 18) {
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
                }
                .padding(.top, 8)
                
                if authVM.isLoading {
                    ProgressView()
                        .padding()
                } else {
                    Button("Login") {
                        authVM.login()
                    }
                    .buttonStyle(.borderedProminent)
                }
                
                if let error = authVM.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .padding(.top, 4)
                }
                
                HStack {
                    Button("Forgot Password?") { path.append(.forgotPassword) }
                    Spacer()
                    Button("Sign Up") { path.append(.signUp) }
                }
                .padding(.top, 8)
            }
            .padding()
            .navigationDestination(for: AuthDestination.self) { destination in
                switch destination {
                case .forgotPassword:
                    ForgotPasswordView()
                case .signUp:
                    SignupView()
                }
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
