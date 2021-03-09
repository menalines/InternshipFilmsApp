//
//  FilmCell.swift
//  Internship_Cogniteq
//
//  Created by Siarova Katsiaryna on 5.03.21.
//

import UIKit
import Alamofire
import AlamofireImage

class FilmCell: UITableViewCell {
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var overviewButton: UIImageView!
    
    func configure(posterPath: String?, title: String?, overview: String?, year: String?) {
        if let posterPath = posterPath, let url = URL(string: "https://image.tmdb.org/t/p/w500/\(posterPath)") {
            posterImageView.af.setImage(withURL: url)
        }
        
        titleLabel.text = title
        overviewLabel.text = overview
        yearLabel.text = year
    }
}
