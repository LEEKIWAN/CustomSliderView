//
//  ViewController.swift
//  CustomSliderView
//
//  Created by kiwan on 2020/05/25.
//  Copyright © 2020 kiwan. All rights reserved.
//

import UIKit

class ViewController: UIViewController, VGPlayerSliderDelegate {
    
    @IBOutlet weak var bookmarkView: BookmarkView!
    
    
    @IBOutlet weak var thumbnailView: ProgressThumbnailView!
    @IBOutlet weak var sliderView: VGPlayerSlider!
    @IBOutlet weak var consLeading: NSLayoutConstraint!
    
    @IBOutlet weak var consWidth: NSLayoutConstraint!
    @IBOutlet weak var consBottomMargin: NSLayoutConstraint!
    
    @IBOutlet open weak var consBookmarkBottomMargin: NSLayoutConstraint!
    
    @IBOutlet weak var seekerButton: DoubleTapSeekerButton!
    
    @IBOutlet weak var seekerButton2: DoubleTapSeekerButton!
    
    @IBOutlet weak var brightnessVertical: VerticalProgressView!
    @IBOutlet weak var soundVertical: VerticalProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sliderView.delegate = self
        
        seekerButton.directionMode = .backward
        seekerButton2.directionMode = .forward
        
        brightnessVertical.mode = .brightness
        soundVertical.mode = .sound
    }
    
    @IBAction func onBookmarkToggleTouched(_ sender: UIButton) {
        bookmarkView.isShown = !bookmarkView.isShown
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
    
    
    @IBAction func onDoubleTapTouched(_ sender: UITapGestureRecognizer) {
        
        let location = sender.location(in: self.view)
        if location.x > self.view.bounds.width / 2 {
            print("right")
        } else {
            print("left")
        }
    }
}
