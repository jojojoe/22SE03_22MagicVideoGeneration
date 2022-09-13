//
//  AHanimaVideoPreviewVC.swift
//  AHanimalHilight
//
//  Created by TomSmith on 2022/9/5.
//

import UIKit
import AVKit
import AVFoundation
import Photos
import VideoLab
import KRProgressHUD

class AHanimaVideoPreviewVC: AVPlayerViewController {
    var videoLab: VideoLab
    var exportSession: AVAssetExportSession?
    let backBtn = UIButton()
    let exportBtn = UIButton()
    let bottomBanner = UIView()
    
    
    init(videoLab: VideoLab) {
        self.videoLab = videoLab
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationItem()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.view.bringSubviewToFront(bottomBanner)
        
    }
    
    // MARK: - Private
    @objc func backBtnClick(sender: UIButton) {
        if self.navigationController != nil {
            self.navigationController?.popViewController(animated: true)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    @objc func saveBtnClick(sender: UIButton) {
        saveAction()
    }
    
    func setupNavigationItem() {
        self.showsPlaybackControls = true
        self.player?.play()
        view.addSubview(bottomBanner)
        bottomBanner.snp.makeConstraints {
            $0.left.equalToSuperview().offset(6)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(view.snp.top).offset(24)
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
        backBtn.setImage(UIImage(named: "ic_magic_video_return"), for: .normal)
        bottomBanner.addSubview(backBtn)
        backBtn.snp.makeConstraints {
            $0.left.equalToSuperview().offset(20)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(37)
            $0.height.equalTo(48)
        }
        backBtn.addTarget(self, action: #selector(backBtnClick(sender: )), for: .touchUpInside)
        //
        
        bottomBanner.addSubview(exportBtn)
        exportBtn.setImage(UIImage(named: "ic_next_step"), for: .normal)
        exportBtn.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.right.equalToSuperview().offset(-20)
            $0.width.equalTo(34)
            $0.height.equalTo(34)
        }
        exportBtn.addTarget(self, action: #selector(saveBtnClick(sender: )), for: .touchUpInside)
        
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
        
//        NotificationCenter.default.addObserver(self, selector: #selector(playerItemDidPlayToEndTimeNotification(notifi: )), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: self.player?.currentItem)
    }
    
//    @objc func playerItemDidPlayToEndTimeNotification(notifi: Notification) {
//        debugPrint("save vc reset play")
//        if let playerItem = notifi.object as? AVPlayerItem {
//            if let avitem = self.player?.currentItem ,avitem == playerItem {
//                resetPlay()
//            }
//        }
//    }
    
    
//    func resetPlay() {
//        seek(to: CMTime.zero) { (isFinished) in
//            if isFinished {
//                self.player?.play()
//            }
//        }
//    }
//
//    func seek(to time: CMTime, comletion: ((Bool) -> Void)? = nil) {
//        self.player?.seek(to: time, toleranceBefore: .zero, toleranceAfter: .zero) { (isFinished) in
//            comletion?(isFinished)
//        }
//    }
    
    func saveAction() {
        self.player?.pause()
        requestLibraryAuthorization { [weak self] (status) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                KRProgressHUD.show()
            }
            self.exportVideo()
        }
    }
    
    func exportVideo() {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return
        }
        
        let outputURL = documentDirectory.appendingPathComponent("demo.mp4")
        if FileManager.default.fileExists(atPath: outputURL.path) {
            do {
                try FileManager.default.removeItem(at: outputURL)
            } catch {
            }
        }
        
        exportSession = videoLab.makeExportSession(presetName: AVAssetExportPresetHighestQuality, outputURL: outputURL)
        exportSession?.exportAsynchronously(completionHandler: {
            DispatchQueue.main.async {
                KRProgressHUD.dismiss()
                switch self.exportSession?.status {
                case .completed:
                    
                    self.saveFileToAlbum(outputURL)
                    print("export completed")
                    self.showSaveAlert(alertStr: "Saved Successfully!")
                    
                case .failed:
                    print("export failed")
                    self.showSaveAlert(alertStr: "Saved Failed!")
                case .cancelled:
                    print("export cancelled")
                default:
                    print("export")
                }
            }
            
        })
    }
    
    func requestLibraryAuthorization(_ handler: @escaping (PHAuthorizationStatus) -> Void) {
        let status = PHPhotoLibrary.authorizationStatus()
        if status == .authorized {
            handler(status)
        } else {
            PHPhotoLibrary.requestAuthorization { (status) in
                DispatchQueue.main.async {
                    handler(status)
                }
            }
        }
    }
    
    func saveFileToAlbum(_ fileURL: URL, handler: ((Bool, Error?) -> Void)? = nil) {
        PHPhotoLibrary.shared().performChanges({
            PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: fileURL)
        }) { (saved, error) in
            if let handler = handler {
                handler(saved, error)
            }
        }
    }
    
    
     func showSaveAlert(alertStr: String) {
         let alert = UIAlertController(title: alertStr, message: "", preferredStyle: .alert)
         let homeAction = UIAlertAction(title: "Remake", style: .default) { _ in
             DispatchQueue.main.async {
                 self.navigationController?.popToRootViewController(animated: true)
             }
         }
//         let againAction = UIAlertAction(title: "重新制作", style: .default) { _ in
//             DispatchQueue.main.async {
//                 self.navigationController?.popViewController(animated: true)
//             }
//         }
         alert.addAction(homeAction)
//         alert.addAction(againAction)
         self.present(alert, animated: true)
     }
}
