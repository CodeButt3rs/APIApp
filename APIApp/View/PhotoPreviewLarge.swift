//
//  PhotoView.swift
//  APIApp
//
//  Created by Владислав Лесовой on 12.12.2023.
//

import SwiftUI

struct PhotoPreviewLarge: View {
    
    var photo: Nasa_Stored_Photo
    init(photo: Nasa_Stored_Photo) {
        self.photo = photo
    }
    var body: some View {
        HStack{
            Image(uiImage: UIImage(data: photo.image)!)
                .resizable()
                .scaledToFill()
                .frame(width: 300, height: 300)
                .clipShape(RoundedRectangle(cornerRadius: 25))
        }
    }
}

#Preview {
    HStack{
        
    }
}
