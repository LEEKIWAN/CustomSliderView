//
//  VerticalProgressView.swift
//  CustomSliderView
//
//  Created by kiwan on 2020/07/20.
//  Copyright © 2020 kiwan. All rights reserved.
//

import UIKit

class VerticalProgressView: UIView {
    //    weak var delegate: PlayerSliderViewDelegate?
    var previousProgressValue: Float = 0
    
    let panGestureView = UIView()
    let statusImageView = UIImageView()
    
    
    let progressView: UIProgressView = {
        let prgressView = UIProgressView()
        prgressView.progress = 0.7
        prgressView.progressTintColor = UIColor(red: 1.0, green: 0.21, blue: 0.33, alpha: 1)
        prgressView.trackTintColor = UIColor.blue
        prgressView.layer.cornerRadius = 4
        prgressView.clipsToBounds = true
        prgressView.transform = CGAffineTransform(rotationAngle: .pi / -2)
        prgressView.translatesAutoresizingMaskIntoConstraints = false
        return prgressView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setNib()
        setUI()
        setEvent()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setNib()
        setUI()
        setEvent()
    }
    
    func setNib() {
        addSubview(progressView)
        addSubview(statusImageView)
        addSubview(panGestureView)
        
        panGestureView.snp.makeConstraints { (maker) in
            maker.size.equalToSuperview()
        }
        
        statusImageView.snp.makeConstraints { (maker) in
            maker.centerX.top.equalToSuperview()
            maker.width.height.equalTo(30)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        progressView.bounds.size.width = bounds.height - 40
        progressView.bounds.size.height = 10
        progressView.center.x = bounds.midX
        progressView.center.y = bounds.midY + 20
        
    }
    
    
    func setUI() {
        panGestureView.backgroundColor = .clear        
        statusImageView.image = #imageLiteral(resourceName: "brightness_high")
    }
    
    func setEvent() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(timeSliderValueChanged(_:)))
        panGestureView.addGestureRecognizer(panGesture)
    }
    
    open func setProgress(_ progress: Float, animated: Bool) {
        progressView.setProgress(progress, animated: animated)
    }
    
    //MARK: - Event
    @objc func timeSliderValueChanged(_ recognizer: UIPanGestureRecognizer) {
        let velocity = recognizer.velocity(in: recognizer.view)
        switch recognizer.state {
        case.began:
            break
        case .changed:
            let value = Float(velocity.y / 10000)
            UIScreen.main.brightness -= CGFloat(value)
            progressView.setProgress(Float(UIScreen.main.brightness), animated: false)
            
            statusImageView.image = UIScreen.main.brightness >= 0.5 ? #imageLiteral(resourceName: "brightness_high") : #imageLiteral(resourceName: "brightness_low")
            
            if (progressView.progress == 0 || progressView.progress == 1) && (previousProgressValue != progressView.progress) {
                UIDevice.vibrate()
            }
            
            previousProgressValue = progressView.progress
            
        case .ended:
            break
        default:
            break
        }
    }
    
}

