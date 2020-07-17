//
//  DoubleTapSeekerButton.swift
//  CustomSliderView
//
//  Created by kiwan on 2020/06/04.
//  Copyright © 2020 kiwan. All rights reserved.
//

import UIKit

class DoubleTapSeekerButton: UIView {
    
    @IBOutlet weak var backgroundButtonView: UIView!
    @IBOutlet weak var consLeading: NSLayoutConstraint!
    
    @IBOutlet weak var seekButton: UIButton!
    @IBOutlet weak var secondLabel: UILabel!
    
    var animator: UIViewPropertyAnimator = UIViewPropertyAnimator(duration: 1, curve: .linear)
    
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
    
    private func setUI() {
        backgroundButtonView.layer.cornerRadius = backgroundButtonView.frame.size.height / 2
    }
    
    private func setNib() {
        let view = Bundle.main.loadNibNamed("DoubleTapSeekerButton", owner: self, options: nil)?.first as! UIView
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(view)
    }
    
    private func setEvent() {
    }
    
    private func setShown(_ shown: Bool) {
        //        shown ? show() : hide()
    }
    
    @IBAction func onButtonTouched(_ sender: UIButton) {
        
        
        if animator.isRunning {
//            animator.finishAnimation(at: .start)
//            animator.stopAnimation(true)
//            createAnimator()
            animator.fractionComplete = 0.0
        
        }
        else {
            createAnimator()
            animator.startAnimation()
        }
        
        
        //        animator?.startAnimation()
    }
    
    func createAnimator() {
        animator = UIViewPropertyAnimator(duration: 1, curve: .linear) {
            UIView.animateKeyframes(withDuration: 1, delay: 0, options: [], animations: {
                UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.0) {
                    self.backgroundButtonView.alpha = 1
                    self.consLeading.constant = 0
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
                    
                    self.backgroundButtonView.alpha = 0
                    self.consLeading.constant = 20
                    self.secondLabel.alpha = 1
                    self.layoutIfNeeded()
                }
                
                UIView.addKeyframe(withRelativeStartTime: 0.8, relativeDuration: 0.2) {
                    self.consLeading.constant = 40
                    self.secondLabel.alpha = 0
                    self.layoutIfNeeded()
                }
            }) { (completion: Bool) in
                self.consLeading.constant = 0
            }
        }
    }
}

