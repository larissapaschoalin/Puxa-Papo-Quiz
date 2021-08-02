//
//  ViewController.swift
//  crash-challenge-2
//
//  Created by Larissa Paschoalin on 29/07/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var player1TextField: UITextField!
    @IBOutlet weak var player2TextField: UITextField!
    @IBOutlet weak var player3TextField: UITextField!
    
    var colors: [UIColor] = [#colorLiteral(red: 0.3811334074, green: 0.1510561407, blue: 0.7868052125, alpha: 1), #colorLiteral(red: 0.9569618106, green: 0.6907653213, blue: 0, alpha: 1), #colorLiteral(red: 0, green: 0.7542755008, blue: 0.7943208814, alpha: 1)]
    var players: [Player] = []
    var options: [Options] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        changeTextFieldColors()
        // Do any additional setup after loading the view.
        startButton.layer.cornerRadius = 10
        
        options = [Options(option1text: "Nescau", option2text: "Toddy"), Options(option1text: "Uma viagem para o passado", option2text: "Uma viagem para o futuro"), Options(option1text: "Refrigerante sem gás", option2text: "Suco quente"), Options(option1text: "Ter apenas o dia do seu aniversário", option2text: "Ter apenas o Natal"), Options(option1text: "Nunca mais comer sua comida favorita", option2text: "Nunca mais ouvir sua música favorita")]
    }

    func changeTextFieldColors() {
        player1TextField.layer.masksToBounds = true
        player1TextField.layer.borderColor = colors[0].cgColor
        player1TextField.layer.borderWidth = 1.0
        player1TextField.layer.cornerRadius = 5
        
        player2TextField.layer.masksToBounds = true
        player2TextField.layer.borderColor = colors[1].cgColor
        player2TextField.layer.borderWidth = 1.0
        player2TextField.layer.cornerRadius = 5
        
        player3TextField.layer.masksToBounds = true
        player3TextField.layer.borderColor = colors[2].cgColor
        player3TextField.layer.borderWidth = 1.0
        player3TextField.layer.cornerRadius = 5
    }
    
    func savePlayers() {
        if let player1 = player1TextField.text {
            players.append(Player(name: player1, color: colors[0]))
        }
        if let player2 = player2TextField.text {
            players.append(Player(name: player2, color: colors[1]))
        }
        if let player3 = player3TextField.text {
            players.append(Player(name: player3, color: colors[2]))
        }
    }
    
    @IBAction func start(_ sender: Any) {
        self.savePlayers()
        Compatibility.all = Compatibility.startCompatibilities(players: players, totalOptions: options.count)
        let vc = storyboard?.instantiateViewController(identifier: "questions") as! QuentionsViewController
        vc.modalPresentationStyle = .fullScreen
        vc.players = players
        vc.options = options
        vc.currentQuestion = 0
        present(vc, animated: true)
    }
    
}

