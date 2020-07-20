//
//  ProgressThumbnailView.swift
//  CustomSliderView
//
//  Created by kiwan on 2020/05/29.
//  Copyright © 2020 kiwan. All rights reserved.
//

import UIKit
import SnapKit

class ProgressThumbnailView: UIView {    
    
    var isShown: Bool = false {
        didSet {
            self.setShown(isShown)
        }
    }
    
    var thumbnailImageView = UIImageView()
    
    var currentTimeLabel = UILabel()
    
    //MARK: - Func
    override init(frame: CGRect) {
        super.init(frame: frame)
        setNib()
        setEvent()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setNib()
        setUI()
        setEvent()
    }
    
    private func setNib() {
        addSubview(thumbnailImageView)
        addSubview(currentTimeLabel)
        
        
        thumbnailImageView.snp.makeConstraints { (maker) in
            maker.top.equalToSuperview()
            maker.trailing.equalToSuperview()
            maker.leading.equalToSuperview()
            maker.height.equalTo(thumbnailImageView.snp.width).multipliedBy(9.0 / 16.0)
        }
        
        
        currentTimeLabel.snp.makeConstraints { (maker) in
            maker.bottom.equalToSuperview().offset(-7)
            maker.top.equalTo(thumbnailImageView.snp.bottom).offset(7)
            maker.centerX.equalToSuperview()
        }
    }
    
    private func setUI() {
        thumbnailImageView.contentMode = .scaleAspectFill
        thumbnailImageView.layer.masksToBounds = true
        thumbnailImageView.image = #imageLiteral(resourceName: "test")
        
        currentTimeLabel.text = "00:00"
    }
    
    private func setEvent() {
        
    }
    
    private func setShown(_ shown: Bool) {
        shown ? show() : hide()
    }
    
    private func show() {
        guard let vc = parentViewController as? ViewController else { return }
        
        UIView.animate(withDuration: 0.1) {
            vc.consWidth.constant = 230
            vc.consBottomMargin.constant = 20
            
            vc.thumbnailView.alpha = 1
            vc.view.layoutIfNeeded()
        }
    }
    
    private func hide() {
        guard let vc = parentViewController as? ViewController else { return }
        vc.view.layoutIfNeeded()
        
        UIView.animate(withDuration: 0.1) {
            vc.consWidth.constant = 100
            vc.consBottomMargin.constant = 0
            
            vc.thumbnailView.alpha = 0
            
            vc.view.layoutIfNeeded()
            
        }
    }
    
    
    func setThumbnail(image: UIImage? = nil, time: String) {
        if image != nil {
            thumbnailImageView.image = image
            thumbnailImageView.isHidden = false
        }
        else {
            thumbnailImageView.isHidden = true
        }
        
        
        currentTimeLabel.text = time
    }
    

}
