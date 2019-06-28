//
//  NYCLoader.swift
//  NYTimes
//
//  Created by Paurush on 28/06/19.
//  Copyright © 2019 Paurush. All rights reserved.
//

import UIKit

class NYCLoader: UIView {
    
    lazy private var containerView: UIView = {
        let vw = UIView(frame: self.mainView!.frame)
        vw.isUserInteractionEnabled = false
        vw.backgroundColor = .clear
        let size: CGFloat = 80
        
        let progressView = UIView(frame: CGRect(x: 0, y: 0, width: size, height: size))
        progressView.center = vw.center
        progressView.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        progressView.clipsToBounds = true
        progressView.layer.cornerRadius = 10
        
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.frame = CGRect(x: 0, y: 0, width: size/2, height: size/2)
        activityIndicator.style = .whiteLarge
        activityIndicator.center = CGPoint(x: progressView.bounds.width / 2, y: progressView.bounds.height / 2)
        
        progressView.addSubview(activityIndicator)
        vw.addSubview(progressView)
        activityIndicator.startAnimating()
        return vw
    }()
    
    private let mainView: UIView? = {
        let appDel:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDel.window
    }()
    
    open class var shared: NYCLoader {
        struct Static {
            static let instance = NYCLoader()
        }
        return Static.instance
    }
    
    open func showProgressView() {
        hideProgressView()
        DispatchQueue.main.async {
            self.mainView?.addSubview(self.containerView)
            self.mainView?.isUserInteractionEnabled = false
        }
    }
    
    open func hideProgressView() {
        DispatchQueue.main.async {
            self.containerView.removeFromSuperview()
            self.mainView?.isUserInteractionEnabled = true
        }
    }
}


