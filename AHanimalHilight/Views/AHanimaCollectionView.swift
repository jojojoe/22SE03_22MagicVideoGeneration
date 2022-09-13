//
//  AHanimaCollectionView.swift
//  AHanimalHilight
//
//  Created by TomSmith on 2022/8/29.
//

import UIKit
import SwifterSwift
import BBMetalImage

class AHanimaCollectionView: UIView {
    var contentBgV: UIView!
    var collection: UICollectionView!
    let itemCount: Int = 1000
    var itemPaddingScale: CGFloat = 1
    var horTransformScale: CGFloat = 0
    var verTransformScale: CGFloat = 0
    var rotateScale: CGFloat = 0
    var itemWidth: CGFloat = 100
    var itemRowCount: Int = 4
    var isChangeHang: Bool = false
    var isChangeLie: Bool = false
    var userImg: UIImage
    var thumbImg: UIImage?
    var currentShapeItem: AHaniStickerItem?
    
    private var stepCount: Int64 = 0
    var timer: SwiftTimer!
    private var displayLink: CADisplayLink!
    
    
    
    private var uiSource: BBMetalUISource!
    private var videoWriter: BBMetalVideoWriter!
    private var filePath: String!
    
    
    init(frame: CGRect, userImg: UIImage) {
        self.userImg = userImg
        super.init(frame: frame)
        setupCollection()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCollection() {
        
        itemWidth = self.bounds.width / CGFloat(itemRowCount)
        thumbImg = self.userImg.compressThumbImage(targetSize: CGSize(width: itemWidth * UIScreen.main.scale, height: itemWidth * (userImg.size.height/userImg.size.width) * UIScreen.main.scale))
        //
        let wyu = CGFloat(Int(self.frame.width) % 8)
        let hyu = CGFloat(Int(self.frame.height) % 8)
        var sizeWidth: CGFloat = self.frame.width
        var sizeHeight: CGFloat = self.frame.height
        sizeWidth = sizeWidth + (8 - wyu)
        sizeHeight = sizeHeight + (8 - hyu)
        //
        contentBgV = UIView(frame: CGRect(x: 0, y: 0, width: sizeWidth, height: sizeHeight))
        contentBgV.center = self.center
        self.addSubview(contentBgV)
        contentBgV.backgroundColor = UIColor(hexString: "#98D5EB")
        
        //
        let metalView = BBMetalView(frame: frame)
        metalView.bb_textureContentMode = .aspectRatioFit
        addSubview(metalView)
        uiSource = BBMetalUISource(view: self.contentBgV)
        uiSource
            .add(consumer: metalView)
        filePath = NSTemporaryDirectory() + "test.mp4"
        let outputUrl = URL(fileURLWithPath: filePath)
        let frameSize = uiSource.renderPixelSize!
        
        videoWriter = BBMetalVideoWriter(url: outputUrl, frameSize: BBMetalIntSize(width: Int(frameSize.width), height: Int(frameSize.height)))
        uiSource.add(consumer: videoWriter)
        
        
        //
        let collectionRect = CGRect(x: -itemWidth, y: -itemWidth, width: UIScreen.main.bounds.width + itemWidth * 2, height: UIScreen.main.bounds.height + itemWidth * 2)
        
        //
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        collection = UICollectionView.init(frame: collectionRect, collectionViewLayout: layout)
        collection.showsVerticalScrollIndicator = false
        collection.showsHorizontalScrollIndicator = false
        collection.backgroundColor = .clear
        collection.delegate = self
        collection.dataSource = self
        contentBgV.addSubview(collection)
        
        collection.register(cellWithClass: AHanimaPreviewCell.self)
        
        //
        collection.isUserInteractionEnabled = false
    }
 

}

extension AHanimaCollectionView {
    func processBigPreview() -> UIView {
        let scale: CGFloat = 3
        let bgView = UIView(frame: CGRect(x: 0, y: 0, width: self.bounds.width * scale, height: self.bounds.height * scale))
        bgView.backgroundColor = self.contentBgV.backgroundColor
        for cell in self.collection.visibleCells {
            if let cell_m = cell as? AHanimaPreviewCell {
                let bigCell = AHanimaPreviewCell()
                bigCell.contentImgV.image = cell_m.contentImgV.image
                
                bigCell.frame = CGRect(x: cell_m.frame.origin.x * scale - cell.frame.size.width * scale, y: cell_m.frame.origin.y * scale - cell.frame.size.height * scale, width: cell.frame.size.width * scale, height: cell.frame.size.height * scale)
                //
                
                if let item_m = currentShapeItem {
                    if item_m.big == "ic_phtoto_no" {
                        bigCell.contentImgV.mask = nil
                    } else {
                        let shapeV = UIImageView(frame: bigCell.bounds)
                        shapeV.image = UIImage(named: item_m.big)
                        bigCell.contentImgV.mask = shapeV
                    }
                }
                
                bigCell.contentImgV.transform = cell_m.contentImgV.transform
                bigCell.transform = cell_m.transform
                
                //
                bgView.addSubview(bigCell)
            }
        }
        return bgView
        
    }
}

extension AHanimaCollectionView {
    func updateRowCount(value: Int) {
        itemRowCount = value
        let cwidth = Int(self.bounds.width/CGFloat(value))
        itemWidth = CGFloat(cwidth)
        
        let collectionRect = CGRect(x: -itemWidth, y: -itemWidth, width: UIScreen.main.bounds.width + itemWidth * 2, height: UIScreen.main.bounds.height + itemWidth * 2)
        collection.frame = collectionRect
        collection.reloadData()
    }
    func updateCellPadding(value: CGFloat) {
        itemPaddingScale = value
        collection.reloadData()
    }
    func updateCellHorTransform(value: CGFloat) {
        horTransformScale = value
        collection.reloadData()
        isChangeHang = true
        isChangeLie = false
    }
    func updateCellVerTransform(value: CGFloat) {
        verTransformScale = value
        collection.reloadData()
        isChangeHang = false
        isChangeLie = true
    }
    func updateCellRotateTransform(value: CGFloat) {
        rotateScale = value
        collection.reloadData()
       
        
    }
    
