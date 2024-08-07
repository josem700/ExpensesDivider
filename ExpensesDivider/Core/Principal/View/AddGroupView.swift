//
//  AddGroupView.swift
//  ExpensesDivider
//
//  Created by Jose M on 26/7/24.
//

import SwiftUI

struct AddGroupView: View {
    @EnvironmentObject var groupVM:GroupViewModel
    @EnvironmentObject var authVM:AuthViewModel
    @State private var groupTitle = ""
    @State private var selectedCurrency = ""
    private var currencies = ["Euro (€)", "Dolares ($)", "Yenes (JPY)"]
    @State private var newUser = ""
    @State private var groupUsers:[String] = []
    @Environment(\.dismiss) var dismiss
    @State private var showingAlert = false
    @State private var showErrorAlert = false
    @State private var showAddSelfError = false
    
    var body: some View {
        VStack(spacing: 24){
            Text("Crear Nuevo Grupo")
                .font(.title)
                .foregroundStyle(.cyan)
                .fontWeight(.bold)
                .padding(.top, 30)
            InputView(text: $groupTitle, title: "Título del grupo", placeholder: "Piso Granada")
                .padding(10)
            
            HStack {
                Picker("Moneda", selection: $selectedCurrency){
                    ForEach(currencies, id: \.self) { currency in
                        Text(currency)
                            .font(.caption)
                            .fontWeight(.medium)
                    }
                }
                .foregroundStyle(.black)
                .padding(10)
                .pickerStyle(.palette)
            }
            List() {
                ForEach(groupUsers, id: \.self){user in
                    if(user == authVM.currentUser?.email){
                        Text("Yo")
                    }else{
                        Text(user)
                    }
                }.onDelete(perform: { indexSet in
                    groupUsers.remove(atOffsets: indexSet)
                })
                HStack{
                    TextField("", text: $newUser, prompt: Text("Introduce email"))
                        .font(.system(size: 14))
                        .background(Color(.clear))
                        .textInputAutocapitalization(.never)
                    
                    if(!newUser.isEmpty){
                        Image(systemName: emailIsValid ? "checkmark.circle.fill" : "xmark.circle.fill")
                            .foregroundStyle(emailIsValid ? .green : .red)
                    }
                }
                    
                Button("Añadir Usuario", role: .none){
                    if(emailIsValid){
                        Task{
                          let participant =  await authVM.fetchOneUser(userId: newUser)
                            if(participant == nil){
                                showingAlert = true
                                newUser = ""
                            }else if (participant?.email == authVM.currentUser?.email){
                                showAddSelfError = true
                                newUser = ""
                            }else{
                                groupUsers.append(newUser)
                                newUser = ""
                            }
                        }
                    }
                }.alert(isPresented: $showErrorAlert, content: {
                    Alert(title: Text("Usuario no encontrado"),message: Text("Usuario no encontrado. Los usuarios deben estar previamente registrados."))
                })
                .alert(isPresented: $showAddSelfError, content: {
                    Alert(title: Text("Ya estás en el grupo"),message: Text("No puedes añadirte a ti mismo, ya estás dentro del grupo."))
                })
            }
            
            Button(){
                showingAlert = true
            }label: {
                HStack{
                    Text("Crear Grupo")
                        .fontWeight(.semibold)
                    Image(systemName: "plus.circle")
                }
                .foregroundStyle(.white)
                .frame(width: UIScreen.main.bounds.width - 32, height: 48)
            }
            .alert("¿Desea crear el grupo? Los usuarios indicados aparecerán cuando acepten la invitación.", isPresented: $showingAlert) {
                
                Button("Aceptar"){
                    //Funcion crear grupo
                    Task{
                        //await authVM.fetchUser()
                        try await groupVM.createGroup(title: groupTitle, currency: selectedCurrency, members: groupUsers, currentUser: authVM.currentUser)
                        //await authVM.fetchUser()
                        await authVM.fetchGroups()
                    }
                    dismiss()
                }
                
            }
            .background(Color(.systemMint))
            .disabled(!formIsValid)
            .opacity(formIsValid ? 1.0 : 0.5)
            .clipShape(.rect(cornerRadius: 10))
            .padding(.top, 10)
            Spacer()
        }.onAppear(){
            if(authVM.currentUser?.email==nil){
                //Esto es una chapuza pero no me dejaba hacerlo de otra forma
                print(":D")
            }else{
                groupUsers = [authVM.currentUser!.email]
            }
        }
    }
}

extension AddGroupView: AuthenticationFormProtocol {
    var formIsValid: Bool {
        return !groupUsers.isEmpty
        && !groupTitle.isEmpty
        && !selectedCurrency.isEmpty
    }
    var emailIsValid:Bool {
        return !newUser.isEmpty
        && newUser.contains("@")
    }
}

#Preview {
    AddGroupView()
        .environmentObject(AuthViewModel())
        .environmentObject(GroupViewModel())
}
