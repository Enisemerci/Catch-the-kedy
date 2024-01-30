//
//  ViewController.swift
//  KedyiYakala
//
//  Created by Enis Semerci on 30.01.2024.
//

import UIKit

class ViewController: UIViewController {
    //Views
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var kedy1: UIImageView!
    @IBOutlet weak var kedy2: UIImageView!
    @IBOutlet weak var kedy3: UIImageView!
    @IBOutlet weak var kedy4: UIImageView!
    @IBOutlet weak var kedy5: UIImageView!
    @IBOutlet weak var kedy6: UIImageView!
    @IBOutlet weak var kedy7: UIImageView!
    @IBOutlet weak var kedy8: UIImageView!
    @IBOutlet weak var kedy9: UIImageView!
    //Variables
    var score = 0
    var timer = Timer()
    var counter = 0
    var kedyArray = [UIImageView]()
    var hideTimer = Timer()
    var highScore = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scoreLabel.text = "Score: \(score)"
        //Highscore Check
        let storedHighScore = UserDefaults.standard.object(forKey:"highscore")
        
        if storedHighScore == nil{
            highScore = 0
            highScoreLabel.text = "Highscore:\(highScore)"
        }
        if let newscore = storedHighScore as? Int{
            highScore = newscore
            highScoreLabel.text = "Highscore:\(highScore)"

        }
        
        
        //Images
        kedy1.isUserInteractionEnabled = true
        kedy2.isUserInteractionEnabled = true
        kedy3.isUserInteractionEnabled = true
        kedy4.isUserInteractionEnabled = true
        kedy5.isUserInteractionEnabled = true
        kedy6.isUserInteractionEnabled = true
        kedy7.isUserInteractionEnabled = true
        kedy8.isUserInteractionEnabled = true
        kedy9.isUserInteractionEnabled = true
        
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))

        kedy1.addGestureRecognizer(recognizer1)
        kedy2.addGestureRecognizer(recognizer2)
        kedy3.addGestureRecognizer(recognizer3)
        kedy4.addGestureRecognizer(recognizer4)
        kedy5.addGestureRecognizer(recognizer5)
        kedy6.addGestureRecognizer(recognizer6)
        kedy7.addGestureRecognizer(recognizer7)
        kedy8.addGestureRecognizer(recognizer8)
        kedy9.addGestureRecognizer(recognizer9)
        
        kedyArray = [kedy1,kedy2,kedy3,kedy4,kedy5,kedy6,kedy7,kedy8,kedy9]

        //Timers
        counter = 10
        timeLabel.text = "\(counter)"
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countdown), userInfo: nil, repeats: true)
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hidekedy), userInfo: nil, repeats: true)
        hidekedy()
        
    }
    @objc func hidekedy(){
        for kedy in kedyArray{
            kedy.isHidden = true
        }
        
        //random
        let random = Int(arc4random_uniform(UInt32(kedyArray.count - 1)))
        kedyArray[random].isHidden = false
    }
    
    
    @objc func increaseScore(){
        score += 1
        scoreLabel.text = "Score:\(score)"
    }
    @objc func countdown(){
        counter -= 1
        timeLabel.text = "\(counter)"
        
        if counter==0{
            timer.invalidate()
            hideTimer.invalidate()
            for kedy in kedyArray{
                kedy.isHidden = true
            }
            //HighScore
            if self.score > self.highScore{
                self.highScore = self.score
                highScoreLabel.text = "High Score:\(highScore)"
                UserDefaults.standard.setValue(self.highScore, forKey: "highscore")
            }
            
            //ALERT
            let alert = UIAlertController(title: "Time's up", message: "Do you want to play again", preferredStyle: UIAlertController.Style.alert)
            
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
            let replayButton = UIAlertAction(title: "REPLAY", style: UIAlertAction.Style.default) { UIAlertAction in
                //Replay func
                self.score = 0
                self.scoreLabel.text = String(self.score)
                self.counter = 10
                self.timeLabel.text = String(self.counter)
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countdown), userInfo: nil, repeats: true)
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hidekedy), userInfo: nil, repeats: true)
                self.hidekedy()
            }
            alert.addAction(okButton)
            alert.addAction(replayButton)
            self.present(alert, animated: true, completion: nil)
            
        }
    }

}

