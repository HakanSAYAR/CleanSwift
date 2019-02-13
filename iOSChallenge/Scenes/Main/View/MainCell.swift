//
//  MainCell.swift
//  iOSChallenge
//
//  Created by Hakan SAYAR on 10.02.2019.
//  Copyright © 2019 Hakan SAYAR. All rights reserved.
//

import UIKit

class MainCell: UICollectionViewCell{
    
    @IBOutlet weak var searchImageView: UIImageView!
    @IBOutlet weak var searchTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with viewModel: SearchListViewModel) {
        contentView.backgroundColor = viewModel.isVisited ? UIColor.darkGray : UIColor.white
        searchImageView.loadImage(urlString: viewModel.imagePath!)
        searchTitleLabel.text = viewModel.title
    }
}

