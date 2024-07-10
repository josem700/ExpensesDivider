//
//  LoginView.swift
//  ExpensesDivider
//
//  Created by Jose M on 4/7/24.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @EnvironmentObject var viewModel:AuthViewModel
    
    var body: some View {
        NavigationStack{
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
                //Campos
                VStack(spacing: 24){
                    InputView(text: $email, title: "Email", placeholder: "nombre@ejemplo.com")
                        .textInputAutocapitalization(.none)
                    
                    InputView(text: $password, title: "Contraseña", placeholder: "Introduce tu contraseña", isSecureField: true)
                }
                .padding(.horizontal)
                .padding(.top, 12)
                
                //Boton login
                
                Button {
                    Task{
                        try await viewModel.singIn(withEmail: email, password: password)
                    }
                } label: {
                    HStack{
                        Text("Iniciar Sesión")
                            .fontWeight(.semibold)
                        Image(systemName: "arrow.right")
                    }
                    .foregroundStyle(.white)
                    .frame(width: UIScreen.main.bounds.width - 32, height: 48)
                }
                .background(Color(.systemMint))
                .clipShape(.rect(cornerRadius: 10))
                .padding(.top, 10)
                
                Spacer()
                
                //Boton registrarse
                
                NavigationLink{
                    RegistrationView()
                        .navigationBarBackButtonHidden()
                } label: {
                    HStack(spacing: 3){
                        Text("¿No tienes cuenta?")
                        Text("Regístrate")
                            .fontWeight(.bold)
                    }
                    .font(.system(size: 14))
                }
            }
        }
    }
}

#Preview {
    LoginView()
}
