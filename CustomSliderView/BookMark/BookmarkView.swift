//
//  BookmarkView.swift
//  CustomSliderView
//
//  Created by kiwan on 2020/05/29.
//  Copyright © 2020 kiwan. All rights reserved.
//

import UIKit

class BookmarkView: UIView {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var isShown: Bool = false {
        didSet {
            self.setShown(isShown)
        }
    }
    
    //MARK: - Func
    override init(frame: CGRect) {
        super.init(frame: frame)
        setNib()
        setEvent()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setNib()
        setEvent()
    }
    
    private func setNib() {
        let view = Bundle.main.loadNibNamed("BookmarkView", owner: self, options: nil)?.first as! UIView
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(view)
    }
    
    private func setEvent() {
        collectionView.register(UINib(nibName: "BookmarkCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "BookmarkCell")
    }
    
    private func setShown(_ shown: Bool) {
        shown ? show() : hide()
    }
    
    private func show() {
        guard let vc = parentViewController as? ViewController else { return }
        
        UIView.animate(withDuration: 0.2) {
            vc.consBookmarkBottomMargin.constant = 0
            vc.view.layoutIfNeeded()
        }
        
        self.collectionView.reloadData()
    }
    
    private func hide() {
        guard let vc = parentViewController as? ViewController else { return }
        vc.view.layoutIfNeeded()
        
        UIView.animate(withDuration: 0.2) {
            vc.consBookmarkBottomMargin.constant = -234

            vc.view.layoutIfNeeded()
            
        }
    }
}


extension BookmarkView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookmarkCell", for: indexPath) as! BookmarkCollectionViewCell
 

        return cell
    }

}
