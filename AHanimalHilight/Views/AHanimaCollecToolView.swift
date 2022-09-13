//
//  AHanimaCollecToolView.swift
//  AHanimalHilight
//
//  Created by TomSmith on 2022/8/30.
//

import UIKit

class AHanimaCollecToolView: UIView {

    var sizeSlideChangeBlock: ((Float)->Void)?
    var paddingSlideChangeBlock: ((Float)->Void)?
    var horSlideChangeBlock: ((Float)->Void)?
    var verSlideChangeBlock: ((Float)->Void)?
    var rotateSlideChangeBlock: ((Float)->Void)?
    var backClickBlock: (()->Void)?
    var nextClickBlock: (()->Void)?
    let shapeCollection = AHanimaStickerToolView()
    let colorCollection = AHanimaColorCollection()
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildContentView()
        buildAnimateTypeView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildContentView() {
        
        backgroundColor = UIColor.clear
        //
        let bgImgV = UIImageView()
        bgImgV.image = UIImage(named: "ic_edit_nav_bg")
        self.addSubview(bgImgV)
        bgImgV.snp.makeConstraints {
            $0.left.right.top.bottom.equalToSuperview()
        }
        //
        
        addSubview(colorCollection)
        colorCollection.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.height.equalTo(36)
            $0.top.equalToSuperview().offset(25)
        }
        //
        
