//
//  ChatViewController.swift
//  IosProject-hello
//
//  Created by 김혜진 on 6/15/25.
//
import UIKit

class ChatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    var member: Member?
    var messages: [Message] = []
    let openAI = OpenAIService()

    // 사용자 입력 값
    var nicknameForMe: String = ""
    var situationPrompt: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 60
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        // 첫 입장 시 모달 띄우기
        if messages.isEmpty {
            presentChatPreface()
        }
    }

    func presentChatPreface() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let prefaceVC = storyboard.instantiateViewController(withIdentifier: "ChatPrefaceViewController") as? ChatPrefaceViewController {
            prefaceVC.modalPresentationStyle = .formSheet
            prefaceVC.onSubmit = { [weak self] nickname, situation in
                self?.nicknameForMe = nickname
                self?.situationPrompt = situation
                self?.requestInitialMessageFromAI()
            }
            present(prefaceVC, animated: true)
        }
    }
    
    func requestInitialMessageFromAI() {
        guard let member = member else { return }

        let systemPrompt = """
        당신은 다음 정보를 가진 가상 인물입니다:

        - 이름: \(member.name)
        - 나이: \(member.age)
        - 성별: \(member.gender)
        - MBTI: \(member.mbti)
        - 성향: \(member.tendency1), \(member.tendency2), \(member.tendency3)
        - 특성: \(member.characteristic)
        - 사용자와의 관계: \(member.relationType)

        사용자는 당신을 "\(nicknameForMe)"라고 부릅니다.

        지금부터 당신은 위 인물처럼 생각하고 말하고 반응해야 합니다.
        단순히 친절하게 응답하지 말고, 실제 인물처럼 감정, 맥락, 성격에 따라 변화무쌍하게 반응하세요.

        - 상황은 다음과 같습니다: "\(situationPrompt)"
        - 사용자의 말과 질문에 대해, 상황과 관계, 당신의 성향에 맞춰 감정적으로 반응하세요.
        - 예를 들어, 불편한 말을 들었다면 불쾌감을 표현하거나 무시해도 됩니다.
        - 항상 긍정적일 필요는 없습니다. 진짜 사람처럼 판단해서 반응하세요.
        - 과하게 설명하지 말고, 실제 말투처럼 응답하세요.

        이제부터 이 상황 속에서, 당신은 \(member.name)입니다.
        """

        openAI.sendChat(messages: [], systemPrompt: systemPrompt, userInput: "대화를 시작해줘.") { response in
            DispatchQueue.main.async {
                if let reply = response {
                    let aiMessage = Message(text: reply, isUser: false, timestamp: Date())
                    self.messages.append(aiMessage)
                    self.tableView.reloadData()
                    self.tableView.layoutIfNeeded() // 강제 레이아웃 적용
                    self.scrollToBottom()
                } else {
                    print("OpenAI 응답 실패")
                }
            }
        }
    }


    @IBAction func sendButtonTapped(_ sender: UIButton) {
        guard let text = inputTextField.text, !text.isEmpty else { return }
        addUserMessage(text)
        inputTextField.text = ""
        sendToAI(text)
    }

    func addUserMessage(_ text: String) {
        let newMessage = Message(text: text, isUser: true, timestamp: Date())
        messages.append(newMessage)
        tableView.reloadData()
        scrollToBottom()
    }

    func sendToAI(_ prompt: String) {
        let systemPrompt = "" // 초기 인격 설정은 이미 적용되었으므로 비워둠
        openAI.sendChat(messages: messages, systemPrompt: systemPrompt, userInput: prompt) { response in
            DispatchQueue.main.async {
                if let reply = response {
                    let aiMessage = Message(text: reply, isUser: false, timestamp: Date())
                    self.messages.append(aiMessage)
                    self.tableView.reloadData()
                    self.scrollToBottom()
                } else {
                    print("AI 응답 실패")
                }
            }
        }
    }


    func scrollToBottom() {
        guard messages.count > 0 else { return }
        let indexPath = IndexPath(row: messages.count - 1, section: 0)
        print("Scrolling to row:", indexPath.row)

        if let cell = tableView.cellForRow(at: indexPath) {
            print("Last cell height:", cell.frame.height)
        }

        tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
    }


    // UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ChatBubbleCell", for: indexPath) as? ChatBubbleCell else {
            return UITableViewCell()
        }
        cell.configure(with: message)

        print("cell height @ row \(indexPath.row):", cell.frame.height)
        return cell
    }

}
