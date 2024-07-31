//
//  PrincipalView.swift
//  ExpensesDivider
//
//  Created by Jose M on 16/7/24.
//

import SwiftUI

struct PrincipalView: View {
    @EnvironmentObject var ViewModel: AuthViewModel
    
    var body: some View {
        NavigationStack{
            HeaderView()
            MainTabView()
        }
    }
}

#Preview {
    PrincipalView().environmentObject(AuthViewModel()).environmentObject(GroupViewModel())
}
