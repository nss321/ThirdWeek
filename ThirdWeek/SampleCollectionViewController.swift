//
//  SampleCollectionViewController.swift
//  ThirdWeek
//
//  Created by BAE on 1/9/25.
//

import UIKit

class SampleCollectionViewController: UIViewController {

    var list = Array(1...100)
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var listCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configCollectionView()
        configListCollectionView()
        configCollectionViewLayout()
        configureListCollectionViewLayout()
    }
    
    func configCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        let id = SampleCollectionViewCell.identifier
        let xib = UINib(nibName: id, bundle: nil)
        collectionView.register(xib, forCellWithReuseIdentifier: id)
    }
    
    func configListCollectionView() {
        listCollectionView.delegate = self
        listCollectionView.dataSource = self
        let id = SampleCollectionViewCell.identifier
        let xib = UINib(nibName: id, bundle: nil)
        listCollectionView.register(xib, forCellWithReuseIdentifier: id)
    }
    
    func configureListCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        let leftRightInset: CGFloat = 16
        let cellSpacing: CGFloat = 16
        let deviceWidth = UIScreen.main.bounds.width
        let cardWidth = deviceWidth - cellSpacing * 2 - leftRightInset * 2
        
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: cardWidth / 3, height: cardWidth / 3 * 1.2)
        layout.minimumLineSpacing = cellSpacing
        layout.minimumInteritemSpacing = cellSpacing
        layout.sectionInset = UIEdgeInsets(top: leftRightInset, left: leftRightInset, bottom: leftRightInset, right: leftRightInset)
        listCollectionView.collectionViewLayout = layout
    }
    
    func configCollectionViewLayout() {
//        이것도 가능
//        layout.sectionInset = .init(top: 0, left: 0, bottom: 0, right: 0)
        
        // isPagingEnabled는 딱 화면 크기만큼만 돌려줌. 그래서 인셋, 여백 다 지우고 화면에 딱 맞게 Cell을 그려야함.
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = .secondaryLabel
        collectionView.collectionViewLayout = SampleCollectionViewController.collectionViewLayout()
    }

}

extension SampleCollectionViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SampleCollectionViewCell.identifier, for: indexPath) as! SampleCollectionViewCell
        
        cell.backgroundColor = .red
        cell.image.backgroundColor = .white
        cell.titleLabel.text = "\(indexPath.item)"
        
        cell.image.clipsToBounds = true
        
        // View Drawing Cycle. frame은 일단 xib - cell 배치 - 비율 계산이기 때문에
        // 실제 값과는 다름
//        cell.image.layer.cornerRadius = cell.image.frame.width / 2
        
        DispatchQueue.main.async {
            cell.image.layer.cornerRadius = cell.image.frame.width / 2
            
        }
        
        return cell
        
    }
    
}


