//
//  InputView.swift
//  ExpensesDivider
//
//  Created by Jose M on 5/7/24.
//

import SwiftUI

struct InputView: View {
    @Binding var text: String
    let title: String
    let placeholder: String
    var isSecureField = false
    var orangeColor = UIColor(red: 255, green: 207, blue: 150, alpha: 1)
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12){
            Text(title)
                .foregroundStyle(Color(.darkGray))
                .fontWeight(.semibold)
                .font(.title2)
            
            if isSecureField{
                SecureField(placeholder, text: $text)
                    .font(.system(size: 14))
                    //.overlay(RoundedRectangle(cornerRadius: 19).stroke(.black, lineWidth: 2))
            }else{
                TextField(placeholder, text: $text)
                    .font(.system(size: 14))
                    .background(Color(.clear))
                    //.padding(10)
                    //.overlay(RoundedRectangle(cornerRadius: 12).stroke(Color(uiColor: orangeColor), lineWidth: 2))
            }
            Divider()
        }
    }
}

#Preview {
    InputView(text: .constant(""), title: "Email", placeholder: "nombre@ejemplo.com")
}
