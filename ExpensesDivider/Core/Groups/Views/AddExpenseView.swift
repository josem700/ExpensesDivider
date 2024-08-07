//
//  AddExpenseView.swift
//  ExpensesDivider
//
//  Created by Jose M on 6/8/24.
//

import SwiftUI

struct AddExpenseView: View {
    @State private var expenseTitle = ""
    @State private var amount = ""
    @EnvironmentObject var autVM:AuthViewModel
    @EnvironmentObject var grpVM:GroupViewModel
    @State var paidBySelection = ""
    @Binding var currentGroup: ExpensesGroup
    
    var body: some View {
        VStack(spacing: 24){
            Text("Añadir Gasto")
                .font(.title)
                .foregroundStyle(.cyan)
                .fontWeight(.bold)
                .padding(.top, 30)
            
            InputView(text: $expenseTitle, title: "Título", placeholder: "Pizzas")
                .padding(10)
            
            InputView(text: $amount, title: "Cantidad", placeholder: "22,40€")
                .padding(10)
            HStack{
                Text("Pagado por: ")
                    .foregroundStyle(Color(.darkGray))
                    .fontWeight(.semibold)
                    .font(.title2)
                Spacer()
                Picker("Pagado por: ", selection: $paidBySelection){
                    ForEach(currentGroup.members){ member in
                        Text(member.userName)
                    }.foregroundStyle(Color(.black))
                }
                .pickerStyle(.menu)
                .foregroundStyle(.black)
                Spacer()
            }.padding(10)
            Spacer()
        }
        .onAppear(){
            Task{
                grpVM.currentGroup = currentGroup
            }
        }
    }
}

#Preview {
    AddExpenseView(currentGroup: .constant(ExpensesGroup(id: "0000", title: "Viaje mallorca", currency: "Euro", members: [], groupExpenses: [])))
        .environmentObject(AuthViewModel())
        .environmentObject(GroupViewModel())
}
