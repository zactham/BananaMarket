//
//  Credits.swift
//  Banana Market Remake
//
//  Created by Zac on 6/26/18.
//  Copyright © 2018 Zac. All rights reserved.
//

import UIKit

class CreditsiPad: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func resetGame(_ sender: Any) {
        let vc = UIStoryboard(name: "iPadMain", bundle: nil).instantiateViewController(withIdentifier: "TitleScreeniPad")as! TitleScreeniPad
        self.present(vc, animated: false, completion: nil)
        walletValueSevenDays = 20
        days = 1
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        if(endScreen == 1)
        {
            
            let vc = UIStoryboard(name: "iPadMain", bundle: nil).instantiateViewController(withIdentifier: "endGameSevenDaysiPad")as! EndViewControlleriPad
            self.present(vc, animated: false, completion: nil)
        }
        else
        {
            let vc = UIStoryboard(name: "iPadMain", bundle: nil).instantiateViewController(withIdentifier: "endGameUnlimitediPad")as! EndViewControllerUnlimitediPad
            self.present(vc, animated: false, completion: nil)
        }
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
