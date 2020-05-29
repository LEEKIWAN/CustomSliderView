//
//  ViewController.swift
//  CustomSliderView
//
//  Created by kiwan on 2020/05/25.
//  Copyright © 2020 kiwan. All rights reserved.
//

import UIKit

class ViewController: UIViewController, VGPlayerSliderDelegate {

    @IBOutlet weak var thumbnailView: ProgressThumbnailView!
    @IBOutlet weak var sliderView: VGPlayerSlider!
    @IBOutlet weak var consLeading: NSLayoutConstraint!
    
    @IBOutlet weak var consWidth: NSLayoutConstraint!
    @IBOutlet weak var consBottomMargin: NSLayoutConstraint!
    
    @IBOutlet open weak var consBookmarkBottomMargin: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sliderView.delegate = self
        
    }
        
    @IBAction func onBookmarkToggleTouched(_ sender: UIButton) {
    }
    
    @IBAction func onCreateStartPoint(_ sender: UIButton) {
        sliderView.isThumbHidden = !sliderView.isThumbHidden
    }
    
    @IBAction func startPoint(_ sender: UIButton) {
        sliderView.setRepeatStartPoint()
    }
    
    @IBAction func endPoint(_ sender: UIButton) {
        sliderView.setRepeatEndPoint()
    }
    
    // MARK : - VGPlayerSliderDelegate
    
    func vgSliderTouchBegan(slider: VGPlayerSlider) {
        thumbnailView.isShown = true
    }
    
    func vgSliderValueChanged(slider: VGPlayerSlider, thumbXPoint: CGFloat) {
        consLeading.constant = thumbXPoint
        thumbnailView.setThumbnail(image: #imageLiteral(resourceName: "test"), time: "00:00")
    }
    
    func vgSliderTouchEnd(slider: VGPlayerSlider) {
        thumbnailView.isShown = false
    }
}
