//
//  ViewController.swift
//  CatchTeddyApp
//
//  Created by Engin Gündüz on 26.09.2023.
//

import UIKit

class ViewController: UIViewController {
    var score = 0
    var counter = 0
    var timer = Timer()
    var teddyArray = [UIImageView]()
    var hideTimer = Timer()
    var highScore = 0
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highscoreLabel: UILabel!
    @IBOutlet weak var teddy1: UIImageView!
    @IBOutlet weak var teddy2: UIImageView!
    @IBOutlet weak var teddy3: UIImageView!
    @IBOutlet weak var teddy4: UIImageView!
    @IBOutlet weak var teddy5: UIImageView!
    @IBOutlet weak var teddy6: UIImageView!
    @IBOutlet weak var teddy7: UIImageView!
    @IBOutlet weak var teddy8: UIImageView!
    @IBOutlet weak var teddy9: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        scoreLabel.text = "Score \(score)"
        
        //highScore Check
        
        let storedHighScore = UserDefaults.standard.object(forKey: "highscore")
        
        if storedHighScore == nil {
            highScore = 0
            highscoreLabel.text = "HighScore: \(highScore)"
        }
        
        if let newScore = storedHighScore as? Int {
            highScore = newScore
            highscoreLabel.text = "HighScore: \(highScore)"
        }
        
        teddy1.isUserInteractionEnabled = true
        teddy2.isUserInteractionEnabled = true
        teddy3.isUserInteractionEnabled = true
        teddy4.isUserInteractionEnabled = true
        teddy5.isUserInteractionEnabled = true
        teddy6.isUserInteractionEnabled = true
        teddy7.isUserInteractionEnabled = true
        teddy8.isUserInteractionEnabled = true
        teddy9.isUserInteractionEnabled = true
        
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        teddy1.addGestureRecognizer(recognizer1)
        teddy2.addGestureRecognizer(recognizer2)
        teddy3.addGestureRecognizer(recognizer3)
        teddy4.addGestureRecognizer(recognizer4)
        teddy5.addGestureRecognizer(recognizer5)
        teddy6.addGestureRecognizer(recognizer6)
        teddy7.addGestureRecognizer(recognizer7)
        teddy8.addGestureRecognizer(recognizer8)
        teddy9.addGestureRecognizer(recognizer9)
        
        teddyArray = [teddy1, teddy2, teddy3, teddy4, teddy5, teddy6, teddy7, teddy8, teddy9]
        //Timers
        counter = 20
        timeLabel.text = String(counter)
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideTeddy), userInfo: nil, repeats: true)
        
        hideTeddy()
    }
    
    @objc func hideTeddy() {
        for teddy in teddyArray {
            teddy.isHidden = true
        }
        
        let random = Int(arc4random_uniform(UInt32(teddyArray.count - 1)))
        teddyArray[random].isHidden = false
        
    }
    
    @objc func increaseScore(){
        score = score + 1
        scoreLabel.text = "Score \(score)"
    }
    
    @objc func countDown(){
        counter -= 1
        timeLabel.text = String(counter)
        
        if counter == 0{
            timer.invalidate()
            hideTimer.invalidate()
            
            for teddy in teddyArray {
                teddy.isHidden = true
            }
            
            //HighScore
            if self.score > self.highScore {
                self.highScore = self.score
                highscoreLabel.text = "HighScore: \(highScore)"
                UserDefaults.standard.set(self.highScore, forKey: "highscore")
            }
            
            //Alert
            let alert = UIAlertController(title: "Time's Up", message: "Do you want to play again?", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel)
            let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { UIAlertAction in
                
                self.score = 0
                self.scoreLabel.text = "Score \(self.score)"
                self.counter = 20
                self.timeLabel.text = String(self.counter)
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hideTeddy), userInfo: nil, repeats: true)
                
                if self.score > self.highScore {
                    self.highScore = self.score
                    self.highscoreLabel.text = "HighScore: \(self.highScore)"
                    UserDefaults.standard.set(self.highScore, forKey: "highscore")
                }
            }
            alert.addAction(okButton)
            alert.addAction(replayButton)
            self.present(alert, animated: true)
        }
    }
}
