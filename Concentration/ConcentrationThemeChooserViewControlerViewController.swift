//
//  ConcentrationThemeChooserViewControlerViewController.swift
//  Concentration
//
//  Created by Minhax on 01/03/2020.
//  Copyright © 2020 Talha. All rights reserved.
//

import UIKit

class ConcentrationThemeChooserViewControlerViewController: UIViewController,UISplitViewControllerDelegate {

    let themes = [
        "Sports":"⚽️🏀🏈⚾️🥎🏐",
        "Animals":"🐶🐱🐭🦆🦄🦉",
        "Faces":"😅😂🤪🥶😘🥺",
    ]
    override func awakeFromNib() {
        splitViewController?.delegate = self
    }
    func splitViewController(
        _ splitViewController: UISplitViewController,
        collapseSecondary secondaryViewController: UIViewController,
        onto primaryViewController: UIViewController
    ) -> Bool {
        if let cvc = secondaryViewController as? ConcentrationViewController{
            if cvc.Theme == nil{
                return true
            }
        }
        return false
    }
    
    @IBAction func changeTheme(_ sender: UIButton) {
        if let cvc = splitViewDetailConcentrationViewController{
            if let themeName = sender.currentTitle, let theme = themes[themeName]{
                cvc.Theme = theme
            }
            
        }else if let cvc = lastSeguedToConcentrationViewController{
            if let themeName = sender.currentTitle, let theme = themes[themeName]{
                cvc.Theme = theme
            }
            navigationController?.pushViewController(cvc, animated: true)
        }
        else{
            performSegue(withIdentifier: "Choose Theme", sender: sender)
        }
    }
    private var splitViewDetailConcentrationViewController: ConcentrationViewController?{
        return splitViewController?.viewControllers.last as? ConcentrationViewController
    }
    private var lastSeguedToConcentrationViewController: ConcentrationViewController?
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Choose Theme"{
            if let button = sender as? UIButton{
                if let themeName = button.currentTitle , let theme = themes[themeName]{
                    if let cvc = segue.destination as? ConcentrationViewController{
                        cvc.Theme = theme
                        lastSeguedToConcentrationViewController = cvc
                    }
                }
            }
        }
    }
    

}
