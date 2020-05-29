//
//  BookmarkView.swift
//  CustomSliderView
//
//  Created by kiwan on 2020/05/29.
//  Copyright © 2020 kiwan. All rights reserved.
//

import UIKit

class BookmarkView: UIView {
     //MARK: - Func
     override init(frame: CGRect) {
         super.init(frame: frame)
         setNib()
     }
     
     required init?(coder aDecoder: NSCoder) {
         super.init(coder: aDecoder)
         setNib()
     }
     
     private func setNib() {
         let view = Bundle.main.loadNibNamed("BookmarkView", owner: self, options: nil)?.first as! UIView
         view.frame = self.bounds
         self.addSubview(view)
        
//        guard let parentViewcontroller = parentViewController as? ViewController else { return }
        
        
     }
    
     
}
