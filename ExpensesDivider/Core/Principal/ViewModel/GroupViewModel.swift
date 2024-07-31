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
    
    let db = Firestore.firestore()
    @Published var groupExpenses:[GroupExpense]
    @Published var currentGroup: ExpensesGroup?
    
    init(){
        self.groupExpenses = []
    }
    
    func createGroup(title: String, currency: String, members: [String], currentUser:User?) async throws{
        //Crear grupo
        do{
            //Primero creamos el grupo
            let id = UUID().uuidString
            if(currentUser==nil){return}
            let group = ExpensesGroup(id: id, title: title, currency: currency, members: members, groupExpenses: [])
            let encodedGroup = try Firestore.Encoder().encode(group)
            try await db.collection("groups").document(id).setData(encodedGroup)
            var usergrp = currentUser!.userGroups ?? []
            usergrp.append(id)
            try await db.collection("users").document(currentUser!.id).updateData(["userGroups":usergrp])
        }catch{
            //Si ha habido algún error durante el proceso, lo imprimimos por consola
            print("DEBUG: Failed to create a new user. Error: \(error.localizedDescription)")
        }
    }
    
    
    func deleteGroup(groupId: String){
        db.collection("groups").document(groupId).delete()
    }
    
    func fetchExpenses() async{
        let expensesIds:[String] = currentGroup?.groupExpenses ?? []
        groupExpenses.removeAll()
        for expense in expensesIds{
            guard let snapshot = try? await db.collection("expenses").document(expense).getDocument() else {return}
            guard let expense = try? snapshot.data(as: GroupExpense.self) else {continue}
            groupExpenses.append(expense)
        }
    }
}
