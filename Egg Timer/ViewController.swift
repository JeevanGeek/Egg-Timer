//
//  ViewController.swift
//  Egg Timer
//
//  Created by Jeevan Chandra Joshi on 09/01/23.
//

import AVFoundation
import UIKit

class ViewController: UIViewController {
    @IBOutlet var progressBar: UIProgressView!
    @IBOutlet var titleLabel: UILabel!

    let eggTimes = ["Soft": 3, "Medium": 5, "Hard": 7]
    var timer = Timer()
    var player: AVAudioPlayer?
    var totalTime = 0
    var timePassed = 0

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func eggSelected(_ sender: UIButton) {
        let hardness = sender.currentTitle!
        timer.invalidate()
        totalTime = eggTimes[hardness]!
        progressBar.progress = 0.0
        timePassed = 0
        titleLabel.text = hardness
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }

    @objc func updateTimer() {
        if timePassed < totalTime {
            timePassed += 1
            progressBar.progress = Float(timePassed) / Float(totalTime)
        } else {
            timer.invalidate()
            titleLabel.text = "DONE!"
            guard let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3") else {
                return
            }
            do {
                player = try AVAudioPlayer(contentsOf: url)
                player?.play()
            } catch {}
        }
    }
}
