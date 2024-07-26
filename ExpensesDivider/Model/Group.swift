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
    var members: [String]
}

struct GroupExpense: Codable, Identifiable{
    var id = UUID()
    var groupId:String
    var amount: Double
    var title: String
    var createdAt: Date
    var createdBy: String
    var participants: [Participant]
}

struct Participant: Codable{
    var userId: String
    var amountPaid: Double
    var amountOwned: Double
}

struct Payment: Codable, Identifiable{
    var id: String
    var groupId: String
    var fromUserId: String
    var toUserId: String
    var amount: Double
    var createdAt: Date
}
