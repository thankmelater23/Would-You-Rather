//
//  MainViewController.swift
//  Would You Rather
//
//  Created by Andre on 5/26/18.
//  Copyright © 2018 Andre. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    if !Storage.fileExists(File.WWYRHistory, in: .documents){
      Storage.store([Duel](), to: Storage.Directory.documents, as: File.WWYRHistory)
    }
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
