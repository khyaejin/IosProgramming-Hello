//
//  AddMemberViewController.swift
//  IosProject-hello
//
//  Created by 김혜진 on 6/17/25.
//

import UIKit
import FirebaseFirestore
import FirebaseStorage
import FirebaseAuth

class AddMemberViewController: UIViewController,
                                UIImagePickerControllerDelegate,
                                UINavigationControllerDelegate {

    // MARK: - 연결
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var ageField: UITextField!
    @IBOutlet weak var genderField: UISegmentedControl!
    @IBOutlet weak var relationTypePicker: UIPickerView!
    @IBOutlet weak var mbtiButton: UIButton!
    @IBOutlet weak var tendencyCollectionView: UICollectionView!
    @IBOutlet weak var characteristicField: UITextField!

    // MARK: - 값들 관리
    var selectedImage: UIImage?
    let tendencyOptions = ["공손한", "유머", "친근한", "상냥한", "분석적", "격식", "감성적", "논리적", "시크", "다정한", "귀여운", "예의바른", "깔끔한", "활기찬", "쿨한"]
    var selectedTendencies: [String] = []
    let relationTypes = ["연인", "친구", "동료", "상사", "후배"]
    var selectedRelationType: String?
    var selectedMBTI: String?
    weak var delegate: MemberSettingDelegate?

    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        configureMBTIMenu()
        configurePickers()
    }

    // MARK: - UI 초기 설정
    func setupUI() {
        avatarImageView.isUserInteractionEnabled = true
        avatarImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectImage)))

        tendencyCollectionView.delegate = self
        tendencyCollectionView.dataSource = self
        tendencyCollectionView.backgroundColor = .clear
    }

    // MARK: - Picker 설정
    func configurePickers() {
        relationTypePicker.delegate = self
        relationTypePicker.dataSource = self
        selectedRelationType = relationTypes[0]
        relationTypePicker.selectRow(0, inComponent: 0, animated: false)
    }

    // MARK: - MBTI 메뉴 설정
    func configureMBTIMenu() {
        let mbtiTypes = ["INTJ", "ENFP", "ISTP", "ESFJ"]
        let actions = mbtiTypes.map { type in
            UIAction(title: type, handler: { [weak self] _ in
                self?.mbtiButton.setTitle(type, for: .normal)
                self?.selectedMBTI = type
                print("선택된 MBTI: \(type)")
            })
        }
        let menu = UIMenu(title: "MBTI 선택", options: .displayInline, children: actions)
        mbtiButton.menu = menu
        mbtiButton.showsMenuAsPrimaryAction = true
    }

    // MARK: - 이미지 선택
    @objc func selectImage() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        present(picker, animated: true)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            selectedImage = image
            avatarImageView.image = image
        }
        dismiss(animated: true)
    }

    // MARK: - 저장 버튼 동작
    @IBAction func saveButtonTapped(_ sender: Any) {
        view.endEditing(true) // 바로 나가져서 저장 버튼 두번 못 누르도록
        uploadMember()
    }

    // MARK: - 멤버 업로드
    func uploadMember() {
        // TODO: 로그인 기능 추가 필요(회원 관리 기능)
//        guard let uid = Auth.auth().currentUser?.uid else {
//            showAlert(message: "로그인이 필요합니다.")
//            return
//        }
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }

        let uid = appDelegate.testUserId

        let image: UIImage
        if let selected = selectedImage {
            image = selected
        } else {
            image = UIImage(named: "default_member")! //  기본 이미지 사용
        }

        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            showAlert(message: "이미지 데이터를 처리할 수 없습니다.")
            return
        }
        guard let name = nameField.text, !name.isEmpty else {
            showAlert(message: "이름을 입력해주세요.")
            return
        }
        guard let ageText = ageField.text, let age = Int(ageText) else {
            showAlert(message: "나이를 정확히 입력해주세요.")
            return
        }
        guard let mbti = selectedMBTI else {
            showAlert(message: "MBTI를 선택해주세요.")
            return
        }
        guard let characteristic = characteristicField.text, !characteristic.isEmpty else {
            showAlert(message: "특징을 입력해주셔야 보다 정확한 대화 연습이 가능합니다.")
            return
        }
        guard let relationType = selectedRelationType else {
            showAlert(message: "관계 유형을 선택해주세요.")
            return
        }
        
        func showAlert(message: String) {
            let alert = UIAlertController(title: "입력 오류", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .default))
            present(alert, animated: true)
        }


        let gender = genderField.selectedSegmentIndex == 0 ? "남성" : "여성"
        let tendency1 = selectedTendencies[safe: 0] ?? ""
        let tendency2 = selectedTendencies[safe: 1] ?? ""
        let tendency3 = selectedTendencies[safe: 2] ?? ""
        let nicknameForMe = "기본 프롬프트"
        let memberId = UUID().uuidString
        let storageRef = Storage.storage().reference().child("members/\(memberId).jpg")

        storageRef.putData(imageData) { _, error in
            if let error = error {
                print("이미지 업로드 실패: \(error)")
                return
            }

            storageRef.downloadURL { url, error in
                guard let avatarURL = url?.absoluteString else {
                    print("다운로드 URL 실패")
                    return
                }

                let member = Member(
                    id: memberId,
                    userId: uid,
                    name: name,
                    age: age,
                    gender: gender,
                    mbti: mbti,
                    tendency1: tendency1,
                    tendency2: tendency2,
                    tendency3: tendency3,
                    characteristic: characteristic,
                    nicknameForMe: nicknameForMe,
                    relationType: relationType,
                    avatarURL: avatarURL
                )

                let memberDict = Member.toDict(member)
                Firestore.firestore().collection("members").document(memberId).setData(memberDict) { error in
                    if let error = error {
                        print("저장 실패: \(error)")
                    } else {
                        print("저장 성공")
                        self.delegate?.memberDidFinishSetting()
                        self.dismiss(animated: true)
                    }
                }
            }
        }
    }
}

// MARK: - 배열
extension Array {
    subscript(safe index: Int) -> Element? {
        return (0..<count).contains(index) ? self[index] : nil
    }
}

// MARK: - UICollectionView 설정
extension AddMemberViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    // 셀들 간 가로 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }

    // 셀들의 행간
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tendencyOptions.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TendencyCell", for: indexPath) as! TendencyCell
        let title = tendencyOptions[indexPath.item]
        cell.configure(with: title)
        let isSelected = selectedTendencies.contains(title)
        cell.updateStyle(selected: isSelected)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selected = tendencyOptions[indexPath.item]

        if selectedTendencies.contains(selected) {
            selectedTendencies.removeAll { $0 == selected }
            collectionView.deselectItem(at: indexPath, animated: true)
        } else {
            if selectedTendencies.count >= 3 {
                let alert = UIAlertController(title: "최대 3개까지 선택할 수 있어요", message: nil, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "확인", style: .default))
                present(alert, animated: true)
                collectionView.deselectItem(at: indexPath, animated: false)
                return
            }
            selectedTendencies.append(selected)
        }

        collectionView.reloadItems(at: [indexPath])
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let text = tendencyOptions[indexPath.item]
        let font = UIFont.systemFont(ofSize: 15)
        let textAttributes = [NSAttributedString.Key.font: font]
        let textSize = (text as NSString).size(withAttributes: textAttributes)
        let width = textSize.width + 26
        let height: CGFloat = 30
        return CGSize(width: width, height: height)
    }
}

// MARK: - UIPickerView 설정
extension AddMemberViewController: UIPickerViewDelegate, UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return relationTypes.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return relationTypes[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedRelationType = relationTypes[row]
    }
}
