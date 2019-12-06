//
//  FlashViewController.swift
//  Dream Machine
//
//  Created by STUser on 11/11/19.
//  Copyright © 2019 Manish Katoch. All rights reserved.
//

import UIKit
import AVFoundation

protocol FlashViewControllerDelegate {
    func closeFlashView()
}

class FlashViewController: UIViewController {
    
    var delegate: FlashViewControllerDelegate? = nil
    @IBOutlet weak var vwFlash: UIView!
    @IBOutlet weak var lblNote: UILabel!
    @IBOutlet weak var vwBrightness: UIView!
    
    var timer : Timer!
    var T = 0.5 ;
    var colorString: String!
    var frequency: Float!
    var brightness: Float32!
    var isFlashLightOn = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.vwBrightness.alpha = CGFloat(1.0 - Float(self.brightness))
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapedOnView(_:)))
        self.view.addGestureRecognizer(tapGesture)
        self.doFlash()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func initVal(_ frequency: Float, _ colorString: String, _ brightness: Float, _ isFlashLightOn: Bool) {
        self.frequency = frequency
        self.colorString = colorString
        self.brightness = brightness
        self.isFlashLightOn = isFlashLightOn
    }
    
    func doFlash() {
        self.vwFlash.backgroundColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1) //Utils.hexStringToUIColor(hex: self.colorString)
        self.timer = Timer.scheduledTimer(timeInterval: (T/Double(self.frequency)), target: self, selector: #selector(self.onTimerEvent), userInfo: nil, repeats: true)
    }
    
    
    @objc func onTimerEvent() {
        if self.isFlashLightOn {
            
            //self.vwFlash.isHidden = !self.vwFlash.isHidden;
            
             let device = AVCaptureDevice.default(for: AVMediaType.video)
              //let device = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
            if (device?.hasTorch)! {
                do {
                    try device?.lockForConfiguration()
                    if (device?.torchMode == .on) {
                        device?.torchMode = .off
                    } else {
                        do {
                            try device?.setTorchModeOn(level: 1.0)
                        } catch {
                            print(error)
                        }
                    }
                    device?.unlockForConfiguration()
                } catch {
                    print(error)
                }
            }
            
        } else {
            
            self.vwFlash.isHidden = !self.vwFlash.isHidden;
        }
    }
    
    @objc func tapedOnView(_ sender: UITapGestureRecognizer) {
        if self.timer != nil {
            self.timer.invalidate()
            self.timer = nil;
        }
        self.delegate?.closeFlashView()
        if self.isFlashLightOn {
            //let device = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
            let device = AVCaptureDevice.default(for: AVMediaType.video)
            if (device?.hasTorch)! {
                do {
                    try device?.lockForConfiguration()
                    if (device?.torchMode == .on) {
                        device?.torchMode = .off
                    }
                    device?.unlockForConfiguration()
                } catch {
                    print(error)
                }
            }
        }
        self.dismiss(animated: false, completion: nil)
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
