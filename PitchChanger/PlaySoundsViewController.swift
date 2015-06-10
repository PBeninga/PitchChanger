//
//  PlaySoundsViewController.swift
//  PitchChanger
//
//  Created by Patrick Beninga on 6/9/15.
//  Copyright (c) 2015 Patrick Beninga. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    var audioPlayer:AVAudioPlayer!
    var recievedAudio:RecordedAudio!
    
    //Declared globally within PlaySoundsViewController
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: recievedAudio.filePathUrl, error: nil)
        audioPlayer = AVAudioPlayer(contentsOfURL: recievedAudio.filePathUrl, error: nil)
        audioPlayer.enableRate = true;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func stopAudio(sender: UIButton) {
        audioPlayer.stop();
    }

    @IBAction func playFast(sender: UIButton) {
        playAudio(2.0)
    }
    @IBAction func playSlow(sender: UIButton) {
        playAudio(0.5)
    }
    @IBAction func playVader(sender: UIButton) {
        playModifiedAudio(-1000)

    }
    @IBAction func playChimpmunk(sender: UIButton) {
        playModifiedAudio(1000)
        
    }
    func playModifiedAudio(pitch: Float){
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
    }
    func playAudio(rate: Float){
        audioPlayer.stop()
        audioPlayer.rate = rate;
        audioPlayer.currentTime = 0;
        audioPlayer.play()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
