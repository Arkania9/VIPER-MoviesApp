//
//  DetailsMovieCell.swift
//  ViperMoviesApp
//
//  Created by Kamil Zajac on 05.05.2017.
//  Copyright © 2017 Kamil Zajac. All rights reserved.
//

import UIKit

class DetailsMovieCell: UITableViewCell {

    @IBOutlet weak var actorImgView: UIImageView!
    @IBOutlet weak var actorRealNameLbl: UILabel!
    @IBOutlet weak var actorMovieNameLbl: UILabel!

    func configureCastTableView(actor: ActorModel) {
        actorRealNameLbl.text = actor.actorName
        actorMovieNameLbl.text = actor.actorCharacter
        actorImgView.sd_setImage(with: actor.photoURL as URL, completed: { (image, error, cache, url) in
            self.actorImgView.image = image
        })
    }
    
}
