//
//  GroupViewCell.swift
//  ExpensesDivider
//
//  Created by Jose M on 19/7/24.
//

import SwiftUI

struct GroupViewCell: View {
    @State var cellTitle:String
    @State private var showingAlert = false
    var body: some View {
        VStack(alignment: .center, spacing: 20){
         //   HStack{
//                Button{
//                    //Alerta
//                    showingAlert = true
//                }label: {
//                    Image(systemName: "xmark.app").padding(20)
//                        .imageScale(.medium)
//                        .font(.title)
//                        .foregroundColor(.red)
//                }
//                .alert("¿Desea borrar el grupo? Se mantendrán las deudas pendientes", isPresented: $showingAlert) {
//                    
//                    Button("Aceptar"){
//                        //Funcion borrar grupo
//                    }
//                    Button("Borrar", role: .destructive){
//                        //Borrar grupo
//                    }
//                }
        //    }
          Text(cellTitle)
                .font(.caption)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }.background(Color(.systemMint))
    }
}

#Preview {
    GroupViewCell(cellTitle: "Test")
}
