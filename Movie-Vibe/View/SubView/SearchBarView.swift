//
//  SearchBarView.swift
//  Movie-Vibe
//
//  Created by Vishnu Mavawala on 30/03/26.
//

import SwiftUI

struct SearchBarView: View {
    @FocusState private var isFocused: Bool
    @Binding var text: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(Color.gray)
            
            TextField("Search...",
                      text: $text,
                      prompt: Text("Search...").foregroundColor(.gray))
            .textFieldStyle(PlainTextFieldStyle())
            .submitLabel(.search)
            .foregroundStyle(Constant.Color.textColor)
            .tint(Constant.Color.textColor)
            .focused($isFocused)
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Cancel") {
                        isFocused = false
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.blue)
                    .clipShape(Capsule())
                    .controlSize(.small)
                }
            }
            
            if !text.isEmpty {
                Button(action: {
                    text = ""
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(Color.gray)
                }
            }
        }
        .padding(10)
        .background(
            Constant.Color.themeColor
            .blur(radius: 2)
        )
        .background(Color.gray.opacity(0.2))
        .cornerRadius(10)
//        .padding(.horizontal)
    }
}

#Preview {
    SearchBarView(text: .constant(""))
        .background(Constant.Color.themeColor)
}
