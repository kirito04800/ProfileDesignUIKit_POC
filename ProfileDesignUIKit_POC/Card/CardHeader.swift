//
//  CardHeader.swift
//  ProfileDesignUIKit_POC
//
//  Created by Kirito04800 on 13/01/2022.
//

import UIKit

class CardHeader: UIView {

    @UsesAutoLayout
    var stackView: UIStackView = UIStackView().applyModifiers {
        $0.alignment = .center
        $0.axis = .horizontal
        $0.distribution = .fill
        $0.spacing = 12
    }

    @UsesAutoLayout
    var titleLabel = UILabel().applyModifiers {
        $0.textColor = .black
    }

    @UsesAutoLayout
    var iconImageView = UIImageView().applyModifiers {
        $0.backgroundColor = .clear
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
    }

    @UsesAutoLayout
    var showDetailsButton: UIButton = UIButton()

    var title: String?
    var icon: UIImage?

    init(title: String, icon: UIImage) {
        super.init(frame: .zero)
        backgroundColor = .red
        self.title = title
        self.icon = icon

        addSubview(stackView)

        stackView.addArrangedSubview(iconImageView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(showDetailsButton)

//        addSubview(iconImageView)
//        addSubview(titleLabel)
//        addSubview(showDetailsButton)

        setupStackView()
        setupIconImageView()
        setupTitleLabel()
        setupShowDetailsButton()
    }

    private func setupStackView() {
        let constraints = [
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ]
        NSLayoutConstraint.activate(constraints)

    }

    private func setupIconImageView() {
        let constraints = [
//            iconImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
//            iconImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 8),
            iconImageView.heightAnchor.constraint(equalTo: iconImageView.widthAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 26)
        ]
        NSLayoutConstraint.activate(constraints)

        iconImageView.image = icon
    }

    private func setupTitleLabel() {
        let constraints = [
            titleLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7)
        ]
        NSLayoutConstraint.activate(constraints)
        titleLabel.text = title
    }

    private func setupShowDetailsButton() {
        showDetailsButton.setImage(UIImage(systemName: "chevron.right.circle"), for: .normal)


    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
