//
//  GuideListViewController.swift
//  IosProject-hello
//
//  Created by 김혜진 on 6/18/25.
//
import UIKit
import FirebaseFirestore

class GuideListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!

    var situation: Situation! // nil 허용으로 바꾸기
    var guides: [Guide] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        title = situation.description
        view.backgroundColor = .systemBackground

        tableView.delegate = self
        tableView.dataSource = self

        fetchGuides()
    }

    func fetchGuides() {
        Firestore.firestore().collection("guides")
            .whereField("situationId", isEqualTo: situation.id)
            .getDocuments { snapshot, error in
                if let error = error {
                    print("가이드 로딩 오류:", error)
                    return
                }

                guard let documents = snapshot?.documents else { return }

                self.guides = documents.compactMap { Guide.fromDict($0.data()) }
                print("'\(self.situation.description)' 상황: \(self.guides.count)개 가이드 불러와짐.")
                self.tableView.reloadData()
            }
    }

    // MARK: - TableView

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return guides.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let guide = guides[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GuideCell", for: indexPath) as? GuideCell else {
            return UITableViewCell()
        }
        cell.configure(with: guide)
        return cell
    }

}
