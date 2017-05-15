//
//  VideoModel.swift
//  ViperMoviesApp
//
//  Created by Kamil Zajac on 04.05.2017.
//  Copyright © 2017 Kamil Zajac. All rights reserved.
//

import UIKit

struct VideoModel {
    
    let videoKey: String
    
    var videoURL: NSURL {
        return movieVideoURL()
    }
    
    private func movieVideoURL() -> NSURL {
        return NSURL(string: "https://www.youtube.com/embed/\(videoKey)")!
    }

    
}
