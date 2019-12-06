//
//  Helper.swift
//  Dream Machine
//
//  Created by STUser on 26/11/19.
//  Copyright © 2019 Manish Katoch. All rights reserved.
//
import Foundation
import UIKit

class Helper {
    static var app: Helper = {
        return Helper()
    }()
    
    func appColor() -> UIColor{
        return #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
    }
    
    func themeColor() -> UIColor{
        return #colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1)
    }
    
    func buttonsColor() -> UIColor{
        return #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
   
    func colorList(index:Int) -> UIColor{
        let selectedColor = [#colorLiteral(red: 0.9995196462, green: 0.445597291, blue: 0.4476266503, alpha: 1), #colorLiteral(red: 0.9994458556, green: 0.5737752318, blue: 0.4475454092, alpha: 1), #colorLiteral(red: 0.9992756248, green: 0.7792941928, blue: 0.4473581314, alpha: 1), #colorLiteral(red: 0.9206098318, green: 0.891721487, blue: 0.1456184089, alpha: 1), #colorLiteral(red: 0.563716948, green: 0.8284855485, blue: 0.1110252514, alpha: 1), #colorLiteral(red: 0.130705148, green: 0.8385972381, blue: 0.4989557266, alpha: 1), #colorLiteral(red: 0.1968155503, green: 0.8310152888, blue: 0.848624289, alpha: 1), #colorLiteral(red: 0.4409092963, green: 0.7417003512, blue: 0.9728329778, alpha: 1), #colorLiteral(red: 0.2402342558, green: 0.5250636339, blue: 0.9456240535, alpha: 1), #colorLiteral(red: 0.6221653223, green: 0.5291300416, blue: 0.9932393432, alpha: 1), #colorLiteral(red: 0.7962827086, green: 0.5294750929, blue: 0.9932115674, alpha: 1), #colorLiteral(red: 0.9897441268, green: 0.4760087729, blue: 0.8416253924, alpha: 1)]
        return selectedColor[index]
    }
    
    func secondsToHoursMinutesSeconds (seconds : Int) -> (Int, Int, Int) {
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
    func hoursMinutesToSeconds (hours : Int, minutes: Int) -> (Int) {
        let seconds = hours * 3600 + minutes * 60
        return seconds
    }
    
    func rotateImage(imageView: UIImageView, duration: CGFloat){
       
        let rotationAnimation : CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.toValue = NSNumber(value: .pi * 1.75)
        rotationAnimation.duration = CFTimeInterval(duration);
        rotationAnimation.isCumulative = true;
        rotationAnimation.repeatCount = .zero;
        imageView.layer.add(rotationAnimation, forKey: "rotationAnimation")
    }
    
    func stopRotateImage(imageView: UIImageView, duration: CGFloat){
        
        UIView.animate(withDuration: TimeInterval(duration), animations: {
           imageView.layer.removeAnimation(forKey: "rotationAnimation")
        })
    }
    
    
}
