//
//  SituationCollectionViewFlowLayout.swift
//  IosProject-hello
//
//  Created by 김혜진 on 6/18/25.
//

import UIKit

class SituationCollectionViewFlowLayout: UICollectionViewFlowLayout {
    override func prepare() {
        super.prepare()
        scrollDirection = .vertical
        minimumLineSpacing = 12
        sectionInset = UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 16)

        guard let collectionView = collectionView else { return }
        let width = collectionView.bounds.width - sectionInset.left - sectionInset.right
        itemSize = CGSize(width: width, height: 100) 
    }
}
