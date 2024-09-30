//
//  Constant.swift
//  Shrimad_Bhagwat_Geeta
//
//  Created by Manthan on 16/09/24.
//

import Foundation

enum Event{
    case Loading
    case StopLoading
    case Dataloaded
    case message(Error?)
}

enum DataError : Error{
    case invalidURL
    case invalidResponce
    case invalidDecoding
    case massage(_ massage : Error?)
}
