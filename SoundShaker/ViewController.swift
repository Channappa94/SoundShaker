//
//  ViewController.swift
//  SoundShaker
//
//  Created by IMCS2 on 8/7/19.
//  Copyright © 2019 com.phani. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    var count : Int = 0
    var player = AVAudioPlayer()
    var songs = ["firstSong", "malhari", "Zingaat", "humpty", "chasma", "guru", "kar", "queen", "simba"]
    @IBAction func playButton(_ sender: Any) {
        player.play()
    }
    
    @IBAction func pauseButton(_ sender: Any) {
        player.pause()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        soundAlabum()
        swiping()
    }
    
    
    func soundAlabum(){
        print(count)
        let audioPath = Bundle.main.path(forResource: songs[count], ofType: "mp3")
        do{
            player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath!))
        }catch{
            print("Error while playing")
        }
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if event?.subtype == UIEvent.EventSubtype.motionShake{
            print("Device is shaken")
            let number = Int.random(in: 0...8)
            count = number
            soundAlabum()
            player.play()
        }
    }
    
    
    func swiping(){
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.swiped(gesture:)))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.swiped(gesture:)))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        self.view.addGestureRecognizer(swipeLeft)
    }
    
    @IBAction func swiped(gesture: UISwipeGestureRecognizer){
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            if swipeGesture.direction == UISwipeGestureRecognizer.Direction.right{
                print("swiped right")
                if count == 8{
                    count = 8
                    soundAlabum()
                }else{
                    count += 1
                    soundAlabum()
                }
                
            }else{
                print("swiped left")
                if count == 0{
                    count = 0
                    soundAlabum()
                }else{
                    count -= 1
                    soundAlabum()
                }
            }
        }
        
    }
    
    
    
    
    
}


