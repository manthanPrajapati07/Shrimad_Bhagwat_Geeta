//
//  VersesDetailVC.swift
//  Shrimad_Bhagwat_Geeta
//
//  Created by Manthan on 25/09/24.
//

import UIKit

class VersesDetailVC: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var lblChapCount: UILabel!
    @IBOutlet weak var lblSloka: UILabel!
    @IBOutlet weak var lblVerseTranslation: UILabel!
    @IBOutlet weak var lblTranslation: UILabel!
    @IBOutlet weak var lblComentry: UILabel!

    //MARK: - vars
    var ChapVerseCount = ""
    var Sloka = ""
    var TranslationSloka = ""
    var translation = ""
    var Commentry = ""
    
    //MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblChapCount.text = ChapVerseCount
        lblSloka.text = Sloka.replacingOccurrences(of: "\n\n", with: "\n")
        lblVerseTranslation.text = TranslationSloka
        lblTranslation.text = translation
        lblComentry.text = Commentry
    }
    
    //MARK: - @IBActions
    @IBAction func btnBackTap(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
