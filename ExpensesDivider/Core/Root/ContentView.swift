//
//  ContentView.swift
//  ExpensesDivider
//
//  Created by Jose M on 4/7/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        Group{
            if viewModel.userSession != nil {
                PrincipalView()
            } else{
                LoginView()
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(AuthViewModel())
}
