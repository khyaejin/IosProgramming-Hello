//
//  MemberCollectionViewFlowLayout.swift
//  IosProject-hello
//
//  Created by 김혜진 on 6/17/25.
//

import UIKit

class MemberCollectionViewFlowLayout: UICollectionViewFlowLayout {

    private let minimumCellSize = CGSize(width: 100, height: 100)
    private let cellSpacing: CGFloat = 8
    private let sideInset: CGFloat = 12

    override func prepare() {
        super.prepare()

        guard let collectionView = self.collectionView else { return }

        scrollDirection = .horizontal

        // 셀 크기 계산 (높이 고정, 너비는 일정 수 이하로 조절 가능)
        let height = collectionView.bounds.height - sectionInset.top - sectionInset.bottom
        let width = max(minimumCellSize.width, height * 0.85)

        itemSize = CGSize(width: width, height: height)

        minimumInteritemSpacing = cellSpacing
        minimumLineSpacing = 0

        sectionInset = UIEdgeInsets(top: 0, left: sideInset, bottom: 0, right: sideInset)
    }
}
