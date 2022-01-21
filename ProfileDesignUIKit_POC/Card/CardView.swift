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

    @UsesAutoLayout
    var detailsViewContainer = UIView().applyModifiers {
        $0.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
    }

    var detailsView: UIView?
    var isShowDetails: Bool = false
    var viewHeightConstraint: NSLayoutConstraint?
    weak var layoutDelegate: CardLayoutDelegate?

    init(title: String, icon: UIImage, details: UIView,layoutDelegate: CardLayoutDelegate) {
        super.init(frame: .zero)
        backgroundColor = .lightGray
        layer.cornerRadius = 10
        clipsToBounds = true
        self.layoutDelegate = layoutDelegate

        detailsView = details
        detailsView?.translatesAutoresizingMaskIntoConstraints = false

        viewHeightConstraint = heightAnchor.constraint(equalToConstant: 40)

        guard let detailsView = detailsView else { return }
        addSubview(header)
        addSubview(detailsViewContainer)
        detailsViewContainer.addSubview(detailsView)

        setupHeader()
        setupDetailsViewContainer()
        setupDetailsView()
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
        if isShowDetails {
            viewHeightConstraint.isActive = false
            self.setNeedsLayout()
            UIView.animate(withDuration: 0.2) {
                self.layoutDelegate?.layout()
            }
        }
        else {
            self.setNeedsLayout()
            viewHeightConstraint.isActive = true
            UIView.animate(withDuration: 0.2) {
                self.layoutDelegate?.layout()
            }
        }
    }

    private func setupDetailsView() {
        guard let detailsView = detailsView else { return }
        let constraints = [
            detailsView.topAnchor.constraint(equalTo: detailsViewContainer.layoutMarginsGuide.topAnchor),
            detailsView.rightAnchor.constraint(equalTo: detailsViewContainer.layoutMarginsGuide.rightAnchor),
            detailsView.leftAnchor.constraint(equalTo: detailsViewContainer.layoutMarginsGuide.leftAnchor),
            detailsView.bottomAnchor.constraint(equalTo: detailsViewContainer.layoutMarginsGuide.bottomAnchor),
        ]
        constraints[3].priority = .defaultLow
        NSLayoutConstraint.activate(constraints)
    }

    private func setupDetailsViewContainer() {
        let constraints = [
            detailsViewContainer.topAnchor.constraint(equalTo: header.bottomAnchor),
            detailsViewContainer.rightAnchor.constraint(equalTo: rightAnchor),
            detailsViewContainer.leftAnchor.constraint(equalTo: leftAnchor),
            detailsViewContainer.bottomAnchor.constraint(equalTo: bottomAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
