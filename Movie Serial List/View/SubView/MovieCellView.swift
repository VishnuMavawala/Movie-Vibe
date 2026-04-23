//
//  MovieCellView.swift
//  Movie Serial List
//
//  Created by Neosoft on 01/04/26.
//

import SwiftUI

struct MovieCellView: View {
    let movie: MovieViewModel
    
    var body: some View {
        NavigationLink(destination: DetailsView(movie: movie)) {
            HStack {
                CustomeImage(imgName: movie.img)
                    .frame(width: 97.5, height: 150)
                
                VStack(alignment: .leading) {
                    Text(movie.title)
                        .font(.headline)
                    Spacer()
                    VStack(alignment: .leading, spacing: 4) {
                        HStack {
                            Image(systemName: "star")
                            Text(String(format: "%.1f", movie.rate))
                        }
                        .foregroundStyle(Color.orange)
                        HStack {
                            Image(systemName: "calendar")
                            Text(movie.date)
                        }
                        HStack {
                            Image(systemName: "clock")
                            Text("148 Minutes")
                        }
                        HStack {
                            Image(systemName: "ticket")
                            Text(movie.lang)
                        }
                    }
                    .font(.system(size: 13))
                }
                .foregroundStyle(Constant.Color.textColor)
                .padding()
            }
            .padding(.vertical, 4)
        }
    }
}

#Preview {
    MovieCellView(movie: MovieViewModel.default)
        .background(Constant.Color.themeColor)
}
