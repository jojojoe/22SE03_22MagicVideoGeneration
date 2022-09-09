//
//  AHanimaBgScreenEditVC.swift
//  AHanimalHilight
//
//  Created by TomSmith on 2022/8/29.
//

import UIKit
import VideoLab
import AVFoundation
import AVKit
import KRProgressHUD


class AHanimaBgScreenEditVC: UIViewController {

    var bgEffectV: AHanimaCollectionView!
    let toolV = AHanimaCollecToolView()
    let addTextAlertV = AHanimaAddTextAlertView()
    let textInputVC = AHanimaVideoAddTextVC()
    var userImg: UIImage
    
    
    init(userImg: UIImage) {
        self.userImg = userImg
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.clipsToBounds = true
        setupBuildContentV()
        setupInputVC()
    }
    
    func setupBuildContentV() {
        bgEffectV = AHanimaCollectionView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), userImg: userImg)
        view.addSubview(bgEffectV)
        bgEffectV.snp.makeConstraints {
            $0.left.top.right.bottom.equalToSuperview()
        }
         
        //
        
        view.addSubview(toolV)
        toolV.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-24)
            $0.left.equalToSuperview().offset(24)
            $0.height.equalTo(340)
        }
        toolV.backClickBlock = {
            [weak self] in
            guard let `self` = self else {return}
            DispatchQueue.main.async {
                if self.navigationController != nil {
                    self.navigationController?.popViewController(animated: true)
                } else {
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
        toolV.nextClickBlock = {
            [weak self] in
            guard let `self` = self else {return}
            DispatchQueue.main.async {
                self.nextBtnClick()
            }
        }
        toolV.shapeCollection.shapeClickItemBlock = {
            [weak self] shapeItem in
            guard let `self` = self else {return}
            DispatchQueue.main.async {
                self.updateMaskShapeItem(item: shapeItem)
            }
        }
        
        toolV.sizeSlideChangeBlock = {
            [weak self] valuem in
            guard let `self` = self else {return}
            DispatchQueue.main.async {
                self.updateCollectionSize(value: valuem)
            }
        }
        toolV.paddingSlideChangeBlock = {
            [weak self] valuem in
            guard let `self` = self else {return}
            DispatchQueue.main.async {
                self.updateCollectionPadding(value: valuem)
            }
        }
        toolV.horSlideChangeBlock = {
            [weak self] valuem in
            guard let `self` = self else {return}
            DispatchQueue.main.async {
                self.updateCollectionHorTransform(value: valuem)
            }
        }
        toolV.verSlideChangeBlock = {
            [weak self] valuem in
            guard let `self` = self else {return}
            DispatchQueue.main.async {
                self.updateCollectionVerTransform(value: valuem)
            }
        }
        toolV.rotateSlideChangeBlock = {
            [weak self] valuem in
            guard let `self` = self else {return}
            DispatchQueue.main.async {
                self.updateCollectionRotateTransform(value: valuem)
            }
        }
        
        //
        addTextAlertV.alpha = 0
        view.addSubview(addTextAlertV)
        addTextAlertV.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-24)
            $0.left.equalToSuperview().offset(24)
            $0.height.equalTo(260)
        }
        addTextAlertV.skipBtnClickBlock = {
            [weak self] in
            guard let `self` = self else {return}
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0) {
                
                KRProgressHUD.show(withMessage: "Processing...")
                self.makeVideoOnly()
            }
            UIView.animate(withDuration: 0.25) { [weak self] in
                guard let `self` = self else {return}
                self.addTextAlertV.alpha = 0
                self.toolV.alpha = 1
            } completion: {[weak self] (finished) in
                guard let `self` = self else {return}
                DispatchQueue.main.async {
                    [weak self] in
                    guard let `self` = self else {return}
                }
            }
        }
        
        addTextAlertV.okBtnClickBlock = {
            [weak self] in
            guard let `self` = self else {return}
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0) {
             
                self.showAddInputView()
            }
            UIView.animate(withDuration: 0.25) { [weak self] in
                guard let `self` = self else {return}
                self.addTextAlertV.alpha = 0
                self.toolV.alpha = 1
            } completion: {[weak self] (finished) in
                guard let `self` = self else {return}
                DispatchQueue.main.async {
                    [weak self] in
                    guard let `self` = self else {return}
                }
            }
            
        }
        
     
    }

    func applicaAnimation(animateType: Int) {
        self.bgEffectV.applicaAnimation(aniType: animateType)
    }
    

    func setupInputVC() {
        
        self.addChild(textInputVC)
        view.addSubview(textInputVC.view)
        textInputVC.view.alpha = 0
        textInputVC.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        textInputVC.cancelClickActionBlock = {
            
            UIView.animate(withDuration: 0.25) { [weak self] in
                guard let `self` = self else {return}
                self.textInputVC.view.alpha = 0
            } completion: {[weak self] (finished) in
                guard let `self` = self else {return}
                DispatchQueue.main.async {
                    [weak self] in
                    guard let `self` = self else {return}
                }
            }
            
            self.textInputVC.finishTextVEdit()
        }
        
        textInputVC.doneClickActionBlock = {
            [weak self] contentStr, fontStr, colorStr, isPro in
            guard let `self` = self else {return}
            DispatchQueue.main.async {
             
                KRProgressHUD.show(withMessage: "Processing...")
                self.makeVideoAndText(textStr: contentStr, fontStr: fontStr, colorStr: colorStr)
                self.textInputVC.finishTextVEdit()
            }
            
            UIView.animate(withDuration: 0.25) { [weak self] in
                guard let `self` = self else {return}
                self.textInputVC.view.alpha = 0
            } completion: {[weak self] (finished) in
                guard let `self` = self else {return}
                DispatchQueue.main.async {
                    [weak self] in
                    guard let `self` = self else {return}
                }
            }
            
            
            
        }
    }
    
    func showAddInputView() {
        self.view.bringSubviewToFront(textInputVC.view)
        textInputVC.startTEdit()
        UIView.animate(withDuration: 0.25) {
            [weak self] in
            guard let `self` = self else {return}
            self.textInputVC.view.alpha = 1
        }
        
    }
}

