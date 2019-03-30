//
//  ViewController.swift
//  TicTacToe
//
//  Created by Martin Løseth Jensen on 29/03/2019.
//  Copyright © 2019 Martin Løseth Jensen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var playAgainButton: UIButton!
    var count = 0
    var gameIsActive = true
    var activePlayer = 1 // cross
    var gameState = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    var winningCombinations = [
        [0, 1, 2],
        [3, 4, 5],
        [6, 7, 8],
        [0, 3, 6],
        [1, 4, 7],
        [2, 5, 8],
        [0, 4, 8],
        [2, 4, 6]
    ]

    @IBOutlet weak var label: UILabel!

    @IBAction func resetGame(_ sender: Any) {
        playAgainButton.isHidden = true
        count = 0
        gameIsActive = true
        activePlayer = 1 // cross
        gameState = [0, 0, 0, 0, 0, 0, 0, 0, 0]
        label.text = "X-player will start"

        for i in 1...9 {
            let subview = view.viewWithTag(i)
            if subview?.isKind(of: UIButton.self) == true {
                let button = subview as! UIButton
                button.setImage(nil, for: .normal)
            } else {
                print("Tag \(i) is not configured right")
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        playAgainButton.isHidden = true
    }

    @IBAction func buttonClicked(_ sender: UIButton) {
        print("Button pressed: \(sender.tag)")
        print("Activeplayer: \(activePlayer)")

        if (gameState[sender.tag - 1] == 0 && gameIsActive) {
            count += 1 // for checking draw
            gameState[sender.tag - 1] = activePlayer

            if (activePlayer == 1) {
                label.text = "It's 0-player's turn"
                sender.setImage(UIImage.init(named: "X-player"), for: UIControl.State())
                activePlayer = 2
            } else {
                label.text = "It's X-player's turn"
                sender.setImage(UIImage(named: "O-player"), for: UIControl.State())
                activePlayer = 1
            }
        }

        for combination in winningCombinations {

            if gameState[combination[0]] != 0 && gameState[combination[0]] == gameState[combination[1]] && gameState[combination[1]] == gameState[combination[2]] {

                if gameState[combination[0]] == 1 {
                    gameIsActive = false
                    label.text = "X-player has won"
                } else {
                    gameIsActive = false
                    label.text = "O-player has won"
                }
            }

            if gameIsActive && count == 9 {
                if count == 9 {
                    gameIsActive = false
                    label.text = "It was a draw"
                    playAgainButton.isHidden = false
                }
            }
            playAgainButton.isHidden = false
        }
    }
}

