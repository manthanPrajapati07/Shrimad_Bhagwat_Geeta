//
//  Verses.swift
//  Shrimad_Bhagwat_Geeta
//
//  Created by Manthan on 18/09/24.
//

import Foundation

struct VersesList : Codable{
    
    var id : Int?
    var verse_number : Int?
    var chapter_number : Int?
    var slug : String?
    var text : String?
    var transliteration : String?
    var word_meanings : String?
    var translations : [Translateions]?
    var commentaries : [Comentries]?
}

struct Translateions : Codable {
    var id : Int?
    var description : String?
    var author_name : String? //"Swami Adidevananda",
    var language : String? //"english"
}

struct Comentries : Codable{
    var id : Int?
    var description : String?
    var author_name :  String? // "Sri Shankaracharya",
    var language :  String? // "sanskrit"
}
