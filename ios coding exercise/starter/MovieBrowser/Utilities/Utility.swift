//
//  Utility.swift
//  MovieBrowser
//
//  Created by Ashok on 11/30/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import UIKit

extension UIImageView {
    func loadImge(withUrl url: URL) {
           DispatchQueue.global().async { [weak self] in
               if let imageData = try? Data(contentsOf: url) {
                   if let image = UIImage(data: imageData) {
                       DispatchQueue.main.async {
                           self?.image = image
                       }
                   }
               }
           }
       }
}
