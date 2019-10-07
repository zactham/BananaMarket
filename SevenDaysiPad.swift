//
//  ViewController.swift
//  Banana Market
//
//  Created by Justin C. Mullins, Zac Thamer, and Akshay Ponnamaneni on 4/8/18.
//  Copyright © 2018 Proj3ct. All rights reserved.
//

import UIKit
import AVFoundation


// make a global variable so it can be accessed from anywhere



class SevenDaysiPad: UIViewController
{
    
    @IBOutlet weak var sellButton: UIButton!
    @IBOutlet weak var holdButton: UIButton!
    @IBOutlet weak var buyButton: UIButton!
    
    @IBOutlet weak var sevenDaysLabel: UILabel!
    
    @IBOutlet weak var wallet: UILabel!
    
    @IBOutlet weak var dayNumber: UILabel!
    
    @IBOutlet weak var bananaQuantity: UILabel!
    
    @IBOutlet weak var bananaPrice: UILabel!
    
    
    
    @IBOutlet weak var sliderValueLabel: UILabel!
    
    @IBOutlet weak var sliderValue: UISlider!
    
    var currentPrice = 0
    
    
    @IBAction func sellButtonPressed(_ sender: UIButton)
    {
        
        var bananaAmount = Int (bananaQuantity.text!)
        var sliderAmount = Int (sliderValueLabel.text!)
        var w = Int(wallet.text!)
        var bananaPriceValue = Int (bananaPrice.text!)
        currentPrice = bananaPriceValue!
        if(days<8)
        {
            if (bananaAmount! >= sliderAmount!)
            {
                bananaAmount = bananaAmount! - sliderAmount!//- for sell
                w = w! + (bananaPriceValue! * sliderAmount!)
                bananaQuantity.text = String(describing: bananaAmount!)
                wallet.text = String(describing: w!)
                walletValueSevenDays = w!
                dayNumber.text = String(describing: days)
                bananaPriceValue = Int(arc4random_uniform(10) + 1)
                bananaPrice.text = String(describing: bananaPriceValue!)
                
                gameMode()
            }
            greyButtons();
        }
        
        
        
    }
    @IBAction func holdButtonPressed(_ sender: UIButton) {
        
        if(days<8)
        {
            var bananaPriceValue = Int(arc4random_uniform(10) + 1)
            currentPrice = bananaPriceValue
            
            dayNumber.text = String(describing: days)
            bananaPrice.text = String(describing: bananaPriceValue)
            
            gameMode()
            greyButtons();
            
            
        }
        
    }
    
    
    @IBAction func buyButtonPressed(_ sender: UIButton) {
        
        var bananaAmount = Int (bananaQuantity.text!)
        var sliderAmount = Int (sliderValueLabel.text!)
        var w = Int(wallet.text!)
        var bananaPriceValue = Int (bananaPrice.text!)
        currentPrice = bananaPriceValue!
        
        if(days<8)
        {
            if (w! >= sliderAmount! * bananaPriceValue!)
            {
                bananaAmount = bananaAmount! + sliderAmount!//+ for buy
                w = w! - (bananaPriceValue! * sliderAmount!)
                
                
                bananaQuantity.text = String(describing: bananaAmount!)
                wallet.text = String(describing: w!)
                walletValueSevenDays = w!
                dayNumber.text = String(describing: days)
                bananaPriceValue = Int(arc4random_uniform(10) + 1)
                bananaPrice.text = String(describing: bananaPriceValue!)
                
                gameMode()
            }
            greyButtons();
            
        }
        
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
    
    @IBAction func backButton(_ sender: Any) {
        walletValueSevenDays = 20
        days = 1
        endScreen = 0
    }
    func gameMode()
    {
        days+=1
        
        if(days<8)
        {
            print("next day");
            
        }
        else
        {
            endGame();
        }
    }
    
    
    
    @objc func endGame()
    {
        let vc = UIStoryboard(name: "iPadMain", bundle: nil).instantiateViewController(withIdentifier: "endGameSevenDaysiPad")as! EndViewControlleriPad
        self.present(vc, animated: false, completion: nil)
        endScreen = 1
        
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
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        days = 1
        walletValueSevenDays = 20
        gameMode()
        var bananaPriceValue = Int(arc4random_uniform(10) + 1)
        print("view loaded")
        bananaPrice.text = String(describing: bananaPriceValue)
        greyButtons();
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
}


