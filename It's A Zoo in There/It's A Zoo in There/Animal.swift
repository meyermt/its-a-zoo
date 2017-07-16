//
//  Animal.swift
//  It's A Zoo in There
//
//  Created by Michael Meyer on 7/13/17.
//  Copyright © 2017 Michael Meyer. All rights reserved.
//

import UIKit

class Animal {
    
    //MARK: Properties
    let name: String
    let species: String
    let age: Int
    let image: UIImage
    let soundPath: String
    
    //MARK: Initialization
    
    init (name: String, species: String, age: Int, image: UIImage, soundPath: String) {
        
        self.name = name
        self.species = species
        self.age = age
        self.image = image
        self.soundPath = soundPath
    
    }
    
    //MARK: Methods
    
    func dumpAnimalObject() {
        print("Animal Object: name=\(name), species=\(species), age=\(age), image=\(image)")
    }
}
