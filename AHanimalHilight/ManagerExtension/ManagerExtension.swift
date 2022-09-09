//
//  ManagerExtension.swift
//  AHanimalHilight
//
//  Created by TomSmith on 2022/9/2.
//

import Foundation
import UIKit

extension UIImage {
    func compressThumbImage(targetSize: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(targetSize, false, UIScreen.main.scale)
        self.draw(in: CGRect(x: 0, y: 0, width: targetSize.width, height: targetSize.height))
        let targetImg = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return targetImg
    }
}

class AHaniStickerItem {
    var thumb: String = ""
    var big: String = ""
    init(thumb: String, big: String) {
        self.thumb = thumb
        self.big = big
    }
}

class AHaniManager: NSObject {
    static let `default` = AHaniManager()
    var shapeMaskList: [AHaniStickerItem] = []
    var colorStrList: [String] = []
    var fontStrList: [String] = []
    
    
    override init() {
        // coin count
        super.init()
        setupDefaultConfig()
    }
    
    func setupDefaultConfig() {
        shapeMaskList = []
        for i in 1...10 {
            let thumb = "ic_video_mask_\(i)"
            let big = "ic_video_mask_\(i)_max"
            let shape = AHaniStickerItem(thumb: thumb, big: big)
            shapeMaskList.append(shape)
        }
        shapeMaskList.insert(AHaniStickerItem(thumb: "ic_phtoto_no", big: "ic_phtoto_no"), at: 0)
        
        //
        colorStrList = ["#FFFFFF", "#000000", "#B8E986", "#50E3C2", "#FC6076", "#4A90E2", "#DB309A", "#FFB125", "#7ED321", "#9013FE", "#FFF4E0", "#6E7A91"]
        fontStrList = ["AvenirNext-Medium", "Cochin-Italic","Baskerville-Italic", "CourierNewPSMT", "Galvji", "GillSans", "Menlo-Regular", "SavoyeLetPlain"]
    }
    
    
}
public class Once {
    var already: Bool = false
    
    public init() {}
    
    public func run(_ block: () -> Void) {
        guard !already else {
            return
        }
        
        block()
        already = true
    }
}
 

