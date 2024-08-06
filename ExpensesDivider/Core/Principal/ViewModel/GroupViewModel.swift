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
            let authVM = await AuthViewModel()
            if(currentUser==nil){return}
            let group = ExpensesGroup(id: id, title: title, currency: currency, members: members, groupExpenses: [])
            let encodedGroup = try Firestore.Encoder().encode(group)
            try await db.collection("groups").document(id).setData(encodedGroup)
            var usergrp = currentUser!.userGroups ?? []
            usergrp.append(id)
            try await db.collection("users").document(currentUser!.id).updateData(["userGroups":usergrp])
            
            //Una vez creado el grupo, creamos los participantes
            for member in group.members {
                let memberUser = await authVM.fetchOneUser(userId: member)
                if (memberUser==nil) {continue}
                try? await createParticipant(userId: memberUser!.id, userName: memberUser!.name, groupId: currentGroup!.id)
            }
        }catch{
            //Si ha habido algún error durante el proceso, lo imprimimos por consola
            print("DEBUG: Failed to create a new user. Error: \(error.localizedDescription)")
        }
    }
    
    func createParticipant(userId: String, userName: String, groupId: String) async throws{
        if(userId.isEmpty||userName.isEmpty){return}
        do{
            let participant = Participant(userId: userId, groupId: groupId, userName: userName, userDebts: [], totalDebt: 0)
            let encodedParticipant = try Firestore.Encoder().encode(participant)
            try await db.collection("groupParticipants").document(userId).setData(encodedParticipant)
            await fetchparticipants()
        }
        catch{
            //Si ha habido algún error durante el proceso, lo imprimimos por consola
            print("DEBUG: Failed to create a new user. Error: \(error.localizedDescription)")
        }
    }
    
    func fetchparticipants() async{
        groupParticipants.removeAll()
        for participant in groupParticipants{
            guard let snapshot = try? await db.collection("groupParticipants").document(participant.userId).getDocument() else {return}
            guard let participant = try? snapshot.data(as: Participant.self) else {continue}
            groupParticipants.append(participant)
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
