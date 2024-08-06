//
//  GroupParticipant.swift
//  ExpensesDivider
//
//  Created by Jose M on 6/8/24.
//

import Foundation

struct Participant: Codable, Identifiable{
    var id: String {
        self.userId
    }
    var userId: String
    var groupId: String
    var userName: String
    var userDebts: [String]
    var totalDebt: Double
}

struct ParticipantDebt:Codable{
    var debtId: String
    var title: String
    var fromuserID: String
    var toUserId: String
    var amount: Double
}