extension AHanimaBgScreenEditVC {
    func updateCollectionSize(value: Float) {
        bgEffectV.updateRowCount(value: Int(value))
    }
    
    func updateCollectionPadding(value: Float) {
        bgEffectV.updateCellPadding(value: CGFloat(value))
    }
    
    func updateCollectionHorTransform(value: Float) {
        bgEffectV.updateCellHorTransform(value: CGFloat(value))
    }
    
    func updateCollectionVerTransform(value: Float) {
        bgEffectV.updateCellVerTransform(value: CGFloat(value))
    }
    
    func updateCollectionRotateTransform(value: Float) {
        bgEffectV.updateCellRotateTransform(value: CGFloat(value))
    }
    
    func updateMaskShapeItem(item: AHaniStickerItem) {
        self.bgEffectV.updateShapeMask(shapeItem: item)
    }
    
    
}

extension AHanimaBgScreenEditVC {
    func nextBtnClick() {
        
        UIView.animate(withDuration: 0.25) { [weak self] in
            guard let `self` = self else {return}
            self.addTextAlertV.alpha = 1
            self.toolV.alpha = 0
        } completion: {[weak self] (finished) in
            guard let `self` = self else {return}
            DispatchQueue.main.async {
                [weak self] in
                guard let `self` = self else {return}
            }
        }
    }
    
    func makeVideoOnly() {
        let screenImg = self.bgEffectV.processBigPreview().screenshot!
        let videoWidth: CGFloat = screenImg.size.width
        let videoHeight: CGFloat = screenImg.size.height
        debugPrint("screenimg = \(screenImg)")
        
        AnimationVideoManager.shared.transacformImages(images: [screenImg], animationType: .zoomIn, videoFrameWidth: Int(videoWidth), videoFrameHeight: Int(videoHeight), eachImageDuration: 5) {[weak self] url in
            print(url.absoluteString)
            guard let `self` = self else {return}
            DispatchQueue.main.async {
                
                self.processOnlyVideo(url: url)
               
            }
        } failure: { error in
            print(error as Any)
        }
    }
    
    func makeVideoAndText(textStr: String, fontStr: String, colorStr: String) {
        let screenImg = self.bgEffectV.processBigPreview().screenshot!
        let videoWidth: CGFloat = screenImg.size.width
        let videoHeight: CGFloat = screenImg.size.height
        debugPrint("screenimg = \(screenImg)")
        
        AnimationVideoManager.shared.transacformImages(images: [screenImg], animationType: .zoomIn, videoFrameWidth: Int(videoWidth), videoFrameHeight: Int(videoHeight), eachImageDuration: 5) {[weak self] url in
            print(url.absoluteString)
            guard let `self` = self else {return}
            DispatchQueue.main.async {
                KRProgressHUD.dismiss()
                self.processAnimateText(videoURL: url, videoWidth: videoWidth, videoHeight: videoHeight, textStr: textStr, fontStr: fontStr, colorStr: colorStr)
                
            }
        } failure: { error in
            print(error as Any)
        }
    }
}

