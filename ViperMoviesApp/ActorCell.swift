//
//  ActorCell.swift
//  ViperMoviesApp
//
//  Created by Kamil Zajac on 07.05.2017.
//  Copyright © 2017 Kamil Zajac. All rights reserved.
//

import UIKit

class ActorCell: UICollectionViewCell {
    @IBOutlet weak var movieImgView: UIImageView!
    @IBOutlet weak var movieTitleLbl: UILabel!
    @IBOutlet weak var movieDateLbl: UILabel!
    
    func configureCollectionView(movie: MovieModel) {
        movieDateLbl.text = movie.releaseDate!
        movieTitleLbl.text = movie.title!
        movieImgView.sd_setImage(with: movie.photoURL as URL) { (image, error, cache, url) in
            self.movieImgView.image = image
        }
    }
}
