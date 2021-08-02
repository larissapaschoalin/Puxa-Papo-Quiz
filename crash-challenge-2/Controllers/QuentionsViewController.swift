//
//  QuentionsViewController.swift
//  crash-challenge-2
//
//  Created by Larissa Paschoalin on 30/07/21.
//

import UIKit

class QuentionsViewController: UIViewController {
    
    @IBOutlet weak var option1: UIView!
    @IBOutlet weak var option2: UIView!
    @IBOutlet weak var textOption1: UILabel!
    @IBOutlet weak var textOption2: UILabel!
    @IBOutlet weak var buttonNext: UIButton!
    
    
    private var isDragging = false
    private var initialPositionX: CGFloat = 0
    private var initialPositionY: CGFloat = 0
    private var option1Players: Set<Player> = []
    private var option2Players: Set<Player>  = []
    
    var players: [Player] = []
    var options: [Options] = []
    var currentQuestion = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createBalls()
        buttonNext.layer.cornerRadius = 10
        setOptions(option: options[currentQuestion])
    }
    
    func setOptions(option: Options) {
        textOption1.text = option.option1text
        textOption2.text = option.option2text
    }
    
    @objc func draggingView(_ sender: UIPanGestureRecognizer) {
        let point = sender.location(in: view)
        let draggedView = sender.view! as! PlayerUIView
        draggedView.center = point
        
        switch sender.state {
        case .began:
            self.initialPositionX = draggedView.frame.origin.x
            self.initialPositionY = draggedView.frame.origin.y
            if let player = draggedView.player {
                self.option1Players.remove(player)
                self.option2Players.remove(player)
            }
        
        case .ended:
            if draggedView.frame.intersects(option1.frame) {
                draggedView.frame.origin.x = (option1.frame.size.width/2) - (draggedView.frame.size.width/2)
                print("localizou")
                if let player = draggedView.player {
                    option1Players.insert(player)
                }
            }
            else if draggedView.frame.intersects(option2.frame) {
                draggedView.frame.origin.x = (option2.frame.size.width / 2 + option2.frame.size.width) 
                print("localizou2")
                if let player = draggedView.player {
                    option2Players.insert(player)
                }
            }
            else {
                print("fora")
            }
            
        default:
            break
            
        }

    }
    
    
    func createBall(player: Player, x: CGFloat) {
        let y: CGFloat = 200
        let ball = PlayerUIView(frame: CGRect(x: x, y: y, width: 50, height: 50))
        ball.backgroundColor = player.color
        ball.layer.cornerRadius = 25
        ball.contentMode = .scaleAspectFit
        
        let label = UILabel(frame: CGRect(x: 20, y: 10, width: 30, height: 30))
        label.text = player.nameFirstLetter
        ball.addSubview(label)
        ball.player = player
        
        self.view.addSubview(ball)
        
        let gestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(draggingView))
        ball.addGestureRecognizer(gestureRecognizer)
        
    }

    func createBalls() {
        var x: CGFloat = 120
        for player in players {
            createBall(player: player, x: x)
            x += 80
        }
    }
    
    @IBAction func nextQuestion(_ sender: Any) {
        Compatibility.assignCompatibility(players: Array(option1Players), option: options[currentQuestion])
        Compatibility.assignCompatibility(players: Array(option2Players), option: options[currentQuestion])
      
        if self.currentQuestion == options.count - 1 {
            let finalController = storyboard?.instantiateViewController(identifier: "final") as! FinalViewController
            finalController.modalPresentationStyle = .fullScreen
            present(finalController, animated: false)
            return
        }
        let questionController = storyboard?.instantiateViewController(identifier: "questions") as! QuentionsViewController
        questionController.modalPresentationStyle = .fullScreen
        questionController.players = players
        questionController.options = options
        questionController.currentQuestion = self.currentQuestion + 1
        present(questionController, animated: false)
    }
    
}

