//
//  Constants.swift
//  Dream Machine
//
//  Created by Manish Katoch on 08/11/19.
//  Copyright © 2019 Manish Katoch. All rights reserved.
//

import UIKit
import Foundation
let CHANNEL_COUNTS: UInt32 = 5
let SCREEN_WIDTH: UInt32 = UInt32(UIScreen.main.bounds.width)
let SCREEN_HEIGHT: UInt32 = UInt32(UIScreen.main.bounds.height)
let FREQUENCY_MAX: Float = 46.0
let FREQUENCY_MIN: Float = 1.0

let THRESHOLD_DELTA_THETA: Float = 4.0
let THRESHOLD_THETA_ALPHA: Float = 8.0
let THRESHOLD_ALPHA_BETA: Float = 12.0
let THRESHOLD_BETA_GAMMA: Float = 40.0

let FREQUENCY_DESCRIPTION: [String: String] = [
    "delta": "Delta: Deep Sleep",
    "theta": "Theta: Hypnagogic Imagery/Meditation",
    "alpha": "Alpha: Creativity/Meditation",
    "beta" : "Beta: Concentration",
    "gamma": "Gamma: Problem Solving"
]
