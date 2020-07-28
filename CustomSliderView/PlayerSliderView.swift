//
//  VGPlayerSlider.swift
//  Pods
//
//  Created by Vein on 2017/6/4.
//
// https://developer.apple.com/reference/uikit/uislider

import UIKit


protocol PlayerSliderViewDelegate : class {
    func sliderTouchBegan(slider: PlayerSliderView)
    func sliderValueChanged(slider: PlayerSliderView, thumbXPoint: CGFloat)
    func sliderTouchEnd(slider: PlayerSliderView)
    
}

class PlayerSliderView: UISlider {
    
    // MARK: - variable
    
    weak var delegate: PlayerSliderViewDelegate?
    
    
//    public var isThumbHidden: Bool = false {
//        didSet {
//            self.setThumbHidden(hidden: isThumbHidden)
//        }
//    }
    
    public var progress: Float = 0 {
        didSet {
            self.setProgress(progress, animated: false)
        }
    }
    
    var thumbCenterX: CGFloat {
        return thumbBounds.midX
    }
    
    var bookmarkIndicators: [UIView] = []
    
    private var progressView = UIProgressView()
    
    private var sliderRepeatView = SliderRepeatView()
    
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        delegate?.sliderValueChanged(slider: self, thumbXPoint: thumbCenterX)
    }
    
    private func configureSlider() {
        self.addSubview(progressView)
        self.setPlayModeUI()
        
        progressView.snp.makeConstraints { (make) in
            make.leading.equalTo(0)
            make.trailing.equalTo(0)
            make.center.equalToSuperview()
            make.height.equalTo(6)
        }
        
        let thumbImage = #imageLiteral(resourceName: "VGPlayer_ic_slider_thumb")
        setThumbImage(thumbImage, for: .normal)
        setThumbImage(thumbImage, for: .highlighted)
        
        self.addTarget(self, action: #selector(onSliderValueChanged(slider:event:)), for: .valueChanged)
    }
    
    private func setProgress(_ progress: Float, animated: Bool) {
        self.value = progress
        progressView.setProgress(progress, animated: animated)
    }
    
    // MARK: - UI
    private func setLiveMode() {
//        if hidden {
            progressView.tintColor = .red
            progressView.trackTintColor = .red
            self.thumbTintColor = .clear
            self.isUserInteractionEnabled = false
//        }
//        else {
//            self.configureSlider()
//            self.isUserInteractionEnabled = true
//        }
    }
    
    
    // MARK: - Event
    
    @objc func onSliderValueChanged(slider: UISlider, event: UIEvent) {
        if let touchEvent = event.allTouches?.first {
            switch touchEvent.phase {
            case .began:
                delegate?.sliderTouchBegan(slider: self)
            case .moved:
                delegate?.sliderValueChanged(slider: self, thumbXPoint: thumbCenterX)
            case .ended:
                setProgress(slider.value, animated: false)
                self.delegate?.sliderTouchEnd(slider: self)
                
            default:
                break
            }
        }
    }
    
    func setRepeatStartPoint() {
        let center = CGFloat(progressView.progress) * progressView.frame.size.width
        sliderRepeatView.frame = CGRect(x: center, y: progressView.frame.origin.y, width: 2, height: progressView.frame.size.height)
        sliderRepeatView.trackTintColor = .clear
        self.insertSubview(sliderRepeatView, aboveSubview: progressView)
    }
    
    func setRepeatEndPoint() {
        let center = CGFloat(progressView.progress) * progressView.frame.size.width
        let progressWidth = center - sliderRepeatView.frame.origin.x + 2
        
        sliderRepeatView.frame = CGRect(x: sliderRepeatView.frame.origin.x, y: progressView.frame.origin.y, width: progressWidth, height: progressView.frame.size.height)
        
        setRepeatModeUI()
    }

    
    func removeRepeatPoint() {
        sliderRepeatView.removeFromSuperview()
        setPlayModeUI()
    }
    
    
    private func setRepeatModeUI() {
        progressView.backgroundColor = .brown
        progressView.progressTintColor = .clear
    }
    
    private func setPlayModeUI() {
        progressView.tintColor = .blue
        progressView.trackTintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.2964201627)
        progressView.progressTintColor = .blue
        progressView.backgroundColor = .clear
    }

    func addBookmarkIndicator() {
        let center = CGFloat(progressView.progress) * progressView.frame.size.width
        let bookmarkView = UIView(frame: CGRect(x: center, y: progressView.frame.origin.y, width: 2, height: progressView.frame.size.height))
        bookmarkView.backgroundColor = .orange
        self.insertSubview(bookmarkView, aboveSubview: progressView)
        self.bookmarkIndicators.append(bookmarkView)
    }
}
