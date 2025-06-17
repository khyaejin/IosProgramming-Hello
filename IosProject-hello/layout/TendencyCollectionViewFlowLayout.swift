//
//  CenteredCollectionViewFlowLayout.swift
//  IosProject-hello
//
//  Created by 김혜진 on 6/18/25.
//
import UIKit

class TendencyCollectionViewFlowLayout: UICollectionViewFlowLayout {

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let superAttributes = super.layoutAttributesForElements(in: rect),
              let collectionView = self.collectionView else {
            return nil
        }

        let attributesCopy = superAttributes.map { $0.copy() as! UICollectionViewLayoutAttributes }

        let contentWidth = collectionView.bounds.width - collectionView.contentInset.left - collectionView.contentInset.right
        var currentRow: [UICollectionViewLayoutAttributes] = []
        var leftMargin: CGFloat = sectionInset.left
        var currentY: CGFloat = sectionInset.top

        for attributes in attributesCopy {
            // 새 줄로 넘어가야 하면
            if leftMargin + attributes.frame.width > contentWidth {
                centerItems(currentRow, contentWidth: contentWidth, y: currentY)
                currentRow.removeAll()
                leftMargin = sectionInset.left
                currentY += attributes.frame.height + minimumLineSpacing // ⬅️ 행간 추가
            }

            var frame = attributes.frame
            frame.origin.x = leftMargin
            frame.origin.y = currentY
            attributes.frame = frame

            currentRow.append(attributes)
            leftMargin += frame.width + minimumInteritemSpacing
        }

        // 마지막 줄도 정렬
        centerItems(currentRow, contentWidth: contentWidth, y: currentY)

        return attributesCopy
    }

    private func centerItems(_ attributes: [UICollectionViewLayoutAttributes], contentWidth: CGFloat, y: CGFloat) {
        let totalWidth = attributes.reduce(0) { $0 + $1.frame.width } +
            CGFloat(max(attributes.count - 1, 0)) * minimumInteritemSpacing
        let startX = (contentWidth - totalWidth) / 2

        var currentX = startX
        for attr in attributes {
            var frame = attr.frame
            frame.origin.x = currentX
            frame.origin.y = y // 줄 Y 좌표 고정
            attr.frame = frame
            currentX += frame.width + minimumInteritemSpacing
        }
    }
}
