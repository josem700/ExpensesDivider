//
//  GroupView.swift
//  ExpensesDivider
//
//  Created by Jose M on 31/7/24.
//

import SwiftUI

struct GroupView: View {
    @State var currentGroup: ExpensesGroup
    @EnvironmentObject var groupVM: GroupViewModel
    var body: some View {
        TabView{
            HStack{
                
            }
            .tabItem {
                Image(systemName: "creditcard")
                Text("Gastos")
            }
            Text("")
            .tabItem {
                Image(systemName: "book.pages")
                Text("Balances")
            }
            Text("")
                .tabItem {
                    Image(systemName: "gearshape")
                    Text("Ajustes")
            }
        }.onAppear(perform: {
            groupVM.currentGroup = currentGroup
        })
    }
}

#Preview {
    GroupView(currentGroup: ExpensesGroup(id: "0000", title: "Viaje Murcia", currency: "Euro", members: [], groupExpenses: []))
}
