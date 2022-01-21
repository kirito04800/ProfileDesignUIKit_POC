//
//  MainViewController.swift
//  ProfileDesignUIKit_POC
//
//  Created by Kirito04800 on 07/01/2022.
//

import UIKit

class MainViewController: UIViewController, UIScrollViewDelegate {
    let layer = MainView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view = layer
        layer.scrollView.delegate = self
    }

    override func viewDidLayoutSubviews() {
        layer.imageContainerView.layer.shadowOpacity = 0.7
        layer.imageContainerView.layer.masksToBounds = false
        layer.imageContainerView.layer.shadowRadius = 4
        layer.imageContainerView.layer.shadowOpacity = 1
        layer.imageContainerView.layer.shadowColor = UIColor.black.cgColor
        layer.imageContainerView.layer.shadowOffset = CGSize(width: 0 , height: 2)
        layer.imageContainerView.layer.shadowPath = UIBezierPath(rect: CGRect(x: 0,
                                                                              y: layer.imageContainerView.bounds.maxY - layer.imageContainerView.layer.shadowRadius,
                                                                              width: layer.imageContainerView.bounds.width,
                                                                              height: layer.imageContainerView.layer.shadowRadius)).cgPath
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        print(scrollView.contentOffset.y)
        let newSize = Const.PROFILE_IMAGE_DEFAULT_SIZE - (scrollView.contentOffset.y)
        let height = min(max(newSize, Const.PROFILE_IMAGE_MIN_SIZE), Const.PROFILE_IMAGE_DEFAULT_SIZE)
        layer.profileImage.contentMode = .scaleAspectFill
        layer.imageHeightConstraint.constant = height
        layer.imageContainerHeightConstraint.constant = height
        layer.profileImage.clipsToBounds = true
        layer.imageContainerView.layoutIfNeeded()
    }
}

