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
            
            Picker("Pagado por: ", selection: $paidBySelection){
                ForEach(grpVM.groupParticipants){ member in
                    Text(member.userName)
                }.foregroundStyle(Color(.black))
            }
            .pickerStyle(.menu)
            
            Spacer()
        }
        .onAppear(){
            Task{
                grpVM.fetchparticipants
            }
        }
    }
}

#Preview {
    AddExpenseView()
        .environmentObject(AuthViewModel())
        .environmentObject(GroupViewModel())
}
