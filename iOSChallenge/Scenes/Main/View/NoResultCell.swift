//
//  NoResultCell.swift
//  iOSChallenge
//
//  Created by Hakan SAYAR on 11.02.2019.
//  Copyright © 2019 Hakan SAYAR. All rights reserved.
//

import UIKit

class NoResultCell: UICollectionViewCell {
    
    @IBOutlet weak var noResultLabel: UILabel!
    
    var _text: String?{
        didSet{
            noResultLabel?.text = _text ?? ""
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

