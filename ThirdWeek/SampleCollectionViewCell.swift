//
//  SampleCollectionViewCell.swift
//  ThirdWeek
//
//  Created by BAE on 1/9/25.
//

import UIKit

class SampleCollectionViewCell: UICollectionViewCell {

    static let identifier = "SampleCollectionViewCell"
    
    @IBOutlet var image: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // layoutSubviews
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        image.layer.cornerRadius = image.frame.width / 2
//    }

    // layoutInNeeded() {
    
}
