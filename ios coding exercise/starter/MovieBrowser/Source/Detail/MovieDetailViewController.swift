//
//  MovieDetailViewController.swift
//  SampleApp
//
//  Created by Struzinski, Mark on 2/26/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    @IBOutlet weak var titleName: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    
    var filteredItem : Movie?
    var imageBaseUrl = "https://image.tmdb.org/t/p/w200/"
    private var preDateText = "Release Date: "
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let item = filteredItem else {
            return
        }
        
        textView.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        setData(item : item)
    }
    
    private func setData(item : Movie) {
        titleName.text = item.title ?? ""
        date.text = preDateText
        if let dat = item.releaseDate {
            preDateText = preDateText + (formatDate(date: dat) ?? "")
            date.text = preDateText
        }
        textView.text = item.overview ?? ""
        if let path = item.posterPath {
            imageView.loadImge(withUrl: URL(string: imageBaseUrl + path)!)
        }
    }
    
    private func formatDate(date: String) -> String? {
       let dateFormatterGet = DateFormatter()
       dateFormatterGet.dateFormat = "yyyy-MM-dd"

       let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
      
       let dateObj: Date? = dateFormatterGet.date(from: date)
        guard let obj = dateObj else {
            return nil
        }
        
       return dateFormatter.string(from: obj)
    }
}


