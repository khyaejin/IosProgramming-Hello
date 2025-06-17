//
//  SituationViewController.swift
//  IosProject-hello
//
//  Created by 김혜진 on 6/18/25.
//

import UIKit
import FirebaseFirestore

class SituationViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!

    private var situations: [Situation] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self

        // FlowLayout 등록
        collectionView.collectionViewLayout = SituationCollectionViewFlowLayout()

        fetchSituations()
    }

    private func fetchSituations() {
        Firestore.firestore().collection("situations").getDocuments { snapshot, error in
            if let error = error {
                print("상황 로딩 오류:", error)
                return
            }

            guard let documents = snapshot?.documents else { return }

            self.situations = documents.compactMap { Situation.fromDict($0.data()) }
            self.collectionView.reloadData()
        }
    }

    // MARK: - UICollectionViewDataSource

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return situations.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SituationCell", for: indexPath) as? SituationCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: situations[indexPath.item])
        return cell
    }

    // 상황 선택 시 가이드리스트 화면으로 이동
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selected = situations[indexPath.item]
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "GuideListViewController") as? GuideListViewController {
            vc.situation = selected
            navigationController?.pushViewController(vc, animated: true)
        }
    }

}
