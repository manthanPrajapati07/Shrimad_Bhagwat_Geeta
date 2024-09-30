//
//  ChapterDetailVC.swift
//  Shrimad_Bhagwat_Geeta
//
//  Created by Manthan on 18/09/24.
//

import UIKit
import SkeletonView

class ChapterDetailVC: UIViewController , UITextFieldDelegate{
    
    //MARK: - @IBOutlets
    
    @IBOutlet weak var ScrollView: UIScrollView!
    @IBOutlet weak var lblChapCount: UILabel!
    @IBOutlet weak var lblChapDetail: UILabel!
    @IBOutlet weak var lblChapName: UILabel!
    @IBOutlet weak var lblVersesCount: UILabel!
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var tblvVerses: UITableView!
    @IBOutlet weak var HeightTblv: NSLayoutConstraint!
    @IBOutlet weak var lblNoData: UILabel!
    @IBOutlet weak var btnTranslation: UIButton!
    
    //MARK: - @globleVars
    
    var ChapCount = ""
    var ChapDetail = ""
    var ChapDetailHindi = ""
    var ChapName = ""
    var VerseCount = ""
    
    var Istranslate = false {
        didSet{
            if Istranslate{
                self.btnTranslation.setTitle("See Original", for: .normal)
                self.lblChapDetail.text = ChapDetailHindi
            }else{
                self.btnTranslation.setTitle("See Translation", for: .normal)
                self.lblChapDetail.text = ChapDetail
            }
        }
    }
    
    //MARK: viewModel Var
    var viewModel = VarsesViewModel()

    
    //MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        ConfigureTableCell()
        SetUI()
        eventHandler()
        self.viewModel.FetchVerses(Chapter: Int(ChapCount) ?? 1)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear(_:)),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear(_:)),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    //MARK: - Functions
   private func SetUI(){
        Istranslate = false
        self.txtSearch.delegate = self
        self.txtSearch.addTarget(self, action: #selector(SearchMethod), for: .editingChanged)
        
        self.lblChapCount.text = "Chapter \(ChapCount)"
        self.lblChapName.text = ChapName
        self.lblVersesCount.text = "\(VerseCount) Verses"
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
           tapGesture.cancelsTouchesInView = false
           view.addGestureRecognizer(tapGesture)
    }
    
    private func ConfigureTableCell(){
        tblvVerses.register(VersesCell.Nib(), forCellReuseIdentifier: VersesCell.identifier)
        tblvVerses.delegate = self
        tblvVerses.dataSource = self
        tblvVerses.isSkeletonable = true
        tblvVerses.rowHeight = UITableView.automaticDimension
        tblvVerses.estimatedRowHeight = 90
        self.tblvVerses.startSkeletonAnimation()
        self.tblvVerses.showAnimatedSkeleton()
    }
    
    private func updateTableViewHeight() {
         if viewModel.filterVerses.count == 0{
            self.lblNoData.isHidden = false
             self.HeightTblv.constant = CGFloat(150)
        }else{
            self.lblNoData.isHidden = true
            self.HeightTblv.constant = CGFloat(viewModel.filterVerses.count * 90)
        }
    }
    
    
    //MARK: KeyBoard Nottifications
   
    @objc private func hideKeyboard(){
        view.endEditing(true)
    }
    
    @objc private func keyboardWillAppear(_ notification: NSNotification) {
        if let keyboardFrame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let keyboardHeight = keyboardFrame.height
            let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight + 20, right: 0)
            
            ScrollView.contentInset = contentInsets
            ScrollView.scrollIndicatorInsets = contentInsets
            
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }
    }

    @objc private func keyboardWillDisappear(_ notification: NSNotification) {
        ScrollView.contentInset = UIEdgeInsets.zero
        ScrollView.scrollIndicatorInsets = UIEdgeInsets.zero
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    //MARK: - Search Method
    
    @objc private func SearchMethod(_ textField: UITextField) {
        
        viewModel.filterVerses = textField.text!.isEmpty ? viewModel.Verses : viewModel.Verses.filter({(_ item : VersesList) -> Bool in
            
            return (String("Verse\(item.verse_number ?? 0)").lowercased().range(of: textField.text!.lowercased(), options: .caseInsensitive) != nil) || (String("Verse \(item.verse_number ?? 0)").lowercased().range(of: textField.text!.lowercased(), options: .caseInsensitive) != nil)
        })
        self.lblNoData.text = "No Search Results (\(textField.text!))"
        self.tblvVerses.reloadData()
        updateTableViewHeight()
    }
    

    //MARK: - @IBActions
    
    @IBAction func btnBackTap(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnSeeTranslationTap(_ sender: UIButton) {
        self.Istranslate.toggle()
    }
    
}
extension ChapterDetailVC {
    
    //MARK: - EventHandler
    func eventHandler(){
        
        viewModel.EventHandler = { [weak self] event in
            guard let self else {return}
            
            switch event{
            case .Loading:
              break
            case .StopLoading:
                break
            case .Dataloaded:
                DispatchQueue.main.async {
                    self.tblvVerses.hideSkeleton()
                    self.tblvVerses.reloadData()
                    self.updateTableViewHeight()
                }
            case .message(let error):
                print(error!)
            }
        }
        
    }
}

extension ChapterDetailVC : SkeletonTableViewDelegate, SkeletonTableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.filterVerses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblvVerses.dequeueReusableCell(withIdentifier: VersesCell.identifier, for: indexPath) as! VersesCell
        cell.lblVersDisc.text = viewModel.translation[indexPath.row].description
        cell.lblVersCount.text = "Verse \(String(viewModel.filterVerses[indexPath.row].verse_number ?? 0))"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return VersesCell.identifier
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: "VersesDetailVC") as! VersesDetailVC
            
        vc.ChapVerseCount = "Chapter \(ChapCount).\(String(viewModel.filterVerses[indexPath.row].verse_number ?? 0))"
            navigationController?.pushViewController(vc, animated: true)
        vc.Sloka = viewModel.filterVerses[indexPath.row].text ?? ""
        vc.TranslationSloka = viewModel.filterVerses[indexPath.row].transliteration ?? ""
        vc.translation = viewModel.translation[indexPath.row].description ?? ""
        vc.Commentry = viewModel.Commentry[indexPath.row].description ?? ""
    }
    
    //MARK:  skeleton Table method
    func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 5
    }

}
