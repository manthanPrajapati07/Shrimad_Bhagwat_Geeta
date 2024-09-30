//
//  Methods.swift
//  Shrimad_Bhagwat_Geeta
//
//  Created by Manthan on 12/09/24.
//

import Foundation
import Alamofire

enum HTTPMethods : String{
    case get = "GET"
    case post  = "POST"
}

protocol EndPointType {
    var path : String { get }
    var BaseURL : String { get }
    var URL : String { get }
    var HTTPMethod : HTTPMethods { get }
    var Header: HTTPHeaders? { get }
}

enum EndPointItem {
    case Chapter
    case Verses(chapterNumber: Int)
}
// chapter https://bhagavad-gita3.p.rapidapi.com/v2/chapters/
// verses https://bhagavad-gita3.p.rapidapi.com/v2/chapters/1/verses/

extension EndPointItem : EndPointType{

    var path: String {
        switch self{
        case .Chapter :
            return "chapters/"
        case .Verses(let chapterNo):
            return "chapters/\(chapterNo)/verses/"
        }
    }
    
    var BaseURL: String {
        return "https://bhagavad-gita3.p.rapidapi.com/v2/"
    }
    
    var URL: String {
        switch self {
        case .Chapter, .Verses :
            return "\(BaseURL)\(path)"
        }
    }
    
    var HTTPMethod: HTTPMethods {
        switch self{
        case .Chapter , .Verses :
            return .get
        }
    }
    
    var Header: HTTPHeaders? {
        return [
            "x-rapidapi-key":"f814edb779msh07182d7892ccfb3p13bdd5jsn7f79b76a8ba6", "x-rapidapi-host":"bhagavad-gita3.p.rapidapi.com"]
    }
    
}
