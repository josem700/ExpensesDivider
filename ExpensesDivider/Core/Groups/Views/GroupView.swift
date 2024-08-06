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
    @State var expenseVM = ExpensesViewModel()
    @State var sheetPresented = false
    
    var body: some View {
        TabView{
            VStack{
                if(currentGroup.groupExpenses.isEmpty){
                    Button{
                        sheetPresented = true
                    }label: {
                        Text("Añadir Gasto")
                            .font(.title3)
                            .fontWeight(.semibold)
                        Image(systemName: "plus.circle")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .scaledToFill()
                            .padding(2)
                    }
                    .sheet(isPresented: $sheetPresented){
                        AddExpenseView()
                    }
                }
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
    GroupView(currentGroup: ExpensesGroup(id: "0000", title: "Viaje Murcia", currency: "Euro", members: [], groupExpenses: [])).environmentObject(GroupViewModel())
}
