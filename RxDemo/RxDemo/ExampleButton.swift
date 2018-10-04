//
//  ExampleButton.swift
//  RxDemo
//
//  Created by Ernesto Cambuston on 10/3/18.
//  Copyright © 2018 Ernesto Cambuston. All rights reserved.
//

import UIKit

class ExampleButton:UIButton {
    override var isEnabled: Bool {
        willSet(value) {
            if value {
                alpha = 1.0
            } else {
                alpha = 0.4
            }
        }
    }
}
