//
//  MainView.swift
//  ProfileDesignUIKit_POC
//
//  Created by Kirito04800 on 07/01/2022.
//

import Foundation
import UIKit

class MainView: UIView {

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

    let logOutButton: UIButton = UIButton()

    init() {
        super.init(frame: .zero)
        imageContainerHeightConstraint = imageContainerView.heightAnchor.constraint(equalToConstant: 300)
        imageHeightConstraint = profileImage.heightAnchor.constraint(equalToConstant: 300)
        backgroundColor = .white
        addSubview(headerBlankView)
        addSubview(imageContainerView)
        addSubview(scrollView)

        imageContainerView.addSubview(profileImage)
        scrollView.addSubview(contentView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(logOutButton)

        setupLogOutButton()
        setupTitleLabel()
        setupHeaderBlankView()
        setupImageContainerView()
        setupScrollView()
        setupContentView()

        setupProfileImage()
    }

    private func setupHeaderBlankView() {
        headerBlankView.backgroundColor = .white
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
        imageContainerView.backgroundColor = .white
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
            //profileImage.centerYAnchor.constraint(equalTo: imageContainerView.centerYAnchor),
            profileImage.topAnchor.constraint(equalToSystemSpacingBelow: guide.topAnchor, multiplier: 1.0),
            profileImage.centerXAnchor.constraint(equalTo: imageContainerView.centerXAnchor),
            profileImage.widthAnchor.constraint(equalTo: profileImage.heightAnchor),
            imageHeightConstraint
        ]
        NSLayoutConstraint.activate(constraints)

        profileImage.backgroundColor = .clear
        profileImage.contentMode = .scaleAspectFit
//        profileImage.layer.cornerRadius = 300/2
        profileImage.image = UIImage(systemName: "person.crop.circle.fill")
        profileImage.clipsToBounds = true

    }

    private func setupScrollView() {
        scrollView.backgroundColor = .white
        scrollView.keyboardDismissMode = .interactive
        scrollView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: imageContainerView.bottomAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }

    private func setupContentView() {
        contentView.backgroundColor = .white
        contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor,constant: 34).isActive = true
        contentView.heightAnchor.constraint(equalToConstant: 2000).isActive = true
        NSLayoutConstraint.activate(constraints)
    }

    private func setupTitleLabel() {
        let constraints = [
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 32),
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            titleLabel.widthAnchor.constraint(equalToConstant: 100),
            titleLabel.heightAnchor.constraint(equalToConstant: 20)
        ]
        NSLayoutConstraint.activate(constraints)
    }

    private func setupLogOutButton() {
        logOutButton.setTitle("LogOut", for: .normal)
        logOutButton.setTitleColor(.white, for: .normal)
        logOutButton.backgroundColor = .red
        logOutButton.layer.borderColor = UIColor.blue.cgColor
        logOutButton.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            logOutButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -60),
            logOutButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            logOutButton.widthAnchor.constraint(equalToConstant: 150),
            logOutButton.heightAnchor.constraint(equalToConstant: 40)
        ]
        NSLayoutConstraint.activate(constraints)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
