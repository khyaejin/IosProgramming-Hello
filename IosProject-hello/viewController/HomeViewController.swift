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
        guard let startFrame = card.superview?.convert(card.frame, to: nil) else { return }
        originalCardFrame = startFrame

        let dimView = UIView(frame: view.bounds)
        dimView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        dimView.alpha = 0
        view.addSubview(dimView)
        dimmingView = dimView

        // 확대 카드 이미지
        let zoomedCard = UIImageView(image: UIImage(named: "guideCard_front"))
        zoomedCard.contentMode = .scaleAspectFill
        zoomedCard.frame = startFrame
        zoomedCard.layer.cornerRadius = card.layer.cornerRadius
        zoomedCard.clipsToBounds = false
        zoomedCard.isUserInteractionEnabled = true
        zoomedCard.tag = 999
        zoomedCard.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissZoomedCard)))
        view.addSubview(zoomedCard)

        // 내용 라벨 추가
        let label = UILabel()
        label.text = cell.guideLabel.text
        label.textColor = UIColor(hex: "#F0F0FF")
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.alpha = 0  // 처음엔 숨김
        label.tag = 1000
        zoomedCard.addSubview(label)

        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: zoomedCard.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: zoomedCard.centerYAnchor),
            label.widthAnchor.constraint(equalTo: zoomedCard.widthAnchor, multiplier: 0.8)
        ])

        UIView.animate(withDuration: 0.3) {
            dimView.alpha = 1
            zoomedCard.frame = CGRect(x: 0, y: 0, width: self.view.frame.width - 40, height: self.view.frame.height * 0.6)
            zoomedCard.center = self.view.center
            label.alpha = 1
        }

        // 확대 이후에 라벨 등장
        UIView.animate(withDuration: 0.2, delay: 0.3, options: [], animations: {
            label.alpha = 1
        })
    }

    // 축소 시 카드 변화
    @objc func dismissZoomedCard(_ sender: UITapGestureRecognizer) {
        guard let zoomedCard = view.viewWithTag(999) as? UIImageView,
              let label = zoomedCard.viewWithTag(1000) as? UILabel,
              let originalFrame = originalCardFrame else { return }

        // 텍스트 먼저 서서히 사라지게
        UIView.animate(withDuration: 0) {
            label.alpha = 0
        }

        // 그 다음 카드 축소 및 배경 제거
        UIView.animate(withDuration: 0.3, delay: 0.1, options: [], animations: {
            zoomedCard.frame = originalFrame
            self.dimmingView?.alpha = 0
        }, completion: { _ in
            zoomedCard.removeFromSuperview()
            self.dimmingView?.removeFromSuperview()
            self.dimmingView = nil
            self.originalCardFrame = nil
        })
    }


    @IBAction func noticeButton(_ sender: Any) {}
    @IBAction func letterboxButton(_ sender: Any) {}
    
    @IBAction func guideButton(_ sender: Any) {
        // 비법서 탭 바로 이동
        tabBarController?.selectedIndex = 1

    }
    @IBAction func ChatButton(_ sender: Any) {
        // 채팅 탭 바로 이동
        tabBarController?.selectedIndex = 2
    }
    
}


