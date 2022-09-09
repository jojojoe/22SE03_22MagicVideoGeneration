//
//  AHanimaAddTextAlertView.swift
//  AHanimalHilight
//
//  Created by TomSmith on 2022/9/6.
//

import UIKit

class AHanimaAddTextAlertView: UIView {

    var skipBtnClickBlock: (()->Void)?
    var okBtnClickBlock: (()->Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupContent()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupContent() {
        backgroundColor = UIColor(hexString: "#D8D8D8")
        //
        layer.cornerRadius = 12
        layer.masksToBounds = true
        //
        let bgImgV = UIImageView()
        bgImgV.image = UIImage(named: "ic_add_photo")
        bgImgV.contentMode = .scaleAspectFill
        addSubview(bgImgV)
        bgImgV.snp.makeConstraints {
            $0.left.right.top.bottom.equalToSuperview()
        }
        
        //
        let imgV = UIImageView()
        addSubview(imgV)
        imgV.image = UIImage(named: "ic_no_yes_text")
        imgV.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(30)
            $0.width.height.equalTo(58)
        }
        //
        let contentTextLabel = UILabel()
        addSubview(contentTextLabel)
        contentTextLabel.font = UIFont(name: "Helvetica", size: 16)
        contentTextLabel.textColor = .black
        contentTextLabel.text = "Whether you need to add text, add text and click OK to jump to the text editing page"
        contentTextLabel.textAlignment = .center
        contentTextLabel.numberOfLines = 0
        contentTextLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.left.equalTo(50)
            $0.height.greaterThanOrEqualTo(10)
            $0.top.equalTo(imgV.snp.bottom).offset(10)
            $0.bottom.equalToSuperview().offset(-100)
        }
        
        //
        let skipBtn = UIButton()
        skipBtn.setTitle("SKIP", for: .normal)
        skipBtn.setTitleColor(UIColor.black, for: .normal)
        skipBtn.titleLabel?.font = UIFont(name: "Helvetica", size: 16)
        addSubview(skipBtn)
        skipBtn.layer.borderColor = UIColor.black.cgColor
        skipBtn.layer.borderWidth = 1
        skipBtn.layer.cornerRadius = 12
        skipBtn.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-23)
            $0.right.equalTo(self.snp.centerX).offset(-10)
            $0.width.equalTo(140)
            $0.height.equalTo(48)
        }
        skipBtn.addTarget(self, action: #selector(skipBtnClick(sender: )), for: .touchUpInside)
        
        //
        let okBtn = UIButton()
        okBtn.setTitle("OK", for: .normal)
        okBtn.setTitleColor(UIColor.white, for: .normal)
        okBtn.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 16)
        addSubview(okBtn)
        okBtn.backgroundColor = UIColor.black
        okBtn.layer.cornerRadius = 12
        okBtn.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-23)
            $0.left.equalTo(self.snp.centerX).offset(10)
            $0.width.equalTo(140)
            $0.height.equalTo(48)
        }
        okBtn.addTarget(self, action: #selector(okBtnClick(sender: )), for: .touchUpInside)
        
        
    }
    
    @objc func skipBtnClick(sender: UIButton) {
        skipBtnClickBlock?()
        
    }
    
    @objc func okBtnClick(sender: UIButton) {
        okBtnClickBlock?()
    }
    
}
