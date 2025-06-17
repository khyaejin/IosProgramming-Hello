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
        messageLabel.numberOfLines = 0
        messageLabel.lineBreakMode = .byWordWrapping
        messageLabel.setContentCompressionResistancePriority(.required, for: .horizontal)

        bubbleBackground.layer.cornerRadius = 12
        bubbleBackground.backgroundColor = message.isUser
            ? UIColor(hex: "#0400FA")
            : UIColor(hex: "#F0F0FF")
        messageLabel.textColor = message.isUser ? .white : .black

        leadingConstraint.isActive = !message.isUser
        trailingConstraint.isActive = message.isUser

        print("message:", message.text)
        print("messageLabel frame:", messageLabel.frame)
        print("bubbleBackground frame:", bubbleBackground.frame)
        print("contentView height:", contentView.frame.height)
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

}

