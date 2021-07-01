//
//  HeaderCollectionReusableView.swift
//  Imagenie
//
//  Created by Abdur Rehman on 30/06/2021.
//

import UIKit

class HeaderCollectionReusableView: UICollectionReusableView {
    @IBOutlet weak var seeMoreBtn: UIButton!
    @IBOutlet weak var headerLbl: UILabel!
    var seeMoreTapped:(()->Void)!

    @IBAction func seeMoreTapped(_ sender: Any) {
        seeMoreTapped()
    }
}
