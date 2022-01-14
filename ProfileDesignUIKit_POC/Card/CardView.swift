//
//  CardView.swift
//  ProfileDesignUIKit_POC
//
//  Created by Kirito04800 on 13/01/2022.
//

import UIKit

class CardView: UIView {

    @UsesAutoLayout
    var header = CardHeader(title: "test", icon: UIImage(systemName: "info.circle")!)
    var details: UIView?
    var isShowDetails: Bool = false
    var viewHeightConstraint: NSLayoutConstraint?
    weak var layoutDelegate: CardLayoutDelegate?

    init(title: String, icon: UIImage, details: UIView,layoutDelegate: CardLayoutDelegate) {
        super.init(frame: .zero)
        backgroundColor = .lightGray
        layer.cornerRadius = 10
        clipsToBounds = true
        self.layoutDelegate = layoutDelegate
        self.details = details
        self.details?.translatesAutoresizingMaskIntoConstraints = false
        viewHeightConstraint = heightAnchor.constraint(equalToConstant: 40)

        addSubview(header)
        addSubview(details)

        setupHeader()
        setupDetails()
        setupView()
    }

    private func setupView() {
        guard let viewHeightConstraint = self.viewHeightConstraint else { return }
        let constraints = [
            viewHeightConstraint
        ]
        NSLayoutConstraint.activate(constraints)
    }

    private func setupHeader() {
        let constraints = [
            header.topAnchor.constraint(equalTo: topAnchor),
            header.centerXAnchor.constraint(equalTo: centerXAnchor),
            header.widthAnchor.constraint(equalTo: widthAnchor),
            header.heightAnchor.constraint(equalToConstant: 40)
        ]
        NSLayoutConstraint.activate(constraints)
        header.showDetailsButton.addTarget(self, action: #selector(showDetails), for: .touchUpInside)
    }

    @objc
    private func showDetails() {
        guard let viewHeightConstraint = self.viewHeightConstraint else { return }
        isShowDetails = !isShowDetails
        UIView.animate(withDuration: 0.25) {
            if self.isShowDetails {
                self.header.showDetailsButton.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2.0)
            } else {
                self.header.showDetailsButton.transform = CGAffineTransform.identity
            }
        }
        self.layoutIfNeeded()
        if isShowDetails {
            viewHeightConstraint.isActive = false
            self.setNeedsLayout()
            UIView.animate(withDuration: 0.5) {
                self.layoutDelegate?.layout()
            }
        }
        else {
            self.setNeedsLayout()
            viewHeightConstraint.isActive = true
            UIView.animate(withDuration: 0.5) {
                self.layoutDelegate?.layout()
            }
        }
    }

    private func setupDetails() {
        guard let details = self.details else { return }
        let constraints = [
            details.topAnchor.constraint(equalTo: header.bottomAnchor),
            details.centerXAnchor.constraint(equalTo: centerXAnchor),
            details.widthAnchor.constraint(equalTo: widthAnchor),
            details.bottomAnchor.constraint(equalTo: bottomAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
