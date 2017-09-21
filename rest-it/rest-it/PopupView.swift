//
//  PopupView.swift
//  rest-it
//
//  Created by Francis Jones on 21/09/2017.
//  Copyright © 2017 fj. All rights reserved.
//

import UIKit

@IBDesignable class PopupView: UIView {

    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadius;
        }
    }

}
