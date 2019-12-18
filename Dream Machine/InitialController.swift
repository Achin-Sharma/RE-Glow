//
//  InitialController.swift
//  Dream Machine
//
//  Created by Manish Katoch on 08/11/19.
//  Copyright © 2019 Manish Katoch. All rights reserved.
//

import Foundation
import UIKit
import AudioToolbox
import AVFoundation
import MediaPlayer


import AVKit

class InitialController: UIViewController, TimerPopUpProtocol {
    
    
    @IBOutlet weak var hertzLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    
    //Buttons Outlets
    @IBOutlet weak var btn_sound: UIButton!
    @IBOutlet weak var btn_light: UIButton!
    @IBOutlet weak var btn_playP: UIButton!
    @IBOutlet weak var btn_timer: UIButton!
    
    @IBOutlet weak var img_dotTimer: UIImageView!
    
    // Local Variables
    var timer : Timer!
    var defaultFrequency: Double = 40
    var colorString: String = ""
    var frequency: Float = 0.0
    var maxFrequency: Float = 400.0
    var minFrequency: Float = 05.0
    var brightness: Float32 = 1.0
    var isFlashLightOn = false
    var isSoundOn = false
    var toneUnit: AudioComponentInstance?
    var sampleRate: Float32 = 44100.0
    var counter = 0
    var selectedSeconds = 0
    let myUnit = ToneOutputUnit()
    var soundTimer : Timer!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        frequency = Float(defaultFrequency)
    }
    
    
    //MARK: Button Actions
    
    @IBAction func syncSoundLightAction(_ sender: UIButton) {
        
         startBeatsAndLight(sender: sender, syncSoundLight: true)
         btn_sound.isSelected = true
        
    }
    
    @IBAction func soundAction(_ sender: UIButton) {
        
         startBeatsAndLight(sender: sender, syncSoundLight: false)
    }
    
    @IBAction func lightAction(_ sender: UIButton) {
        
        sender.isSelected = !sender.isSelected
        
        isFlashLightOn = !isFlashLightOn
    }
    
    @IBAction func playPauseAction(_ sender: UIButton) {
        
      goToFlashController()
        
    }
    
    @IBAction func timerAction(_ sender: UIButton) {
        
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TimerPopUp") as! TimerPopUp
        
        popOverVC.delegate = self
        
        self.addChild(popOverVC)
        
        popOverVC.view.frame = self.view.frame
        
        self.view.addSubview(popOverVC.view)
        
        popOverVC.didMove(toParent: self)
    }
    
    //MARK: Functions
    @objc func updateCounter() {
        
        if counter == 0 {
            
            myUnit.stop();    soundTimer.invalidate();    updateTimerLabel(seconds:0);  isSoundOn = false;
            
            btn_timer.isSelected = false;   Helper.app.stopRotateImage(imageView: self.img_dotTimer, duration: CGFloat(0.5))
            
        } else  if counter == selectedSeconds{
            
            myUnit.setFrequency(freq: Double(frequency))
            
            myUnit.setToneTime(t: Double(counter))
            
            myUnit.enableSpeaker()
            
            updateTimerLabel(seconds:counter)
            
        }else if myUnit.audioRunning{
            
            updateTimerLabel(seconds:counter)
        }
    }
        
    func goToFlashController(){
        
        let next = storyboard?.instantiateViewController(withIdentifier: "FlashViewController") as! FlashViewController
           
           next.initVal(frequency, colorString, brightness, isFlashLightOn)
           
           self.present(next, animated: true, completion: nil)
        
    }
    
    func updateTimerLabel(seconds: Int){
        
        let (hour, minutes, seconds) = Helper.app.secondsToHoursMinutesSeconds(seconds: seconds)
        
        timeLbl.text = ("\(hour):\(minutes):\(seconds)")
        
        counter -= 1
    }
    
    func startBeatsAndLight(sender: UIButton, syncSoundLight: Bool){
        
        if(counter <= 1){
                   
                   Alert().showTimerAlertAndAction(withTitle: "Alert", withMessage: "Please select the time for Binaural Beats", inView: self, completionHandlerResponce: { (value) in
                       if value{
                           self.navigationController?.popViewController(animated: true)
                           sender.isSelected = false
                           return
                       }
                   })
                   
               }else if(isSoundOn){
                   
                   myUnit.stop(); counter = 0;  soundTimer.invalidate();  isSoundOn = !isSoundOn
                   
                   let (hour, minutes, seconds) = Helper.app.secondsToHoursMinutesSeconds(seconds: 0)
                   Helper.app.stopRotateImage(imageView: self.img_dotTimer, duration: CGFloat(0.5))
                   timeLbl.text = ("\(hour):\(minutes):\(seconds)")
                   
               }else{
                   
                   soundTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
                   myUnit.setFrequency(freq: Double(frequency))
                   myUnit.setToneTime(t: Double(counter))
                   myUnit.enableSpeaker()
                   Helper.app.rotateImage(imageView: self.img_dotTimer, duration: CGFloat(selectedSeconds))
                   isSoundOn = !isSoundOn
            
                 if syncSoundLight{
                 goToFlashController()
                 }
               }
               
               sender.isSelected = !sender.isSelected
    }
    
    //MARK: Custom Delegates
    
    func setTimer(hours: Int, minutes: Int) {
        
        let totalSeconds = Helper.app.hoursMinutesToSeconds(hours: hours, minutes: minutes)
        
        let (hour, minutes, seconds) = Helper.app.secondsToHoursMinutesSeconds(seconds: totalSeconds)
        
        timeLbl.text = ("\(hour):\(minutes):\(seconds)")
        
        counter = totalSeconds
        
        selectedSeconds = totalSeconds
    }
    
    func scrolledTimer(timer: Timer) {
        
    }
    
    func cancelTimer(bool: Bool) {
        
    }
    
    func sendAction(textField: String) {
        
    }
}

extension InitialController: UIScrollViewDelegate{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        print((scrollView.contentOffset.y)/2);
        
        frequency = Float(((scrollView.contentOffset.y)/2))
        
        if ((minFrequency...maxFrequency ~= frequency) && (myUnit.audioRunning) ){
            
            myUnit.setFrequency(freq: Double((scrollView.contentOffset.y)/2))
            
            hertzLbl.text = String(format: "%.2f",((scrollView.contentOffset.y)/2))
            
        }else  if (minFrequency...maxFrequency ~= frequency){
            
            hertzLbl.text = String(format: "%.2f",((scrollView.contentOffset.y)/2))
        }
        
    }
}
