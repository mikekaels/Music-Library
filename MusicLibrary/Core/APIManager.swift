//
//  APIManager.swift
//  MusicLibrary
//
//  Created by Santo Michael Sihombing on 19/02/22.
//

import Foundation
import Alamofire

enum CustomError: Error {
    case noInternetConnection
    case unexpected
}

class APIManager {
    static let shared = APIManager()
    private let httpService = Service()
    
    func fetchChart(page: Int, pageSize: Int, completion: @escaping(Result<MusicModel, CustomError>) -> Void) {
        print("👉 ",page, pageSize)
        if !Connectivity.isConnectedToInternet {
            completion(.failure(.noInternetConnection))
        } else {
            do {
                try APIRouter
                    .getChartSong(page: page, pageSize: pageSize)
                    .request(usingHttpService: httpService)
                    .responseJSON { result in
                        print("👉 REQ: ", result.request)
                        guard [200, 201].contains(result.response?.statusCode), let data = result.data else { return }
                        
                        do {
                            let result = try JSONDecoder().decode(MusicModel.self, from: data)
                            print("👉 RESULT: ", result)
                            completion(.success(result))
                        } catch {
                            print("👉 ERR: ", error)
                            completion(.failure(.unexpected))
                        }
                    }
                
            } catch {
                completion(.failure(error as! CustomError))
            }
        }
    }
}
