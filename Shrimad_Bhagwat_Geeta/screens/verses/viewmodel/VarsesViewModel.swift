//
//  VarsesViewModel.swift
//  Shrimad_Bhagwat_Geeta
//
//  Created by Manthan on 18/09/24.
//

import Foundation

final class VarsesViewModel{
    
    //MARK: - vars
    var Verses = [VersesList]()
    var translation = [Translateions]()
    var Commentry = [Comentries]()
    var filterVerses = [VersesList]()
    var EventHandler : ((_ event : Event) -> ())?
   
    //MARK: - API Functions
    func FetchVerses(Chapter : Int){
        self.EventHandler?(.Loading)
        APIManager.shared.request(ModelType: [VersesList].self, Type: EndPointItem.Verses(chapterNumber: Chapter)) { responce in
            self.EventHandler?(.StopLoading)
            switch responce{
            case .success(let Verses):
                self.Verses = Verses
                self.filterVerses = Verses
                print(self.Verses.count)
        
                for name in self.filterVerses{
                    if let temptranslation = name.translations?.filter({$0.author_name == "Dr. S. Sankaranarayan"}){
                        self.translation.append(contentsOf: temptranslation)
                    }
                    
                    if let commentry = name.commentaries?.filter({$0.author_name == "Swami Chinmayananda"}){
                        self.Commentry.append(contentsOf: commentry)
                    }
                }
                
                print(self.translation.count)
                self.EventHandler?(.Dataloaded)
            case .failure(let error):
                print(error.localizedDescription)
                self.EventHandler?(.message(error))
            }
        }
    }
}
