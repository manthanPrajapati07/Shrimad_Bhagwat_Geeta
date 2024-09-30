//
//  VersesCell.swift
//  Shrimad_Bhagwat_Geeta
//
//  Created by Manthan on 18/09/24.
//

import UIKit

class VersesCell: UITableViewCell {
    
    //MARK: -  @IBOutlets
    
    @IBOutlet weak var lblVersCount: UILabel!
    @IBOutlet weak var lblVersDisc: UILabel!
    
    //MARK: -  static vars
    static var identifier = "VersesCell"
      
    //MARK: -  awakeFromNib()
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    //MARK: -  Static Functions
    static func Nib() -> UINib{
        UINib(nibName: identifier, bundle: nil)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
