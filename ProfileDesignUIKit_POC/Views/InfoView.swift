//
//  InfoView.swift
//  ProfileDesignUIKit_POC
//
//  Created by Kirito04800 on 14/01/2022.
//

import Foundation
import UIKit

class InfoView: UIView {


    var verticalStack = UIStackView().applyModifiers {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.alignment = .center
        $0.axis = .vertical
        $0.distribution = .fill
        $0.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4)
        $0.isLayoutMarginsRelativeArrangement = true
    }

    init() {
        super.init(frame: .zero)
        addSubview(verticalStack)

        for _ in 1...10 {
            let horizontalStack = UIStackView().applyModifiers {
                $0.alignment = .center
                $0.axis = .horizontal
                $0.distribution = .equalCentering
                $0.translatesAutoresizingMaskIntoConstraints = false
            }
            let titleLabel = UILabel().applyModifiers {
                $0.text = "Info"
                $0.textColor = .black
                $0.translatesAutoresizingMaskIntoConstraints = false
            }
            let spacer = UIView()
            let InfoLabel = UILabel().applyModifiers {
                $0.text = "Corresponding information"
                $0.textColor = .black
                $0.translatesAutoresizingMaskIntoConstraints = false
            }

            horizontalStack.addArrangedSubview(titleLabel)
            horizontalStack.addArrangedSubview(spacer)
            horizontalStack.addArrangedSubview(InfoLabel)
            verticalStack.addArrangedSubview(horizontalStack)
        }

        setupVerticalStack()
    }

    private func setupVerticalStack() {
        let bottomConstraint = verticalStack.bottomAnchor.constraint(equalTo: bottomAnchor)
        bottomConstraint.priority = .init(rawValue: 999)

        let constraints = [
            verticalStack.topAnchor.constraint(equalTo: topAnchor),
            verticalStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            verticalStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            bottomConstraint
        ]
        NSLayoutConstraint.activate(constraints)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}
