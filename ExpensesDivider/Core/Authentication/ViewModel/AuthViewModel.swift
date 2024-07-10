//
//  AuthViewModel.swift
//  ExpensesDivider
//
//  Created by Jose M on 8/7/24.
//

import Foundation
import Firebase

class AuthViewModel: ObservableObject{
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    
    init(){
        
    }
    
    func singIn(withEmail email: String, password: String) async throws{
        //Iniciar sesion
    }
    
    func createUser(withEmail email: String, password: String, fullname: String) async throws{
        //Crear Usuario
    }
    
    func singOut(){
        //Cerrar sesion
    }
    
    func deleteAccount(){
        //Borrar cuenta
    }
    
    func fetchUser() async {
        //Obtener datos de usuario
    }
}
