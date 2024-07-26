//
//  GroupViewModel.swift
//  ExpensesDivider
//
//  Created by Jose M on 26/7/24.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class GroupViewModel: ObservableObject{
    
    @Published var userGroups: [ExpensesGroup]
    let db = Firestore.firestore()
    
    init(){
        userGroups = []
        Task{
            await fetchGroups()
        }
    }
    
    func createGroup(id: String, title: String, currency: String, members: [String]) async throws{
        //Crear grupo
        do{
            let id = UUID().uuidString
            let group = ExpensesGroup(id: id, title: title, currency: currency, members: members)
            let encodedGroup = try Firestore.Encoder().encode(group)
            try await db.collection("groups").document(id).setData(encodedGroup)
            
           await fetchGroups()
        }catch{
            //Si ha habido algún error durante el proceso, lo imprimimos por consola
            print("DEBUG: Failed to create a new user. Error: \(error.localizedDescription)")
        }
    }
    
    func fetchGroups() async{
        //Devuelve los grupos a los que pertenece el usuario
        let currentUser = await AuthViewModel().currentUser
        let groupsIds: [String] = currentUser?.userGroups ?? []
        
        for group in groupsIds {
            guard let snapshot = try? await Firestore.firestore().collection("groups").document(group).getDocument() else {return}
            
            guard var group = try? snapshot.data(as: ExpensesGroup.self) else {continue}
            userGroups.append(group)
        }
    }
    
    func deleteGroup(groupId: String){
        db.collection("groups").document(groupId).delete()
    }
}
