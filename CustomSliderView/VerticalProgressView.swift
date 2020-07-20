//
//  VerticalProgressView.swift
//  CustomSliderView
//
//  Created by kiwan on 2020/07/20.
//  Copyright © 2020 kiwan. All rights reserved.
//

import UIKit
import SnapKit

class VerticalProgressView: UIView {
    var currentHeight: Float = 0.0

    let panGestureView = UIView()
    
    let coverView = UIView()
    let progressView = UIView()
    
    var touchBeganedLocation: CGPoint = CGPoint.zero
    
    private var progressHeight: Constraint? = nil
    
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
        addSubview(coverView)
        addSubview(panGestureView)
        
        coverView.snp.makeConstraints { (maker) in
            maker.centerY.centerX.equalToSuperview()
            maker.width.equalTo(10)
            maker.height.equalToSuperview()
        }
        
        coverView.addSubview(progressView)
        
        progressView.snp.makeConstraints { (maker) in
            maker.bottom.trailing.leading.equalToSuperview()
            progressHeight = maker.height.equalTo(10).constraint
        }
        
        
        panGestureView.snp.makeConstraints { (maker) in
            maker.size.equalToSuperview()
        }
    }
    
    func setUI() {
        panGestureView.backgroundColor = .clear
        progressView.backgroundColor = .red
        coverView.backgroundColor = .blue
        
        coverView.layer.cornerRadius = 3
        coverView.layer.masksToBounds = true
    }
    
    func setEvent() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(timeSliderValueChanged(_:)))
        panGestureView.addGestureRecognizer(panGesture)
    }
    
    open func setProgress(_ progress: Float, animated: Bool) {
//        progressView.setProgress(progress, animated: animated)
    }
    
    //MARK: - Event
    @objc func timeSliderValueChanged(_ recognizer: UIPanGestureRecognizer) {
        let location = recognizer.location(in: recognizer.view)
        
        switch recognizer.state {
        case.began:
            touchBeganedLocation = location
            currentHeight = Float(progressHeight!.layoutConstraints.first!.constant)
        case .changed:
            let height = recognizer.view?.frame.size.height ?? 0.0
            let pointY = self.frame.size.height - location.y
            var touchChangedLocationY = location.x - touchBeganedLocation.y

            progressHeight?.update(offset: Float(pointY + touchChangedLocationY))
            
            print(pointY ,touchChangedLocationY)
        case .ended:
            break
        default:
            break
        }
    }
    
}

