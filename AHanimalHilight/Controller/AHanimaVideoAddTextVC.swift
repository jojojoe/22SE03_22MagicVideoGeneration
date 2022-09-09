//
//  AHanimaVideoAddTextVC.swift
//  AHanimalHilight
//
//  Created by TomSmith on 2022/9/5.
//

import UIKit
import SnapKit
import KRProgressHUD
import DeviceKit

let maxLableCount: Int = 50


class AHanimaVideoAddTextVC: UIViewController {
    let contentV = UIView()
    var limitLabel: UILabel = UILabel.init(text: "0/\(maxLableCount)")
    let textFontBar = AHanimaFontCollection()
    let textColorBar = AHanimaColorCollection()
    var conTextView = UITextView()
    var cancelClickActionBlock: (()->Void)?
    var doneClickActionBlock: ((_ content: String, _ fontStr: String, _ colorStr: String, Bool)->Void)?
    
    var currentColorStr: String = ""
    var currentFontNameStr: String = ""
    

    let colorBtn = UIButton()
    let fontBtn = UIButton()
    let backBtn = UIButton()
    let doneBtn = UIButton()
    var cancelBtn = UIButton()
    
    // Public
    var contentText: String = "" {
        didSet {
            updateLimitTextLabel(contentText: contentText)
        }
    }
    //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registKeyboradNotification()
        currentColorStr = AHaniManager.default.colorStrList.first ?? "#FFFFFF"
        currentFontNameStr = AHaniManager.default.fontStrList.first ?? "AvenirNext-Regular"
        setupTextViewNotification()
        setupView()
        fontBtnClick(btn: fontBtn)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    func registKeyboradNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification , object:nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification , object:nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        let keyboardHeight = (notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.height
        print(keyboardHeight)
        contentV.snp.remakeConstraints {
            $0.left.right.equalToSuperview()
            $0.height.equalTo(110)
            $0.bottom.equalTo(view.snp.bottom).offset(-keyboardHeight)
        }
        
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        let keyboardHeight = (notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.height
        print(keyboardHeight)
        
    }
    
    
    
}

extension AHanimaVideoAddTextVC {
    func updateDefaultShowStatus(fontName: String, textColor: String) {
        currentColorStr = textColor
        currentFontNameStr = fontName
        self.textFontBar.currentFontStr = fontName
        self.textFontBar.collection.reloadData()
        self.textColorBar.currentColorItem = textColor
        self.textColorBar.collection.reloadData()
    }
}

extension AHanimaVideoAddTextVC {
    
    func setupView() {
        view.backgroundColor = UIColor(hexString: "#000000")!.withAlphaComponent(0.5)
        //
        
        contentV.backgroundColor = UIColor(hexString: "#1F1F1F")
        view.addSubview(contentV)
        contentV.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.height.equalTo(110)
            $0.bottom.equalTo(view.snp.bottom).offset(0)
        }
        //
        contentV.addSubview(cancelBtn)
        cancelBtn.setImage(UIImage(named: "ic_close_text"), for: .normal)
        cancelBtn.addTarget(self, action: #selector(cancelBtnClick(btn:)), for: .touchUpInside)
        cancelBtn.snp.makeConstraints {
            $0.left.equalToSuperview().offset(5)
            $0.bottom.equalToSuperview()
            $0.width.height.equalTo(44)
        }
        //
        contentV.addSubview(doneBtn)
        doneBtn.setImage(UIImage(named: "ic_done_text"), for: .normal)
        doneBtn.addTarget(self, action: #selector(doneBtnClick(btn:)), for: .touchUpInside)
        doneBtn.snp.makeConstraints {
            $0.right.equalToSuperview().offset(-5)
            $0.bottom.equalToSuperview()
            $0.width.height.equalTo(44)
        }
        
        //
        let btnBgV = UIView()
        btnBgV.backgroundColor = UIColor(hexString: "#323233")
        contentV.addSubview(btnBgV)
        btnBgV.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalTo(cancelBtn.snp.centerY)
            $0.width.equalTo(116)
            $0.height.equalTo(28)
        }
        btnBgV.layer.cornerRadius = 8
        btnBgV.clipsToBounds = true
        //
        btnBgV.addSubview(fontBtn)
        fontBtn.snp.makeConstraints {
            $0.left.equalToSuperview()
            $0.top.bottom.equalToSuperview()
            $0.width.equalTo(58)
        }
        fontBtn.setTitle("Font", for: .normal)
        fontBtn.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 12)
        fontBtn.setTitleColor(UIColor(hexString: "#1F1F1F"), for: .selected)
        fontBtn.setTitleColor(UIColor(hexString: "#FFFFFF"), for: .normal)
        fontBtn.backgroundColor = UIColor(hexString: "#ECF7FF")
        fontBtn.layer.cornerRadius = 8
        fontBtn.addTarget(self, action: #selector(fontBtnClick(btn: )), for: .touchUpInside)
        
        //
        btnBgV.addSubview(colorBtn)
        colorBtn.snp.makeConstraints {
            $0.right.equalToSuperview()
            $0.top.bottom.equalToSuperview()
            $0.width.equalTo(58)
        }
        colorBtn.setTitle("Color", for: .normal)
        colorBtn.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 12)
        colorBtn.setTitleColor(UIColor(hexString: "#1F1F1F"), for: .selected)
        colorBtn.setTitleColor(UIColor(hexString: "#FFFFFF"), for: .normal)
        colorBtn.backgroundColor = UIColor(hexString: "#323233")
        colorBtn.layer.cornerRadius = 8
        colorBtn.addTarget(self, action: #selector(colorBtnClick(btn: )), for: .touchUpInside)
        //
        contentV.addSubview(textFontBar)
        textFontBar.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.equalToSuperview().offset(0)
            $0.height.equalTo(64)
        }
        textFontBar.fontDidSelectBlock = {
            [weak self] fontName, indexP in
            guard let `self` = self else {return}
            DispatchQueue.main.async {
                self.conTextView.font = UIFont(name: fontName, size: 40)
                self.currentFontNameStr = fontName
            }
        }
        //
        fontBtn.isSelected = true
        colorBtn.isSelected = true
        //
        contentV.addSubview(textColorBar)
        textColorBar.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.equalToSuperview().offset(0)
            $0.height.equalTo(64)
        }
        textColorBar.colorSelectBlock = {
            [weak self] colorString, pro in
            guard let `self` = self else {return}
            DispatchQueue.main.async {
                self.conTextView.textColor = UIColor(hexString: colorString)
                self.currentColorStr = colorString
            }
        }
        //
        self.conTextView.font = UIFont(name: currentFontNameStr, size: 40)
        self.conTextView.textColor = UIColor(hexString: currentColorStr)
        conTextView.text = ""
        conTextView.returnKeyType = .default
        conTextView.backgroundColor = UIColor.clear
        conTextView.delegate = self
        conTextView.textAlignment = .center
        view.addSubview(conTextView)
        conTextView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(30)
            $0.right.equalToSuperview().offset(-30)
            $0.bottom.equalTo(contentV.snp.top).offset(-30)
            $0.top.equalToSuperview().offset(40)
        }
        
    }
    
    @objc
    func fontBtnClick(btn: UIButton) {
        fontBtn.isSelected = true
        colorBtn.isSelected = false
        fontBtn.backgroundColor = UIColor(hexString: "#ECF7FF")
        colorBtn.backgroundColor = UIColor(hexString: "#323233")
        textFontBar.isHidden = false
        textColorBar.isHidden = true
    }
    
    @objc
    func colorBtnClick(btn: UIButton) {
        fontBtn.isSelected = false
        colorBtn.isSelected = true
        fontBtn.backgroundColor = UIColor(hexString: "#323233")
        colorBtn.backgroundColor = UIColor(hexString: "#ECF7FF")
        textFontBar.isHidden = true
        textColorBar.isHidden = false
    }
    
    @objc
    func cancelBtnClick(btn: UIButton) {
        finishTextVEdit()
        cancelClickActionBlock?()
    }
    
    @objc
    func doneBtnClick(btn: UIButton) {
        
        finishTextVEdit()
        let str: String = conTextView.text
        doneClickActionBlock?(str, currentFontNameStr, currentColorStr, false)

    }
    
}

