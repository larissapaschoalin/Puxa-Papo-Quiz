//
//  FinalViewController.swift
//  crash-challenge-2
//
//  Created by Larissa Paschoalin on 01/08/21.
//

import UIKit

class FinalViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var finalTable: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.finalTable.dataSource = self
        self.finalTable.delegate = self

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Compatibility.all.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "finalCell", for: indexPath) as! FinalTableViewCell
        let compatibility = Compatibility.all[indexPath.row]
        
        cell.player1Label.text = compatibility.player1.nameFirstLetter
        cell.player1View.backgroundColor = compatibility.player1.color
        cell.player1View.layer.cornerRadius = 40
        cell.player1NameLabel.text = compatibility.player1.name
        
        cell.player2Label.text = compatibility.player2.nameFirstLetter
        cell.player2View.backgroundColor = compatibility.player2.color
        cell.player2View.layer.cornerRadius = 40
        cell.player2NameLabel.text = compatibility.player2.name
        
        cell.compatibilityLabel.text = "\(compatibility.percentage)%"
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
