//
//  EndViewControllerUnlimited.swift
//  Banana Market Remake
//
//  Created by Zac on 6/22/18.
//  Copyright © 2018 Zac. All rights reserved.
//

import UIKit
import TwitterKit
import TwitterCore
import GoogleMobileAds

class EndViewControllerUnlimited: UIViewController, TWTRComposerViewControllerDelegate{

    var bannerView: GADBannerView!

    @IBOutlet weak var days: UILabel!
    @IBOutlet weak var score: UILabel!
    
    @IBOutlet var imgTweet: UIImageView!
    @IBOutlet var tvTweet: UITextView!
    
    //Takes a screenshot for the share
    var screenshot = UIGraphicsGetImageFromCurrentImageContext()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(purchasedRemoveAds == 0)
        {
            bannerAds()
        }
        
        //UPDATES WALLET AND DAY 
        score.text = String(describing: walletValueUnlimited)
        days.text = String(describing: daysUnlimited)
        
    }
    
    //Screenshot
    func takeScreenshot()
    {
        let bounds = UIScreen.main.bounds
        UIGraphicsBeginImageContextWithOptions(bounds.size, true, 0.0)
        self.view.drawHierarchy(in: bounds, afterScreenUpdates: false)
        screenshot = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }
    
    @IBAction func brownShareButton(_ sender: UIButton) {
        takeScreenshot()
        
        let activityController = UIActivityViewController(activityItems: [screenshot], applicationActivities: nil)
        
        present(activityController, animated: true, completion: nil)
        
        
        
        
        
    }
    
    
    ////TESTING - ca-app-pub-3940256099942544/2934735716
    ////PUBLISHING - ca-app-pub-9397447406737552/2579722617
    func bannerAds()
    {
        // In this case, we instantiate the banner with desired ad size.
        bannerView = GADBannerView(adSize: kGADAdSizeBanner)
        bannerView.delegate = self as? GADBannerViewDelegate
        addBannerViewToView(bannerView)
        
        bannerView.adUnitID = "ca-app-pub-9397447406737552/2579722617"
        bannerView.rootViewController = self
        
        bannerView.load(GADRequest())
        
        
    }
    
    func addBannerViewToView(_ bannerView: GADBannerView) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bannerView)
        view.addConstraints(
            [NSLayoutConstraint(item: bannerView,
                                attribute: .bottom,
                                relatedBy: .equal,
                                toItem: bottomLayoutGuide,
                                attribute: .top,
                                multiplier: 1,
                                constant: 0),
             NSLayoutConstraint(item: bannerView,
                                attribute: .centerX,
                                relatedBy: .equal,
                                toItem: view,
                                attribute: .centerX,
                                multiplier: 1,
                                constant: 0)
            ])
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //RESTARTS THE GAME
    @IBAction func restartGame(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "UnlimitedID")as! Unlimited
        self.present(vc, animated: false, completion: nil)
        walletValueUnlimited = 20
        daysUnlimited = 1
        
    }
    
    @IBAction func mainMenu(_ sender: UIButton) {
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TitleScreen")as! TitleScreen
        self.present(vc, animated: false, completion: nil)
        
        walletValueUnlimited = 20
        daysUnlimited = 1
        endScreen = 0
    }
    
    
    @IBAction func twitterShare(_ sender: UIButton) {
        print("Shared")
        
        if (TWTRTwitter.sharedInstance().sessionStore.hasLoggedInUsers()) {
            // App must have at least one logged-in user to compose a Tweet
            
            guard let shareImg2 = UIImage.init(named: "happyBanana.png") else{
                print("failed init share img")
                return
            }
            //let shareImg = UIImage.init(named: "mountain")!
            let composer = TWTRComposerViewController.init(initialText: "Your final wallet amount in BANANA MARKET's Unlimited Mode in \(daysUnlimited) day is $\(walletValueUnlimited) https://itunes.apple.com/us/app/banana-market/id1412538188?ls=1&mt=8 ", image: shareImg2, videoURL: nil)
            composer.delegate = self
            present(composer, animated: true, completion: nil)
            
        } else {
            // Log in, and then check again
            TWTRTwitter.sharedInstance().logIn { session, error in
                if session != nil { // Log in succeeded
                    
                    guard let shareImg2 = UIImage.init(named: "happyBanana.png") else{
                        print("failed init share img")
                        return
                    }
                    
                    let composer = TWTRComposerViewController.init(initialText: "Your final wallet amount in BANANA MARKET's Unlimited Mode in \(daysUnlimited) day is $ \(walletValueUnlimited) https://itunes.apple.com/us/app/banana-market/id1412538188?ls=1&mt=8 ", image: shareImg2, videoURL: nil)
                    composer.delegate = self
                    self.present(composer, animated: true, completion: nil)
                    
                    
                    
                } else {
                    let alert = UIAlertController(title: "No Twitter Accounts Available", message: "You must log in before presenting a composer.", preferredStyle: .alert)
                    self.present(alert, animated: false, completion: nil)
                }
            }
        }
    }
    
    func composerDidCancel(_ controller: TWTRComposerViewController) {
        print("composerDidCancel, composer cancelled tweet")
    }
    
    func composerDidSucceed(_ controller: TWTRComposerViewController, with tweet: TWTRTweet) {
        print("composerDidSucceed tweet published")
    }
    func composerDidFail(_ controller: TWTRComposerViewController, withError error: Error) {
        print("composerDidFail, tweet publish failed == \(error.localizedDescription)")
    }
    
    @IBAction func Credits(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CreditsScreen")as! Credits
        self.present(vc, animated: false, completion: nil)
    }
    
    
   

}
