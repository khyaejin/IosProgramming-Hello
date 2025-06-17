//
//  TendencyCell.swift
//  IosProject-hello
//
//  Created by 김혜진 on 6/17/25.
//
// TendencyCell.swift
// 성향

import UIKit

class TendencyCell: UICollectionViewCell {
    @IBOutlet weak var tendencyLabel: UILabel!

    override var isSelected: Bool {
        didSet {
            updateStyle(selected: isSelected)
        }
    }

    func configure(with title: String) {
        tendencyLabel.text = title
        tendencyLabel.font = UIFont.systemFont(ofSize: 14)
        tendencyLabel.textAlignment = .center

        contentView.layer.cornerRadius = 13
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.systemBlue.cgColor
        contentView.clipsToBounds = true

        // 선택 상태 반영
        updateStyle(selected: isSelected)
    }

    func updateStyle(selected: Bool) {
        contentView.backgroundColor = selected ? .systemBlue : .white
        tendencyLabel.textColor = selected ? .white : .systemBlue
    }
}
