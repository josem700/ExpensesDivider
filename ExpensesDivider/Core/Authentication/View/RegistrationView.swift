//
//  RegistrationView.swift
//  ExpensesDivider
//
//  Created by Jose M on 5/7/24.
//

import SwiftUI

struct RegistrationView: View {
    @State private var email = ""
    @State private var fullname = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        VStack{
            //imagen
            Image("dinero")
                .resizable()
                .scaledToFill()
                .frame(width: 120, height: 120)
                .padding(.vertical, 32)
                .clipShape(Circle())
            
            Text("ExpensesDivider")
                .font(.title)
                .fontWeight(.bold)
                .foregroundStyle(.cyan)
        
            VStack(spacing: 24){
                InputView(text: $email, title: "Email", placeholder: "nombre@ejemplo.com")
                    .textInputAutocapitalization(.none)
                
                InputView(text: $fullname, title: "Nombre Completo", placeholder: "Introduce tu nombre")
                    .textInputAutocapitalization(.words)
                
                InputView(text: $password, title: "Contraseña", placeholder: "Introduce tu contraseña", isSecureField: true)
                
                InputView(text: $confirmPassword, title: "Confirma Contraseña", placeholder: "Confirma tu contraseña", isSecureField: true)
            }
            .padding(.horizontal)
            .padding(.top, 12)
            
            Button {
                Task{
                    try await viewModel.createUser(withEmail:email,
                                                   password: password,
                                                    fullname: fullname)
                }
            } label: {
                HStack{
                    Text("Registrarse")
                        .fontWeight(.semibold)
                    Image(systemName: "arrow.right")
                }
                .foregroundStyle(.white)
                .frame(width: UIScreen.main.bounds.width - 32, height: 48)
            }
            .background(Color(.systemMint))
            .clipShape(.rect(cornerRadius: 10))
            .padding(.top, 20)
            
            Spacer()
            
            Button{
                dismiss()
            }label: {
                HStack(spacing: 3){
                    Text("¿Ya tienes una cuenta?")
                    Text("Inicia Sesión")
                        .fontWeight(.bold)
                }
                .font(.system(size: 14))
            }
        }
    }
}

#Preview {
    RegistrationView()
}
