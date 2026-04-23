//
//  SegmentPickerView.swift
//  Movie Serial List
//
//  Created by Neosoft on 01/04/26.
//

import SwiftUI

struct SegmentPickerView: View {
    let segments: [String]
    @Binding var selectedIndex: Int
    
    var body: some View {
        HStack(spacing: 32) {
            ForEach(segments.indices, id: \.self) { index in
                VStack {
                    Text(segments[index])
                        .foregroundColor(selectedIndex == index ? .white : .gray)
                        .font(.system(size: 16, weight: .medium))
                        .onTapGesture {
                            withAnimation {
                                selectedIndex = index
                            }
                        }
                    
                    // Underline
                    Rectangle()
                        .frame(height: 2)
                        .foregroundColor(selectedIndex == index ? .white : .clear)
                        .cornerRadius(1)
                        .animation(.easeInOut, value: selectedIndex)
                }
            }
        }
    }
}

#Preview {
    SegmentPickerView(segments: MovieType.allCase.map({ $0.rawValue }), selectedIndex: .constant(0))
        .padding()
        .background(Constant.Color.themeColor)
}
