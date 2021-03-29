//
//  SearchCell.swift
//  Internship_Cogniteq
//
//  Created by Siarova Katsiaryna on 10.03.21.
//

import UIKit
import Alamofire
import AlamofireImage

class SearchCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    
    func configure(title: String?, year: String?) {
        titleLabel.text = title
        yearLabel.text = year
    }
}
