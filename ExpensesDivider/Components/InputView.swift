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
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12){
            Text(title)
                .foregroundStyle(Color(.darkGray))
                .fontWeight(.semibold)
                .font(.title2)
            
            if isSecureField{
                SecureField(placeholder, text: $text)
                    .font(.system(size: 14))
            }else{
                TextField(placeholder, text: $text)
                    .font(.system(size: 14))
                    .background(Color(.clear))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            
            Divider()
        }
    }
}

#Preview {
    InputView(text: .constant(""), title: "Email", placeholder: "nombre@ejemplo.com")
}
