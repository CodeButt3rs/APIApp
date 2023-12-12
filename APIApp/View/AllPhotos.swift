//
//  AllPhotos.swift
//  APIApp
//
//  Created by Владислав Лесовой on 12.12.2023.
//

import SwiftUI
import SwiftData

struct AllPhotos: View {
    @Environment(\.modelContext) private var ctx
    @Query private var photos: [Photo]
    
    var body: some View {
        VStack(alignment: .leading){
            ScrollView(.vertical, showsIndicators: false){
                    ForEach(photos, id: \.id){i in
                        NavigationLink(destination: {PhotoView(photo: i.response)}, label: {PhotoPreviewLarge(photo: i.response)})
                    }
                .padding([.leading, .trailing], 10)
                .frame(minWidth: 400, minHeight: 320)
                .overlay(content: {
                    if photos.isEmpty{
                        VStack{
                            ZStack{
                                RoundedRectangle(cornerRadius: 25)
                                    .fill(.white)
                                    .shadow(radius: 5)
                                    .frame(width: 300, height: 300)
                                VStack{
                                    Image(systemName: "list.bullet.clipboard")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 70)
                                        .foregroundStyle(.gray)
                                    Text("Тут пусто...")
                                        .foregroundStyle(.gray)
                                }
                            }
                        }
                    }
                })
            }
            .navigationTitle("Библиотека")
        }
        Spacer()
    }
}

#Preview {
    AllPhotos()
}
