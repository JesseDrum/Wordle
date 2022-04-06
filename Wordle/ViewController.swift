//
//  ViewController.swift
//  Wordle
//
//  Created by Drum, Jesse on 4/4/22.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var guessTextField: UITextField!

    
    var answer: String = "BOATS"
    var guessCount = 0
    
    
    @IBOutlet var guess1L: [UILabel]!
    @IBOutlet var guess2L: [UILabel]!
    @IBOutlet var guess3L: [UILabel]!
    @IBOutlet var guess4L: [UILabel]!
    @IBOutlet var guess5L: [UILabel]!
    @IBOutlet var guess6L: [UILabel]!
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = guessTextField.text! + string
            return true
        
    }
    
    

    func getRandomAnswer()
    {
        answer = WordList.wordleWords.randomElement()?.uppercased() ?? "BOATS"
    }
    
    @IBAction func textFieldAction(_ sender: Any) {
        
      
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        clearScreen()
        guessTextField.delegate = self
        getRandomAnswer()
    }

    
    
    func fillInGuess(guess: String, labels: [UILabel])
    {
        
        for i in labels.indices
        {
            labels[i].text = guess[i]
        }
        
        //color block
        for i in 0...4
        {
            let currentLetter = guess[i]

            if currentLetter == answer[i]
            {
                labels[i].backgroundColor = UIColor.green
            }
            else if answer.contains(currentLetter)
            {
                labels[i].backgroundColor = UIColor.yellow

            }
            else{
                labels[i].backgroundColor = UIColor.gray
            }
            
        }
        
        
        
    }
    
    func isGuessValid(guess: String) -> Bool
    {
        if guess.count == 5 && WordList.allPossibleWords.contains(guess.lowercased())
        {
            return true
        }
        else
        {
            return false
        }
    }
    func clearScreen(){
        
        let allL = [guess1L, guess2L, guess3L, guess4L, guess5L, guess6L]
        
        for i in allL
        {
            for lable in i!
            {
                lable.backgroundColor = UIColor.clear
                lable.text = " "
                lable.layer.borderColor = UIColor.darkGray.cgColor
                lable.layer.borderWidth = 2
                lable.layer.cornerRadius = 5
            }
        }
        
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guessTextField.resignFirstResponder()
        performAction()
        guessTextField.text = ""
        return true
    }
    
    func performAction()
    {
        let guess = guessTextField.text!.uppercased()
        
        if isGuessValid(guess: guess) == true
        {
            switch guessCount {
            case 0:
                fillInGuess(guess: guess, labels: guess1L)
            case 1:
                fillInGuess(guess: guess, labels: guess2L)
            case 2:
                fillInGuess(guess: guess, labels: guess3L)
            case 3:
                fillInGuess(guess: guess, labels: guess4L)
            case 4:
                fillInGuess(guess: guess, labels: guess5L)
            case 5:
                fillInGuess(guess: guess, labels: guess6L)
            default:
                print("Ran out of guessess")
            }
        guessCount += 1
        }
        else
        {
            //
        }
        
    }
    
    
}







extension String {

    var length: Int {
        return count
    }

    subscript (i: Int) -> String {
        return self[i ..< i + 1]
    }

    func substring(fromIndex: Int) -> String {
        return self[min(fromIndex, length) ..< length]
    }

    func substring(toIndex: Int) -> String {
        return self[0 ..< max(0, toIndex)]
    }

    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)),
                                            upper: min(length, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }
}
