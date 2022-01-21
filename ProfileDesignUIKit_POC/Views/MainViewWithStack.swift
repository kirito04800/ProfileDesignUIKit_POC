//
//  MainView.swift
//  ProfileDesignUIKit_POC
//
//  Created by Kirito04800 on 07/01/2022.
//

import Foundation
import UIKit

class MainViewWithStack: UIView, CardLayoutDelegate {
    
    @UsesAutoLayout
    var stackView: UIStackView = UIStackView().applyModifiers {
        $0.alignment = .center
        $0.axis = .vertical
        $0.distribution = .fill
        $0.spacing = 12
        $0.isLayoutMarginsRelativeArrangement = true
        $0.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
    }

    @UsesAutoLayout
    var titleLabel = UILabel().applyModifiers {
        let text: AttributedString =
            """
            \(
                "My Profile's page",
                attributes: [.color(.black), .font(.systemFont(ofSize: 12, weight: .regular))])
            """
        $0.attributedText = text.attributedString
        $0.textAlignment = .center
        $0.numberOfLines = 0
        $0.lineBreakMode = .byWordWrapping
    }

    @UsesAutoLayout
    var headerBlankView = UIView()

    @UsesAutoLayout
    var imageContainerView = UIView()

    @UsesAutoLayout
    var profileImage = UIImageView ()

    var imageContainerHeightConstraint: NSLayoutConstraint = NSLayoutConstraint.init()
    var imageHeightConstraint: NSLayoutConstraint = NSLayoutConstraint.init()

    @UsesAutoLayout
    var scrollView = UIScrollView()

    @UsesAutoLayout
    var contentView = UIView()


    var cards: [CardView]?
    var card1: CardView?
    var card2: CardView?
    var card3: CardView?
    var card4: CardView?

    let logOutButton: UIButton = UIButton()

    init() {
        super.init(frame: .zero)
        imageContainerHeightConstraint = imageContainerView.heightAnchor.constraint(equalToConstant: 300)
        imageHeightConstraint = profileImage.heightAnchor.constraint(equalToConstant: 300)
        backgroundColor = .white

        guard let icon = UIImage(systemName: "info.circle") else { return }

        card1 = CardView(title: "info1", icon: icon, details: InfoView(), layoutDelegate: self)
        card2 = CardView(title: "info3", icon: icon, details: InfoView(), layoutDelegate: self)
        card3 = CardView(title: "info4", icon: icon, details: InfoView(), layoutDelegate: self)
        card4 = CardView(title: "info5", icon: icon, details: InfoView(), layoutDelegate: self)

        guard let card1 = card1, let card2 = card2, let card3 = card3, let card4 = card4
        else { return }
        cards = [card1,card2,card3,card4]

        addSubview(headerBlankView)
        addSubview(imageContainerView)
        addSubview(scrollView)

        imageContainerView.addSubview(profileImage)
        scrollView.addSubview(stackView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(card1)
        stackView.addArrangedSubview(card2)
        stackView.addArrangedSubview(card3)
        stackView.addArrangedSubview(card4)
        stackView.addArrangedSubview(logOutButton)

        setupScrollView()
        setupStackView()
        setupLogOutButton()
        setupTitleLabel()
        setupCardsViews()
        setupHeaderBlankView()
        setupImageContainerView()

        setupProfileImage()
    }

    private func setupStackView() {
        let constraints = [
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            stackView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }

    private func setupCardsViews() {
        guard let cards = cards else { return }
        var constrains: [NSLayoutConstraint] = []
        for i in 0..<cards.count {
            cards[i].translatesAutoresizingMaskIntoConstraints = false
            constrains.append(cards[i].widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8))
        }
        NSLayoutConstraint.activate(constrains)
    }

    private func setupHeaderBlankView() {
        headerBlankView.backgroundColor = .blue
        headerBlankView.layer.zPosition = 2
        let constraints = [
            headerBlankView.topAnchor.constraint(equalTo: topAnchor),
            headerBlankView.centerXAnchor.constraint(equalTo: centerXAnchor),
            headerBlankView.widthAnchor.constraint(equalTo: widthAnchor),
            headerBlankView.heightAnchor.constraint(equalToConstant: Const.PROFILE_IMAGE_MIN_SIZE)
        ]
        NSLayoutConstraint.activate(constraints)
    }


    private func setupImageContainerView() {
        imageContainerView.backgroundColor = .blue
        imageContainerView.layer.shadowOpacity = 0.7
        imageContainerView.layer.masksToBounds = false
        imageContainerView.layer.shadowRadius = 4
        imageContainerView.layer.shadowOpacity = 1
        imageContainerView.layer.shadowColor = UIColor.black.cgColor
        imageContainerView.layer.shadowOffset = CGSize(width: 0 , height: 2)
        imageContainerView.layer.shadowPath = UIBezierPath(rect: CGRect(x: 0,
                                                                        y: imageContainerView.bounds.maxY - imageContainerView.layer.shadowRadius,
                                                                        width: imageContainerView.bounds.width,
                                                                        height: imageContainerView.layer.shadowRadius)).cgPath
        imageContainerView.layer.zPosition = 2
        let guide = safeAreaLayoutGuide
        let constraints = [
            imageContainerView.topAnchor.constraint(equalToSystemSpacingBelow: guide.topAnchor, multiplier: 1.0),
            imageContainerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageContainerView.widthAnchor.constraint(equalTo: widthAnchor),
            imageContainerHeightConstraint
        ]
        NSLayoutConstraint.activate(constraints)
    }

    private func setupProfileImage() {
        let guide = safeAreaLayoutGuide
        let constraints = [
            profileImage.topAnchor.constraint(equalToSystemSpacingBelow: guide.topAnchor, multiplier: 1.0),
            profileImage.centerXAnchor.constraint(equalTo: imageContainerView.centerXAnchor),
            profileImage.widthAnchor.constraint(equalTo: profileImage.heightAnchor),
            imageHeightConstraint
        ]
        NSLayoutConstraint.activate(constraints)

        profileImage.backgroundColor = .clear
        profileImage.contentMode = .scaleAspectFit
        profileImage.image = UIImage(systemName: "person.crop.circle.fill")
        profileImage.clipsToBounds = true

    }

    private func setupScrollView() {
        scrollView.backgroundColor = .white
        scrollView.keyboardDismissMode = .interactive
        scrollView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: imageContainerView.bottomAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }

    private func setupContentView() {
        contentView.backgroundColor = .white
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        let constraint = contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        constraint.priority = .defaultLow
        constraint.isActive = true
    }

    private func setupTitleLabel() {
        let constraints = [
            titleLabel.widthAnchor.constraint(equalToConstant: 100),
            titleLabel.heightAnchor.constraint(equalToConstant: 20)
        ]
        NSLayoutConstraint.activate(constraints)
    }

    private func setupLogOutButton() {
        logOutButton.setTitle("LogOut", for: .normal)
        logOutButton.setTitleColor(.white, for: .normal)
        logOutButton.tintColor = .red
        logOutButton.translatesAutoresizingMaskIntoConstraints = false
        logOutButton.configuration = .borderedProminent()
        let constraints = [
            logOutButton.widthAnchor.constraint(equalToConstant: 150),
            logOutButton.heightAnchor.constraint(equalToConstant: 40),
        ]
        NSLayoutConstraint.activate(constraints)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
