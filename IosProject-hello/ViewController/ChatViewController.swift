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

//    var messages: [Message] = []
    var messages = [
               Message(text: "안녕하세요! 반가워요 😊", isUser: false, timestamp: Date()),
               Message(text: "안녕하세요~ ae연인이랑 대화해볼래요!", isUser: true, timestamp: Date()),
               Message(text: "좋아요! 무엇이든 물어보세요 🤖", isUser: false, timestamp: Date()),
               Message(text: "안녕하세요~ ae연인이랑 대화해볼래요!", isUser: true, timestamp: Date()),
               Message(text: "좋아요! 무엇이든 물어보세요 🤖", isUser: false, timestamp: Date()),
               Message(text: "안녕하세요~ ae연인이랑 대화해볼래요!", isUser: true, timestamp: Date()),
               Message(text: "좋아요! 무엇이든 물어보세요 🤖", isUser: false, timestamp: Date()),
               Message(text: "안녕하세요~ ae연인이랑 대화해볼래요!", isUser: true, timestamp: Date()),
               Message(text: "좋아요! 무엇이든 물어보세요 🤖", isUser: false, timestamp: Date()),
               
           ]

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100  // 적절한 초기 높이 설정

        tableView.reloadData()

    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        print("메시지 수: \(messages.count)")
            return messages.count
        
        }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
//        print(" 셀 생성: \(message.text) | isUser: \(message.isUser)")

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ChatBubbleCell", for: indexPath) as? ChatBubbleCell else {
//            print(" 셀 캐스팅 실패")
            return UITableViewCell()
        }

        cell.configure(with: message)
        return cell
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
        // AI 호출 초안
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            let aiReply = Message(text: "AI 응답: \(prompt)", isUser: false, timestamp: Date())
            self.messages.append(aiReply)
            self.tableView.reloadData()
            self.scrollToBottom()
        }
    }

    func scrollToBottom() {
        guard messages.count > 0 else { return }
        let indexPath = IndexPath(row: messages.count - 1, section: 0)
        tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
    }
}
