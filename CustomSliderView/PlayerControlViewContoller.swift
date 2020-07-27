//
//  ViewController.swift
//  CustomSliderView
//
//  Created by kiwan on 2020/05/25.
//  Copyright © 2020 kiwan. All rights reserved.
//

import UIKit

class PlayerControlViewContoller: UIViewController, PlayerSliderViewDelegate {
    
    @IBOutlet weak var bookmarkView: BookmarkView!
    
    
    @IBOutlet weak var thumbnailView: SliderThumbnailView!
    @IBOutlet weak var sliderView: PlayerSliderView!
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
    
//    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
//        super.willTransition(to: newCollection, with: coordinator)
//        
//        coordinator.animate(alongsideTransition: { [unowned self] _ in
//            if newCollection.verticalSizeClass == .compact {
//                self.view.backgroundColor = UIColor.red
//            } else {
//                self.view.backgroundColor = UIColor.green
//            }
//        }) { [unowned self] _ in
//            self.view.backgroundColor = UIColor.blue
//        }
//    }
    
    private var windowInterfaceOrientation: UIInterfaceOrientation? {
         return UIApplication.shared.windows.first?.windowScene?.interfaceOrientation
     }
    
    @IBAction func onBookmarkToggleTouched(_ sender: UIButton) {
        bookmarkView.isShown = !bookmarkView.isShown
    }
    
    @IBAction func onCreateStartPoint(_ sender: UIButton) {
//        sliderView.isThumbHidden = !sliderView.isThumbHidden
    }
    
    @IBAction func startPoint(_ sender: UIButton) {
        sliderView.setRepeatStartPoint()
    }
    
    @IBAction func endPoint(_ sender: UIButton) {
        sliderView.setRepeatEndPoint()
        
        
    }
    
    @IBAction func onResetRepeatMode(_ sender: UIButton) {
        sliderView.removeRepeatPoint()
    }
    // MARK : - VGPlayerSliderDelegate
    @IBAction func onAddBookmarkViewTouched(_ sender: UIButton) {
        sliderView.addBookmarkIndicator()
    }
    
    func sliderTouchBegan(slider: PlayerSliderView) {
        thumbnailView.isShown = true
    }
    
    func sliderValueChanged(slider: PlayerSliderView, thumbXPoint: CGFloat) {
        consLeading.constant = thumbXPoint
        thumbnailView.setThumbnail(image: #imageLiteral(resourceName: "test"), time: "00:00")
    }
    
    func sliderTouchEnd(slider: PlayerSliderView) {
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
