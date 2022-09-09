//
//  AHaniHomeVC.swift
//  AHanimalHilight
//
//  Created by TomSmith on 2022/8/29.
//

import UIKit
import SnapKit
import YPImagePicker
import KRProgressHUD
import Photos

class AHaniHomeVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        makeViewControllerView()
    }
    
    
    

}

extension AHaniHomeVC {
    func makeViewControllerView() {
        view.clipsToBounds = true
        view.backgroundColor = UIColor(hexString: "#1F1F1F")!
        
        //
        let settingBtn = UIButton()
        view.addSubview(settingBtn)
        settingBtn.setImage(UIImage(named: "ic_setting_center"), for: .normal)
        settingBtn.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.right.equalTo(view.safeAreaLayoutGuide.snp.right).offset(-10)
            $0.width.equalTo(78/2)
            $0.height.equalTo(100/2)
        }
        settingBtn.addTarget(self, action: #selector(settingBtnClick(sender: )), for: .touchUpInside)
        //
        let type1Btn = UIButton()
        type1Btn.setBackgroundImage(UIImage(named: "ic_add_photo"), for: .normal)
        type1Btn.setTitle("+", for: .normal)
        type1Btn.setTitleColor(UIColor.black, for: .normal)
        type1Btn.titleLabel?.font = UIFont(name: "AmericanTypewriter-Light", size: 120)
        view.addSubview(type1Btn)
        type1Btn.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.left.equalToSuperview().offset(30)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-30)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(240)
        }
        type1Btn.addTarget(self, action: #selector(type1BtnClick(sender:)), for: .touchUpInside)
        
        //
        let titleNameLabel = UILabel()
        view.addSubview(titleNameLabel)
        titleNameLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(42)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(80)
            $0.width.height.greaterThanOrEqualTo(10)
        }
        titleNameLabel.font = UIFont(name: "AvenirNext-HeavyItalic", size: 46)
        titleNameLabel.numberOfLines = 0
        titleNameLabel.textColor = UIColor.white
        titleNameLabel.text = "SELECT\nYOUR\nPHOTO"
    }
    
    
    @objc func type1BtnClick(sender: UIButton) {
        checkPhotoAlbum()
    }
    @objc func settingBtnClick(sender: UIButton) {
        self.navigationController?.pushViewController(AHanimaSettingVC(), animated: true)
    }
    
}

extension AHaniHomeVC {
    func showScreenEditVC(img: UIImage) {
        let vc = AHanimaBgScreenEditVC(userImg: img)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension AHaniHomeVC {
    
    func checkPhotoAlbum() {
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            if #available(iOS 14, *) {
                PHPhotoLibrary.requestAuthorization(for: .readWrite) { status in
                    switch status {
                    case .authorized:
                        DispatchQueue.main.async {

                            self.showPhotosGallery()
                        }
                    case .limited:
                        DispatchQueue.main.async {
                            self.showPhotosGallery()
                        }
                    case .notDetermined:
                        if status == PHAuthorizationStatus.authorized {
                            DispatchQueue.main.async {

                                self.showPhotosGallery()
                            }
                        } else if status == PHAuthorizationStatus.limited {
                            DispatchQueue.main.async {
                                self.showPhotosGallery()
                            }
                        }
                    case .denied:
                        DispatchQueue.main.async {
                            [weak self] in
                            guard let `self` = self else {return}
                            self.showDeclinedAlert()
                        }
                        
                    case .restricted:
                        DispatchQueue.main.async {
                            [weak self] in
                            guard let `self` = self else {return}
                            self.showDeclinedAlert()
                        }
                    default: break
                    }
                }
            } else {
                
                PHPhotoLibrary.requestAuthorization { status in
                    switch status {
                    case .authorized:
                        DispatchQueue.main.async {
                            self.showPhotosGallery()
                        }
                    case .limited:
                        DispatchQueue.main.async {
                            self.showPhotosGallery()
                        }
                    case .denied:
                        DispatchQueue.main.async {
                            [weak self] in
                            guard let `self` = self else {return}
                            self.showDeclinedAlert()
                        }
                        
                    case .restricted:
                        DispatchQueue.main.async {
                            [weak self] in
                            guard let `self` = self else {return}
                            self.showDeclinedAlert()
                        }
                    default: break
                    }
                }
                
            }
        }
    }
    func showDeclinedAlert() {
        let alert = UIAlertController(title: "Oops", message: "You have declined access to photos, please active it in Settings>Privacy>Photos.", preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "Ok", style: .default, handler: { (goSettingAction) in
            DispatchQueue.main.async {
                let url = URL(string: UIApplication.openSettingsURLString)!
                UIApplication.shared.open(url, options: [:])
            }
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(confirmAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true)
    }
    
    
    func showPhotosGallery() {
        var config = YPImagePickerConfiguration()
        config.library.mediaType = .photo
        config.screens = [.library]
        config.library.maxNumberOfItems = 1
        config.library.defaultMultipleSelection = false
        config.library.skipSelectionsGallery = true
        config.library.isSquareByDefault = true
        config.showsPhotoFilters = false
        config.library.preselectedItems = nil
        let pickerVC = YPImagePicker(configuration: config)
        pickerVC.view.backgroundColor = UIColor(hexString: "#323233")
        pickerVC.didFinishPicking { [unowned pickerVC] items, cancelled in
            var imgs: [UIImage] = []
            for item in items {
                switch item {
                case .photo(let photo):
                    if let img = photo.image.scaled(toWidth: 1600) {
                        imgs.append(img)
                    }
                    print(photo)
                    
                case .video(let video):
                    print(video)
                    
                }
            }
            pickerVC.dismiss(animated: true, completion: nil)
            if !cancelled {
                if let image = imgs.first {
                    self.showScreenEditVC(img: image)
                }
            }
        }
        
        present(pickerVC, animated: true, completion: nil)
    }
    
    
}
