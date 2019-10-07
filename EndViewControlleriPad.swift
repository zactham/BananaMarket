//
//  EndViewController.swift
//  Banana Market Remake
//
//  Created by Zac on 5/29/18.
//  Copyright © 2018 Zac. All rights reserved.
//

import UIKit
import TwitterKit
import TwitterCore
import GoogleMobileAds


class EndViewControlleriPad: UIViewController, TWTRComposerViewControllerDelegate{
    
     var bannerView: GADBannerView!
    
    
    @IBOutlet weak var highScore: UILabel!
    @IBOutlet weak var score: UILabel!
    
    @IBOutlet var imgTweet: UIImageView!
    @IBOutlet var tvTweet: UITextView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(purchasedRemoveAds == 0)
        {
            bannerAds()
        }
        
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
        highScore.text = String(describing: highScoreInt)
        
        
        
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
    
    
    // Saves out high score
    func updateHighScore ()
    {
        score.text = String(describing: walletValueSevenDays)
        if(walletValueSevenDays > highScoreInt)//SETS HIGHSCORE
        {
            highScoreInt = walletValueSevenDays
            highScore.text = String(describing: highScoreInt)
            print("New HIGH SCORE was achieved, value: ", highScoreInt);
        }
        
        var highScoreDefault = UserDefaults.standard
        highScoreDefault.setValue(highScoreInt, forKey: "highScore")
        print("Saving HIGH SCORE to UserDefault as: ", highScoreInt);
        highScoreDefault.synchronize()
        
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  
    

    
    @IBAction func mainMenu(_ sender: UIButton)
    {
        let vc = UIStoryboard(name: "iPadMain", bundle: nil).instantiateViewController(withIdentifier: "TitleScreeniPad")as! TitleScreeniPad
        self.present(vc, animated: false, completion: nil)
        
        walletValueSevenDays = 20
        days = 1
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
            let composer = TWTRComposerViewController.init(initialText: "Your final wallet amount in BANANA MARKET's 7 Day Mode is $ \(walletValueSevenDays) https://itunes.apple.com/us/app/banana-market/id1412538188?ls=1&mt=8 ", image: shareImg2, videoURL: nil)
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
                    
                    let composer = TWTRComposerViewController.init(initialText: "Your final wallet amount in BANANA MARKET's 7 Day Mode is $ \(walletValueSevenDays) https://itunes.apple.com/us/app/banana-market/id1412538188?ls=1&mt=8 ", image: shareImg2, videoURL: nil)
                    composer.delegate = self
                    self.present(composer, animated: true, completion: nil)
                    
                    
                    
                } else {
                    let alert = UIAlertController(title: "No Twitter Accounts Available", message: "You must log in before presenting a composer.", preferredStyle: .alert)
                    self.present(alert, animated: false, completion: nil)
                }
            }
        }
    }
    
    
    
    
    
    //MARK:- TWTRComposerViewControllerDelegate
    
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