extension AHanimaVideoAddTextVC {
    func finishTextVEdit() {
        conTextView.resignFirstResponder()
    }
    
    func startTEdit() {
        conTextView.becomeFirstResponder()
    }

    func updateLimitTextLabel(contentText: String) {
        
        limitLabel.text = "\(contentText.count)/\(maxLableCount)"
        if contentText.count >= maxLableCount {
            limitLabel.textColor = UIColor.white
            showCountLimitAlert()
        } else {
            limitLabel.textColor = UIColor.white
        }
    }

}
 

extension AHanimaVideoAddTextVC: UITextViewDelegate {
    
    func showCountLimitAlert() {
        
        if !KRProgressHUD.isVisible {
            KRProgressHUD.showInfo(withMessage: "No more than \(maxLableCount) characters.")
        }
        
    }
    
    func setupTextViewNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(textViewNotifitionAction), name: UITextView.textDidChangeNotification, object: nil);
    }
    @objc
    func textViewNotifitionAction(userInfo:NSNotification){
        guard let textView = userInfo.object as? UITextView else { return }
        if textView.text.count >= maxLableCount {
            let selectRange = textView.markedTextRange
            if let selectRange = selectRange {
                let position =  textView.position(from: (selectRange.start), offset: 0)
                if (position != nil) {
                    //
                    return
                }

            }
            textView.text = String(textView.text[..<String.Index(encodedOffset: maxLableCount)])

            //
            textView.selectedRange = NSRange(location: textView.text.count, length: 0)
        }
        
        contentText = textView.text
        
    }
    
     
     
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        // range: The range of characters to be replaced.(location、count)
        
//        textView.text = contentText
        return true

        
        
        if text == "\n" {
            finishTextVEdit()
            var str: String = conTextView.text
            if str == "" {
                str = "DOUBLE TAP TO TEXT"
            }
            doneClickActionBlock?(str, currentFontNameStr, currentColorStr, false)
            return false
        }
           
        //
        let selectedRange = textView.markedTextRange
        if let selectedRange = selectedRange {
            let position =  textView.position(from: (selectedRange.start), offset: 0)
            if position != nil {
                let startOffset = textView.offset(from: textView.beginningOfDocument, to: selectedRange.start)
                let endOffset = textView.offset(from: textView.beginningOfDocument, to: selectedRange.end)
                let offsetRange = NSMakeRange(startOffset, endOffset - startOffset) //
                if offsetRange.location < maxLableCount {
                    //
                    return true
                } else {
                    debugPrint("max")
                    return false
                }
            }
        }

        // last
        if range.location >= maxLableCount {
            debugPrint("max")
            return false
        }

        // other
        if textView.text.count >= maxLableCount && range.length <  text.count {
            debugPrint("max")
            return false
        }

        return true
    }
    
}


extension AHanimaVideoAddTextVC {
    
    
}
 
