//
//  MediaDetailsViewController.swift
//  Imagenie
//
//  Created by Abdur Rehman on 30/06/2021.
//

import UIKit

class MediaDetailsViewController: UIViewController {
    @IBOutlet weak var likesLbl: UILabel!
    @IBOutlet weak var commentsLbl: UILabel!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var userProfileImg: UIImageView!
    @IBOutlet weak var imgView: UIImageView!

    var media:Media?

    override func viewDidLoad() {
        super.viewDidLoad()

        populateData()
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }

    func populateData(){
        guard let media = media else{
            self.dismiss(animated: true)
            return
        }

        likesLbl.text = String(media.likes ?? 0)
        commentsLbl.text = String(media.comments ?? 0) + " Comments"
        userNameLbl.text = media.user

        if let userImg = media.userImageURL{
            userProfileImg.kf.setImage(with: URL(string: userImg))
        }

        if let picture = media.webformatURL{
            imgView.kf.setImage(with: URL(string: picture))
        }
    }
}
