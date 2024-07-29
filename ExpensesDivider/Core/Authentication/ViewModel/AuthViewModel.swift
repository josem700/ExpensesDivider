//
//  AuthViewModel.swift
//  ExpensesDivider
//
//  Created by Jose M on 8/7/24.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

protocol AuthenticationFormProtocol{
    var formIsValid: Bool { get }
}

//Esto sirve por que la peticion es asincrona y solo permite hacer uso de published en el hilo principal, basicamente le dice que la clase se ejecute en el hilo principal
@MainActor
class AuthViewModel: ObservableObject{
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    @Published var userGroups: [ExpensesGroup]?
    
    init(){
        //Comprueba si hay un usuario logueado al entrar en la app
        self.userSession = Auth.auth().currentUser
        //signOut()
        Task{
            //Obtenemos datos del usuario
            await fetchUser()
            await fetchGroups()
        }
    }
    
    func signIn(withEmail email: String, password: String) async throws{
        //Iniciar sesion
        print("Sign In..")
        do{
            //Asignamos en una variable el resultado de hacer login
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            //Parseamos el usuario recibido en nuestro objeto
            self.userSession = result.user
            //Esperamos a que carguen los datos del usuario
            await fetchUser()
        }catch{
            print("DEBUG: Failed to log in. Error: \(error.localizedDescription)")
        }
    }
    
    func createUser(withEmail email: String, password: String, name: String, surname:String) async throws{
        //Crear Usuario
        print("Create User")
        do{
            //Intentamos crear usuario
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            //Rellenamos nuestro modelo local de usuario, lo creamos
             let user = User(id: result.user.uid, name: name,surname: surname, email: email, createdAt: Date(),userGroups: [])
            //Una vez nuestro objeto usuario esta quedado, lo encodeamos
            let encodedUser = try Firestore.Encoder().encode(user)
            //Una vez todo creado correcto, subimos a Firebase nuestro nuevo usuario creado
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
            
            //Llamamos a fetchUser con await para que antes de que pase a la pantalla del perfil, ya esten cargados los datos del usuario
            await fetchUser()
        }catch{
            //Si ha habido algún error durante el proceso, lo imprimimos por consola
            print("DEBUG: Failed to create a new user. Error: \(error.localizedDescription)")
        }
    }
    
    func signOut(){
        //Cerrar sesion
        do{
            //LLamamos al metodo para cerrar sesion
            try Auth.auth().signOut()
            //Ponemos el usuario actual en nulo y vuelve a pantalla de inicio
            self.userSession = nil
            self.currentUser = nil
        }catch{
            print("DEBUG: Failed to sign out. Error: \(error.localizedDescription)")
        }
    }
    
    func deleteAccount(){
        //Borrar cuenta
    }
    
    func fetchUser() async {
        //Obtener datos de usuario
        //Id del usuario
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        //Firebase devuelve un objeto del tipo snapshot al obtener el documento de la coleccion
        guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument() else {return}
        //Como la clase User es codable, podemos meterle directamente el usuario
        self.currentUser = try? snapshot.data(as: User.self)
        print("DEBUG: Usuario actual: \(String(describing: self.currentUser))")
    }
    
    func fetchGroups() async{
        //Devuelve los grupos a los que pertenece el usuario
        let groupsIds: [String] = currentUser?.userGroups ?? []
        
        for group in groupsIds {
            guard let snapshot = try? await Firestore.firestore().collection("groups").document(group).getDocument() else {return}
            guard let group = try? snapshot.data(as: ExpensesGroup.self) else {continue}
            userGroups?.append(group)
        }
    }
}
