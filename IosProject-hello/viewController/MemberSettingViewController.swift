//
//  MemberSettingViewController.swift
//  IosProject-hello
//
//  Created by 김혜진 on 6/13/25.
//

import UIKit
import FirebaseFirestore

protocol MemberSettingDelegate: AnyObject {
    func memberDidFinishSetting()
}


class MemberSettingViewController: UIViewController {
    // AddMemberViewController 클래스 내부에 추가
    weak var delegate: MemberSettingDelegate?

    @IBOutlet weak var collectionView: UICollectionView!
    var members: [Member] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.contentInset = UIEdgeInsets(top: 16, left: 25, bottom: 16, right: 25)

        collectionView.backgroundColor = .clear

        fetchMembers()
    }

    // MARK: - Firestore 멤버 불러오기
    func fetchMembers() {
        Firestore.firestore().collection("members")
            .getDocuments { snapshot, error in
                if let error = error {
                    print("전체 멤버 불러오기 오류: \(error.localizedDescription)")
                    return
                }

                self.members = snapshot?.documents.compactMap {
                    let data = $0.data()
                    print("시도 중인 멤버 데이터: \(data)")
                    return Member.fromDict(data)
                } ?? []


                self.collectionView.reloadData()
                
                print("가져온 멤버 수: \(self.members.count)")
                for m in self.members {
                    print(" \(m.name), 이미지: \(m.avatarURL)")
                }

            }
    }
}

// MARK: - CollectionView 구성
extension MemberSettingViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return members.count + 1 // 마지막 셀은 "멤버 추가"
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == members.count {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddMemberCell", for: indexPath)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemberCell", for: indexPath) as! MemberCell
            cell.configure(with: members[indexPath.item])
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item == members.count {
            print("멤버 추가 셀 클릭됨")

            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let addVC = storyboard.instantiateViewController(withIdentifier: "AddMemberViewController") as? AddMemberViewController {
                addVC.delegate = self
                present(addVC, animated: true)
            }
        } else {
            print("멤버 셀 클릭됨: \(indexPath.item)번 셀")

            let selectedMember = members[indexPath.item]
            print("선택된 멤버 이름: \(selectedMember.name), ID: \(selectedMember.id)")

            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let chatVC = storyboard.instantiateViewController(withIdentifier: "ChatViewController") as? ChatViewController {
                chatVC.member = selectedMember
                print("ChatViewController 인스턴스 생성 완료")
                navigationController?.pushViewController(chatVC, animated: true)
            } else {
                print("ChatViewController 인스턴스화 실패 (Storyboard ID 확인 필요)")
            }
        }
    }


}

// MARK: - AddMemberViewController Delegate 구현
extension MemberSettingViewController: MemberSettingDelegate {
    func memberDidFinishSetting() {
        fetchMembers()
    }
}
