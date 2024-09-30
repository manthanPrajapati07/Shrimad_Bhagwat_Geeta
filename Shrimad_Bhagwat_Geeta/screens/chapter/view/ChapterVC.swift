//
//  ChapterVC.swift
//  Shrimad_Bhagwat_Geeta
//
//  Created by Manthan on 16/09/24.
//

import UIKit
import SkeletonView

class ChapterVC: UIViewController {

    //MARK: - @IBOutlets
    @IBOutlet weak var clvChapter :UICollectionView!

    //MARK: - GlobleVar
    private var ViewModel = ChapterViewModel()
    
    //MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        ConfigureCell()
        eventHandler()
        self.ViewModel.FetchChapter()
    }
    //MARK: - functions
    private func ConfigureCell(){
        self.clvChapter.register(ChapterCell.Nib(), forCellWithReuseIdentifier: ChapterCell.identifier)
        self.clvChapter.dataSource = self
        self.clvChapter.delegate = self
        self.clvChapter.collectionViewLayout = layout()
        self.clvChapter.isSkeletonable = true
        self.clvChapter.startSkeletonAnimation()
        self.clvChapter.showAnimatedSkeleton()
    }
    
}

extension ChapterVC {
    
    //MARK: eventHandler
    private func eventHandler(){
        ViewModel.eventHandler = { [weak self] event in
            guard let self else{ return }
            switch event{
            case .Loading:
                break
            case .StopLoading:
                break
            case .Dataloaded:
                DispatchQueue.main.async {
                    self.clvChapter.hideSkeleton()
                    self.clvChapter.reloadData()
                }
            case .message(let error):
                print(error!)
            }
            
        }
    }
    
    
}
extension ChapterVC : SkeletonCollectionViewDataSource, SkeletonCollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        ViewModel.Chapter.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = clvChapter.dequeueReusableCell(withReuseIdentifier: ChapterCell.identifier, for: indexPath) as! ChapterCell
        let data = ViewModel.Chapter[indexPath.item]
        let images = ViewModel.imageArr[indexPath.item]
        cell.lblChapterCount.isHidden = false
        cell.viewBg.borderWidth = 3
        cell.ChapterData = data
        cell.imgtitle.image = UIImage(named: images)
        
        return cell
    }
    
    func layout() -> UICollectionViewLayout{
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 0
        return layout
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (collectionView.frame.width-5)/2
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: "ChapterDetailVC") as! ChapterDetailVC
        
        vc.ChapCount = String(ViewModel.Chapter[indexPath.item].chapter_number ?? 0)
        vc.ChapDetail = ViewModel.Chapter[indexPath.item].chapter_summary ?? ""
        vc.ChapDetailHindi = ViewModel.Chapter[indexPath.item].chapter_summary_hindi ?? ""
        vc.ChapName = ViewModel.Chapter[indexPath.item].name_translated ?? ""
        vc.VerseCount = String(ViewModel.Chapter[indexPath.item].verses_count ?? 0)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> SkeletonView.ReusableCellIdentifier {
        return ChapterCell.identifier
    }
    
    //MARK: SkeletonMethods
    func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 18
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, skeletonCellForItemAt indexPath: IndexPath) -> UICollectionViewCell? {
        let cell = clvChapter.dequeueReusableCell(withReuseIdentifier: ChapterCell.identifier, for: indexPath) as! ChapterCell
        cell.lblChapterCount.isHidden = true
        cell.viewBg.borderWidth = 0
        return cell
    }
}
