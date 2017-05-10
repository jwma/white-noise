//
//  ViewController.swift
//  white-noise
//
//  Created by 马嘉威 on 2017/5/10.
//  Copyright © 2017年 马嘉威. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var sounds: [String: NSObject] = [String: NSObject]()
    let mapping: [String: String] = ["100": "thunder", "200": "raining"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        readyPlayer()
    }
    
    func readyPlayer() {
        
        createPlayerByType(type: "thunder")
        createPlayerByType(type: "raining")
        
        let audioSession = AVAudioSession.sharedInstance()
        
        do {
            try audioSession.setCategory(AVAudioSessionCategoryPlayback)
        } catch {
            
        }
    }
    
    func createPlayerByType(type: String) {
        do {
            let player = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: type, ofType: "mp3")!))
            player.prepareToPlay()
            player.numberOfLoops = -1
            player.volume = 0.5
            
            sounds[type] = player
        } catch {
            print(error)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getPlayerByTag(tag: Int) -> AVAudioPlayer{
        let tag = "\(tag)"
        let type = mapping[tag]
        
        return sounds[type!] as! AVAudioPlayer
    }
    
    @IBAction func play(_ sender: UIButton) {
        let player = getPlayerByTag(tag: sender.tag)
        player.play()
    }
    
    @IBAction func stop(_ sender: UIButton) {
        let player = getPlayerByTag(tag: sender.tag)
        player.currentTime = 0
        player.stop()
    }
    
    @IBAction func changeVolume(_ sender: UISlider) {
        let player = getPlayerByTag(tag: sender.tag)
        player.volume = sender.value
    }
}

