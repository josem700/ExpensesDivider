//
//  MainTabView.swift
//  ExpensesDivider
//
//  Created by Jose M on 16/7/24.
//

import SwiftUI

struct MainTabView: View {
    @StateObject var groupVM = GroupViewModel()
    var body: some View {
        TabView{
            HStack{
                Button(){
                    
                }label: {
                    if groupVM.userGroups.count<1{
                        Text("Añadir Grupo")
                            .font(.title3)
                            .fontWeight(.semibold)
                        
                        Image(systemName: "plus.circle")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .scaledToFill()
                            .padding(2)
                    }else{
                        ScrollView{
                            LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))]){
                                ForEach(groupVM.userGroups) { group in
                                    GroupViewCell(cellTitle: group.title)
                                }
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
    MainTabView()
}
