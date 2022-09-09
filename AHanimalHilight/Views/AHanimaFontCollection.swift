//
//  AHanimaFontCollection.swift
//  AHanimalHilight
//
//  Created by TomSmith on 2022/9/6.
//

import UIKit

class AHanimaFontCollection: UIView {
    
    var collection: UICollectionView!
    var currentFontStr: String?
    var fontDidSelectBlock: ((String, IndexPath)->Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collection = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: layout)
        collection.showsHorizontalScrollIndicator = false
        collection.showsVerticalScrollIndicator = false
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = .clear
        addSubview(collection)
        collection.snp.makeConstraints {
            $0.top.bottom.right.left.equalToSuperview()
        }
        collection.register(cellWithClass: TIoymFontCell.self)
        
        //
    }

}

extension AHanimaFontCollection: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withClass: TIoymFontCell.self, for: indexPath)
        
        let font =  AHaniManager.default.fontStrList[indexPath.item]
   
        
        cell.fontLabel.font = UIFont(name: font, size: 14)
        
        if currentFontStr == font {
            cell.selectV.isHidden = false
        } else {
            cell.selectV.isHidden = true
        }
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return AHaniManager.default.fontStrList.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
}

extension AHanimaFontCollection: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 78, height: 36)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
    
}

extension AHanimaFontCollection: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let item = AHaniManager.default.fontStrList[indexPath.item]
        fontDidSelectBlock?(item, indexPath)
        currentFontStr = item
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
    }
}


class TIoymFontCell: UICollectionViewCell {
    let fontLabel = UILabel()
    let selectV = UIImageView()
//    let vipImgV = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        
        //
        fontLabel.textAlignment = .center
        fontLabel.text = "Font"
        fontLabel.textColor = UIColor(hexString: "#C4C4C4")
        fontLabel.adjustsFontSizeToFitWidth = true
        addSubview(fontLabel)
        fontLabel.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.top.equalToSuperview()
        }
        fontLabel.backgroundColor = UIColor(hexString: "#323233")
        fontLabel.layer.cornerRadius = 8
        fontLabel.clipsToBounds = true
        //
        selectV.layer.cornerRadius = 8
        selectV.layer.borderWidth = 1
        selectV.layer.borderColor = UIColor(hexString: "#ECF7FF")!.cgColor
        selectV.contentMode = .scaleAspectFit
        selectV.clipsToBounds = true
        contentView.addSubview(selectV)
        selectV.snp.makeConstraints {
            $0.top.right.bottom.left.equalToSuperview()
        }
       
        
        //
        
//        vipImgV.image("editor_diamond")
//            .adhere(toSuperview: contentView)
//        vipImgV.snp.makeConstraints {
//            $0.centerY.equalToSuperview()
//            $0.right.equalToSuperview()
//            $0.width.height.equalTo(32/2)
//        }
        
        
    }
}