        addSubview(shapeCollection)
        shapeCollection.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.equalToSuperview().offset(70)
            $0.height.equalTo(30)
        }
     
        //
        let sizeSlider = UISlider()
        addSubview(sizeSlider)
        sizeSlider.setThumbImage(UIImage(named: "ic_slide_adjust"), for: .normal)
        sizeSlider.minimumTrackTintColor = UIColor(hexString: "#848484")!
        sizeSlider.maximumTrackTintColor = UIColor(hexString: "#848484")!
        sizeSlider.minimumValue = 1
        sizeSlider.maximumValue = 6
        sizeSlider.value = 4
        sizeSlider.snp.makeConstraints {
            $0.height.equalTo(30)
            $0.right.equalToSuperview().offset(-30)
            $0.left.equalToSuperview().offset(80)
            $0.top.equalTo(shapeCollection.snp.bottom).offset(18)
        }
        sizeSlider.addTarget(self, action: #selector(sizeSliderValueChange(sender: )), for: .valueChanged)
        let sizeLabel = UILabel()
        sizeLabel.text = "Size"
        sizeLabel.textColor = UIColor.white
        sizeLabel.textAlignment = .center
        sizeLabel.adjustsFontSizeToFitWidth = true
        addSubview(sizeLabel)
        sizeLabel.snp.makeConstraints {
            $0.centerY.equalTo(sizeSlider)
            $0.left.equalToSuperview().offset(4)
            $0.right.equalTo(sizeSlider.snp.left).offset(-4)
            $0.height.greaterThanOrEqualTo(10)
        }
        
        //
        let paddingSlider = UISlider()
        addSubview(paddingSlider)
        paddingSlider.setThumbImage(UIImage(named: "ic_slide_adjust"), for: .normal)
        paddingSlider.minimumTrackTintColor = UIColor(hexString: "#848484")!
        paddingSlider.maximumTrackTintColor = UIColor(hexString: "#848484")!
        paddingSlider.minimumValue = 0.5
        paddingSlider.maximumValue = 1
        paddingSlider.value = 0.9
        paddingSlider.snp.makeConstraints {
            $0.height.equalTo(30)
            $0.right.equalToSuperview().offset(-30)
            $0.left.equalToSuperview().offset(80)
            $0.top.equalTo(sizeSlider.snp.bottom).offset(5)
        }
        paddingSlider.addTarget(self, action: #selector(paddingSliderValueChange(sender: )), for: .valueChanged)
        let paddingLabel = UILabel()
        paddingLabel.text = "Distance"
        paddingLabel.textColor = UIColor.white
        paddingLabel.textAlignment = .center
        paddingLabel.adjustsFontSizeToFitWidth = true
        addSubview(paddingLabel)
        paddingLabel.snp.makeConstraints {
            $0.centerY.equalTo(paddingSlider)
            $0.left.equalToSuperview().offset(4)
            $0.right.equalTo(sizeSlider.snp.left).offset(-4)
            $0.height.greaterThanOrEqualTo(10)
        }
        //
        
        //
        let horSlider = UISlider()
        addSubview(horSlider)
        horSlider.setThumbImage(UIImage(named: "ic_slide_adjust"), for: .normal)
        horSlider.minimumTrackTintColor = UIColor(hexString: "#848484")!
        horSlider.maximumTrackTintColor = UIColor(hexString: "#848484")!
        horSlider.minimumValue = -1
        horSlider.maximumValue = 1
        horSlider.value = 0
        horSlider.snp.makeConstraints {
            $0.height.equalTo(30)
            $0.right.equalToSuperview().offset(-30)
            $0.left.equalToSuperview().offset(80)
            $0.top.equalTo(paddingSlider.snp.bottom).offset(5)
        }
        horSlider.addTarget(self, action: #selector(horSliderValueChange(sender: )), for: .valueChanged)
        let horLabel = UILabel()
        horLabel.text = "Horizontal"
        horLabel.textColor = UIColor.white
        horLabel.textAlignment = .center
        horLabel.adjustsFontSizeToFitWidth = true
        addSubview(horLabel)
        horLabel.snp.makeConstraints {
            $0.centerY.equalTo(horSlider)
            $0.left.equalToSuperview().offset(4)
            $0.right.equalTo(sizeSlider.snp.left).offset(-4)
            $0.height.greaterThanOrEqualTo(10)
        }
        //
        let verSlider = UISlider()
        addSubview(verSlider)
        verSlider.setThumbImage(UIImage(named: "ic_slide_adjust"), for: .normal)
        verSlider.minimumTrackTintColor = UIColor(hexString: "#848484")!
        verSlider.maximumTrackTintColor = UIColor(hexString: "#848484")!
        verSlider.minimumValue = -1
        verSlider.maximumValue = 1
        verSlider.value = 0
        verSlider.snp.makeConstraints {
            $0.height.equalTo(30)
            $0.right.equalToSuperview().offset(-30)
            $0.left.equalToSuperview().offset(80)
            $0.top.equalTo(horSlider.snp.bottom).offset(5)
        }
        verSlider.addTarget(self, action: #selector(verSliderValueChange(sender: )), for: .valueChanged)
        let verLabel = UILabel()
        verLabel.text = "Vertical"
        verLabel.textColor = UIColor.white
        verLabel.textAlignment = .center
        verLabel.adjustsFontSizeToFitWidth = true
        addSubview(verLabel)
        verLabel.snp.makeConstraints {
            $0.centerY.equalTo(verSlider)
            $0.left.equalToSuperview().offset(4)
            $0.right.equalTo(sizeSlider.snp.left).offset(-4)
            $0.height.greaterThanOrEqualTo(10)
        }
        //
        //
        let rotateSlider = UISlider()
        addSubview(rotateSlider)
        rotateSlider.setThumbImage(UIImage(named: "ic_slide_adjust"), for: .normal)
        rotateSlider.minimumTrackTintColor = UIColor(hexString: "#848484")!
        rotateSlider.maximumTrackTintColor = UIColor(hexString: "#848484")!
        rotateSlider.minimumValue = 0
        rotateSlider.maximumValue = 1
        rotateSlider.value = 0
        rotateSlider.snp.makeConstraints {
            $0.height.equalTo(30)
            $0.right.equalToSuperview().offset(-30)
            $0.left.equalToSuperview().offset(80)
            $0.top.equalTo(verSlider.snp.bottom).offset(5)
        }
        rotateSlider.addTarget(self, action: #selector(rotateSliderValueChange(sender: )), for: .valueChanged)
        let rotateLabel = UILabel()
        rotateLabel.text = "Rotate"
        rotateLabel.textColor = UIColor.white
        rotateLabel.textAlignment = .center
        rotateLabel.adjustsFontSizeToFitWidth = true
        addSubview(rotateLabel)
        rotateLabel.snp.makeConstraints {
            $0.centerY.equalTo(rotateSlider)
            $0.left.equalToSuperview().offset(4)
            $0.right.equalTo(sizeSlider.snp.left).offset(-4)
            $0.height.greaterThanOrEqualTo(10)
        }
        
        //
        let backBtn = UIButton()
        backBtn.setImage(UIImage(named: "ic_magic_video_return"), for: .normal)
        backBtn.addTarget(self, action: #selector(backBtnClick(sender:)), for: .touchUpInside)
        self.addSubview(backBtn)
        backBtn.snp.makeConstraints {
            $0.bottom.equalTo(self.snp.bottom).offset(-18)
            $0.left.equalToSuperview().offset(20)
            $0.width.equalTo(37)
            $0.height.equalTo(48)
        }
        
        //
        let nextBtn = UIButton()
        nextBtn.setImage(UIImage(named: "ic_next_step"), for: .normal)
        nextBtn.addTarget(self, action: #selector(nextBtnClick(sender: )), for: .touchUpInside)
        self.addSubview(nextBtn)
        nextBtn.snp.makeConstraints {
            $0.bottom.equalTo(self.snp.bottom).offset(-23)
            $0.right.equalToSuperview().offset(-23)
            $0.width.equalTo(34)
            $0.height.equalTo(34)
        }
        
        //
        //
        let titleNameLabel = UILabel()
        addSubview(titleNameLabel)
        titleNameLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalTo(backBtn.snp.centerY)
            $0.width.height.greaterThanOrEqualTo(10)
        }
        titleNameLabel.font = UIFont(name: "Helvetica-Bold", size: 16)
        titleNameLabel.numberOfLines = 0
        titleNameLabel.textColor = UIColor.white
        titleNameLabel.text = "ADJUST SET"
        
        
    }
    
    func buildAnimateTypeView() {
        
    }

    
    @objc func sizeSliderValueChange(sender: UISlider) {
        sizeSlideChangeBlock?(sender.value)
    }
    @objc func paddingSliderValueChange(sender: UISlider) {
        paddingSlideChangeBlock?(sender.value)
    }
    @objc func horSliderValueChange(sender: UISlider) {
        horSlideChangeBlock?(sender.value)
    }
    @objc func verSliderValueChange(sender: UISlider) {
        verSlideChangeBlock?(sender.value)
    }
    @objc func rotateSliderValueChange(sender: UISlider) {
        rotateSlideChangeBlock?(sender.value)
    }
  
    @objc func backBtnClick(sender: UIButton) {
        backClickBlock?()
    }
    
    @objc func nextBtnClick(sender: UIButton) {
        nextClickBlock?()
    }
    
}
