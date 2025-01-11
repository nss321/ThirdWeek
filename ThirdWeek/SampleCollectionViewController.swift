//
//  SampleCollectionViewController.swift
//  ThirdWeek
//
//  Created by BAE on 1/9/25.
//

import UIKit

final class SampleCollectionViewController: UIViewController {

    /// 전체 데이터
    var totalList: [Int] = Array(1...100)
    
    /// 필터링된 데이터
    /// 이거 연산 프로퍼티는 안되나?? 어차피 초기화가 늦는건데
    lazy var list: [Int] = totalList
    
//    var list: [int] {
//        totalList
//    }
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var listCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configCollectionView()
        configCollectionViewLayout()
//        registCell()
        registCell(to: collectionView, cell: SampleCollectionViewCell.self, identifier: SampleCollectionViewCell.identifier)
        registCell(to: listCollectionView, cell: SampleCollectionViewCell.self, identifier: SampleCollectionViewCell.identifier)
        configSearchBar()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)))
    }
    
    @objc func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
}


// MARK: SearchBar
extension SampleCollectionViewController: UISearchBarDelegate {
    func configSearchBar() {
        searchBar.delegate = self
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(#function)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print(#function)
        view.endEditing(true)
        searchBar.searchTextField.text = ""
        searchBar.setShowsCancelButton(false, animated: true)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print(#function)
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(#function)
        
        var result: [Int] = []
        
        if searchText == "" {
            result = Array(1...100)
        } else {
            for item in list {
                if item == Int(searchText)! {
                    result.append(item)
                }
            }
        }
        
//        for item in list {
//            if item == Int(searchText)! {
//                result.append(item)
//            }
//        }
        
        list = result
        listCollectionView.reloadData()
    }
}


// MARK: CollectionVie
extension SampleCollectionViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func configCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        listCollectionView.delegate = self
        listCollectionView.dataSource = self
    }
    
    func registCell(to: UICollectionView, cell: UICollectionViewCell.Type ,identifier: String) {
        to.register(UINib(nibName: "\(cell)", bundle: nil), forCellWithReuseIdentifier: identifier)
    }
    
//    func registCell(to: UICollectionView, identifier: String) {
//        var id = SampleCollectionViewCell.identifier
//        var xib = UINib(nibName: id, bundle: nil)
//        collectionView.register(xib, forCellWithReuseIdentifier: id)
//        id = SampleCollectionViewCell.identifier
//        xib = UINib(nibName: id, bundle: nil)
//        listCollectionView.register(xib, forCellWithReuseIdentifier: id)
//    }
    
    func configCollectionViewLayout() {
        // layout.sectionInset = .init(top: 0, left: 0, bottom: 0, right: 0)
        // isPagingEnabled는 딱 화면 크기만큼만 돌려줌. 그래서 인셋, 여백 다 지우고 화면에 딱 맞게 Cell을 그려야함.

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
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = .secondaryLabel
        collectionView.collectionViewLayout = SampleCollectionViewController.collectionViewLayout()
    }

    
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
        
        cell.titleLabel.text = "\(list[indexPath.item])"
        return cell
    }
}


