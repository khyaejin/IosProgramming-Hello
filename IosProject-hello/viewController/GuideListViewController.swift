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

    var situation: Situation
    var guides: [Guide] = []

    init(situation: Situation) {
        self.situation = situation
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "비법서 목록"
        view.backgroundColor = .systemBackground

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "GuideCell")

        fetchGuides()
    }

    func fetchGuides() {
        Firestore.firestore().collection("guides")
            .whereField("situationId", isEqualTo: situation.id)
            .getDocuments { snapshot, error in
                if let error = error {
                    print("🔥 가이드 로딩 오류:", error)
                    return
                }

                guard let documents = snapshot?.documents else { return }

                self.guides = documents.compactMap { Guide.fromDict($0.data()) }
                self.tableView.reloadData()
            }
    }

    // MARK: - TableView

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return guides.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let guide = guides[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "GuideCell", for: indexPath)
        cell.textLabel?.text = guide.content
        cell.textLabel?.numberOfLines = 0
        return cell
    }
}
