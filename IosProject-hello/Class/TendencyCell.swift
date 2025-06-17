//
//  TendencyCell.swift
//  IosProject-hello
//
//  Created by 김혜진 on 6/17/25.
//

import UIKit

// 성향
class TendencyCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!

    override var isSelected: Bool {
        didSet {
            contentView.backgroundColor = isSelected ? UIColor.systemBlue : UIColor.clear
            titleLabel.textColor = isSelected ? .white : .black
            contentView.layer.borderColor = isSelected ? UIColor.systemBlue.cgColor : UIColor.lightGray.cgColor
        }
    }

    func configure(with title: String) {
            titleLabel.text = title
            contentView.layer.cornerRadius = 16
            contentView.layer.borderWidth = 1
            contentView.layer.borderColor = UIColor.lightGray.cgColor
        }
}
