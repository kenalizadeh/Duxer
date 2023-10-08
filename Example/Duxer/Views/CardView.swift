//
//  CardView.swift
//  DuxerExample
//
//  Created by Kenan Alizadeh
//

import UIKit
import WrapperCell

final class CardView: UIControl {

    private lazy var contentStackView: UIStackView = .build(self.buildContentStackView)
    private lazy var labelStackView: UIStackView = .build(self.buildLabelStackView)
    private lazy var networkIconContainerView: UIView = .build(self.buildNetworkIconContainerView)
    private lazy var networkIconImageView: UIImageView = .build(self.buildNetworkIconImageView)
    private lazy var balanceLabel: UILabel = .build(self.buildBalanceLabel)
    private lazy var cardNameLabel: UILabel = .build(self.buildCardNameLabel)
    private lazy var cardNumberLabel: UILabel = .build(self.buildCardNumberLabel)

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    override init(frame: CGRect) {
        super.init(frame: .zero)

        _ = self.contentStackView
        self.roundCorners(.allCorners, radius: 8)
        self.isUserInteractionEnabled = false
    }
}

private extension CardView {

    func buildContentStackView(_ v: inout UIStackView) {
        v.translatesAutoresizingMaskIntoConstraints = false
        v.axis = .horizontal
        v.distribution = .fillProportionally

        [
            self.networkIconContainerView,
            self.labelStackView
        ].forEach(v.addArrangedSubview)

        self.addSubview(v)
        NSLayoutConstraint.activate([
            v.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 8),
            v.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            v.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            v.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -8)
        ])
    }

    func buildLabelStackView(_ v: inout UIStackView) {
        v.translatesAutoresizingMaskIntoConstraints = false
        v.axis = .vertical
        v.spacing = 4

        [
            self.balanceLabel,
            self.cardNameLabel,
            self.cardNumberLabel
        ].forEach(v.addArrangedSubview)
    }

    func buildNetworkIconContainerView(_ v: inout UIView) {
        v.translatesAutoresizingMaskIntoConstraints = false
        v.setContentHuggingPriority(.required, for: .horizontal)
    }

    func buildNetworkIconImageView(_ v: inout UIImageView) {
        v.translatesAutoresizingMaskIntoConstraints = false
        v.contentMode = .scaleAspectFit

        self.networkIconContainerView.addSubview(v)
        NSLayoutConstraint.activate([
            v.centerXAnchor.constraint(equalTo: self.networkIconContainerView.centerXAnchor),
            v.widthAnchor.constraint(lessThanOrEqualTo: self.networkIconContainerView.widthAnchor, constant: -6),
            v.centerYAnchor.constraint(equalTo: self.networkIconContainerView.centerYAnchor),
            v.heightAnchor.constraint(lessThanOrEqualTo: self.networkIconContainerView.heightAnchor, constant: -6),
            v.heightAnchor.constraint(equalToConstant: 40),
            v.widthAnchor.constraint(equalTo: v.heightAnchor)
        ])
    }

    func buildCardNameLabel(_ v: inout UILabel) {
        v.translatesAutoresizingMaskIntoConstraints = false
    }

    func buildBalanceLabel(_ v: inout UILabel) {
        v.translatesAutoresizingMaskIntoConstraints = false
    }

    func buildCardNumberLabel(_ v: inout UILabel) {
        v.translatesAutoresizingMaskIntoConstraints = false
    }
}

extension CardView: ConfigurableView {

    struct Item {
        let label: TextContent
        let networkIcon: Image
        let cardNumber: TextContent
        let cardNumberFormatter: StringFormatter
        let balance: TextContent
        let backgroundColor: UIColor?
    }

    func configure(_ item: Item) {
        self.cardNameLabel.setText(content: item.label)
        self.networkIconImageView.image = item.networkIcon.uiImage
        self.cardNumberLabel.setText(content: item.cardNumber, formatter: item.cardNumberFormatter)
        self.balanceLabel.setText(content: item.balance)
        self.backgroundColor = item.backgroundColor
    }

    func reset() {
        self.cardNameLabel.text = nil
        self.networkIconImageView.image = nil
        self.cardNumberLabel.text = nil
        self.balanceLabel.text = nil
        self.backgroundColor = nil
    }
}

typealias CardCell = WrapperCell<CardView>
