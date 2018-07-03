//
//  UIViewControllerExt.swift
//  Goal Post App
//
//  Created by Oforkanji Odekpe on 7/3/18.
//  Copyright © 2018 Oforkanji Odekpe. All rights reserved.
//

import UIKit

extension UIViewController{
    
    //Custom Animation to Present View Controller
    func presentDetail(_ viewControllerToPresent: UIViewController){
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight
        self.view.window?.layer.add(transition, forKey: kCATransition)
        
        present(viewControllerToPresent, animated: false, completion: nil)
    }
    
    //Custom Animation to Dismiss View Controller
    func dismissDetail(){
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromLeft
        self.view.window?.layer.add(transition, forKey: kCATransition)
        
        dismiss(animated: false, completion: nil)
    }
}
