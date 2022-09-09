//
//  TextlayerAnimate.swift
//  VideoLab_Example
//
//  Created by TomSmith on 2022/8/29.
//  Copyright © 2022 Chocolate. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit
import VideoLab

// scale  alpha  color  rotate  position
class TextScaleAlphaAnimationLayer: TextAnimationBaseLayer {
    override func addAnimations(to layers: [CATextLayer]) {
        var beginTime = AVCoreAnimationBeginTimeAtZero
        
        let allTime = 5.0
        let beginTimeInterval = (allTime-1)/CGFloat(layers.count)
        
        for layer in layers {
            let animationGroup = CAAnimationGroup()
            animationGroup.duration = allTime
            animationGroup.beginTime = AVCoreAnimationBeginTimeAtZero
            animationGroup.fillMode = .both
            animationGroup.isRemovedOnCompletion = false

            let opacityAnimation = CABasicAnimation(keyPath: "opacity")
            opacityAnimation.fromValue = 0.0
            opacityAnimation.toValue = 1.0
            opacityAnimation.duration = beginTimeInterval
            opacityAnimation.beginTime = beginTime
            opacityAnimation.fillMode = .both

            let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
            scaleAnimation.fromValue = 0.0
            scaleAnimation.toValue = 1.0
            scaleAnimation.duration = beginTimeInterval
            scaleAnimation.beginTime = beginTime
            scaleAnimation.fillMode = .both
            
            //
            let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
            rotateAnimation.fromValue = 0.0
            rotateAnimation.toValue = CGFloat.pi * 2
            rotateAnimation.duration = 0.125
            rotateAnimation.beginTime = beginTime
            rotateAnimation.fillMode = .both
            
            //
            let colorAnimation = CABasicAnimation(keyPath: "backgroundColor")
            colorAnimation.fromValue = UIColor.white.cgColor
            colorAnimation.toValue = UIColor.black.cgColor
            colorAnimation.duration = 0.125
            colorAnimation.beginTime = beginTime
            colorAnimation.fillMode = .both
            
            //
            let positionAnimation = CABasicAnimation(keyPath: "position.y")
            positionAnimation.fromValue = layer.position.y + 560
            positionAnimation.toValue = layer.position.y
            positionAnimation.duration = 0.425
            positionAnimation.beginTime = beginTime
            positionAnimation.fillMode = .both
            animationGroup.animations = [opacityAnimation, scaleAnimation]
//            animationGroup.animations = [ positionAnimation]
            layer.add(animationGroup, forKey: "animationGroup")

            beginTime += beginTimeInterval
        }
    }
}
