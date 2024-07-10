//
//  ProfileView.swift
//  ExpensesDivider
//
//  Created by Jose M on 5/7/24.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        List{
            Section{
                HStack {
                    Text(User.MOCK_USER.initials)
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color(.white))
                        .frame(width: 72, height: 72)
                        .background(Color(.systemMint))
                    .clipShape(Circle())
                    
                    VStack(alignment: .leading, spacing: 4){
                        Text(User.MOCK_USER.fullname)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .padding(.top, 4)
                        
                        Text(User.MOCK_USER.email)
                            .font(.footnote)
                            .tint(.gray)
                    }
                }
            }
            Section("General"){
                HStack {
                    SettingsRowView(imageName: "gear", title: "Versión", tintColor: Color(.systemGray))
                    Spacer()
                    Text("1.0.0")
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                }
            }
            Section("Cuenta"){
                Button{
                    
                }label: {
                    SettingsRowView(imageName: "arrow.left.circle.fill", title: "Cerrar Sesión", tintColor: .red)
                }
                
                Button{
                    
                }label: {
                    SettingsRowView(imageName: "xmark.circle.fill", title: "Borrar Cuenta", tintColor: .red)
                }
            }
        }
    }
}

#Preview {
    ProfileView()
}
