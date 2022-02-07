//
//  ApiRouter.swift
//  Al_Ayn_IOS
//
//  Created by s ali on 05/02/22.
//

import Alamofire
enum Router: URLRequestConvertible {
    enum Constants {
        static let API_KEY =  "955b91c07171479b94c31ccecb0119ff"
        static let baseURL =  "https://newsapi.org/v2/"
    }

    case GetNews(String)

    var method: Alamofire.HTTPMethod {
        switch self {
            case .GetNews:
                return .get
        
        }
    }

    var path: String {
        switch self {
            case .GetNews(let params):
            let path = Constants.baseURL + params + "&apiKey=" + Constants.API_KEY
                return path
            
        }
    }

    func asURLRequest() throws -> URLRequest {
        print(path)
        let url = try path.asURL()
        var request = URLRequest(url: url)
        print(request)
        request.httpMethod = method.rawValue
        request.timeoutInterval = TimeInterval(10 * 1000)
        return try URLEncoding.default.encode(request, with: [:])
    }

}