extension AHanimaBgScreenEditVC {
    func processOnlyVideo(url: URL) {
        let avasset = AVAsset(url: url)
        let vc = AHanimaVideoOnlySaveVC(videoAsset: avasset, videoURL: url)
        self.navigationController?.pushViewController(vc, animated: true)
        KRProgressHUD.dismiss()
    }
}

extension AHanimaBgScreenEditVC {
    func processAnimateText(videoURL: URL, videoWidth: CGFloat, videoHeight: CGFloat, textStr: String, fontStr: String, colorStr: String) {
        // 1. RenderLayer
        
        let asset = AVAsset(url: videoURL)
        let source = AVAssetSource(asset: asset)
        source.selectedTimeRange = CMTimeRange(start: CMTime.zero, duration: asset.duration)
        let timeRange = source.selectedTimeRange
        let renderLayer1 = RenderLayer(timeRange: timeRange, source: source)
        
        // 2. Composition
        let composition = RenderComposition()
        composition.renderSize = CGSize(width: videoWidth, height: videoHeight)
        composition.layers = [renderLayer1]
        composition.animationLayer = makeTextAnimationLayer(videoWidth: videoWidth, videoHeight: videoHeight, textStr: textStr, fontStr: fontStr, colorStr: colorStr)
        
        
        // 3. VideoLab
        let videoLab = VideoLab(renderComposition: composition)
        
        //
        let playerItem = videoLab.makePlayerItem()
        playerItem.seekingWaitsForVideoCompositionRendering = true
        let controller = AHanimaVideoPreviewVC(videoLab: videoLab)
        controller.player = AVPlayer(playerItem: playerItem)
        if let synchronizedLayer = makeSynchronizedLayer(playerItem: playerItem, videoLab: videoLab) {
            controller.view.layer.addSublayer(synchronizedLayer)
        }
        
        navigationController?.pushViewController(controller, animated: true)
        
    }
    
    func makeTextAnimationLayer(videoWidth: CGFloat, videoHeight: CGFloat, textStr: String, fontStr: String, colorStr: String) -> TextOpacityAnimationLayer {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: fontStr, size: 180) ?? UIFont.systemFont(ofSize: 180),
            .foregroundColor: UIColor(hexString: colorStr) ?? UIColor.white,
            .paragraphStyle: paragraphStyle
        ]
        let attributedString = NSAttributedString(string: textStr, attributes: attributes)
        
        let size = attributedString.boundingRect(with: CGSize(width: videoWidth, height: CGFloat.infinity),
                                                 options: .usesLineFragmentOrigin,
                                                 context: nil).size
        
        let layer = TextOpacityAnimationLayer()
        layer.attributedText = attributedString
        layer.position = CGPoint(x: videoWidth/2, y: videoHeight/2)
        layer.bounds = CGRect(origin: CGPoint.zero, size: size)

        return layer
    }
    
    func makeSynchronizedLayer(playerItem: AVPlayerItem, videoLab: VideoLab) -> CALayer? {
        guard let animationLayer = videoLab.renderComposition.animationLayer else {
            return nil
        }

        let synchronizedLayer = AVSynchronizedLayer(playerItem: playerItem)
        synchronizedLayer.addSublayer(animationLayer)
        synchronizedLayer.zPosition = 999
        let videoSize = videoLab.renderComposition.renderSize
        synchronizedLayer.frame = CGRect(origin: CGPoint.zero, size: videoSize)
        
        let screenSize = UIScreen.main.bounds.size
        let videoRect = AVMakeRect(aspectRatio: videoSize, insideRect: CGRect(origin: CGPoint.zero, size: screenSize))
        synchronizedLayer.position = CGPoint(x: videoRect.midX, y: videoRect.midY)
        let scale = fminf(Float(screenSize.width / videoSize.width), Float(screenSize.height / videoSize.height))
        synchronizedLayer.setAffineTransform(CGAffineTransform(scaleX: CGFloat(scale), y: CGFloat(scale)))
        return synchronizedLayer
    }
}

extension AHanimaBgScreenEditVC {
    
}
