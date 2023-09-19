//
//  C2CTransferView.swift
//  DuxerExample
//
//  Created by 004230 on 24.04.23.
//

import UIKit

final class C2CTransferView: UIView {

    private lazy var verticalStackView: UIStackView = .build(self.buildVerticalStackView)
    private lazy var cardNumberStackView: UIStackView = .build(self.buildCardNumberStackView)
    private lazy var senderLabel: UILabel = .build(self.buildSenderLabel)
    private lazy var recipientLabel: UILabel = .build(self.buildRecipientLabel)
    private lazy var infoStackView: UIStackView = .build(self.buildInfoStackView)
    private lazy var amountLabel: UILabel = .build(self.buildAmountLabel)
    private lazy var dateLabel: UILabel = .build(self.buildDateLabel)

    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    override init(frame: CGRect) {
        super.init(frame: frame)

        _ = self.verticalStackView

        self.backgroundColor = .systemTeal
        self.roundCorners(.allCorners, radius: 8)
    }
}

private extension C2CTransferView {

    func buildVerticalStackView(_ v: inout UIStackView) {
        v.translatesAutoresizingMaskIntoConstraints = false
        v.axis = .vertical
        v.spacing = 5
        v.distribution = .fillEqually

        [
            self.cardNumberStackView,
            self.infoStackView
        ].forEach(v.addArrangedSubview)

        self.addSubview(v)
        NSLayoutConstraint.activate([
            v.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            v.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            v.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            v.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8)
        ])
    }

    func buildCardNumberStackView(_ v: inout UIStackView) {
        v.axis = .horizontal
        v.spacing = 0
        v.distribution = .fillEqually

        [
            self.senderLabel,
            self.recipientLabel
        ].forEach(v.addArrangedSubview)
    }

    func buildSenderLabel(_ v: inout UILabel) {
        v.textColor = .white
    }

    func buildRecipientLabel(_ v: inout UILabel) {
        v.textColor = .white
        v.textAlignment = .right
    }

    func buildInfoStackView(_ v: inout UIStackView) {
        v.axis = .horizontal
        v.spacing = 0
        v.distribution = .fillEqually

        [
            self.amountLabel,
            self.dateLabel
        ].forEach(v.addArrangedSubview)
    }

    func buildAmountLabel(_ v: inout UILabel) {
        v.textColor = .white
    }

    func buildDateLabel(_ v: inout UILabel) {
        v.textColor = .white.withAlphaComponent(0.75)
        v.textAlignment = .right
    }
}

extension C2CTransferView: ConfigurableView {

    typealias Item = C2CTransfer

    func configure(_ item: C2CTransfer) {
        self.senderLabel.text = "Sender: * " + item.sender.number.suffix(4)
        self.recipientLabel.text = "Recipient: * " + item.recipient.number.suffix(4)
        self.amountLabel.text = String(format: "%.2f", item.amount) + " ₼"
        self.dateLabel.text = DateFormatter.build {
            $0.dateFormat = "MM-dd-yyyy HH:mm"
        }.string(from: item.date)
    }

    func reset() {
        self.senderLabel.text = nil
        self.recipientLabel.text = nil
        self.amountLabel.text = nil
        self.dateLabel.text = nil
    }
}

typealias TransferCell = WrapperCell<C2CTransferView>
