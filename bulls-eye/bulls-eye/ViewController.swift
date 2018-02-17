//
//  ViewController.swift
//  bulls-eye
//
//  Created by Ильин Роман on 16.02.2018.
//  Copyright © 2018 Romax. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var currentSliderValue = 0
    var targetValue = 0
    var score = 0
    var round = 0
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLbl: UILabel!
    @IBOutlet weak var scoreLbl: UILabel!
    @IBOutlet weak var roundLbl: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        startNewRound()
        let thumbImageNormal = UIImage(named: "SliderThumb-Normal")
        slider.setThumbImage(thumbImageNormal, for: .normal)
        let thumbImageHighlighted = UIImage(named: "SliderThumb-Highlighted")
        slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        let trackLeftImage = UIImage(named: "SliderTrackLeft")
        let trackLeftResizable = trackLeftImage?.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        let trackRightImage = UIImage(named: "SliderTrackRight")
        let trackRightResizable = trackRightImage?.resizableImage(withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightResizable, for: .normal)
    }
    
    func startNewRound() {
        targetValue = Int(arc4random_uniform(101))
        currentSliderValue = 50
        slider.value = Float(currentSliderValue)
        round += 1
        updateLabels()
    }
    
    func updateLabels() {
        targetLbl.text = "\(targetValue)"
        scoreLbl.text = "\(score)"
        roundLbl.text = "\(round)"
    }
    
    @IBAction func sliderMoved(_ slider: UISlider) {
        currentSliderValue = lroundf(slider.value)
    }
    
    
    @IBAction func showAlert() {
        
        let difference = abs(currentSliderValue - targetValue)
        var points = 100 - difference
        
        let title: String
        if difference == 0 {
            title = "Perfect!"
            points += 100
        } else if difference < 5 {
            title = "You almost had it!"
            if difference == 1 {
                points += 50
            }
        } else if difference < 10 {
            title = "Pretty good!"
        } else {
            title = "Not even close..."
        }
        
        score += points
        
        let message = "You scored \(points) points"
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Awesome", style: .default, handler: {
            action in
                self.startNewRound()
        })
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func startOverWasPressed(_ sender: UIButton) {
        round = 0
        score = 0
        startNewRound()
    }
}

