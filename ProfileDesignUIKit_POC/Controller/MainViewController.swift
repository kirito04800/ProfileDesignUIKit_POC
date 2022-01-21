//
//  MainViewController.swift
//  ProfileDesignUIKit_POC
//
//  Created by Kirito04800 on 07/01/2022.
//

import UIKit

class MainViewController: UIViewController, UIScrollViewDelegate {
    var layer = MainView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view = layer
        layer.scrollView.delegate = self
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layer.titleLabel.layer.shadowOffset = CGSize(width: 5, height: 5)
        layer.titleLabel.layer.shadowColor = UIColor.black.cgColor
        layer.titleLabel.layer.shadowRadius = 3
        layer.titleLabel.layer.shadowOpacity = 1
        layer.titleLabel.layer.masksToBounds = false

        layer.cards?.forEach({ card in
            card.layer.masksToBounds = false
            card.layer.shadowOffset = .zero
            card.layer.shadowColor = UIColor.black.cgColor
            card.layer.shadowRadius = 4
            card.layer.shadowOpacity = 0.6
        })







        layer.imageContainerView.layer.shadowOpacity = 0.7
        layer.imageContainerView.layer.masksToBounds = false
        layer.imageContainerView.layer.shadowRadius = 4
        layer.imageContainerView.layer.shadowColor = UIColor.black.cgColor
        layer.imageContainerView.layer.shadowOffset = CGSize(width: 0 , height: 2)
        layer.imageContainerView.layer.shadowPath = UIBezierPath(rect: CGRect(x: 0,
                                                                              y: layer.imageContainerView.bounds.maxY - layer.imageContainerView.layer.shadowRadius,
                                                                              width: layer.imageContainerView.bounds.width,
                                                                              height: layer.imageContainerView.layer.shadowRadius)).cgPath
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(scrollView.contentOffset.y)
        let newSize = Const.PROFILE_IMAGE_DEFAULT_SIZE - (scrollView.contentOffset.y)
        let height = min(max(newSize, Const.PROFILE_IMAGE_MIN_SIZE), Const.PROFILE_IMAGE_DEFAULT_SIZE)
        layer.profileImage.contentMode = .scaleAspectFill
        layer.imageHeightConstraint.constant = height
        layer.imageContainerHeightConstraint.constant = height
        layer.profileImage.clipsToBounds = true
        layer.imageContainerView.layoutIfNeeded()
    }
}

