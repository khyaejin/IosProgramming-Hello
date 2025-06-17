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


    // MARK: - IBOutlets
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var ageField: UITextField!
    @IBOutlet weak var genderField: UISegmentedControl!
    @IBOutlet weak var relationTypePicker: UIPickerView!
    @IBOutlet weak var mbtiField: UIButton!
    @IBOutlet weak var tendencyCollectionView: UICollectionView!
    @IBOutlet weak var characteristicField: UITextField!

    // MARK: - Properties
    var selectedImage: UIImage?
    let tendencyOptions = ["공손한", "유머", "친근한", "상냥한", "분석적", "격식", "감성적", "논리적", "시크", "다정한", "귀여운", "예의바른", "깔끔한", "활기찬", "쿨한"]
    var selectedTendencies: [String] = []
    let relationTypes = ["연인", "친구", "동료", "상사", "후배"]
    var selectedRelationType: String?
    weak var delegate: MemberSettingDelegate?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        avatarImageView.isUserInteractionEnabled = true
        avatarImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectImage)))

        tendencyCollectionView.delegate = self
        tendencyCollectionView.dataSource = self
        
        relationTypePicker.delegate = self
        relationTypePicker.dataSource = self
        
        selectedRelationType = relationTypes[0]
        relationTypePicker.selectRow(0, inComponent: 0, animated: false)

    }

    // MARK: - Image Picker
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

    // MARK: - MBTI 선택
    @IBAction func mbtiFieldTapped(_ sender: UIButton) {
        let alert = UIAlertController(title: "MBTI 선택", message: nil, preferredStyle: .actionSheet)
        ["INTJ", "ENFP", "ISTP", "ESFJ"].forEach { type in
            alert.addAction(UIAlertAction(title: type, style: .default, handler: { _ in
                sender.setTitle(type, for: .normal)
            }))
        }
        alert.addAction(UIAlertAction(title: "취소", style: .cancel))
        present(alert, animated: true)
    }

    // MARK: - Save
    @IBAction func saveButtonTapped(_ sender: Any) {
        uploadMember()
    }

    func uploadMember() {
        guard let uid = Auth.auth().currentUser?.uid,
              let image = selectedImage,
              let imageData = image.jpegData(compressionQuality: 0.8),
              let name = nameField.text,
              let age = Int(ageField.text ?? ""),
              let mbti = mbtiField.title(for: .normal),
              let characteristic = characteristicField.text,
              let relationType = selectedRelationType
                
        else {
            print("필드 누락 또는 잘못된 값")
            return
        }

        // 성별
        let gender = genderField.selectedSegmentIndex == 0 ? "남성" : "여성"
        
        // 성향 3개만 저장
        let tendency1 = selectedTendencies[safe: 0] ?? ""
        let tendency2 = selectedTendencies[safe: 1] ?? ""
        let tendency3 = selectedTendencies[safe: 2] ?? ""

        // 프롬프트는 임시로
        let prompt = "기본 프롬프트"
        
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
                    prompt: prompt,
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

// MARK: - Array Safe Index
extension Array {
    subscript(safe index: Int) -> Element? {
        return (0..<count).contains(index) ? self[index] : nil
    }
}

// MARK: - UICollectionView
extension AddMemberViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tendencyOptions.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TendencyCell", for: indexPath) as! TendencyCell
        let title = tendencyOptions[indexPath.item]
        cell.configure(with: title)
        cell.isSelected = selectedTendencies.contains(title)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selected = tendencyOptions[indexPath.item]
        if selectedTendencies.contains(selected) {
            selectedTendencies.removeAll { $0 == selected }
        } else {
            if selectedTendencies.count >= 3 {
                let alert = UIAlertController(title: "최대 3개까지 선택할 수 있어요", message: nil, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "확인", style: .default))
                present(alert, animated: true)
                collectionView.deselectItem(at: indexPath, animated: true)
                return
            }
            selectedTendencies.append(selected)
        }
        collectionView.reloadData()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let text = tendencyOptions[indexPath.item]
        let width = text.size(withAttributes: [.font: UIFont.systemFont(ofSize: 16)]).width + 24
        return CGSize(width: width, height: 32)
    }
}

// MARK: - UIPickerViewDelegate, UIPickerViewDataSource
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


