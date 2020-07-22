//
//  VerticalProgressView.swift
//  CustomSliderView
//
//  Created by kiwan on 2020/07/20.
//  Copyright © 2020 kiwan. All rights reserved.
//

import UIKit
import MediaPlayer


class VerticalProgressView: UIView {
    enum Mode {
         case sound
         case brightness
     }
    
    var mode: Mode = .sound {
        didSet {
            updateModeUI()
        }
    }
    
    var volumeView: MPVolumeView = MPVolumeView(frame: CGRect(x: -1000, y: -1000, width: 100, height: 100))
    var volumeSlider : UISlider?
    
    
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
    
    private func setNib() {
        addSubview(volumeView)
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
    
    private func setUI() {
        volumeSlider = volumeView.subviews.first as? UISlider
        panGestureView.backgroundColor = .clear
        updateBrightnessUI()
    }
    
    private func setEvent() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(timeSliderValueChanged(_:)))
        panGestureView.addGestureRecognizer(panGesture)
    }
    
    private func updateModeUI() {
        self.mode == .brightness ? updateBrightnessUI() : updateSoundUI()
    }
    
    //MARK: - Event
    @objc func timeSliderValueChanged(_ recognizer: UIPanGestureRecognizer) {
        let velocity = recognizer.velocity(in: recognizer.view)
        switch recognizer.state {
        case.began:
            break
        case .changed:
            if mode == .brightness {
                updateBrightnessUI(value: Float(velocity.y / 10000))
            }
            else {
                updateSoundUI(value: Float(velocity.y / 10000))
            }
            
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
    
    func updateBrightnessUI(value: Float = 0) {
        UIScreen.main.brightness -= CGFloat(value)
        progressView.setProgress(Float(UIScreen.main.brightness), animated: false)
        statusImageView.image = UIScreen.main.brightness >= 0.5 ? #imageLiteral(resourceName: "brightness_high") : #imageLiteral(resourceName: "brightness_low")
    }
    
    func updateSoundUI(value: Float = 0) {
        guard let volumeSlider = volumeSlider else {
            return
        }
        
        let audioSession = AVAudioSession.sharedInstance()
        var systemVolume: Float!
        do {
            try audioSession.setActive(true)
            systemVolume = audioSession.outputVolume
        } catch {
            print("Error Setting Up Audio Session")
        }
        
        volumeSlider.value -= value
        progressView.setProgress(systemVolume!, animated: false)
//
        if systemVolume == 0 {
            statusImageView.image = #imageLiteral(resourceName: "volume_muted")
        }
        else if systemVolume < 0.5 {
            statusImageView.image = #imageLiteral(resourceName: "volume_low")
        }
        else {
            statusImageView.image = #imageLiteral(resourceName: "volume_high")
        }
        
      }
    
}

