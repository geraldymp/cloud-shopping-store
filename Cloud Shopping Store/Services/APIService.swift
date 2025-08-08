////
////  APIService.swift
////  Cloud Shopping Store
////
////  Created by Geraldy on 06/08/25.
////
//
//import Alamofire
//import Foundation
//import SwiftUI
//
//class APIService {
//    static let shared = APIService()
//
//    private init() {}
//    
//    enum NetworkError: Error {
//        case invalidURL
//        case decodingError
//        case unknown
//    }
//
//    func fetchProducts(completion: @escaping (Result<[Product], Error>) -> Void)
//    {
//        let url = "https://fakestoreapi.com/products"
////        let url = "https://opentdb.com/api.php?amount=10&category=9&type=boolean"
//        
//        AF.request(url)
//            .validate()
//            .responseDecodable(of: [Product].self) { response in
//                print("FETCH PROD CALLED 2", response.result)
//                switch response.result {
//                case .success(let products):
//                    print("fetch succ")
//                    completion(.success(products))
//                case .failure(let error):
//                        print("fetch fal \(error)")
//                    completion(.failure(error))
//                }
//            }
//    }
//    
////    private func fetchRemoteData() {
////            let url = URL(string: "https://jsonplaceholder.typicode.com/photos")!
////            var request = URLRequest(url: url)
////            request.httpMethod = "GET"  // optional
////            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
////            let task = URLSession.shared.dataTask(with: request){ data, response, error in
////                if let error = error {
////                    print("Error while fetching data:", error)
////                    return
////                }
////
////                guard let data = data else {
////                    return
////                }
////
////                do {
////                    let decodedData = try JSONDecoder().decode([Album].self, from: data)
////                    // Assigning the data to the array
////                    self.albums = decodedData
////                } catch let jsonError {
////                    print("Failed to decode json", jsonError)
////                }
////            }
////
////            task.resume()
////        }
//}
