//
//  OverviewViewController.swift
//  Internship_Cogniteq
//
//  Created by Siarova Katsiaryna on 9.03.21.
//

import UIKit
import Alamofire
import AlamofireImage

class OverviewViewController: UIViewController {
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    
    var film: Films.Results?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        if let posterPath = film?.posterPath, let url = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)") {
            posterImageView.af.setImage(withURL: url)
            titleLabel.text = film?.title
            overviewLabel.text = film?.overview
            yearLabel.text = film?.getYear()
        }
    }
}
