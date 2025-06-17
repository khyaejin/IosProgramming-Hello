//
//  MemberCollectionViewFlowLayout.swift
//  IosProject-hello
//
//  Created by 김혜진 on 6/17/25.
//
import UIKit

class MemberCollectionViewFlowLayout: UICollectionViewFlowLayout {

    private let cellSpacing: CGFloat = 30       // 셀 간 간격
    private let sideInset: CGFloat = 25         // 좌우 여백
    private let verticalInset: CGFloat = 16     // 상하 여백

    override func prepare() {
        super.prepare()

        guard let collectionView = self.collectionView else { return }

        // 가로 스크롤 설정
        scrollDirection = .horizontal

        // 인셋 설정
        sectionInset = UIEdgeInsets(top: verticalInset, left: sideInset, bottom: verticalInset, right: sideInset)

        // 셀 크기 계산
        let cellWidth: CGFloat = 230
        let cellHeight: CGFloat = 300

        itemSize = CGSize(width: cellWidth, height: cellHeight)

        // 셀 사이 간격
        minimumInteritemSpacing = cellSpacing
        minimumLineSpacing = cellSpacing
    }
}
