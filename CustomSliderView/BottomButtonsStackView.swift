//
//  BottomButtonsStackView.swift
//  CustomSliderView
//
//  Created by kiwan on 2020/07/23.
//  Copyright © 2020 kiwan. All rights reserved.
//

import UIKit
import SnapKit

class BottomButtonsStackView: UIView {
    var isLockMode = false {
        didSet {
            updateLockModeUI(isLocked: isLockMode)
        }
    }
    
    let stackView = UIStackView()
    
    let lockButton = UIButton()
    let seriesButton = UIButton()
    let repeatButton = UIButton()
    let bookmarkButton = UIButton()
    let moreButton = UIButton()
    
//    override var intrinsicContentSize: CGSize {
//        return stackView.frame.size
//         // if using in, say, a vertical stack view, the width is ignored
//     }
//    
//    override func prepareForInterfaceBuilder() {
//           invalidateIntrinsicContentSize()
//       }

    
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
        addSubview(stackView)
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.snp.makeConstraints { (maker) in
            maker.size.equalToSuperview()
            maker.center.equalToSuperview()
        }
        
        stackView.addArrangedSubview(lockButton)
        stackView.addArrangedSubview(seriesButton)
        stackView.addArrangedSubview(repeatButton)
        stackView.addArrangedSubview(bookmarkButton)
        stackView.addArrangedSubview(moreButton)
    }
    
    private func setUI() {
        lockButton.backgroundColor = .blue
        lockButton.imageView?.contentMode = .scaleAspectFit
        seriesButton.imageView?.contentMode = .scaleAspectFit
        repeatButton.imageView?.contentMode = .scaleAspectFit
        bookmarkButton.imageView?.contentMode = .scaleAspectFit
        moreButton.imageView?.contentMode = .scaleAspectFit
        
        lockButton.setImage(#imageLiteral(resourceName: "iconmonstr-lock-16-240"), for: .normal)
        seriesButton.setImage(#imageLiteral(resourceName: "iconmonstr-lock-16-240"), for: .normal)
        repeatButton.setImage(#imageLiteral(resourceName: "iconmonstr-loop-thin-240"), for: .normal)
        bookmarkButton.setImage(#imageLiteral(resourceName: "iconmonstr-star-3-240"), for: .normal)
        moreButton.setImage(#imageLiteral(resourceName: "iconmonstr-lock-16-240"), for: .normal)
        
    }
    
    private func setEvent() {
        lockButton.addTarget(self, action: #selector(onLockTouched(_:)), for: .touchUpInside)
    }
    
    
    @objc func onLockTouched(_ sender: UIButton) {
        isLockMode = !isLockMode
    }
    
    func updateLockModeUI(isLocked: Bool) {
        if isLocked {
            UIView.animate(withDuration: 0.2) { [weak self] in
                 guard let self = self else { return }
                 self.seriesButton.isHidden = true
                 self.repeatButton.isHidden = true
                 self.bookmarkButton.isHidden = true
                 self.moreButton.isHidden = true
                
                self.layoutIfNeeded()
             }
        }
        else {
            UIView.animate(withDuration: 0.2) { [weak self] in
                guard let self = self else { return }
                self.seriesButton.isHidden = false
                self.repeatButton.isHidden = false
                self.bookmarkButton.isHidden = false
                self.moreButton.isHidden = false
                self.layoutIfNeeded()
            }
        }
    }
    
    func lockAnimateView() {
        
    }
    
    func unlockAnimateView() {
        
    }
    
}
