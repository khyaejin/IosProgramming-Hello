//
//  HomeViewController.swift
//  IosProject-hello
//
//  Created by 김혜진 on 6/13/25.
//
import UIKit

class HomeViewController: UIViewController,
                          UICollectionViewDataSource,
                          UICollectionViewDelegate,
                          UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var characterImageView: UIImageView! // 캐릭터 이미지
    
    @IBOutlet weak var dialogueLabel: UILabel! // 말풍선 내용
    
    @IBOutlet weak var situationTitleLabel: UILabel! // 상황 제목 라벨
    
    @IBOutlet weak var situationListCollectionView: UICollectionView! // 상황 리스트  컬렉션
    
    var guides: [Guide] = []
    let guideService = GuideService()

    @IBAction func noticeButton(_ sender: Any) { // 공지사항 버튼
    }
    @IBAction func letterboxButton(_ sender: Any) { // 우편함 버튼
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 상황 리스트 데이터 넣기
        situationListCollectionView.delegate = self
        situationListCollectionView.dataSource = self
        
        // 상황 ID에 따라 초기화
        setupGuideList(for: "situation001")
        
        if let layout = situationListCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 16 // 카드 간 간격
            layout.minimumInteritemSpacing = 0
        }

        situationListCollectionView.isPagingEnabled = false
        situationListCollectionView.showsHorizontalScrollIndicator = false
          
        // 테스트 코드 실행
//        let dataAddTest = DataAddTest()
//        dataAddTest.testDatabase()
        
    }
        
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        // 둥근 테두리
//        cell.contentView.layer.cornerRadius = 20
//        cell.contentView.layer.masksToBounds = true
//    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return guides.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let guide = guides[indexPath.item]
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GuideCollectionViewCell", for: indexPath) as? GuideCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.guideLabel.text = guide.content
        return cell
    }
    
    // 셀 크기 지정
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: collectionView.frame.height * 0.9)
    }


    // 셀 간 간격 설정 (optional)
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    
    // 넘어온 텍스트들을 카드에 보여줌
    func setupGuideList(for situationId: String) {
        fetchGuidesForSituation(situationId)
    }
    
    // 상황에 맞는 가이드 불러오는 메서드
    func fetchGuidesForSituation(_ situationId: String) {
        guideService.fetchGuides(for: situationId) { [weak self] result in
            DispatchQueue.main.async {
                self?.guides = result
                self?.situationListCollectionView.reloadData()
            }
        }
    }
}
