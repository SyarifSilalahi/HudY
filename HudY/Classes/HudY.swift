//
//  HudY.swift
//  Pods
//
//  Created by Syarif on 11/10/17.
//
//

import UIKit
import MediaPlayer
import AVKit

open class HudY: UIView {
    open class var sharedInstance: HudY {
        struct Singleton {
            static let screenSize: CGRect = UIScreen.main.bounds
            static let instance = HudY(frame: CGRect(x: 0,y: 0,width: screenSize.width,height: screenSize.height))
        }
        return Singleton.instance
    }
    
    var contentView : UIView = UIView()
    private var isShown:Bool = false
    private let gifManager = SwiftyGifManager(memoryLimit:60)
    
    let background = UIView(frame: CGRect(x: 0 , y: 0, width: 150, height: 150))
    
    var player: AVPlayer?
    var playerLayer: AVPlayerLayer?
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.commonInit()
    }
    
    func updateFrame() {
        let window:UIWindow = UIApplication.shared.windows.first!
        HudY.sharedInstance.center = window.center
    }
    
    func commonInit(){
        background.alpha = 0.75
        background.backgroundColor = UIColor.darkGray
        background.layer.cornerRadius = 10
        background.clipsToBounds = true
        background.center = self.center
        addSubview(background)
    }
    
    open class func show(_ type: RPLoadingAnimationType = RPLoadingAnimationType.spininngDot, color:UIColor = UIColor.black, frame:CGRect = CGRect(x: 0 , y: 0, width: 140, height: 140)){
        let window = UIApplication.shared.windows.first!
        let content = HudY.sharedInstance
        content.backgroundColor = UIColor.lightGray.withAlphaComponent(0.7)
        
        if(!UIApplication.shared.isIgnoringInteractionEvents){
            UIApplication.shared.beginIgnoringInteractionEvents()
        }
        content.updateFrame()
        
        if content.superview == nil {
            //show the spinner
            content.alpha = 0.0
            window.addSubview(content)
            
            UIView.animate(withDuration: 0.33, delay: 0.0, options: .curveEaseOut, animations: {
                content.alpha = 1.0
            }, completion: nil)
            
            // Orientation change observer
            NotificationCenter.default.addObserver(
                content,
                selector: #selector(updateFrame),
                name: NSNotification.Name.UIApplicationDidChangeStatusBarOrientation,
                object: nil)
        }
        
        content.isShown = true
        
        content.addSubview(content.contentView)
        content.contentView.frame = frame
        content.contentView.center = content.center
        
        let animationView = RPLoadingAnimationView(
            frame: frame,
            type: type,
            colors: [color],
            size: frame.size
        )
        
        content.contentView.addSubview(animationView)
        animationView.setupAnimation()
    }
    
    open class func showGif(_ gifSource:String?, frame:CGRect = CGRect(x: 0 , y: 0, width: 140, height: 140), animated: Bool = true){
        let window = UIApplication.shared.windows.first!
        let content = HudY.sharedInstance
        content.backgroundColor = UIColor.lightGray.withAlphaComponent(0.7)
        
        if(!UIApplication.shared.isIgnoringInteractionEvents){
            UIApplication.shared.beginIgnoringInteractionEvents()
        }
        content.updateFrame()
        
        if content.superview == nil {
            //show the spinner
            content.alpha = 0.0
            window.addSubview(content)
            
            UIView.animate(withDuration: 0.33, delay: 0.0, options: .curveEaseOut, animations: {
                content.alpha = 1.0
            }, completion: nil)
            
            // Orientation change observer
            NotificationCenter.default.addObserver(
                content,
                selector: #selector(updateFrame),
                name: NSNotification.Name.UIApplicationDidChangeStatusBarOrientation,
                object: nil)
        }
        
        content.addSubview(content.contentView)
        content.contentView.frame = frame
        content.contentView.center = content.center
        
        let gif = UIImageView(frame: CGRect(x: 0 , y: 0, width: content.contentView.frame.size.width, height: content.contentView.frame.size.height))
        
        gif.contentMode = .scaleAspectFill
        gif.clipsToBounds = true
        content.contentView.addSubview(gif)
        if let imgName = gifSource {
            let gifImage = UIImage(gifName: imgName)
            gif.setGifImage(gifImage, manager: content.gifManager, loopCount: -1)
        }
        
        content.isShown = true
        
    }
    
    open class func showVideo(_ name:String?, frame:CGRect = CGRect(x: 0 , y: 0, width: 140, height: 140), animated: Bool = true){
        let window = UIApplication.shared.windows.first!
        let content = HudY.sharedInstance
        content.backgroundColor = UIColor.lightGray.withAlphaComponent(0.7)
        
        if(!UIApplication.shared.isIgnoringInteractionEvents){
            UIApplication.shared.beginIgnoringInteractionEvents()
        }
        content.updateFrame()
        
        if content.superview == nil {
            //show the spinner
            content.alpha = 0.0
            window.addSubview(content)
            
            UIView.animate(withDuration: 0.33, delay: 0.0, options: .curveEaseOut, animations: {
                content.alpha = 1.0
            }, completion: nil)
            
            // Orientation change observer
            NotificationCenter.default.addObserver(
                content,
                selector: #selector(updateFrame),
                name: NSNotification.Name.UIApplicationDidChangeStatusBarOrientation,
                object: nil)
        }
        
        content.addSubview(content.contentView)
        content.contentView.frame = frame
        content.contentView.center = content.center
        
        //setting video player
        let path = Bundle.main.path(forResource: name, ofType: "mp4")
        content.player = AVPlayer(url: NSURL(fileURLWithPath: path!) as URL)
        content.playerLayer = AVPlayerLayer(player: content.player)
        content.playerLayer!.frame = frame
        
        content.playerLayer!.videoGravity = AVLayerVideoGravityResizeAspectFill
        content.contentView.layer.addSublayer(content.playerLayer!)
        content.player!.play()
        content.player!.actionAtItemEnd = .none
        
        NotificationCenter.default.addObserver(
            content,
            selector: #selector(playerItemDidReachEnd),
            name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
            object: nil)
        
        content.isShown = true
    }
    
    func playerItemDidReachEnd() {
        player!.seek(to: kCMTimeZero)
    }
    
    open class func hide(_ completion: (() -> Void)? = nil) {
        
        let content = HudY.sharedInstance
        
        NotificationCenter.default.removeObserver(content)
        
        DispatchQueue.main.async(execute: {
            if(UIApplication.shared.isIgnoringInteractionEvents){
                UIApplication.shared.endIgnoringInteractionEvents()
            }
            //UIApplication.sharedApplication().beginIgnoringInteractionEvents()
            content.isUserInteractionEnabled = true
            if content.superview == nil {
                content.isShown = false
                return
            }
            
            UIView.animate(withDuration: 0.33, delay: 0.0, options: .curveEaseOut, animations: {
                content.alpha = 0.0
            }, completion: {_ in
                for view in content.contentView.subviews{
                    view.removeFromSuperview()
                }
                content.contentView.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
                content.alpha = 1.0
                content.removeFromSuperview()
                content.isShown = false
                completion?()
            })
        })
        
    }
    
}
