//
//  Helper.swift
//  Al_Ayn_IOS
//
//  Created by s ali on 05/02/22.
//

import Foundation
func stringToDate(_ inputDate: String) -> String {
    let olDateFormatter = DateFormatter()
    olDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    
    if let oldDate = olDateFormatter.date(from: inputDate)
    {
        
        let convertDateFormatter = DateFormatter()
        convertDateFormatter.dateFormat = "MMM dd yyyy"
        
        return  convertDateFormatter.string(from: oldDate)
        
    }
    return ""
    
}


