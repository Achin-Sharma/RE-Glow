//
//  TimerPopUp.swift
//  Dream Machine
//
//  Created by STUser on 25/11/19.
//  Copyright © 2019 Manish Katoch. All rights reserved.
//

import UIKit

protocol TimerPopUpProtocol {
    
    func scrolledTimer(timer: Timer)
    
    func cancelTimer(bool: Bool)
    
    func setTimer(hours:Int, minutes:Int)
}

class TimerPopUp: UIViewController {
    
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var view_mainPicker: UIView!
    
    var delegate : TimerPopUpProtocol? = nil

    var hour: Int = 0
    var minutes: Int = 0
    
        override func viewDidLoad() {
            super.viewDidLoad()
            
            self.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
            self.showAnimate()
            self.pickerView.delegate = self
            self.view_mainPicker.layer.cornerRadius = 26
            self.view_mainPicker.clipsToBounds = true
        }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
    
        //MARK: Button Actions
    
    @IBAction func cancelAction(_ sender: UIButton) {
       
        self.removeAnimate()
        delegate?.cancelTimer(bool: true)
    }
    
    
    @IBAction func setTimerAction(_ sender: UIButton) {
      
      self.removeAnimate()
      delegate?.setTimer(hours: hour, minutes: minutes)
    }
    
  
    
        //
        func showAnimate()
        {
            self.view_mainPicker.transform = CGAffineTransform(translationX: view_mainPicker.bounds.minX, y: -400)
            
            self.view.alpha = 0.0;
            UIView.animate(withDuration: 0.35, animations: {
                self.view.alpha = 1.0
                self.view_mainPicker.transform = CGAffineTransform.identity
            });
        }
        
        func removeAnimate()
        {
            UIView.animate(withDuration: 0.35, animations: {
                self.view_mainPicker.transform = CGAffineTransform(translationX: self.view_mainPicker.bounds.minX, y: 300)
                self.view.alpha = 0.0;
            }, completion:{(finished : Bool)  in
                if (finished)
                {
                    self.view.removeFromSuperview()
                }
            });
        }
    }


extension TimerPopUp: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return 25
        case 1:
            return 60
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return pickerView.frame.size.width/4.5
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return "\(row)"
        case 1:
            return "\(row)"
        default:
            return ""
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            hour = row
        case 1:
            minutes = row
        default:
            break;
        }
    }
}