    func updateShapeMask(shapeItem: AHaniStickerItem) {
        currentShapeItem = shapeItem
        collection.reloadData()
    }
    
    func updateStickerOverlayer(stickerItem: AHaniStickerItem) {
        
    }
    
    
}

extension AHanimaCollectionView {
    // 暂时无用
    func beginRecordVideo(isStart: Bool) {
        if isStart {
            
            inisetupDisplayLink()
            //
            try? FileManager.default.removeItem(at: videoWriter.url)
            videoWriter.start()
            stepCount = 0
            displayLink.isPaused = false
        } else {
            displayLink.isPaused = true
            removeDisplayLink()
            videoWriter.finish { [weak self] in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    debugPrint("0-0-0- video write finished")
                    debugPrint("video path = \(self.videoWriter.url)")
                }
            }
        }

    }
    
    @objc private func refreshDisplayLink(_ link: CADisplayLink) {
        
        stepCount += 1
        uiSource.transmitTexture(with: CMTime(value: stepCount, timescale: 60))
    }
    
    func inisetupDisplayLink() {
        displayLink = CADisplayLink(target: self, selector: #selector(refreshDisplayLink(_:)))
        displayLink.add(to: .main, forMode: .common)
        
    }
    
    func removeDisplayLink() {
        if displayLink != nil {
            displayLink.invalidate()
            displayLink = nil
        }
    }
}

extension AHanimaCollectionView {
    func applicaAnimation(aniType: Int) {
        if aniType == 0 {
            applicaAnimationTypeOriginal()
        } else if aniType == 1 {
            applicaAnimationType1()
        } else if aniType == 2 {
            applicaAnimationType2()
        }
    }
    
    func applicaAnimationTypeOriginal() {
        timer.suspend()
        self.contentBgV.transform = CGAffineTransform.identity
    }
    
    func applicaAnimationType1() {
        
        func animation() {
            DispatchQueue.main.async {
            //
                UIView.animate(withDuration: 1.5, delay: 0, options: .curveEaseInOut) {
                    self.contentBgV.transform = CGAffineTransform(scaleX: 1.4, y: 1.4)
                } completion: { finished in
                    if finished {
                        UIView.animate(withDuration: 1.5, delay: 0, options: .curveEaseInOut) {
                            self.contentBgV.transform = CGAffineTransform.identity
                        } completion: { finished in
                            if finished {
                                
                            }
                        }
                    }
                }
            }
        }
        
        animation()
        timer = SwiftTimer.repeaticTimer(interval: .seconds(3)) {[weak self] _ in
            guard let `self` = self else {return}
            animation()
        }
        timer.start()
        
        
    }
    
    func applicaAnimationType2() {
        
    }
    
    func applicaAnimationType3() {
        
    }
}


extension AHanimaCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withClass: AHanimaPreviewCell.self, for: indexPath)
        cell.contentImgV.image = thumbImg
        //
        if let item_m = currentShapeItem {
            if item_m.big == "ic_phtoto_no" {
                cell.contentImgV.mask = nil
            } else {
                let shapeV = UIImageView(frame: cell.bounds)
                shapeV.image = UIImage(named: item_m.big)
                cell.contentImgV.mask = shapeV
            }
        }
        
        cell.contentImgV.transform = CGAffineTransform(scaleX: itemPaddingScale, y: itemPaddingScale)
        if indexPath.item % 2 == 0 {
            cell.contentImgV.transform = cell.contentImgV.transform.rotated(by: rotateScale * (CGFloat.pi * 2))
        } else {cell.contentImgV.transform = cell.contentImgV.transform.rotated(by: -rotateScale * (CGFloat.pi * 2))
            
        }
        
        if isChangeHang {
            let hangshu = cell.frame.origin.y / cell.bounds.height
            
            if (Int(hangshu) % 2) == 0 {
                cell.transform = CGAffineTransform(translationX: cell.bounds.width * 0, y: cell.bounds.height * 0)
            } else {
                cell.transform = CGAffineTransform(translationX: cell.bounds.width * horTransformScale, y: cell.bounds.height * 0)
            }
        } else if isChangeLie {
            let lieshu = cell.frame.origin.x / cell.bounds.width
            if (Int(lieshu) % 2) == 0 {
                cell.transform = CGAffineTransform(translationX: cell.bounds.width * 0, y: cell.bounds.height * 0)
            } else {
                cell.transform = CGAffineTransform(translationX: cell.bounds.width * 0, y: cell.bounds.height * verTransformScale)
            }
        }
        
        
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemCount
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
}

extension AHanimaCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: itemWidth, height: itemWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}

extension AHanimaCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
    }
}


class AHanimaPreviewCell: UICollectionViewCell {
    let contentImgV = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        contentImgV.contentMode = .scaleAspectFill
        contentImgV.clipsToBounds = true
        contentView.addSubview(contentImgV)
        contentImgV.snp.makeConstraints {
            $0.top.right.bottom.left.equalToSuperview()
        }
        
        
    }
}
