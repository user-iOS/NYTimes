//
//  NYCMasterCell.swift
//  NYTimes
//
//  Created by Paurush on 28/06/19.
//  Copyright © 2019 Paurush. All rights reserved.
//

import UIKit

class NYCMasterCell: UITableViewCell {
    
    @IBOutlet weak var imgViewArticle: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblByAuthor: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    
    var nycModel: NYCModel? {
        didSet {
            configureCell()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imgViewArticle.layer.cornerRadius = 25
    }
    
    func configureCell() {
        if let model = nycModel {
            self.imgViewArticle.loadImage(urlString: model.media.first?.media_metadata.first?.url ?? "")
            self.lblTitle.text = model.title
            self.lblByAuthor.text = model.byline
            self.lblDate.text = model.published_date
        }
    }
}
