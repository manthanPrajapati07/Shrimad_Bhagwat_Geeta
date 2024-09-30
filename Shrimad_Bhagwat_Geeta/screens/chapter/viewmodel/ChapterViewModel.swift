//
//  ChapterViewModel.swift
//  Shrimad_Bhagwat_Geeta
//
//  Created by Manthan on 15/09/24.
//

import Foundation

final class ChapterViewModel {
    
    //MARK: -  Declaration
    
    var Chapter = [ChapterList]()
    var imageArr = ["image1", "image2", "image3", "image4", "image5", "image6", "image7", "image8", "image9", "image10", "image11", "image12","image13", "image14", "image15", "image16", "image17", "image18"]
    var eventHandler : ((_ event : Event) -> ())?
    
    //MARK: -  API functions
    
    func FetchChapter(){
        self.eventHandler?(.Loading)
        APIManager.shared.request(ModelType: [ChapterList].self, Type: EndPointItem.Chapter) { responce in
            self.eventHandler?(.StopLoading)
            switch responce{
            case .success(let chapters):
                self.Chapter = chapters
                self.eventHandler?(.Dataloaded)
                print(chapters)
            case .failure(let error):
                print(error.localizedDescription)
                self.eventHandler?(.message((error)))
            }
        }
    }
    
}


