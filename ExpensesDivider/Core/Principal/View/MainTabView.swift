//
//  MainTabView.swift
//  ExpensesDivider
//
//  Created by Jose M on 16/7/24.
//

import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var authVM: AuthViewModel
    @State private var showingSheet = false
    var body: some View {
        TabView{
            HStack{
                if (authVM.userGroups?.count<1){
                    Button{
                        showingSheet = true
                    }label: {
                        Text("Añadir Grupo")
                            .font(.title3)
                            .fontWeight(.semibold)
                        Image(systemName: "plus.circle")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .scaledToFill()
                            .padding(2)
                    }
                    .sheet(isPresented: $showingSheet){
                        AddGroupView()
                    }
                }else{
                    ScrollView{
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))]){
                            ForEach(authVM.userGroups!) { group in
                                GroupViewCell(cellTitle: group.title)
                            }
                        }
                    }
                }
            }.tabItem {
                Image(systemName: "person.3")
                Text("Gastos compartidos")
            }
            Text("Mis gastos")
                .tabItem {
                    Image(systemName: "creditcard.fill")
                    Text("Mis gastos")
                }
        }
    }
}

#Preview {
    MainTabView().environmentObject(AuthViewModel())
}
