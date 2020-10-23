//
//  ViewController.swift
//  Concentration
//
//  Created by Zak Kaid on 9/9/20.
//  Copyright © 2020 Zak Kaid. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count+1)/2)
    
    private var themeBackgroundColor: UIColor?
    private var themeCardColor: UIColor?
    private var themeCardTitles: [String]?
    
   
   
    private let halloweenTheme = Theme.init(backgroundColor: .black, cardColor: .orange, cardTitles: ["👻","🍬","🍭","🦇","💀","👽","🎃","👺","👹","🍫"])
    private let smilesTheme = Theme.init(backgroundColor: #colorLiteral(red: 1, green: 0.2527923882, blue: 1, alpha: 1), cardColor: #colorLiteral(red: 0, green: 0.9914394021, blue: 1, alpha: 1), cardTitles: ["😁","😊","🙂","😄","😌","🥰","🙃","😂","☺️","😋"])
    private let upsetTheme = Theme.init(backgroundColor:#colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1) , cardColor:#colorLiteral(red: 0.5791940689, green: 0.1280144453, blue: 0.5726861358, alpha: 1) , cardTitles: ["😔","😕","☹️","😣","😩","😢","😠","😡","🤬","😤"])
    private let foodTheme = Theme.init(backgroundColor: #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1), cardColor: #colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1), cardTitles: ["🍔","🍟","🍕","🥨","🌮","🍗","🍙","🍪","🍩","🌭"])
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTheme()
        updateViewFromModel()
        resetButton.isHidden = false
    }
    
    private func setTheme() {
        let themes = [halloweenTheme, smilesTheme, upsetTheme, foodTheme]
        let randomTheme = themes.count.arc4random
        print(themes[randomTheme])
        themeBackgroundColor = themes[randomTheme].backgroundColor
        themeCardColor = themes[randomTheme].cardColor
        themeCardTitles = themes[randomTheme].cardTitles
        view.backgroundColor = themeBackgroundColor
        resetButton.tintColor = themeCardColor
        
    }
    
    
    
    private var numberOfPairsOfCards: Int {
        return (cardButtons.count+1)/2
    }
    
   private var emojiChoices = "👻🍬🍭🦇💀👽🎃👺👹🍫"
    
    //[Int : String]() is also a dictionary
    private var emoji = Dictionary<Int, String>()
   
   private(set) var flipCount = 0 {
       didSet{
           flipCountLabel.text = "Flips: \(flipCount)"
       }
   }
    
    
   @IBOutlet private weak var flipCountLabel: UILabel!
    
    @IBOutlet private weak var resetButton: UIButton!
    
    @IBOutlet private var cardButtons: [UIButton]!
   
   
    
    
    
   @IBAction private func touchCard(_ sender: UIButton){
    /*let cardNumber = cardButtons.firstIndex(of: sender)!
    print("cardNumber = \(cardNumber)")
    flipCard(withEmoji: emojiChoices[cardNumber], on: sender)*/
    flipCount += 1
      if let cardNumber = cardButtons.firstIndex(of: sender){
           game.chooseCard(at: cardNumber)
           updateViewFromModel()
       }else{
           print("Chosen card was not in cardButtons")
       }
   }
    
    
    
    @IBAction private func resetButtonPressed(_ sender: UIButton) {
        resetButton.isHidden  = false
        flipCount = 0
        game.resetCards()
        setTheme()
        game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
        updateViewFromModel()
        
        
        
    }
    
    
    func flipCard(withEmoji emoji: String, on button: UIButton){
        if button.currentTitle == emoji{
            button.setTitle("", for: UIControl.State.normal)
            button.backgroundColor = #colorLiteral(red: 1, green: 0.5451101562, blue: 0.01321644701, alpha: 0.8470588235)
        }else{
            button.setTitle(emoji, for: UIControl.State.normal)
            button.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
        }
    }
   
    
    
   private func updateViewFromModel(){
       for index in cardButtons.indices {
           let button = cardButtons[index]
           let card = game.cards[index]
           if card.isFaceUp{
            button.setTitle(emoji(for: card), for: UIControl.State.normal)
            button.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)

           }else{
            button.setTitle("", for: UIControl.State.normal)
            
            if card.isMatched {
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
            }else{
                button.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
         }
           
       }
   }
    
    
    
    func emoji(for card: Card) -> String {
        //can combine nested if statements together. makes it so it meets all conditions.
        if emoji[card.identifier] == nil, emojiChoices.count > 0{
            let randomStringIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.count.arc4random)
                emoji[card.identifier] = String(emojiChoices.remove(at: randomStringIndex))
        /*if emoji[card] == nil && themeCardTitles != nil{
            emoji[card] = themeCardTitles!.remove(at: (themeCardTitles?.count.arc4random)!)*/
            }
        
        return emoji[card.identifier] ?? "?"
    }


}

extension Int {
    var arc4random: Int{
        if self > 0 {
            return Int (arc4random_uniform(UInt32(self)))
        }else if self < 0 {
            return -Int (arc4random_uniform(UInt32(-self)))
        }else{
            return 0
        }
    }
}
