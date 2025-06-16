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
                          UICollectionViewDelegateFlowLayout,
                          GuideCollectionViewCellDelegate {
    
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var dialogueLabel: UILabel!
    @IBOutlet weak var situationTitleLabel: UILabel!
    @IBOutlet weak var situationListCollectionView: UICollectionView!
    
    var originalCardFrame: CGRect?
    var dimmingView: UIView?
    
    var guides: [Guide] = []
    let guideService = GuideService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        situationListCollectionView.delegate = self
        situationListCollectionView.dataSource = self
        
        if let layout = situationListCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 16
            layout.minimumInteritemSpacing = 0
        }
        
        situationListCollectionView.isPagingEnabled = false
        situationListCollectionView.showsHorizontalScrollIndicator = false
        
        setupGuideList(for: "situation001")
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return guides.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let guide = guides[indexPath.item]
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GuideCollectionViewCell", for: indexPath) as? GuideCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.guideLabel.text = guide.content
        cell.delegate = self
        return cell
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 130, height: collectionView.frame.height * 0.9)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 14
    }

    func setupGuideList(for situationId: String) {
        fetchGuidesForSituation(situationId)
    }

    func fetchGuidesForSituation(_ situationId: String) {
        guideService.fetchGuides(for: situationId) { [weak self] result in
            DispatchQueue.main.async {
                self?.guides = result
                self?.situationListCollectionView.reloadData()
            }
        }
    }

    // 카드 확대 애니메이션
    func guideCardTapped(from cell: GuideCollectionViewCell) {
        guard let card = cell.guideCard else { return }
        originalCardFrame = card.superview?.convert(card.frame, to: nil)
        
        let dimView = UIView(frame: view.bounds)
        dimView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        dimView.alpha = 0
        view.addSubview(dimView)
        dimmingView = dimView

        let zoomedCard = UIImageView(image: card.image)
        zoomedCard.contentMode = card.contentMode
        zoomedCard.frame = originalCardFrame!
        zoomedCard.layer.cornerRadius = card.layer.cornerRadius
        zoomedCard.clipsToBounds = true
        zoomedCard.isUserInteractionEnabled = true
        zoomedCard.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissZoomedCard)))
        zoomedCard.tag = 999

        view.addSubview(zoomedCard)

        UIView.animate(withDuration: 0.3) {
            dimView.alpha = 1
            zoomedCard.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
            zoomedCard.center = self.view.center
        }
    }

    @objc func dismissZoomedCard(_ sender: UITapGestureRecognizer) {
        guard let zoomedCard = view.viewWithTag(999) as? UIImageView,
              let originalFrame = originalCardFrame else { return }

        UIView.animate(withDuration: 0.3, animations: {
            zoomedCard.frame = originalFrame
            self.dimmingView?.alpha = 0
        }, completion: { _ in
            zoomedCard.removeFromSuperview()
            self.dimmingView?.removeFromSuperview()
            self.dimmingView = nil
            self.originalCardFrame = nil
        })
    }
    
    // 공략 상대 설정하기 버튼 클릭 시
    @IBAction func AddNewmember(_ sender: Any) {
        // MemberSettingViewController로 이동
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
           if let vc = storyboard.instantiateViewController(withIdentifier: "MemberSettingViewController") as? MemberSettingViewController {
               vc.delegate = self  // 복귀 시 데이터 전달 받으려면
               vc.modalPresentationStyle = .fullScreen
               present(vc, animated: true, completion: nil)
           }
    }

    @IBAction func noticeButton(_ sender: Any) {}
    @IBAction func letterboxButton(_ sender: Any) {}
}

extension HomeViewController: MemberSettingDelegate {
    func memberDidFinishSetting() {
        // 다시 돌아왔을 때 처리할 로직
        print("멤버 설정 완료 후 돌아옴")
        // 새로고침 
    }
}
