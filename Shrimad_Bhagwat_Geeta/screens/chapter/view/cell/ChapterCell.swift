//
//  ChapterCell.swift
//  Shrimad_Bhagwat_Geeta
//
//  Created by Manthan on 16/09/24.
//

import UIKit
import SkeletonView

class ChapterCell: UICollectionViewCell {
    
    //MARK: - @IBOutlets
    @IBOutlet weak var lblChapterCount :UILabel!
    @IBOutlet weak var viewBg: UIView!
    @IBOutlet weak var imgtitle: UIImageView!
    
    //MARK: - static Declaration
    static let identifier = "ChapterCell"
    
    //MARK: - vars
    var ChapterData : ChapterList?{
        didSet{
            FatchChapterDetail()
        }
    }

    //MARK: - awakeFromNib()
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    //MARK: - static Functions
    
    static func Nib() -> UINib{
        UINib(nibName: identifier, bundle: nil)
    }
    
    //MARK: - Functions
    func FatchChapterDetail(){
        guard let ChapterData else{ return}
        self.lblChapterCount.text = "Chapter \(String(ChapterData.chapter_number ?? 0))"
    }

}
