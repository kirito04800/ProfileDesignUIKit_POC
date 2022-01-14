//
//  LayoutDelegate.swift
//  ProfileDesignUIKit_POC
//
//  Created by Kirito04800 on 14/01/2022.
//

import UIKit

protocol CardLayoutDelegate where Self: UIView {
    func layout()
}

extension CardLayoutDelegate {
    func layout() {
        self.layoutIfNeeded()
    }
}
