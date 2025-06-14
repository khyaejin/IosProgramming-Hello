//
//  HomeViewController.swift
//  IosProject-hello
//
//  Created by 김혜진 on 6/13/25.
//
import UIKit

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet weak var characterImageView: UIImageView! // 캐릭터 이미지
    
    @IBOutlet weak var dialogueLabel: UILabel! // 말풍선 내용
    
    @IBOutlet weak var situationTitleLabel: UILabel! // 상황 제목 라벨
    
    @IBOutlet weak var situationListTableView: UITableView! // 상황 리스트  테이블
    
    var guides: [Guide] = []
    let guideService = GuideService()
    
    @IBAction func adviceButton(_ sender: Any) { // 조언 시작 버튼
    }

    @IBAction func noticeButton(_ sender: Any) { // 공지사항 버튼
    }
    @IBAction func letterboxButton(_ sender: Any) { // 우편함 버튼
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 테스트 코드 실행
//        let dataAddTest = DataAddTest()
//        dataAddTest.testDatabase()
        
        // 상황 리스트 데이터 넣기
        situationListTableView.delegate = self
        situationListTableView.dataSource = self
        
        // 상황 ID에 따라 초기화
        setupGuideList(for: "situation001")
        
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return guides.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GuideCell", for: indexPath) as? GuideTableViewCell else {
            return UITableViewCell()
        }
        let guide = guides[indexPath.row]
        cell.guideLabel.text = guide.content
        return cell
    }
    
    // 넘어온 텍스트들을 situationListTableView에 보여줌
    func setupGuideList(for situationId: String) {
        fetchGuidesForSituation(situationId)
    }
    
    // 상황에 맞는 가이드 불러오는 메서드
    func fetchGuidesForSituation(_ situationId: String) {
        guideService.fetchGuides(for: situationId) { [weak self] result in
            DispatchQueue.main.async {
                self?.guides = result
                self?.situationListTableView.reloadData()
            }
        }
    }
}
