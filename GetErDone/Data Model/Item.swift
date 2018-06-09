//
//  Item.swift
//  GetErDone
//
//  Created by Steven Nguyen on 2018-06-08.
//  Copyright © 2018 Steven Nguyen. All rights reserved.
//

import Foundation

class Item: Codable{
    
    // Marking this class Encodable means that its objects can encode itself into a plist or JSON
    // For a class to be of type Encodable, it cannot have custom classes in it, it must have the standard data types (String, int, bool, etc.)
    
    // Must conform to Encodable AND Decodable classes or simple just Codable
    
    var task: String = ""  //Name of task
    var done: Bool = false  // Whether 'checked' or not

}
