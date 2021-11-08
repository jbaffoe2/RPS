//
//  ViewController.swift
//  RPS
//
//  Created by Baffoe, Joseph - FUT on 11/3/21.
//

import UIKit
import SafariServices

class ViewController: UIViewController, SFSafariViewControllerDelegate
{

    //Declare Global Outlets and Variables
    @IBOutlet weak var cpuSelection: UIImageView!
    
    @IBOutlet weak var youSelected: UIImageView!
  
    @IBOutlet weak var gameMovesView: UIStackView!
    
    @IBOutlet var singleTapped: UITapGestureRecognizer!
 
    @IBOutlet var imagesView: [UIImageView]!
    
    var images:[UIImage] = []
    
    var userChoice = 3
    
    @IBOutlet weak var yourScoreLabel: UILabel!
    
    var yourScore = 0
    
    @IBOutlet weak var cpuScoreLabel: UILabel!
    
    var cpuScore = 0
    
    @IBOutlet weak var tieScoreLabel: UILabel!
    
    var tieScore = 0
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //Create Images Array
        let rockImage = UIImage(named: "Rock")
        let paperImage = UIImage(named: "Paper")
        let scissorsImage = UIImage(named: "Scissors")
        images = [rockImage, paperImage, scissorsImage] as! [UIImage]
        
    }
    
//Action Function for Rock, Paper and Scissors Selection
    @IBAction func tappedImages(_ sender: UITapGestureRecognizer)
    {
        
        //Assign tapped point for User Choice
        let selectedPoint = ((sender as! AnyObject).location(in: gameMovesView))
        
        for view in imagesView
        {
            if view.frame.contains(selectedPoint)
            {
                userChoice = view.tag
                youSelected.image = images[userChoice]
            }
        }
        
        //Assign Computer Choice Randomly
        let randomNum = Int.random(in: 0...2)
        cpuSelection.image = images[randomNum]
        
        //Call Alert for displayEndGame
        winnerDes(cpuChoice: randomNum)
        
        //Display Scores
        yourScoreLabel.text = "\(yourScore)"
        cpuScoreLabel.text = "\(cpuScore)"
        tieScoreLabel.text = "\(tieScore)"
      
    }
    
    func winnerDes(cpuChoice: Int)
    {
        if youSelected.image == UIImage()
        {
            displayEndGame(message: "You Lose! Play Again.")
            cpuScore += 1
            
        } else if userChoice == cpuChoice
        {
            displayEndGame(message: "Tie Game!")
            tieScore += 1
        }else if userChoice == 0 && cpuChoice == 1
        {
            displayEndGame(message: "You Lose! Play Again.")
            cpuScore += 1
        }else if userChoice == 0 && cpuChoice == 2
        {
            displayEndGame(message: "You Win! Great Job!")
            yourScore += 1
        }else if userChoice == 1 && cpuChoice == 0
        {
            displayEndGame(message: "You Win! Great Job!")
            yourScore += 1
        }else if userChoice == 1 && cpuChoice == 2
        {
            displayEndGame(message: "You Lose! Play Again.")
            cpuScore += 1
        }else if userChoice == 2 && cpuChoice == 0
        {
            displayEndGame(message: "You Lose! Play Again.")
            cpuScore += 1
        }else if userChoice == 2 && cpuChoice == 1
        {
            displayEndGame(message: "You Win! Great Job!")
            yourScore += 1
        }else
        {
            displayEndGame(message: "You Lose! Play Again.")
            cpuScore += 1
        }
        
        
    }
    
    func displayEndGame(message: String)
    {
        //Declare Alert
        let alert = UIAlertController(title: "Good Game!", message: message, preferredStyle: .alert)
        
        //OKs alert
        let ok = UIAlertAction(title: "OK", style: .default)
        {
            action in
            print("OK Pressed")
            self.youSelected.image = UIImage(named: "Select")
            self.cpuSelection.image = UIImage(named: "Select")
            
        }
        alert.addAction(ok)
        
        //Present Alert
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK: Stretch #1
    //Function for Rules URL
    @IBAction func urlButton(_ sender: UIBarButtonItem)
    {
        let myURL = URL(string: "https://en.wikipedia.org/wiki/Rock_paper_scissors")
        let svc = SFSafariViewController(url: myURL!)
        svc.delegate = self
        self.present(svc, animated: true, completion: nil)
    }
    
}

