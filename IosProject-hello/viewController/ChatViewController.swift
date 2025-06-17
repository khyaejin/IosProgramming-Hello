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
        tableView.estimatedRowHeight = 100
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
        이름: \(member.name)
        나이: \(member.age)
        성별: \(member.gender)
        MBTI: \(member.mbti)
        성향: \(member.tendency1), \(member.tendency2), \(member.tendency3)
        특성: \(member.characteristic)
        관계: \(member.relationType)

        사용자는 당신에게 "\(nicknameForMe)"라는 호칭으로 불리길 원합니다.
        다음 상황을 시뮬레이션합니다: "\(situationPrompt)"
        """

        openAI.sendChat(messages: [], systemPrompt: systemPrompt, userInput: "대화를 시작해줘.") { response in
            DispatchQueue.main.async {
                if let reply = response {
                    let aiMessage = Message(text: reply, isUser: false, timestamp: Date())
                    self.messages.append(aiMessage)
                    self.tableView.reloadData()
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
        return cell
    }
}
