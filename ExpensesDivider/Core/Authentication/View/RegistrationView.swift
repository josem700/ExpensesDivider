//
//  RegistrationView.swift
//  ExpensesDivider
//
//  Created by Jose M on 5/7/24.
//

import SwiftUI

struct RegistrationView: View {
    @State private var email = ""
    @State private var name = ""
    @State private var surname = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        ScrollView{
            VStack{
                //imagen
                Image("dinero")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 120, height: 120)
                    .padding(.vertical,20)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(.black, lineWidth: 2)) 
                
                Text("ExpensesDivider")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(.cyan)
                
                VStack(spacing: 24){
                    InputView(text: $email, title: "Email", placeholder: "nombre@ejemplo.com")
                        .textInputAutocapitalization(.never)
                    
                    InputView(text: $name, title: "Nombre", placeholder: "Introduce tu nombre")
                        .textInputAutocapitalization(.words)
                    
                    InputView(text: $surname, title: "Apellidos", placeholder: "Introduce tu nombre")
                        .textInputAutocapitalization(.words)
                    
                    InputView(text: $password, title: "Contraseña", placeholder: "Introduce tu contraseña", isSecureField: true)
                    
                    ZStack(alignment: .trailing){
                        InputView(text: $confirmPassword, title: "Confirma Contraseña", placeholder: "Confirma tu contraseña", isSecureField: true)
                        
                        if(!password.isEmpty && !confirmPassword.isEmpty){
                            if password == confirmPassword{
                                Image(systemName: "checkmark.circle.fill")
                                    .imageScale(.large)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(.systemGreen))
                            }else{
                                Image(systemName: "xmark.circle.fill")
                                    .imageScale(.large)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(.systemRed))
                            }
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.top, 12)
                
                //Boton registro
                Button {
                    Task{
                        try await viewModel.createUser(withEmail:email,
                                                       password: password,
                                                       name: name,
                                                       surname: surname)
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
                .disabled(!formIsValid)
                .opacity(formIsValid ? 1.0 : 0.5)
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
                    .padding(.bottom, 20)
                }
            }
        }
    }
}

//Con esta extension hacemos que la variable formisvalid sea true o false en funcion de una serie de condiciones
extension RegistrationView: AuthenticationFormProtocol {
    var formIsValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count>5
        && !name.isEmpty
        && !surname.isEmpty
        && password==confirmPassword
    }
}

#Preview {
    RegistrationView().environmentObject(AuthViewModel())
}
