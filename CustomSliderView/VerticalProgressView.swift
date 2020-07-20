//
//  VerticalProgressView.swift
//  CustomSliderView
//
//  Created by kiwan on 2020/07/20.
//  Copyright © 2020 kiwan. All rights reserved.
//

import UIKit

class VerticalProgressView: UIView {
    var currentValue: Float = 0.0
    
    //    weak var delegate: PlayerSliderViewDelegate?
    let panGestureView = UIView()
    
    let progressView: UIProgressView = {
        let prgressView = UIProgressView()
        prgressView.progress = 0.7
        prgressView.progressTintColor = UIColor(red: 1.0, green: 0.21, blue: 0.33, alpha: 1)
        prgressView.trackTintColor = UIColor.blue
        prgressView.layer.cornerRadius = 6.5
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
        addSubview(panGestureView)
        
        panGestureView.snp.makeConstraints { (maker) in
            maker.size.equalToSuperview()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        progressView.bounds.size.width = bounds.height - 10
        progressView.bounds.size.height = 10
        progressView.center.x = bounds.midX
        progressView.center.y = bounds.midY
    }
    
    
    func setUI() {
        panGestureView.backgroundColor = .clear
    }
    
    func setEvent() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(timeSliderValueChanged(_:)))
        panGestureView.addGestureRecognizer(panGesture)
    }
    
    open func setProgress(_ progress: Float, animated: Bool) {
        progressView.setProgress(progress, animated: animated)
    }
    
    //MARK: - Event
    @objc func timeSliderValueChanged(_ recognizer: UIPanGestureRecognizer?) {
        switch recognizer?.state {
        case.began:
            let location = recognizer?.location(in: recognizer?.view)
            let height = recognizer?.view?.frame.size.height ?? 0.0
            let pointY = self.frame.size.height - location!.y

            let prv = progressView.progress * Float(height)
            
            currentValue = prv
//            print(currentValue)
            break
        case .changed:
            let location = recognizer?.location(in: recognizer?.view)
            let height = recognizer?.view?.frame.size.height ?? 0.0
            let pointY = self.frame.size.height - location!.y
            
            let value = pointY / height
            progressView.setProgress(Float(value), animated: false)
            
            print(currentValue , pointY)
        case .ended:
            break
        default:
            break
        }
    }
    
}

