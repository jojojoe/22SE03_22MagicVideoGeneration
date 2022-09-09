//
//  AHanimaVideoOnlySaveVC.swift
//  AHanimalHilight
//
//  Created by TomSmith on 2022/9/7.
//

import UIKit
import AVFoundation
import MobileCoreServices
import AVKit
import Photos
import MediaPlayer
import KRProgressHUD

class AHanimaVideoOnlySaveVC: UIViewController {
    var avItem: AVPlayerItem?
    var videoAsset: AVAsset
    var videoURL: URL
    var avplayer = AVPlayer()
    var playerController = AVPlayerViewController()
    var viewDidLayoutOnce: Once = Once()
    
    let backBtn = UIButton()
    let exportBtn = UIButton()
    let bottomBanner = UIView()
    
    init(videoAsset: AVAsset, videoURL: URL) {
        self.videoAsset = videoAsset
        self.videoURL = videoURL
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupVideoPreview()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        viewDidLayoutOnce.run {
            self.setupPlayer()
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        view.bringSubviewToFront(bottomBanner)
    }

}

extension AHanimaVideoOnlySaveVC {
    func setupVideoPreview() {
        view.backgroundColor = UIColor.black
        view.clipsToBounds = true
        
        
        view.addSubview(bottomBanner)
        bottomBanner.snp.makeConstraints {
            $0.left.equalToSuperview().offset(6)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(view.snp.top).offset(24)
//            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-6)
            $0.height.equalTo(188/2)
        }
        //
        let bannerImgV = UIImageView()
        bannerImgV.image = UIImage(named: "ic_preview_video")
        bottomBanner.addSubview(bannerImgV)
        bannerImgV.snp.makeConstraints {
            $0.left.right.top.bottom.equalToSuperview()
        }
        
        //
        bottomBanner.addSubview(backBtn)
        backBtn.setImage(UIImage(named: "ic_magic_video_return"), for: .normal)
        backBtn.snp.makeConstraints {
            $0.left.equalToSuperview().offset(20)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(37)
            $0.height.equalTo(48)
        }
        backBtn.addTarget(self, action: #selector(bBtnClick(sender: )), for: .touchUpInside)
        //
        
        bottomBanner.addSubview(exportBtn)
        exportBtn.setImage(UIImage(named: "ic_next_step"), for: .normal)
        exportBtn.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.right.equalToSuperview().offset(-20)
            $0.width.equalTo(34)
            $0.height.equalTo(34)
        }
        exportBtn.addTarget(self, action: #selector(sBtnClick(sender: )), for: .touchUpInside)
        
        //
        let titleNameLabel = UILabel()
        bottomBanner.addSubview(titleNameLabel)
        titleNameLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalTo(backBtn.snp.centerY)
            $0.width.height.greaterThanOrEqualTo(10)
        }
        titleNameLabel.font = UIFont(name: "Helvetica-Bold", size: 16)
        titleNameLabel.numberOfLines = 0
        titleNameLabel.textColor = UIColor.white
        titleNameLabel.text = "PREVIEW"
        
        
        
    }
    
    func setupPlayer() {
        
        let avItem = AVPlayerItem(asset: videoAsset)
        self.avItem = avItem
        self.avplayer = AVPlayer(playerItem: avItem)
        playerController.player = self.avplayer
        self.addChild(playerController)
        view.addSubview(playerController.view)
        playerController.showsPlaybackControls = false
        
        //
        let vheight: CGFloat = view.frame.maxY
        playerController.view.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: vheight)
        
        self.avplayer.play()
        
        NotificationCenter.default.addObserver(self, selector: #selector(playerItemDidPlayToEndTimeNotification(notifi: )), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: avItem)
    }

    @objc func playerItemDidPlayToEndTimeNotification(notifi: Notification) {
        debugPrint("save vc reset play")
        if let playerItem = notifi.object as? AVPlayerItem {
            if let avitem = self.avItem ,avitem == playerItem {
                resetPlay()
            }
        }
    }
    
    func resetPlay() {
        seek(to: CMTime.zero) { (isFinished) in
            if isFinished {
                self.avplayer.play()
            }
        }
    }
    
    func seek(to time: CMTime, comletion: ((Bool) -> Void)? = nil) {
        self.avplayer.seek(to: time, toleranceBefore: .zero, toleranceAfter: .zero) { (isFinished) in
            comletion?(isFinished)
        }
    }
}

extension AHanimaVideoOnlySaveVC {
    @objc func bBtnClick(sender: UIButton) {
        if self.navigationController != nil {
            self.navigationController?.popViewController(animated: true)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    @objc func sBtnClick(sender: UIButton) {
        
        KRProgressHUD.show()
        let manager = PHPhotoLibrary.shared()
        manager.performChanges {
            PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: self.videoURL)
        } completionHandler: {[weak self] success, error in
            guard let `self` = self else {return}
            DispatchQueue.main.async {
                KRProgressHUD.dismiss()
                if success {
                    self.showSaveAlert(alertStr: "Saved Successfully!")
                } else {
                    self.showSaveAlert(alertStr: "Failed to save, please try again.")
                }
            }
        }

    }
   
    func showSaveAlert(alertStr: String) {
        let alert = UIAlertController(title: alertStr, message: "", preferredStyle: .alert)
        let homeAction = UIAlertAction(title: "New one", style: .default) { _ in
            DispatchQueue.main.async {
                self.navigationController?.popToRootViewController(animated: true)
            }
        }
        let againAction = UIAlertAction(title: "重新制作", style: .default) { _ in
            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)
            }
        }
        alert.addAction(homeAction)
        alert.addAction(againAction)
        self.present(alert, animated: true)
    }
}


