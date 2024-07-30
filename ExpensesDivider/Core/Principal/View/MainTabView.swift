//
//  MainTabView.swift
//  ExpensesDivider
//
//  Created by Jose M on 16/7/24.
//

import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var authVM: AuthViewModel
    @EnvironmentObject var grpVM: GroupViewModel
    @State private var showingSheet = false
    
    var body: some View {
        TabView{
            HStack{
                if (authVM.userGroups.count<1){
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
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 10){
                            ForEach(authVM.userGroups) { group in
                                GroupViewCell(cellTitle: group.title)
                                    .clipShape(RoundedRectangle(cornerRadius: 18))
                                    .frame(minWidth: 100, minHeight: 100)
                            }
                            .onLongPressGesture(perform: {
                                Alert(title: Text("¿Desea borrar este grupo? Tenga en cuenta que los saldos pendientes se perderán."),primaryButton: .destructive(Text("Borrar")){
                                    
                                
                                }, secondaryButton: .cancel())
                            })
                            Button{
                                showingSheet = true
                            }label: {
                                VStack {
                                    Text("Añadir Grupo")
                                        .font(.title3)
                                    .fontWeight(.semibold)
                                
                                Image(systemName: "plus.circle")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .scaledToFill()
                                    .padding(2)
                                }
                            }
                            .frame(minWidth: 100, minHeight: 100)
                            .font(.system(size: 12))
                            .overlay(RoundedRectangle(cornerRadius: 18)
                                .stroke(.blue, lineWidth: 2)
                            )
                            .sheet(isPresented: $showingSheet){
                                AddGroupView()
                            }
                        }.padding(20)
                    }
                }
            }
            .tabItem {
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
