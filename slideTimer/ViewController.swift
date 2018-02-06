//
//  ViewController.swift
//  slideTimer
//
//  Created by LARRY COMBS on 1/21/18.
//  Copyright © 2018 LARRY COMBS. All rights reserved.
//

import UIKit
import AudioToolbox

class ViewController: UIViewController, CountdownTimerDelegate {
    
    
    
    //MARK - Outlets
    @IBOutlet weak var Reset: UIBarButtonItem!
    @IBAction func Reset(_ sender: Any) {
        
        sliderHoursOutlet.isHidden = false
        sliderMinutesOutlet.isHidden = false
        sliderSecondsOutlet.isHidden = false
        messageLabel.isHidden = true
        counterView.isHidden = false
        
        stopBtn.isEnabled = false
        stopBtn.alpha = 1.0
        Reset.isEnabled = true
        // Set progess bar and timer
        
        //countdownTimer.setTimer(hours: selectedHours, minutes: selectedMinutes, seconds: selectedSecs)
        //progressBar.setProgressBar(hours: selectedHours, minutes: selectedMinutes, seconds: selectedSecs)
        
        //countdownTimer.start()
        //progressBar.start()
        //countdownTimerDidStart = true
        startBtn.setTitle("START",for: .normal)
        
        
    }
    @IBOutlet weak var sliderHoursOutlet: UISlider!
    
    @IBAction func sliderHoursAction(_ sender: UISlider)
    {
        let value = Int(sender.value)
        selectedHours = value
        hours.text = String(value)
        countdownTimer.duration = Double(sender.value)
       
    }
    @IBOutlet weak var sliderMinutesOutlet: UISlider!
    @IBAction func sliderMinutesAction(_ sender: UISlider)
    {
        let value = Int(sender.value)
        selectedMinutes = value
        minutes.text = String(value)
        
 
    }
    @IBOutlet weak var sliderSecondsOutlet: UISlider!
    @IBAction func sliderSecondsAction(_ sender: UISlider)
    {
        selectedSecs = Int(sender.value)
        //countdownTimer.duration = Double(sender.value)
        seconds.text? = String(selectedSecs)
        
    }
    @IBOutlet weak var Date: UILabel!
    @IBOutlet weak var progressBar: ProgressBar!
    @IBOutlet weak var hours: UILabel!
    @IBOutlet weak var minutes: UILabel!
    @IBOutlet weak var seconds: UILabel!
    @IBOutlet weak var counterView: UIStackView!
    @IBOutlet weak var stopBtn: UIButton!
    @IBOutlet weak var startBtn: UIButton!
    
    
    //MARK - Vars
    
    var countdownTimerDidStart = false
    
    lazy var countdownTimer: CountdownTimer = {
        let countdownTimer = CountdownTimer()
        return countdownTimer
    }()
    
    
    // Test, for dev
    var selectedSecs = 30
    var selectedMinutes = 0
    var selectedHours = 0
    
    let picker = UIDatePicker()
    
    
    
    lazy var messageLabel: UILabel = {
        let label = UILabel(frame:CGRect.zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 24.0, weight: UIFont.Weight.light)
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.text = "Done!"
        
        
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countdownTimer.delegate = self
        countdownTimer.setTimer(hours: 0, minutes: 0, seconds: selectedSecs)
        progressBar.setProgressBar(hours: 0, minutes: 0, seconds: selectedSecs)
        stopBtn.isEnabled = false
        stopBtn.alpha = 0.5
        Reset.isEnabled = false
        view.addSubview(messageLabel)
        
        var constraintCenter = NSLayoutConstraint(item: messageLabel, attribute: .centerX, relatedBy: .equal, toItem: self.minutes, attribute: .centerX, multiplier: 1, constant: 0)
        self.view.addConstraint(constraintCenter)
        constraintCenter = NSLayoutConstraint(item: messageLabel, attribute: .centerY, relatedBy: .equal, toItem: self.minutes, attribute: .centerY, multiplier: 1, constant: 0)
        self.view.addConstraint(constraintCenter)
        
        
        let date = NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMMM dd, YYYY"
        let stringDate = dateFormatter.string(from: date as Date)
        Date.text = stringDate
        
        messageLabel.isHidden = true
        counterView.isHidden = false
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    
    //MARK: - Countdown Timer Delegate
    
    func countdownTime(time: (hours: String, minutes: String, seconds: String)) {
        hours.text = time.hours
        minutes.text = time.minutes
        seconds.text = time.seconds
    }
    
    
    func countdownTimerDone() {
        
        sliderHoursOutlet.isHidden = false
        sliderMinutesOutlet.isHidden = false
        sliderSecondsOutlet.isHidden = false
        counterView.isHidden = true
        messageLabel.isHidden = false
        seconds.text = String(selectedSecs)
        countdownTimerDidStart = false
        stopBtn.isEnabled = false
        stopBtn.alpha = 0.5
        startBtn.setTitle("START",for: .normal)
        Reset.isEnabled = true
        //Reset.alpha = 0.5
        
        
        
        //messageLabel.centerXAnchor.constraint(equalTo: minutes.centerXAnchor).isActive = true
        //messageLabel.centerYAnchor.constraint(equalTo: minutes.centerYAnchor).isActive = true
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
        
        print("countdownTimerDone")
    }
    
    
    //MARK: - Actions
    
    @IBAction func startTimer(_ sender: UIButton) {
        
        sliderHoursOutlet.isHidden = true
        sliderMinutesOutlet.isHidden = true
        sliderSecondsOutlet.isHidden = true
        messageLabel.isHidden = true
        counterView.isHidden = false
        
        stopBtn.isEnabled = true
        stopBtn.alpha = 1.0
        Reset.isEnabled = false
        
        // Set progess bar and timer
        
        countdownTimer.setTimer(hours: selectedHours, minutes: selectedMinutes, seconds: selectedSecs)
        progressBar.setProgressBar(hours: selectedHours, minutes: selectedMinutes, seconds: selectedSecs)
        
        
        if !countdownTimerDidStart{
            countdownTimer.start()
            progressBar.start()
            countdownTimerDidStart = true
            startBtn.setTitle("PAUSE",for: .normal)
            
        }else{
            countdownTimer.pause()
            progressBar.pause()
            countdownTimerDidStart = false
            startBtn.setTitle("RESUME",for: .normal)
        }
    }
    
    
    @IBAction func stopTimer(_ sender: UIButton) {
        
        resetTimer()
    }
    
    func resetTimer(){
        
        sliderHoursOutlet.isHidden = false
        sliderMinutesOutlet.isHidden = false
        sliderSecondsOutlet.isHidden = false
        countdownTimer.stop()
        progressBar.stop()
        countdownTimerDidStart = false
        stopBtn.isEnabled = false
        stopBtn.alpha = 0.5
        startBtn.setTitle("START",for: .normal)
        Reset.isEnabled = false
        
        
    }
    
    
    
}
