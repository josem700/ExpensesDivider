//
//  HeaderView.swift
//  ExpensesDivider
//
//  Created by Jose M on 16/7/24.
//

import SwiftUI

struct HeaderView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @State var isPresented = false
    var body: some View {
        let user = viewModel.currentUser
            VStack{
                HStack{
                    Text("Hola, \(user?.name ?? "") 😁")
                        .foregroundStyle(Color(.systemMint))
                        .fontWeight(.semibold)
                        .font(.title2)
                    
                    Spacer()
                    Button(){
                        isPresented.toggle()
                    }label: {
                        Text(user?.initials ?? "U")
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundStyle(Color(.white))
                            .frame(width: 72, height: 72)
                            .background(Color(.systemMint))
                            .clipShape(Circle())
                    }
                    .sheet(isPresented: $isPresented, content: {
                        ProfileView.init()
                    })
            }.padding()
        }
    }
}

#Preview {
    HeaderView().environmentObject(AuthViewModel())
}
