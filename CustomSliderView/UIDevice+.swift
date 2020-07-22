//
//  UIDevice+.swift
//  CustomSliderView
//
//  Created by kiwan on 2020/07/21.
//  Copyright © 2020 kiwan. All rights reserved.
//

import AudioToolbox
import UIKit

extension UIDevice {
    static func vibrate() {
//        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
        
    }
}
