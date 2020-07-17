//
//  VGPlayerSlider.swift
//  Pods
//
//  Created by Vein on 2017/6/4.
//
// https://developer.apple.com/reference/uikit/uislider

import UIKit


protocol VGPlayerSliderDelegate: class {
    func vgSliderTouchBegan(slider: VGPlayerSlider)
    func vgSliderValueChanged(slider: VGPlayerSlider, thumbXPoint: CGFloat)
    func vgSliderTouchEnd(slider: VGPlayerSlider)
    
}

class VGPlayerSlider: UISlider {
    
    // MARK: - variable
    
    weak var delegate: VGPlayerSliderDelegate?
    
    
    public var isThumbHidden: Bool = false {
        didSet {
            self.setThumbHidden(hidden: isThumbHidden)
        }
    }
    
    public var progress: Float = 0 {
        didSet {
            self.setProgress(progress, animated: false)
        }
    }
    
    var thumbCenterX: CGFloat {
        return thumbBounds.midX
    }
    
    
    private var progressView = UIProgressView()
    
    private var repeatProgressView = VGProgressView()
    
    // MARK: - function
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        configureSlider()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureSlider()
    }
    
    override open func thumbRect(forBounds bounds: CGRect, trackRect rect: CGRect, value: Float) -> CGRect {
        let rect = super.thumbRect(forBounds: bounds, trackRect: rect, value: value)
        let newRect = CGRect(x: rect.origin.x, y: rect.origin.y + 1, width: rect.width, height: rect.height)
        return newRect
    }
    
    override open func trackRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.trackRect(forBounds: bounds)
        let newRect = CGRect(origin: rect.origin, size: CGSize(width: rect.size.width, height: rect.size.height))
        configureProgressView(newRect)
        return newRect
    }
    
    private func configureSlider() {
        self.thumbTintColor = .blue
        
        progressView.tintColor = .blue
        progressView.trackTintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.2964201627)
        progressView.transform = progressView.transform.scaledBy(x: 1, y: 5)
        
        self.addTarget(self, action: #selector(onSliderValueChanged(slider:event:)), for: .valueChanged)
        
    }
    
    open func setProgress(_ progress: Float, animated: Bool) {
        self.value = progress
        progressView.setProgress(progress, animated: animated)
    }
    
    // MARK: - UI
    
    private func configureProgressView(_ frame: CGRect) {
        
        progressView.frame = frame
        insertSubview(progressView, at: 0)
        
        //        progressView.snp.makeConstraints { (make) in
        //            make.leading.equalTo(0)
        //            make.trailing.equalTo(0)
        //            make.center.equalToSuperview()
        //            make.height.equalTo(0.5)
        //        }
    }
    
    func setThumbHidden(hidden: Bool) {
        if hidden {
            progressView.tintColor = .red
            progressView.trackTintColor = .red
            self.thumbTintColor = .clear
            self.isUserInteractionEnabled = false
        }
        else {
            self.configureSlider()
            self.isUserInteractionEnabled = true
        }
    }
    
    
    // MARK: - Event
    
    @objc func onSliderValueChanged(slider: UISlider, event: UIEvent) {
        if let touchEvent = event.allTouches?.first {
            switch touchEvent.phase {
            case .began:
                delegate?.vgSliderTouchBegan(slider: self)
            case .moved:
                delegate?.vgSliderValueChanged(slider: self, thumbXPoint: thumbCenterX)
            case .ended:
                setProgress(slider.value, animated: false)
                self.delegate?.vgSliderTouchEnd(slider: self)
                
            default:
                break
            }
        }
    }
    
    func setRepeatStartPoint() {
        let center = CGFloat(progressView.progress) * progressView.frame.size.width
        repeatProgressView.frame = CGRect(x: center, y: progressView.frame.origin.y, width: 2, height: progressView.frame.size.height)
        repeatProgressView.trackTintColor = .clear
        self.insertSubview(repeatProgressView, aboveSubview: progressView)
    }
    
    func setRepeatEndPoint() {
        let center = CGFloat(progressView.progress) * progressView.frame.size.width
        let progressWidth = center - repeatProgressView.frame.origin.x + 2
        
        repeatProgressView.frame = CGRect(x: repeatProgressView.frame.origin.x, y: progressView.frame.origin.y, width: progressWidth, height: progressView.frame.size.height)
        
        
        progressView.backgroundColor = .brown
        progressView.progressTintColor = .clear
//        progressView.backgroundColor = .brown
    }
    
}
