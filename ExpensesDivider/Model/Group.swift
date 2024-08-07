//
//  Group.swift
//  ExpensesDivider
//
//  Created by Jose M on 24/7/24.
//

import Foundation

struct ExpensesGroup: Identifiable, Codable{
    var id: String
    var title: String
    var currency: String
    var members: [Participant]
    var groupExpenses: [String]
}

struct GroupExpense: Codable, Identifiable{
    var id = UUID()
    var groupId:String
    var amount: Double
    var title: String
    var createdAt: Date
    var fromUserId: String
    var toUsers: [String]
}


