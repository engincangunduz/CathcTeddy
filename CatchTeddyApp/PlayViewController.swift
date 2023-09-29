//
//  PlayViewController.swift
//  CatchTeddyApp
//
//  Created by Engin Gündüz on 27.09.2023.
//

import UIKit

class PlayViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func playClicked(_ sender: Any) {
        performSegue(withIdentifier: "toPlayVC", sender: nil)
    }
}
