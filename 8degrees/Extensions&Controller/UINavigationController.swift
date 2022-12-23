//
//  UINavigationController.swift
//  8degrees
//
//  Created by Jimmy on 2022/12/23.
//

import SwiftUI

extension UINavigationController {
    open override func viewWillLayoutSubviews() {
        navigationBar.topItem?.title = ""
    }
}
