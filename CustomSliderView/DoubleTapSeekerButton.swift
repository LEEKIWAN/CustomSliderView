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
    
    var secondInterval = 10
    
    private let seekButton = UIButton()
    
    private let fadeAnimationView = UIView()
    private let secondAnimationLabel = UILabel()
    
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
        
        
        seekButton.snp.makeConstraints { (maker) in
            maker.size.equalToSuperview()
        }
        
        fadeAnimationView.snp.makeConstraints { (maker) in
            maker.edges.equalTo(seekButton).inset(UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2))
        }
        
        secondIntervalLabel.snp.makeConstraints { (maker) in
            maker.centerX.centerY.equalTo(seekButton)
        }
        
        secondAnimationLabel.snp.makeConstraints { (maker) in
            maker.centerY.equalTo(seekButton)
            labelConstraint = maker.leading.equalTo(seekButton.snp.trailing).constraint
        }
        
    }
    
    
    private func setUI() {
        seekButton.setImage(#imageLiteral(resourceName: "iconmonstr-redo-7-240.png"), for: .normal)
        seekButton.tintColor = .white
        
        fadeAnimationView.layer.cornerRadius = 35.0 / 2
        fadeAnimationView.layer.masksToBounds = true
        fadeAnimationView.backgroundColor = .white
        fadeAnimationView.alpha = 0
        
        
        secondIntervalLabel.text = "\(secondInterval)"
        secondIntervalLabel.textColor = .white
        secondIntervalLabel.font = secondIntervalLabel.font.withSize(16)
        
        secondAnimationLabel.text = "\(secondInterval)"
        secondAnimationLabel.textColor = .white
        secondAnimationLabel.alpha = 0
        
        secondAnimationLabel.font = secondAnimationLabel.font.withSize(18)
        
        self.backgroundColor = .blue
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
        if animator.isRunning {
            animator.fractionComplete = 0.0
        }
        else {
            createAnimator()
            animator.startAnimation()
        }
    }
    
    func createAnimator() {
        
        animator = UIViewPropertyAnimator(duration: 1, curve: .linear) {
            UIView.animateKeyframes(withDuration: 1, delay: 0, options: [], animations: {
                UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.0) {
                    self.fadeAnimationView.alpha = 1
                    self.labelConstraint?.update(offset: 0)
                    self.seekButton.transform = CGAffineTransform(rotationAngle: 0)
                }
                
                UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.05) {
                    var t = CGAffineTransform.identity
                    t = t.rotated(by: CGFloat.pi / 4)
                    t = t.scaledBy(x: 0.8, y: 0.8)
                    
                    self.seekButton.transform = t
                    
                    self.layoutIfNeeded()
                }
                
                UIView.addKeyframe(withRelativeStartTime: 0.05, relativeDuration: 0.15) {
                    var t = CGAffineTransform.identity
                    t = t.rotated(by: 0)
                    t = t.scaledBy(x: 1, y: 1)
                    
                    self.seekButton.transform = t
                    self.layoutIfNeeded()
                }
                
                
                UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.2) {
                    
                    self.fadeAnimationView.alpha = 0
                    if self.directionMode == .forward {
                        self.labelConstraint!.update(offset: 10)
                    }
                    else {
                        self.labelConstraint!.update(offset: -10)
                    }
                    
                    
                    self.secondAnimationLabel.alpha = 1
                    self.layoutIfNeeded()
                }
                
                
                
                UIView.addKeyframe(withRelativeStartTime: 0.8, relativeDuration: 0.2) {
                    if self.directionMode == .forward {
                        self.labelConstraint!.update(offset: 20)
                    }
                    else {
                        self.labelConstraint!.update(offset: -20)
                    }
                    self.secondAnimationLabel.alpha = 0
                    self.layoutIfNeeded()
                }
            }) { (completion: Bool) in
                self.labelConstraint?.update(offset: 0)
            }
        }
    }
}

