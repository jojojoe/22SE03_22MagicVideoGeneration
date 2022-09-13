//
//  AHanimaSettingVC.swift
//  AHanimalHilight
//
//  Created by TomSmith on 2022/9/6.
//

import UIKit
import MessageUI
import KRProgressHUD

class AHanimaSettingVC: UIViewController {
    let feedEmail: String = "arupghoshimapara@gmail.com"
    let appStoreID : String = "835599320"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupSettingView()
    }
    
    func setupSettingView() {
        view.backgroundColor = UIColor(hexString: "#1F1F1F")
        
        //
        let backBtn = UIButton()
        view.addSubview(backBtn)
        backBtn.setImage(UIImage(named: "ic_magic_video_return"), for: .normal)
        backBtn.snp.makeConstraints {
            $0.left.equalToSuperview().offset(12)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            $0.width.equalTo(78/2)
            $0.height.equalTo(100/2)
        }
        backBtn.addTarget(self, action: #selector(backBtnClick(sender: )), for: .touchUpInside)
        
        //
        let emailBtn = UIButton()
        view.addSubview(emailBtn)
        emailBtn.setImage(UIImage(named: "ic_email"), for: .normal)
        emailBtn.snp.makeConstraints {
            $0.right.equalToSuperview().offset(-12)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            $0.width.equalTo(78/2)
            $0.height.equalTo(100/2)
        }
        emailBtn.addTarget(self, action: #selector(emailBtnClick(sender: )), for: .touchUpInside)
        
        //
        let titleNameLabel = UILabel()
        view.addSubview(titleNameLabel)
        titleNameLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(42)
            $0.top.equalTo(backBtn.snp.bottom).offset(24)
            $0.width.height.greaterThanOrEqualTo(10)
        }
        titleNameLabel.font = UIFont(name: "AvenirNext-HeavyItalic", size: 46)
        titleNameLabel.numberOfLines = 0
        titleNameLabel.textColor = UIColor.white
        titleNameLabel.text = "SETTING"
        
        //
        let termsBtn = UIButton()
        view.addSubview(termsBtn)
        termsBtn.setTitleColor(UIColor.white, for: .normal)
        termsBtn.titleLabel?.font = UIFont(name: "AvenirNext-MediumItalic", size: 16)
        termsBtn.contentHorizontalAlignment = .left
        termsBtn.setTitle("TERMS OF USE", for: .normal)
        termsBtn.addTarget(self, action: #selector(termsBtnClick(sender:)), for: .touchUpInside)
        termsBtn.snp.makeConstraints {
            $0.right.equalToSuperview()
            $0.left.equalToSuperview().offset(40)
            $0.top.equalTo(titleNameLabel.snp.bottom).offset(85)
            $0.height.equalTo(60)
        }
        
        //
        let privacyBtn = UIButton()
        view.addSubview(privacyBtn)
        privacyBtn.setTitleColor(UIColor.white, for: .normal)
        privacyBtn.titleLabel?.font = UIFont(name: "AvenirNext-MediumItalic", size: 16)
        privacyBtn.contentHorizontalAlignment = .left
        privacyBtn.setTitle("PRIVACY POLICY", for: .normal)
        privacyBtn.addTarget(self, action: #selector(privacyBtnClick(sender:)), for: .touchUpInside)
        privacyBtn.snp.makeConstraints {
            $0.right.equalToSuperview()
            $0.left.equalToSuperview().offset(40)
            $0.top.equalTo(termsBtn.snp.bottom).offset(0)
            $0.height.equalTo(60)
        }
        
        //
        let shareAppBtn = UIButton()
        view.addSubview(shareAppBtn)
        shareAppBtn.setTitleColor(UIColor.white, for: .normal)
        shareAppBtn.titleLabel?.font = UIFont(name: "AvenirNext-MediumItalic", size: 16)
        shareAppBtn.contentHorizontalAlignment = .left
        shareAppBtn.setTitle("SHARE APP", for: .normal)
        shareAppBtn.addTarget(self, action: #selector(shareAppBtnClick(sender:)), for: .touchUpInside)
        shareAppBtn.snp.makeConstraints {
            $0.right.equalToSuperview()
            $0.left.equalToSuperview().offset(40)
            $0.top.equalTo(privacyBtn.snp.bottom).offset(0)
            $0.height.equalTo(60)
        }
        
        //
        let rateBtn = UIButton()
        view.addSubview(rateBtn)
        rateBtn.setTitleColor(UIColor.white, for: .normal)
        rateBtn.titleLabel?.font = UIFont(name: "AvenirNext-MediumItalic", size: 16)
        rateBtn.contentHorizontalAlignment = .left
        rateBtn.setTitle("RATE US", for: .normal)
        rateBtn.addTarget(self, action: #selector(rateBtnClick(sender:)), for: .touchUpInside)
        rateBtn.snp.makeConstraints {
            $0.right.equalToSuperview()
            $0.left.equalToSuperview().offset(40)
            $0.top.equalTo(shareAppBtn.snp.bottom).offset(0)
            $0.height.equalTo(60)
        }
        
        //
        let line1 = UIView()
        view.addSubview(line1)
        line1.backgroundColor = UIColor.white.withAlphaComponent(0.4)
        line1.snp.makeConstraints {
            $0.right.equalToSuperview()
            $0.bottom.equalTo(termsBtn.snp.bottom)
            $0.height.equalTo(1)
            $0.left.equalToSuperview().offset(40)
        }
        //
        let line2 = UIView()
        view.addSubview(line2)
        line2.backgroundColor = UIColor.white.withAlphaComponent(0.4)
        line2.snp.makeConstraints {
            $0.right.equalToSuperview()
            $0.bottom.equalTo(privacyBtn.snp.bottom)
            $0.height.equalTo(1)
            $0.left.equalToSuperview().offset(40)
        }
        //
        let line3 = UIView()
        view.addSubview(line3)
        line3.backgroundColor = UIColor.white.withAlphaComponent(0.4)
        line3.snp.makeConstraints {
            $0.right.equalToSuperview()
            $0.bottom.equalTo(shareAppBtn.snp.bottom)
            $0.height.equalTo(1)
            $0.left.equalToSuperview().offset(40)
        }
        //
        let line4 = UIView()
        view.addSubview(line4)
        line4.backgroundColor = UIColor.white.withAlphaComponent(0.4)
        line4.snp.makeConstraints {
            $0.right.equalToSuperview()
            $0.bottom.equalTo(rateBtn.snp.bottom)
            $0.height.equalTo(1)
            $0.left.equalToSuperview().offset(40)
        }
        
        
    }
    
    
    @objc func backBtnClick(sender: UIButton) {
        if self.navigationController != nil {
            self.navigationController?.popViewController(animated: true)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func emailBtnClick(sender: UIButton) {
        feedback()
    }
    
    @objc func privacyBtnClick(sender: UIButton) {
        let vc = AHanimaTermsPrivateVC()
        vc.contentTextView.text = priStr_Info
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func shareAppBtnClick(sender: UIButton) {
        let url = "https://apps.apple.com/us/app/id\(appStoreID)"
        let vc = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        self.present(vc, animated: true)
    }
    
    @objc func termsBtnClick(sender: UIButton) {
        let vc = AHanimaTermsPrivateVC()
        vc.contentTextView.text = termsStr_Info
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func rateBtnClick(sender: UIButton) {
        let urlStr = "https://itunes.apple.com/us/app/itunes-u/id\(appStoreID)?action=write-review&mt=8"
        if let url = URL(string: urlStr) {
            UIApplication.shared.open(url, options: [:]) { _ in
                
            }
        }
    }
    
}
extension AHanimaSettingVC: MFMailComposeViewControllerDelegate {
    func feedback() {
     
        if MFMailComposeViewController.canSendMail(){
        
            let systemVersion = UIDevice.current.systemVersion
            let modelName = UIDevice.current.modelName
            let infoDic = Bundle.main.infoDictionary
            
            let appVersion = infoDic?["CFBundleShortVersionString"] ?? "1.8.8"
            
            let appName = "\(AppName)"
            
            
            let controller = MFMailComposeViewController()
             
            controller.mailComposeDelegate = self
            
            controller.setSubject("\(appName) Feedback")
           
            controller.setToRecipients([feedEmail])
          
            controller.setMessageBody("\n\n\nSystem Version：\(systemVersion)\n Device Name：\(modelName)\n App Name：\(appName)\n App Version：\(appVersion )", isHTML: false)
            
      
            self.present(controller, animated: true, completion: nil)
        } else {
            KRProgressHUD.showError(withMessage: "The device doesn't support email")
            
        }
    }
     
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}
extension UIDevice {
    
    var identifier: String {
        
        var systemInfo = utsname()
        uname(&systemInfo)
        
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        return identifier
    }
    var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        switch identifier {
        case "iPod1,1":  return "iPod Touch 1"
        case "iPod2,1":  return "iPod Touch 2"
        case "iPod3,1":  return "iPod Touch 3"
        case "iPod4,1":  return "iPod Touch 4"
        case "iPod5,1":  return "iPod Touch 5"
        case "iPod7,1":  return "iPod Touch 6"
            
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":  return "iPhone 4"
        case "iPhone4,1":  return "iPhone 4s"
        case "iPhone5,1":  return "iPhone 5"
        case "iPhone5,2":  return "iPhone 5"
        case "iPhone5,3", "iPhone5,4":  return "iPhone 5c"
        case "iPhone6,1", "iPhone6,2":  return "iPhone 5s"
        case "iPhone7,2":  return "iPhone 6"
        case "iPhone7,1":  return "iPhone 6 Plus"
        case "iPhone8,1":  return "iPhone 6s"
        case "iPhone8,2":  return "iPhone 6s Plus"
        case "iPhone8,4":  return "iPhone SE"
        case "iPhone9,1", "iPhone9,3":  return "iPhone 7"
        case "iPhone9,2", "iPhone9,4":  return "iPhone 7 Plus"
        case "iPhone10,1", "iPhone10,4": return "iPhone 8"
        case "iPhone10,2", "iPhone10,5": return "iPhone 8 Plus"
        case "iPhone10,3", "iPhone10,6": return "iPhone X"
        case "iPhone11,2" : return "iPhone_XS"
        case "iPhone11,4" : return "iPhone_XS_Max"
        case "iPhone11,6" : return "iPhone_XS_Max"
        case "iPhone11,8" : return "iPhone_XR"
        case "iPhone12,1" : return "iPhone_11"
        case "iPhone12,3" : return "iPhone_11_Pro"
        case "iPhone12,5" : return "iPhone_11_Pro_Max"
        case "iPhone12,8" : return "iPhone_SE2"
        case "iPhone13,1" : return "iPhone_12_mini"
        case "iPhone13,2" : return "iPhone_12"
        case "iPhone13,3" : return "iPhone_12_Pro"
        case "iPhone13,4" : return "iPhone_12_Pro_Max"
        case "iPhone14,4" : return "iPhone_13_mini"
        case "iPhone14,5" : return "iPhone_13"
        case "iPhone14,2" : return "iPhone_13_Pro"
        case "iPhone14,3" : return "iPhone_13_Pro_Max"
            
        case "iPad1,1": return "iPad"
        case "iPad1,2": return "iPad 3G"
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":  return "iPad 2"
        case "iPad2,5", "iPad2,6", "iPad2,7":  return "iPad Mini"
        case "iPad3,1", "iPad3,2", "iPad3,3":  return "iPad 3"
        case "iPad3,4", "iPad3,5", "iPad3,6":  return "iPad 4"
        case "iPad4,1", "iPad4,2", "iPad4,3":  return "iPad Air"
        case "iPad4,4", "iPad4,5", "iPad4,6":  return "iPad Mini 2"
        case "iPad4,7", "iPad4,8", "iPad4,9":  return "iPad Mini 3"
        case "iPad5,1", "iPad5,2":  return "iPad Mini 4"
        case "iPad5,3", "iPad5,4":  return "iPad Air 2"
        case "iPad6,3", "iPad6,4":  return "iPad Pro 9.7"
        case "iPad6,7", "iPad6,8":  return "iPad Pro 12.9"
            
        case "AppleTV2,1":  return "Apple TV 2"
        case "AppleTV3,1","AppleTV3,2":  return "Apple TV 3"
        case "AppleTV5,3":  return "Apple TV 4"
            
        case "i386", "x86_64":  return "Simulator"
            
        default:  return identifier
        }
    }
    
}
