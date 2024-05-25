//
//  ShortCuts.swift
//  DEPD
//
//  Created by Shahzaib I. Bhatti on 22/05/2024.
//

import UIKit

enum StoryBoard: String {
    case main = "Main"
}

func getStoryBoard(_ storyBoard: StoryBoard) -> UIStoryboard {
    return UIStoryboard(name: storyBoard.rawValue, bundle: nil)
}
