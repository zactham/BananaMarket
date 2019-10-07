//
//  ViewController.swift
//  Banana Market
//
//  Created by Justin C. Mullins, Zac Thamer, and Akshay Ponnamaneni on 4/8/18.
//  Copyright © 2018 Proj3ct. All rights reserved.
//

import UIKit
import AVFoundation


class UnlimitediPad: UIViewController
{
    
    @IBOutlet weak var wallet: UILabel!
    @IBOutlet weak var dayNumber: UILabel!
    
    @IBOutlet weak var bananaQuantity: UILabel!
    
    @IBOutlet weak var bananaPrice: UILabel!
    
    @IBOutlet weak var sellButton: UIButton!
    @IBOutlet weak var holdButton: UIButton!
    @IBOutlet weak var buyButton: UIButton!
    
    @IBOutlet weak var sliderValueLabel: UILabel!
    
    @IBOutlet weak var sliderValue: UISlider!
    
    var days = 1
    
    @IBAction func sellButtonPressed(_ sender: UIButton)
    {
        var bananaAmount = Int (bananaQuantity.text!)
        var sliderAmount = Int (sliderValueLabel.text!)
        var w = Int(wallet.text!)
        var bananaPriceAmount = Int (bananaPrice.text!)
        var d = Int(dayNumber.text!)
        days = d!
        if (bananaAmount! >= sliderAmount!)
        {
            bananaAmount = bananaAmount! - sliderAmount!
            w = w! + (bananaPriceAmount! * sliderAmount!)
            gameMode()
            
            
            print(String(describing: bananaAmount!))
            print(String(describing: w!))
            print(String(describing: d!))
            bananaQuantity.text = String(describing: bananaAmount!)
            wallet.text = String(describing: w!)
            walletValueUnlimited = w!
            dayNumber.text = String(describing: days)
            daysUnlimited = days
            bananaPriceAmount = Int(arc4random_uniform(10) + 1)
            bananaPrice.text = String(describing: bananaPriceAmount!)
        }
        else
        {
            //
        }
        greyButtons();
    }
    @IBAction func holdButtonPressed(_ sender: UIButton) {
        var d = Int(dayNumber.text!)
        days = d!
        gameMode()
        dayNumber.text = String(describing: days)
        daysUnlimited = days
        var bananaPriceAmount = Int(arc4random_uniform(10) + 1)
        bananaPrice.text = String(describing: bananaPriceAmount)
        
        greyButtons();
    }
    
    
    @IBAction func buyButtonPressed(_ sender: UIButton) {
        
        var bananaAmount = Int (bananaQuantity.text!)
        var sliderAmount = Int (sliderValueLabel.text!)
        var w = Int(wallet.text!)
        var bananaPriceAmount = Int (bananaPrice.text!)
        var d = Int(dayNumber.text!)
        days = d!
        if (w! >= sliderAmount! * bananaPriceAmount!)
        {
            bananaAmount = bananaAmount! + sliderAmount!
            w = w! - (bananaPriceAmount! * sliderAmount!)
            gameMode()
            
            bananaQuantity.text = String(describing: bananaAmount!)
            wallet.text = String(describing: w!)
            walletValueUnlimited = w!
            dayNumber.text = String(describing: days)
            daysUnlimited = days
            bananaPriceAmount = Int(arc4random_uniform(10) + 1)
            bananaPrice.text = String(describing: bananaPriceAmount!)
        }
        else
        {
            //
        }
        greyButtons();
    }
    
    
    @IBAction func ToggleSound(_ sender: Any)
    {
        //print("sound pressed")
        if(audioPlayer.isPlaying)
        {
            audioPlayer.pause()
        }
        else
        {
            audioPlayer.play()
        }
    }
    
    
    @IBAction func endGame(_ sender: Any) {
        let vc = UIStoryboard(name: "iPadMain", bundle: nil).instantiateViewController(withIdentifier: "endGameUnlimitediPad")as! EndViewControllerUnlimitediPad
        self.present(vc, animated: false, completion: nil)
        endScreen = 2;
    }
    
    
    func gameMode()
    {
        self.days+=1
    }
    
    // @IBAction func resetAction(_ sender: Any){}
    
    
    @IBAction func sliderChanged(_ sender: UISlider) {
        sliderValueLabel.text = String(Int(sliderValue.value))
        print("slider")
        greyButtons();
        
    }
    
    //GREYS OUT THE BUY AND SELL BUTTONS WHEN THEY CANT BE USED
    func greyButtons()
    {
        var bananaAmount = Int (bananaQuantity.text!)
        var sliderAmount = Int (sliderValueLabel.text!)
        var w = Int(wallet.text!)
        var bananaPriceValue = Int (bananaPrice.text!)
        
        if (bananaAmount! >= sliderAmount!)
        {
            let image = UIImage(named: "sellButton.png") as UIImage!
            sellButton.setImage(image, for: [])
        }
        else
        {
            let image = UIImage(named: "greySellButton.png") as UIImage!
            sellButton.setImage(image, for: [])
        }
        
        if (w! >= sliderAmount! * bananaPriceValue!)
        {
            let image = UIImage(named: "buyButton.png") as UIImage!
            buyButton.setImage(image, for: [])
        }
        else{
            let image = UIImage(named: "greyBuyButton.png") as UIImage!
            buyButton.setImage(image, for: [])
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        walletValueSevenDays = 20
        days = 1
        var bananaPriceAmount = Int(arc4random_uniform(10) + 1)
        bananaPrice.text = String(describing: bananaPriceAmount)
        greyButtons();
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
}

