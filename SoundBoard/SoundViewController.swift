//
//  SoundViewController.swift
//  SoundBoard
//
//  Created by C T on 10/5/17.
//  Copyright © 2017 ASU. All rights reserved.
//

import UIKit
//Used for audio
import AVFoundation

class SoundViewController: UIViewController {
    
    
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var soundNameTextField: UITextField!
    
    
    var audioRecorder: AVAudioRecorder?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupRecorder()
    }
    
    func setupRecorder() {
        
        do {
            //Create an audio session
            let session = AVAudioSession.sharedInstance()
            //Want to play audio and record
            try session.setCategory(AVAudioSessionCategoryPlayAndRecord)
            //Play from speaker
            try session.overrideOutputAudioPort(.speaker)
            try session.setActive(true)
            
            //Create URL for the audio file
            let basePath : String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            
            let pathComponents = [basePath, "audio.mp4a"]
            
            let audioURL = NSURL.fileURL(withPathComponents: pathComponents)!
            print(audioURL)
            
            //Create settings for the audio recorder
            
            var settings : [String : AnyObject] = [:]
            settings[AVFormatIDKey] = NSNumber(value: kAudioFormatMPEG4AAC)
            settings[AVSampleRateKey] = NSNumber(value: 44100.0)
            settings[AVNumberOfChannelsKey] = NSNumber(value: 2)
        
            
            //Create AudioRecorder object
            audioRecorder = try AVAudioRecorder(url: audioURL!, settings: settings)
            audioRecorder!.prepareToRecord()
            
        } catch let error as NSError {
            print(error)
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func recordTapped(_ sender: Any) {
        
        if audioRecorder!.isRecording {
            //Stop the recording
            audioRecorder?.stop()
            
            //Change button title to Record
            recordButton.setTitle("Record", for: .normal)
        } else {
            //Start the recording
            audioRecorder?.record()
            
            //Change button title to Stop
            recordButton.setTitle("Stop", for: .normal)
            
        }
    }
    @IBAction func playTapped(_ sender: Any) {
        
    }
    
    @IBAction func addTapped(_ sender: Any) {
        
    }
    
}
