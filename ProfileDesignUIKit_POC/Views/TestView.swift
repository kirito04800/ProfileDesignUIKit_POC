//
//  TestView.swift
//  ProfileDesignUIKit_POC
//
//  Created by Kirito04800 on 14/01/2022.
//

import UIKit

class TestView: UIView, CardLayoutDelegate {

    var myCard: CardView?


    init() {
        super.init(frame: .zero)
        backgroundColor = .white
        let info = InfoView()
        myCard = CardView(title: "my test Card collapsable", icon: UIImage(systemName: "info.circle")!, details: info, layoutDelegate: self )
        guard let myCard = myCard else {
            return
        }

        addSubview(myCard)


        myCard.translatesAutoresizingMaskIntoConstraints = false

        let constraints = [
            myCard.topAnchor.constraint(equalTo: topAnchor, constant: 64),
            myCard.centerXAnchor.constraint(equalTo: centerXAnchor),
            myCard.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
        ]
        NSLayoutConstraint.activate(constraints)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
