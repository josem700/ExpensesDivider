//
//  User.swift
//  ExpensesDivider
//
//  Created by Jose M on 8/7/24.
//

import Foundation

struct User: Identifiable, Codable{
    let id: String
    let name: String
    let surname: String
    let email: String
    let createdAt: Date
    let userGroups: [String]?
    
    var initials: String{
        let formatter = PersonNameComponentsFormatter()
        if let components = formatter.personNameComponents(from: name){
            formatter.style = .abbreviated
            return formatter.string(from: components)
        }
        return ""
    }
}

extension User {
    //Usuario de prueba
    static var MOCK_USER = User(id: NSUUID().uuidString, name: "Kobe", surname: "Bryant", email: "test@gmail.com", createdAt: Date(), userGroups: [])
}
