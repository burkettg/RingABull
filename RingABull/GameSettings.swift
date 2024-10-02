//
//  GameSettings.swift
//  RingABull
//
//  Created by Greg Burkett on 10/2/24.
//

import Foundation
import SwiftUI

class GameSettings: ObservableObject {
    
    let defaults = UserDefaults.standard
    @Published var accuracy = ""
    @Published var currentCardCount = 0
    @Published var gameLevel = 0
    
}
