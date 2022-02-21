//
//  Router.swift
//  MusicLibrary
//
//  Created by Santo Michael Sihombing on 19/02/22.
//

import Foundation
import Alamofire

enum APIRouter {
    case getChartSong(page: Int, pageSize: Int)
    case findSongs(page: Int, pageSize: Int, query: String)
    case getRandomImage
}

let apiKey: String = "0ad8a85dcc89c7bb9208a2230624cd21"
let unsplashAccesKey = "Ujuvr2oFjFCKfggCDeVtwyQXQP8Eeiw4kZG-FxiobGE"

extension APIRouter: HttpRouter {
    
    var baseURL: String {
        switch self {
        case .getChartSong, .findSongs: return "https://api.musixmatch.com/ws/1.1";
        case .getRandomImage: return "https://api.unsplash.com"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getChartSong, .findSongs, .getRandomImage: return .get
        }
    }
    
    var headers: HTTPHeaders {
        switch self {
        case .getRandomImage:
            return [
                "Authorization": "Client-ID \(unsplashAccesKey)"
            ]
        case .getChartSong, .findSongs:
            return [
                "Content-Type": "application/json; charset=UTF-8"
            ]
        }
        
    }
    
    var path: String {
        switch self {
        case .getChartSong: return "chart.tracks.get"
        case .findSongs: return "track.search"
        case .getRandomImage: return "photos/random"
        }
    }
    
    var encoding: ParameterEncoding {
        switch method {
        default: return URLEncoding.default
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .getChartSong(let page, let pageSize):
            return [
                "apikey":apiKey,
                "page":page,
                "page_size":pageSize
            ]
            
        case .findSongs(let page, let pageSize, let query):
            return [
                "apikey":apiKey,
                "page":page,
                "page_size":pageSize,
                "q_artist":query
            ]
        case .getRandomImage:
            return [
                "count":"10"
            ]
        }
    }
    
    var body: Parameters? {
        switch self {
        default: return nil
        }
    }
}

protocol HttpRouter: URLRequestConvertible {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: HTTPHeaders { get }
    var parameters: Parameters? { get }
    var encoding: ParameterEncoding { get }
    
    func body() throws -> Data?
    
    func request(usingHttpService service: HttpService) throws -> DataRequest
}

extension HttpRouter {
    var parameter: Parameters? { return nil }
    
    func body() throws -> Data? { return nil }
    
    func asURLRequest() throws -> URLRequest {

        var url =  try urlComponent().asURL()
        url.appendPathComponent(path)
        
        var request = try URLRequest(url: url, method: method, headers: headers)
        request.httpBody = try body()
        
        return request
    }
    
    func urlComponent() throws -> URLComponents {
        var components = URLComponents(string: baseURL)!
        
        guard parameters != nil, let parameters = parameters else {
            return components
        }

        let items: [URLQueryItem] = parameters.map { (key, value) in
            return URLQueryItem(name: key, value: String(describing: value))
        }
        
        components.queryItems = items
        
        return components
    }
    
    func request(usingHttpService service: HttpService) throws -> DataRequest {
        return try service.request(asURLRequest())
    }
}

