//
//  APIManager.swift
//  Shrimad_Bhagwat_Geeta
//
//  Created by Manthan on 12/09/24.
//

import Foundation
import Alamofire

typealias Handler<T> = (Result<T, DataError>) -> ()

final class APIManager {
    
    static let shared = APIManager()
    private init() {}
    
    func request<T: Codable>(ModelType : T.Type,Type : EndPointType, Complition : @escaping Handler<T>) where T: Codable{
        
        AF.request(Type.URL, method: HTTPMethod(rawValue: Type.HTTPMethod.rawValue), headers: Type.Header).response{ response in
            print(Type.URL)
            
            switch response.result {
            case .success(let data):
                do {
                    let json = try JSONDecoder().decode(ModelType, from: data!)
                    Complition(.success(json))
                }catch{
                    Complition(.failure(.invalidDecoding))
                }
            case .failure(let error):
                Complition(.failure(.massage(error)))
            }
        }
    }
}

