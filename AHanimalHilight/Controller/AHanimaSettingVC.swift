//
//  AHanimaSettingVC.swift
//  AHanimalHilight
//
//  Created by TomSmith on 2022/9/6.
//

import UIKit

class AHanimaSettingVC: UIViewController {

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
        termsBtn.setTitle("INSTRUCTIONS FOR USE", for: .normal)
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
        privacyBtn.setTitle("PRIVACY AGREEMENT", for: .normal)
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
        
    }
    
    @objc func privacyBtnClick(sender: UIButton) {
        
    }
    
    @objc func shareAppBtnClick(sender: UIButton) {
        
    }
    
    @objc func termsBtnClick(sender: UIButton) {
        
    }
    
    @objc func rateBtnClick(sender: UIButton) {
        
    }
    
}
