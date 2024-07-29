//
//  ExpensesDividerApp.swift
//  ExpensesDivider
//
//  Created by Jose M on 4/7/24.
//

import SwiftUI
import Firebase

@main
struct ExpensesDividerApp: App {
    @StateObject var ViewModel = AuthViewModel()
    @StateObject var GroupModel = GroupViewModel()
    init(){
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(ViewModel)
                .environmentObject(GroupModel)
        }
    }
}
