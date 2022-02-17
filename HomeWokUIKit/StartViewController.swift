//
//  StartViewController.swift
//  HomeWokUIKit
//
//  Created by Даниил Франк on 13.02.2022.
//

import UIKit


class StartViewController: UIViewController{

    @IBAction func unwindSegue(_ segue: UIStoryboardSegue) {
        let colorVC = segue.source as! ColorViewController
        colorVC.colorDelegate = self
        colorVC.setColor()
    }
}

extension StartViewController: SetColorDelegate {
    func setColor(color: UIColor) {
        view.backgroundColor = color
    }
}


