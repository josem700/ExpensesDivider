//
//  ExpensesViewModel.swift
//  ExpensesDivider
//
//  Created by Jose M on 31/7/24.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class ExpensesViewModel: ObservableObject{
    
    let db = Firestore.firestore()
    
    init(){
    }
    
    func createExpense(groupId:String, title: String, fromUser:String, toUsers: [String], amount: Double) async throws{
        //Crear Gasto
        do{
            let id = UUID().uuidString
            let expense = GroupExpense(groupId: id, amount: amount, title: title, createdAt: Date(), fromUserId: fromUser, toUsers: toUsers)
            let encodedExpense = try Firestore.Encoder().encode(expense)
            try await db.collection("expenses").document(id).setData(encodedExpense)
            
        }
    }
}
