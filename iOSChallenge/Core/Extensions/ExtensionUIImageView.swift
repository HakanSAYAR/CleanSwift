//
//  ExtensionUIImageView.swift
//  iOSChallenge
//
//  Created by Hakan SAYAR on 10.02.2019.
//  Copyright © 2019 Hakan SAYAR. All rights reserved.
//

import UIKit

extension UIImageView{
    public func loadImage(urlString: String) {
        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
            if let error = error{
                print("failed to fetch image",error)
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                self.image = image
            })
        }).resume()
    }
}

