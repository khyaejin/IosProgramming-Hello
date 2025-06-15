//
//  GuideTableViewCell.swift
//  IosProject-hello
//
//  Created by 김혜진 on 6/15/25.
//

import UIKit

class GuideCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var guideLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.layer.cornerRadius = 12
        contentView.layer.masksToBounds = true
    }
    
}

