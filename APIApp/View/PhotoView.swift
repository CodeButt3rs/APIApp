//
//  PhotoView1.swift
//  APIApp
//
//  Created by Владислав Лесовой on 12.12.2023.
//

import SwiftUI

struct PhotoView: View {
    
    var photo: Nasa_Stored_Photo
    init(photo: Nasa_Stored_Photo) {
        self.photo = photo
    }

    var body: some View {
        VStack(alignment: .leading){
            Text("Фото с ровера №\(photo.rover_id)")
                .font(.largeTitle)
                .bold()
                .frame(alignment: .top)
                .padding(.bottom, 30)
            Image(uiImage: UIImage(data: photo.image)!)
                .resizable()
                .scaledToFit()
            Spacer()
        }
        .padding()
    }
}

#Preview {
    HStack{
        
    }
}
