//
//  ExpenseUserListView.swift
//  ExpensesDivider
//
//  Created by Jose M on 7/8/24.
//

import SwiftUI

struct ListItem:Identifiable{
    var id = UUID()
    var name: String
    var isChecked: Bool
}

struct ExpenseUserListView: View {
    @EnvironmentObject var grpVM:GroupViewModel
    @State private var usersList = []
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    ExpenseUserListView()
}
