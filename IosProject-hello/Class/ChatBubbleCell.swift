//
//  ChatBubbleCell.swift
//  IosProject-hello
//
//  Created by 김혜진 on 6/15/25.
//
import UIKit

class ChatBubbleCell: UITableViewCell {
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var bubbleBackground: UIView!
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var trailingConstraint: NSLayoutConstraint!

    func configure(with message: Message) {
        messageLabel.text = message.text
        bubbleBackground.layer.cornerRadius = 12
//        bubbleBackground.backgroundColor = message.isUser ? .systemBlue : .lightGray
        bubbleBackground.backgroundColor = message.isUser
            ? UIColor(hex: "#0400FA") // 진한 파란색
            : UIColor(hex: "#F0F0FF") // 연한 파란색
        messageLabel.textColor = message.isUser ? .white : .black

        leadingConstraint.isActive = !message.isUser
        trailingConstraint.isActive = message.isUser
    }
}
