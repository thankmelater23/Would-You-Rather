//
//  OptionsViewController.swift
//  Would You Rather
//
//  Created by Andre on 5/26/18.
//  Copyright © 2018 Andre. All rights reserved.
//

import UIKit

class OptionsViewController: UIViewController {
  @IBAction func segueOptionsToMain(_ sender: Any) {
//    performSegue(withIdentifier: Segue.unwind_to_main, sender: self)
    self.performSegue(withIdentifier: Segue.options_to_main, sender: nil)
//    self.dismiss(animated: true, completion: nil)
  }
  
  @IBOutlet weak var segueOptionsToMain: UIBarButtonItem!
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destinationViewController.
   // Pass the selected object to the new view controller.
   }
   */
  
}
