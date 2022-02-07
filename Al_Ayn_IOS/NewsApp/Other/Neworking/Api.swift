//
//  Api.swift
//  Al_Ayn_IOS
//
//  Created by s ali on 05/02/22.
//

import Alamofire

protocol Api {
    static func getNews(params:String,completion:@escaping (AFResult<News>)->Void)
}


//Api Implementation class
class ApiImp: Api {
    static func getNews(params:String, completion: @escaping (AFResult<News>) -> Void) {
        let decoder = JSONDecoder()
//        let context = CoreDataHelper.sharedInstance.persistentContainer.viewContext
//        decoder.userInfo[CodingUserInfoKey.managedObjectContext!] = context
        AF.request(Router.GetNews(params))
            .responseDecodable(decoder: decoder) {
                (response: AFDataResponse<News>) in
                debugPrint(response)
                completion(response.result)
        }
    }



}

