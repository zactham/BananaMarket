//
//  TitleScreen.swift
//  Banana Market Remake
//
//  Created by Zac on 6/22/18.
//  Copyright © 2018 Zac. All rights reserved.
//

import UIKit
import AVFoundation
import StoreKit
import CoreData

var audioPlayer = AVAudioPlayer()//sound
var endScreen = 0
var purchasedRemoveAds = 0




class TitleScreen: UIViewController, SKProductsRequestDelegate, SKPaymentTransactionObserver {

    @IBOutlet weak var removeAdsButton: UIButton!
    
    @IBOutlet weak var restorePurchasesButton: UIButton!
    
    var list = [SKProduct]()
    var p = SKProduct()
    
    var purchasedRemovedAdsDefault = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         removeAdsButton.layer.cornerRadius = 4
         restorePurchasesButton.layer.cornerRadius = 4
         removeAdsButton.isEnabled = false
         restorePurchasesButton.isEnabled = false
        if(purchasedRemoveAds == 1)
        {
            removeAdsButton.isHidden = true;
        }
        
       
        
        //Plays sound even if phone is on silent mode
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
        }
        catch {
            // report for an error
        }
        
        //Plays sound
        do
        {
            audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "SmoothJazz", ofType: "wav")!))
            audioPlayer.prepareToPlay()
            audioPlayer.play()
            //Loops the sound
            audioPlayer.numberOfLoops = -1
            
        }
        catch{
            print(error)
        }
        if(SKPaymentQueue.canMakePayments()) {
            print("IAP is enabled, loading")
            let productID: NSSet = NSSet(objects: "zac.Banana.Market.Remake.removeAds")
            let request: SKProductsRequest = SKProductsRequest(productIdentifiers: productID as! Set<String>)
            request.delegate = self
            request.start()
        } else {
            print("please enable IAPS")
        }
        // Do any additional setup after loading the view.
        
        //
        // LOAD IN THE PREVIOUS HIGH SCORE
        //
        var highScoreDefault = UserDefaults.standard
        if(highScoreDefault.value(forKey: "highScore") != nil)
        {
            highScoreInt = highScoreDefault.value(forKey: "highScore") as! NSInteger
            print("Loading HIGH SCORE from user defaults as: ", highScoreInt);
        }
        else
        {
            print("No HIGH SCORE key found");
        }
        
        var purchasedAdsDefault = UserDefaults.standard
        if(purchasedAdsDefault.value(forKey: "purchasedAds") != nil)
        {
            purchasedRemoveAds = purchasedAdsDefault.value(forKey: "purchasedAds") as! NSInteger
            print("Loading purchased ads value from user defaults as: ", purchasedRemoveAds);
        }
        else
        {
            print("No purchasedAds key found");
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func howToPlayButton(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "InstructionsID")as! Instructions
        self.present(vc, animated: false, completion: nil)
    }
    
  
    @IBAction func toggleSound(_ sender: Any)
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
    
    @IBAction func removeAds(_ sender: UIButton)
    {
        //purchasedRemoveAds = true
        print("rem ads")
        for product in list {
            let prodID = product.productIdentifier
            if(prodID == "zac.Banana.Market.Remake.removeAds") {
                p = product
                buyProduct()
            }
        }
    }
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        print("product request")
        let myProduct = response.products
        print("myProduct size=");
        print(myProduct.count);
        for product in myProduct {
            print("product added")
            print(product.productIdentifier)
            print(product.localizedTitle)
            print(product.localizedDescription)
            print(product.price)
            
            list.append(product)
        }
            removeAdsButton.isEnabled = true
            restorePurchasesButton.isEnabled = true
       
    }
    
    public func buyProduct() {
        print("buy " + p.productIdentifier)
        let pay = SKPayment(product: p)
        SKPaymentQueue.default().add(self)
        SKPaymentQueue.default().add(pay as SKPayment)
        
    }
    
    func updateAdsVariable()
    {
        var purchasedAdsDefault = UserDefaults.standard
        purchasedAdsDefault.setValue(purchasedRemoveAds, forKey: "purchasedAds")
        print("Saving PURCHASED ADS to UserDefault as: ", purchasedRemoveAds);
        purchasedAdsDefault.synchronize()
    }
    
    @IBAction func restorePurchases(_ sender: Any)
    {
        SKPaymentQueue.default().add(self)
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
   
    func paymentQueueRestoreCompletedTransactionsFinished(_ queue: SKPaymentQueue) {
        print("transactions restored")
        for transaction in queue.transactions {
            let t: SKPaymentTransaction = transaction
            let prodID = t.payment.productIdentifier as String
            
            switch prodID {
            case "zac.Banana.Market.Remake.removeAds":
                print("remove ads")
                purchasedRemoveAds = 1
                updateAdsVariable()
                UserDefaults.standard.set(true, forKey: "Key") //Bool
            default:
                print("IAP not found")
            }
        }
        
        
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        print("add payment")
        
        for transaction: AnyObject in transactions {
            let trans = transaction as! SKPaymentTransaction
            print(trans.error)
            
            switch trans.transactionState {
            case .purchased:
                print("buy ok, unlock IAP HERE")
                print(p.productIdentifier)
                
                let prodID = p.productIdentifier
                switch prodID {
                case "zac.Banana.Market.Remake.removeAds":
                    print("remove ads")
                    purchasedRemoveAds = 1
                    updateAdsVariable()
                default:
                    print("IAP not found")
                }
                queue.finishTransaction(trans)
            case .failed:
                print("buy error")
                queue.finishTransaction(trans)
                break
            default:
                print("Default")
                break
            }
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
