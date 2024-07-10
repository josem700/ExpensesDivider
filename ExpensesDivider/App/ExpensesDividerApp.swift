//
//  ExpensesDividerApp.swift
//  ExpensesDivider
//
//  Created by Jose M on 4/7/24.
//

import SwiftUI

@main
struct ExpensesDividerApp: App {
    @StateObject var ViewModel = AuthViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(ViewModel)
        }
    }
}
