//
//  GuideCollectionViewCell.swift
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
        
        // 카드 이미지뷰에 탭 제스처 추가
        guideCard.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(cardTapped))
        guideCard.addGestureRecognizer(tap)

        setupCardStyle()
        guideLabel.isHidden = true  // 기본 상태에선 숨김
    }

    @objc func cardTapped() {
        delegate?.guideCardTapped(from: self)
    }

    func configure(with guide: Guide) {
        guideCard.image = UIImage(named: "guideCard_back") // 기본 이미지
        guideLabel.text = guide.content
        guideLabel.isHidden = true // 확대되기 전에는 안 보이게
    }

    func flipToFront(content: String) {
        UIView.transition(with: guideCard, duration: 0.3, options: .transitionFlipFromLeft, animations: {
            self.guideCard.image = UIImage(named: "guideCard_front")
        }, completion: nil)

        // 필요시 셀 안에서도 라벨 보이게 할 수 있음
        guideLabel.text = content
        guideLabel.isHidden = false
        guideLabel.textAlignment = .center
    }

    private func setupCardStyle() {
        guideCard.contentMode = .scaleAspectFill
        guideCard.clipsToBounds = true
        guideCard.layer.cornerRadius = 16
        guideCard.layer.shadowColor = UIColor.black.cgColor
        guideCard.layer.shadowOpacity = 0.08
        guideCard.layer.shadowOffset = CGSize(width: 0, height: 2)
        guideCard.layer.shadowRadius = 4
    }
}
