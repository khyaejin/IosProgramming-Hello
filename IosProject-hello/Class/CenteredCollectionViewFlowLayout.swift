//
//  CenteredCollectionViewFlowLayout.swift
//  IosProject-hello
//
//  Created by 김혜진 on 6/18/25.
//

import UIKit

class CenteredCollectionViewFlowLayout: UICollectionViewFlowLayout {

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let superAttributes = super.layoutAttributesForElements(in: rect),
              let collectionView = self.collectionView else {
            return nil
        }

        let contentWidth = collectionView.bounds.width - collectionView.contentInset.left - collectionView.contentInset.right
        var rowAttributes: [UICollectionViewLayoutAttributes] = []
        var leftMargin: CGFloat = sectionInset.left
        var maxY: CGFloat = -1.0

        for attributes in superAttributes {
            if attributes.frame.origin.y >= maxY {
                // 새로운 줄 시작
                centerItems(rowAttributes, contentWidth: contentWidth, leftInset: sectionInset.left)
                rowAttributes.removeAll()
                leftMargin = sectionInset.left
            }

            var frame = attributes.frame
            frame.origin.x = leftMargin
            attributes.frame = frame

            rowAttributes.append(attributes)
            leftMargin += frame.width + minimumInteritemSpacing
            maxY = max(maxY, frame.maxY)
        }

        // 마지막 줄 처리
        centerItems(rowAttributes, contentWidth: contentWidth, leftInset: sectionInset.left)

        return superAttributes
    }

    private func centerItems(_ attributes: [UICollectionViewLayoutAttributes], contentWidth: CGFloat, leftInset: CGFloat) {
        let totalWidth = attributes.reduce(0) { $0 + $1.frame.width } +
            CGFloat(max(attributes.count - 1, 0)) * minimumInteritemSpacing
        let startX = (contentWidth - totalWidth) / 2 + leftInset

        var currentX = startX
        for attr in attributes {
            var frame = attr.frame
            frame.origin.x = currentX
            attr.frame = frame
            currentX += frame.width + minimumInteritemSpacing
        }
    }
}
