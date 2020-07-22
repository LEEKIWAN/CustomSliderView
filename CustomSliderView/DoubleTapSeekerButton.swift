//
//  DoubleTapSeekerButton.swift
//  CustomSliderView
//
//  Created by kiwan on 2020/06/04.
//  Copyright © 2020 kiwan. All rights reserved.
//

import UIKit
import SnapKit

class DoubleTapSeekerButton: UIView {
    enum Direction {
        case forward
        case backward
    }
    
    var animationScale = 20
    var interval = 10
    
    private var currentInterval = 0
    private let seekButton = UIButton()
    
    private let fadeAnimationView = UIView()
    private let secondAnimationLabel = UILabel()
    private let secondIntervalLabel = UILabel()
    
    private var animator: UIViewPropertyAnimator = UIViewPropertyAnimator(duration: 1, curve: .linear)
    
    private var labelConstraint: Constraint? = nil
    
    var directionMode: Direction = .forward {
        didSet {
            updateDirectionUI()
        }
    }
    
    //MARK: - Func
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
    
    private func setNib() {
        addSubview(seekButton)
        addSubview(fadeAnimationView)
        addSubview(secondAnimationLabel)
        addSubview(secondIntervalLabel)
        
        seekButton.snp.makeConstraints { (maker) in
            maker.size.equalToSuperview()
        }
        
        fadeAnimationView.snp.makeConstraints { (maker) in
            maker.edges.equalTo(seekButton).inset(UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2))
        }
        
        secondAnimationLabel.snp.makeConstraints { (maker) in
            maker.centerY.equalTo(seekButton)
            labelConstraint = maker.centerX.equalTo(seekButton).constraint
        }
        
        secondIntervalLabel.snp.makeConstraints { (maker) in
            maker.centerY.centerX.equalTo(seekButton)
        }
    }
    
    private func setUI() {
        seekButton.adjustsImageWhenHighlighted = false
        seekButton.setImage(#imageLiteral(resourceName: "iconmonstr-redo-7-240.png"), for: .normal)
        seekButton.tintColor = .white
        
        fadeAnimationView.layer.cornerRadius = 35.0 / 2
        fadeAnimationView.layer.masksToBounds = true
        fadeAnimationView.backgroundColor = .white
        fadeAnimationView.alpha = 0
    
        secondAnimationLabel.text = "\(interval)"
        secondAnimationLabel.textColor = .white
        secondAnimationLabel.font = secondAnimationLabel.font.withSize(21)
        secondAnimationLabel.alpha = 0
        
        secondIntervalLabel.text = "\(interval)"
        secondIntervalLabel.textColor = .white
        secondIntervalLabel.font = secondIntervalLabel.font.withSize(16)
        
        currentInterval = interval
    }
    
    private func setEvent() {
        seekButton.addTarget(self, action: #selector(onButtonTouched(_:)), for: .touchUpInside)
    }
    
    private func updateDirectionUI() {
        secondAnimationLabel.snp.removeConstraints()
        
        if directionMode == .forward {
            seekButton.setImage(#imageLiteral(resourceName: "iconmonstr-redo-7-240.png"), for: .normal)
            secondAnimationLabel.snp.makeConstraints { (maker) in
                maker.centerY.equalTo(seekButton)
                labelConstraint = maker.leading.equalTo(seekButton.snp.trailing).constraint
            }
        }
        else {
            seekButton.setImage(#imageLiteral(resourceName: "iconmonstr-undo-7-240.png"), for: .normal)
            secondAnimationLabel.snp.makeConstraints { (maker) in
                maker.centerY.equalTo(seekButton)
                labelConstraint = maker.trailing.equalTo(seekButton.snp.leading).constraint
            }
        }
    }
    
    @objc func onButtonTouched(_ sender: UIButton) {
        self.updateCurrentIntervalText()
        if animator.isRunning {
            animator.fractionComplete = 0.0
        }
        else {
            createAnimator()
            animator.startAnimation()
        }
    }
    
    private func updateCurrentIntervalText() {
        let mark = directionMode == .backward ? "-" : "+"
        secondAnimationLabel.text = "\(mark)\(currentInterval)"
        secondAnimationLabel.sizeToFit()
        currentInterval += interval
    }
    
    private func createAnimator() {
        
        animator = UIViewPropertyAnimator(duration: 1, curve: .linear) {
            UIView.animateKeyframes(withDuration: 1, delay: 0, options: [], animations: {
                UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.0) {
                    self.secondIntervalLabel.alpha = 1.0
                    self.fadeAnimationView.alpha = 0.8
                    self.secondAnimationLabel.alpha = 0.0
                    self.labelConstraint?.update(offset: 0)
                    self.seekButton.transform = CGAffineTransform(rotationAngle: 0)
                }
                
                UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.05) {
                    var t = CGAffineTransform.identity
                    if self.directionMode == .forward {
                        t = t.rotated(by: CGFloat.pi / 4)
                    }
                    else {
                        t = t.rotated(by: CGFloat.pi / -4)
                    }
                    
                    t = t.scaledBy(x: 0.8, y: 0.8)
                    self.seekButton.transform = t
                    self.layoutIfNeeded()
                }
                
                UIView.addKeyframe(withRelativeStartTime: 0.05, relativeDuration: 0.05) {
                    self.secondIntervalLabel.alpha = 0
                    self.layoutIfNeeded()
                }
                
                UIView.addKeyframe(withRelativeStartTime: 0.05, relativeDuration: 0.15) {
                    var t = CGAffineTransform.identity
                    t = t.rotated(by: 0)
                    t = t.scaledBy(x: 1, y: 1)
                    self.seekButton.transform = t
                    self.fadeAnimationView.alpha = 0
                    self.layoutIfNeeded()
                }
                
                
                UIView.addKeyframe(withRelativeStartTime: 0.1, relativeDuration: 0.2) {
                    _ = self.directionMode == .forward ? self.labelConstraint!.update(offset: self.animationScale) : self.labelConstraint!.update(offset: -self.animationScale)
                    
                    self.secondAnimationLabel.alpha = 1.0
                    self.layoutIfNeeded()
                }
                
                UIView.addKeyframe(withRelativeStartTime: 0.8, relativeDuration: 0.2) {
                    self.secondAnimationLabel.alpha = 0
                    self.layoutIfNeeded()
                }
            }) { (completion: Bool) in
                self.labelConstraint?.update(offset: 0)
                self.secondAnimationLabel.alpha = 0
                self.secondIntervalLabel.alpha = 1
                self.currentInterval = self.interval
            }
        }
    }
}

