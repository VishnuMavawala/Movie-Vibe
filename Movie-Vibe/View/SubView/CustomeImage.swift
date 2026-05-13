//
//  CustomeImage.swift
//  Movie-Vibe
//
//  Created by Vishnu Mavawala on 26/03/26.
//

import SwiftUI

struct CustomeImage: View {
    
    let imgName: String
    @StateObject private var localImage = LocalImage()
    
    var body: some View {
        Group {
            if let img = localImage.image {
                Image(uiImage: img)
                    .resizable()
                    .scaledToFit()
                    .border(Color.black, width: 0.5)
                    .cornerRadius(12)
            } else {
                ProgressView()
            }
        }
        .task {
            await localImage.getImage(url: Constant.Urls.imgUrl(imgName))
        }
    }
}

#Preview {
    CustomeImage(imgName: "/zfbjgQE1uSd9wiPTX4VzsLi0rGG.jpg")
}
