//
//  AddGroupView.swift
//  ExpensesDivider
//
//  Created by Jose M on 26/7/24.
//

import SwiftUI

struct AddGroupView: View {
    @State private var groupTitle = ""
    @State private var groupCurrency = ""
    var body: some View {
        VStack(spacing: 24){
            Text("Crear Nuevo Grupo")
                .font(.title)
                .foregroundStyle(.cyan)
                .fontWeight(.bold)
            InputView(text: $groupTitle, title: "Título del grupo", placeholder: "Piso Granada")
                .padding(24)
            Spacer()
        }
    }
}

#Preview {
    AddGroupView()
}
