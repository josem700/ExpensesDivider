//
//  GroupViewModel.swift
//  ExpensesDivider
//
//  Created by Jose M on 26/7/24.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

@MainActor
class GroupViewModel: ObservableObject{
    
    let db = Firestore.firestore()
    @Published var groupExpenses:[GroupExpense]
    @Published var currentGroup: ExpensesGroup?
    @Published var groupParticipants: [Participant]
    
    init(){
        self.groupExpenses = []
        self.groupParticipants = []
    }
    
    func createGroup(title: String, currency: String, members: [String], currentUser:User?) async throws{
        //Crear grupo
        do{
            //Primero creamos el grupo
            let id = UUID().uuidString
            let authVM = AuthViewModel()
            if(currentUser==nil){return}
            for member in members {
                let memberUser = await authVM.fetchOneUser(userId: member)
                if (memberUser==nil) {continue}
                try? await createParticipant(userId: memberUser!.id, userName: memberUser!.name, groupId: id)
            }
            let group = ExpensesGroup(id: id, title: title, currency: currency, members: groupParticipants, groupExpenses: [])
            let encodedGroup = try Firestore.Encoder().encode(group)
            try await db.collection("groups").document(id).setData(encodedGroup)
            var usergrp = currentUser!.userGroups ?? []
            usergrp.append(id)
            try await db.collection("users").document(currentUser!.id).updateData(["userGroups":usergrp])
            await AuthViewModel().fetchGroups()
            //Una vez creado el grupo, creamos los participantes
            
        }catch{
            //Si ha habido algún error durante el proceso, lo imprimimos por consola
            print("DEBUG: Failed to create a new user. Error: \(error.localizedDescription)")
        }
    }
    
    func createParticipant(userId: String, userName: String, groupId: String) async throws{
        if(userId.isEmpty||userName.isEmpty){return}
        do{
            let participant = Participant(id: userId, groupId: groupId, userName: userName, userDebts: [], totalDebt: 0)
            groupParticipants.append(participant)
        }
    }
    
//    func fetchparticipants(currentGroupId: String) async{
//        //groupParticipants.removeAll()
////        for participant in currentGroup!.members{
////            guard let snapshot = try? await db.collection("groups").document(currentGroupId).getDocument() else {return}
////            guard let participant = try? snapshot.data(as: Participant.self) else {continue}
////            groupParticipants.append(participant)
////        }
//        groupParticipants = cu
//    }
    
    
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
