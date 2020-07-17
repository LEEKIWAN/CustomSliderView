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
    
    let fadeAnimationView: UIView = UIView()
    
    let seekButton: UIButton = UIButton()
    let secondLabel: UILabel = UILabel()
    
    var animator: UIViewPropertyAnimator = UIViewPropertyAnimator(duration: 1, curve: .linear)
    
    var labelConstraint: Constraint? = nil
    
    
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
        addSubview(fadeAnimationView)
        addSubview(seekButton)
        addSubview(secondLabel)
        
        seekButton.snp.makeConstraints { (maker) in
            maker.centerX.equalToSuperview()
            maker.centerY.equalToSuperview()
            maker.width.equalTo(35)
            maker.height.equalTo(35)
        }
        
        fadeAnimationView.snp.makeConstraints { (maker) in
            maker.edges.equalTo(seekButton).inset(UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2))
        }
        
        secondLabel.snp.makeConstraints { (maker) in
            maker.centerY.equalTo(seekButton)
            labelConstraint = maker.leading.equalTo(seekButton.snp.trailing).constraint
        }
        
    }
    
    
    private func setUI() {
        
        seekButton.setImage(#imageLiteral(resourceName: "iconmonstr-redo-7-240.png"), for: .normal)
        seekButton.tintColor = .white
        
        fadeAnimationView.layer.cornerRadius = 31.0 / 2
        fadeAnimationView.layer.masksToBounds = true
        fadeAnimationView.backgroundColor = .white
        fadeAnimationView.alpha = 0
        
        secondLabel.text = "10"
        secondLabel.textColor = .white
        secondLabel.alpha = 0
        
        secondLabel.font = secondLabel.font.withSize(18)
        
//        self.backgroundColor = .blue
    }
    
    
    private func setEvent() {
        seekButton.addTarget(self, action: #selector(onButtonTouched(_:)), for: .touchUpInside)
    }
    
    private func setShown(_ shown: Bool) {
        //        shown ? show() : hide()
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
                    //                    self.consLeading.constant = 0
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
                    //                    self.consLeading.constant = 20
                    self.labelConstraint?.update(offset: 20)
                    self.secondLabel.alpha = 1
                    self.layoutIfNeeded()
                }
                
                UIView.addKeyframe(withRelativeStartTime: 0.8, relativeDuration: 0.2) {
                    //                    self.consLeading.constant = 40
                    self.labelConstraint?.update(offset: 40)
                    self.secondLabel.alpha = 0
                    self.layoutIfNeeded()
                }
            }) { (completion: Bool) in
                //                self.consLeading.constant = 0
                self.labelConstraint?.update(offset: 0)
            }
        }
    }
}

