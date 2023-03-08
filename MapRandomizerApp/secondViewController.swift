//
//  secondViewController.swift
//  MapRandomizerApp
//
//  Created by CHRISTIAN BOURQUIN on 2/16/23.
//

import UIKit

class secondViewController: UIViewController {
    var incoming : [String] = []
    var incomingD : [String] = []
    var tIncoming : [String] = []
    var tIncomingD : [String] = []
    

    @IBOutlet weak var labelOutlet: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        var test = Int.random(in:1..<3)
        if test == 1 && tIncoming.count > 0{
            var k = Int.random(in: 0..<tIncoming.count)
            labelOutlet.text = "\(tIncoming[k]): \(tIncomingD[k])"

        }
        else{
            var k = Int.random(in: 0..<incoming.count)
            labelOutlet.text = "\(incoming[k]): \(incomingD[k]) mi"
        }
        
    }

    @IBAction func randomize(_ sender: Any) {
        var test = Int.random(in:1..<3)
        if test == 1 && tIncoming.count > 0{
            var k = Int.random(in: 0..<tIncoming.count)
            labelOutlet.text = "\(tIncoming[k]): \(tIncomingD[k])"

        }
        else{
            var k = Int.random(in: 0..<incoming.count)
            labelOutlet.text = "\(incoming[k]): \(incomingD[k]) mi"
        }
        
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
