//
//  GuideTableViewCell.swift
//  IosProject-hello
//
//  Created by 김혜진 on 6/15/25.
//

import UIKit

protocol GuideCollectionViewCellDelegate: AnyObject {
    func guideCardTapped(from cell: GuideCollectionViewCell)
}

class GuideCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var guideCard: UIImageView!
    @IBOutlet weak var guideLabel: UILabel!
    
    weak var delegate: GuideCollectionViewCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        guideCard.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(cardTapped))
        guideCard.addGestureRecognizer(tap)
    }

    @objc func cardTapped() {
        delegate?.guideCardTapped(from: self)
    }
}
