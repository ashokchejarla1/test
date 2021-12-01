//
//  MovieTableViewCell.swift
//  MovieBrowser
//
//  Created by Ashok on 11/30/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var titleName: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var date: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUp(model : Movie) {
        titleName.text = model.title ?? ""
        if let rDate =  model.releaseDate {
            date.text = formatDate(date: rDate) ?? ""
        }
       
        rating.text = "\(model.voteAverage ?? 0.0)"
    }
    
    private func formatDate(date: String) -> String? {
       let dateFormatterGet = DateFormatter()
       dateFormatterGet.dateFormat = "yyyy-MM-dd"

       let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd, yyyy"
      
       let dateObj: Date? = dateFormatterGet.date(from: date)
        guard let obj = dateObj else {
            return nil
        }
        
       return dateFormatter.string(from: obj)
    }

}
