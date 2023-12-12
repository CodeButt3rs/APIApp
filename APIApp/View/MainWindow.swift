//
//  ContentView.swift
//  APIApp
//
//  Created by Владислав Лесовой on 12.12.2023.
//

import SwiftUI
import SwiftData

struct MainWindow: View {
    @Environment(\.modelContext) private var ctx
    @Query private var photos: [Photo]
    
    @State var sols: String = "0"
    @State var camera: String = "fhaz"
    
    @ObservedObject var MainWindVM: MainWindowVM = MainWindowVM()
    
    var body: some View {
        NavigationStack{
            VStack{
                Text("Последние 5 фотографий")
                    .font(.title)
                    .bold()
                    .padding([.leading, .trailing])
                    .frame(alignment:  .center)
                VStack(alignment: .leading){
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack(spacing: 20){
                            ForEach(photos.suffix(5), id: \.id){i in
                                NavigationLink(destination: {PhotoView(photo: i.response)}, label: {PhotoPreview(photo: i.response)})
                                    .transition(.scale)
                            }
                        }
                        .padding([.leading, .trailing], 10)
                        .frame(minWidth: 200, minHeight: 320)
                        .overlay(content: {
                            if photos.isEmpty{
                                VStack{
                                    ZStack{
                                        RoundedRectangle(cornerRadius: 25)
                                            .fill(.white)
                                            .shadow(radius: 5)
                                            .frame(width: 150, height: 300)
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
                    Spacer()
                    Spacer()
                    .background(.background)
                    Button(action: {
                        Task{
                            do{
                                let photos: Nasa_Photos_Response = try await MainWindVM.RequestPhotos(data: Nasa_Camera_Request(sol: Int.random(in: 1...1000), camera: "fhaz"))
                                for i in photos.photos{
                                    let img = try await MainWindVM.DownloadImage(url: i.img_src)
                                    let photo: Nasa_Stored_Photo = Nasa_Stored_Photo(image: img, rover_id: i.rover.id, name: String(i.id))
                                    ctx.insert(Photo(timestamp: .now, response: photo))
                                }
                            }
                            catch{
                                print("Error occured!")
                            }
                        }
                    }, label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 15)
                                .fill(.black)
                                .frame(width: 200, height: 70)
                            Text("Запросить!")
                                .foregroundStyle(.white)
                        }
                        .frame(minWidth: 400)
//                        .border(.red)
                    })
                    NavigationLink(destination: {AllPhotos()}, label: {Text("Библиотека")})
                        .padding(.leading, 155)
                        .frame(alignment: .center)
                    Spacer()
                }
            }
            .navigationTitle("Главная")
        }
    }
}

#Preview {
    MainWindow()
        .modelContainer(for: Photo.self, inMemory: true)
}
