//
//  MainWindowVM.swift
//  APIApp
//
//  Created by Владислав Лесовой on 12.12.2023.
//

import Foundation
import SwiftUI
extension MainWindow{
    @MainActor class MainWindowVM: ObservableObject{
        
        private func MakeRequest(request_string: String) async throws -> Data{
            var urlComponents = URLComponents(string: request_string)!
            urlComponents.queryItems?.append(URLQueryItem(name: "api_key", value: Nasa.api_key))
            
            var request: URLRequest = URLRequest(url: urlComponents.url!)
            request.httpMethod = "GET"
            let urlSession = URLSession.shared
            var resp: Data
            
            do{
                let (data, _) = try await urlSession.data(for: request)
                resp = data
            }
            catch{
                throw error
            }
            return resp
        }
        public func RequestPhotos(data: Nasa_Camera_Request) async throws -> Nasa_Photos_Response{
            var resp: Nasa_Photos_Response
            var urlComponents = URLComponents(string: Nasa.photos_url)!
            do{
                urlComponents.queryItems = [
                    URLQueryItem(name: "sol", value: (String(data.sol))),
                    URLQueryItem(name: "camera", value: data.camera)
                ]
                let result = try await MakeRequest(request_string: urlComponents.url!.absoluteString)
                resp = try JSONDecoder().decode(Nasa_Photos_Response.self, from: result)
            }
            catch{
                throw error
            }
            return resp
        }
        public func DownloadImage(url: String) async throws -> Data{
            _ = URLComponents(string: Nasa.photos_url)!
            var url1 = url
            url1.insert("s", at: url.index(url.startIndex, offsetBy: 4))
            var resp: Data
            do{
                resp = try await MakeRequest(request_string: url1)
            }
            catch{
                throw error
            }
            return resp
        }
        
    }
}
