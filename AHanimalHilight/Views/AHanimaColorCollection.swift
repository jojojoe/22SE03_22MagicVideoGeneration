//
//  AHanimaColorCollection.swift
//  AHanimalHilight
//
//  Created by TomSmith on 2022/9/6.
//

import UIKit

class AHanimaColorCollection: UIView {
    var currentColorItem: String?
    var colorSelectBlock: ((String, Bool)->Void)?
    var collection: UICollectionView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension AHanimaColorCollection {
    func setupView() {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collection = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: layout)
        collection.showsVerticalScrollIndicator = false
        collection.showsHorizontalScrollIndicator = false
        collection.backgroundColor = .clear
        collection.delegate = self
        collection.dataSource = self
        addSubview(collection)
        collection.snp.makeConstraints {
            $0.top.bottom.right.left.equalToSuperview()
        }
        collection.register(cellWithClass: TIooyColorCell.self)
    }
    
    
    
    
}

extension AHanimaColorCollection: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withClass: TIooyColorCell.self, for: indexPath)
        let item = AHaniManager.default.colorStrList[indexPath.item]

        cell.contentImgV.backgroundColor = UIColor(hexString: item)
        
        if currentColorItem == item {
            cell.selectV.isHidden = false
        } else {
            cell.selectV.isHidden = true
        }
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return AHaniManager.default.colorStrList.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
}

extension AHanimaColorCollection: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 24, height: 36)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
}

extension AHanimaColorCollection: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let item = AHaniManager.default.colorStrList[indexPath.item]
        currentColorItem = item
        collectionView.reloadData()
         
        colorSelectBlock?(item, false)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
    }
}





class TIooyColorCell: UICollectionViewCell {
    let contentImgV = UIImageView()
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
        contentImgV.contentMode = .scaleAspectFill
        contentImgV.clipsToBounds = true
        contentView.addSubview(contentImgV)
        contentImgV.snp.makeConstraints {
            $0.top.right.bottom.left.equalToSuperview()
        }
        contentImgV.layer.cornerRadius = 8
        //
        selectV.layer.cornerRadius = 8
        selectV.layer.borderWidth = 1
        selectV.layer.borderColor = UIColor.white.cgColor
        selectV.contentMode = .scaleAspectFit
        selectV.clipsToBounds = true
        contentView.addSubview(selectV)
        selectV.snp.makeConstraints {
            $0.top.right.bottom.left.equalToSuperview()
        }
       
//        vipImgV.image("editor_diamond")
//            .adhere(toSuperview: contentView)
//        vipImgV.snp.makeConstraints {
//            $0.top.equalToSuperview()
//            $0.right.equalToSuperview()
//            $0.width.height.equalTo(32/2)
//        }
        
        
    }
}


