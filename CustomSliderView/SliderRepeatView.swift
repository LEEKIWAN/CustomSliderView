//
//  VGProgressView.swift
//  CustomSliderView
//
//  Created by kiwan on 2020/05/26.
//  Copyright © 2020 kiwan. All rights reserved.
//

import UIKit

class SliderRepeatView: UIProgressView {

    let startView = UIView()
    let endView = UIView()
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
//        self.tintColor = .red
//        self.backgroundColor = .red
        self.trackTintColor = .red
        
        startView.frame = CGRect(x: 0, y: 0, width: 2, height: self.frame.size.height)
        endView.frame = CGRect(x: self.frame.size.width - 2, y: 0, width: 2, height: self.frame.size.height)
        
        startView.backgroundColor = .black
        endView.backgroundColor = .black
        self.addSubview(startView)
        self.addSubview(endView)
    }
    

}
