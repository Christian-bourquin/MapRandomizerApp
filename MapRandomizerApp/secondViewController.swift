//
//  secondViewController.swift
//  MapRandomizerApp
//
//  Created by CHRISTIAN BOURQUIN on 2/16/23.
//

import UIKit

class secondViewController: UIViewController {
    var incoming : [String] = []
    
    @IBOutlet weak var labelOutlet: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        labelOutlet.text = incoming[Int.random(in: 0..<incoming.count)]
    }

    @IBAction func randomize(_ sender: Any) {
        labelOutlet.text = incoming[Int.random(in: 0..<incoming.count)]
        
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
