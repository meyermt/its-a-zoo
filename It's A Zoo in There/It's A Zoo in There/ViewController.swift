//
//  ViewController.swift
//  It's A Zoo in There
//
//  Created by Michael Meyer on 7/13/17.
//  Copyright © 2017 Michael Meyer. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UIScrollViewDelegate {
    
    //MARK: Properties
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var label: UILabel!
    var animals: [Animal] = [Animal]()
    var animalPlayer: AVAudioPlayer?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let kittyImage = UIImage(named: "kitty")
        let animal1 = Animal(name: "Killer", species: "Kitty", age: 1, image: kittyImage!, soundPath: "catSound")
        animals.append(animal1)
        let puppyImage = UIImage(named: "puppy")
        let animal2 = Animal(name: "Redford", species: "Doggy", age: 2, image: puppyImage!, soundPath: "dogSound")
        animals.append(animal2)
        let seahorseImage = UIImage(named: "seahorse")
        let animal3 = Animal(name: "Darthy", species: "Seahorse", age: 908, image: seahorseImage!, soundPath: "darthSound")
        animals.append(animal3)
        animals.shuffle()
        
        // - Attributions: https://stackoverflow.com/questions/39772422/how-to-set-scrollview-content-size-in-swift-3-0
        self.scrollView.contentSize = CGSize(width: 1125, height: 500)
        
        label.text! = animals[0].species
        
        var x = 0
        // - Attributions: https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/CollectionTypes.html
        for (index, value) in animals.enumerated() {
            print(value.dumpAnimalObject())
            let button = UIButton(frame: CGRect(x: x, y: 20, width: 375, height: 50))
            button.setTitle(value.name, for: .normal)
            button.tag = index
            button.setTitleColor(.blue, for: .normal)
            button.isHidden = false
            button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
            scrollView.addSubview(button)
            let imageView = UIImageView(image: value.image)
            imageView.frame = CGRect(x: x, y: 70, width: 375, height: 430)
            scrollView.addSubview(imageView)
            x += 375
        }
        self.scrollView.delegate = self
    }
    
    //MARK: UIScrollViewDelegate Protocol Adoption
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        label.alpha = 1
        switch scrollView.bounds.minX {
        case 0:
            label.text! = animals[0].species
        case 375:
            label.text! = animals[1].species
        case 750:
            label.text! = animals[2].species
        default: break
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        switch scrollView.bounds.minX {
        case 0..<187:
            calculateAlpha(Float(187 - scrollView.bounds.minX))
            label.text! = animals[0].species
        case 187..<375:
            calculateAlpha(Float(scrollView.bounds.minX - 187))
            label.text! = animals[1].species
        case 375..<562:
            calculateAlpha(Float(562 - scrollView.bounds.minX))
            label.text! = animals[1].species
        case 562..<750:
            calculateAlpha(Float(scrollView.bounds.minX - 562))
            label.text! = animals[2].species
        default: break
        }
    }
    
    
    //MARK: Private Methods
    
    /**
        Calculates alpha based on halfway point of iPhone 7 and then plugs into label
     
        - Parameter num: number to calculate alpha for
    */
    private func calculateAlpha(_ num: Float) {
        let alpha = num / 187
        label.alpha = CGFloat(alpha)
    }
    
    // - Attributions: https://stackoverflow.com/questions/24022479/how-would-i-create-a-uialertview-in-swift
    /**
        Shows alert when an animal's name button is tapped. Also plays sound and prints animal info to console.
     
        - Parameter button: button that is being pressed
    */
    @objc private func buttonTapped(_ button: UIButton!) {
        let animal = animals[button.tag]
        let alert = UIAlertController(title: animal.name, message: "This \(animal.species) is \(animal.age)", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
        animal.dumpAnimalObject()
        self.present(alert, animated: true, completion: nil)
        playSound(animal.soundPath)
    }
    
    // - Attributions: https://developer.apple.com/library/content/qa/qa1913/_index.html
    
    /**
        Given string name of sound from assets catalog, plays sound.
     
        - Parameter soundString: name of the sound from catalog
    */
    private func playSound(_ soundString: String) {
        do {
            let animalSound = NSDataAsset(name: soundString)
            animalPlayer = try AVAudioPlayer(data: animalSound!.data, fileTypeHint: AVFileTypeMPEGLayer3)
            animalPlayer?.play()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
}

//MARK: Extensions

// - Attributions: https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Closures.html
extension Array {
    
    /**
        Shuffles an array by using random numbers as comparators
    */
    mutating func shuffle() {
        func randomize(_ n1: Any, _ n2: Any) -> Bool {
            let randoNum = arc4random()
            let randoNum2 = arc4random()
            return randoNum > randoNum2
        }
        self = self.sorted(by: randomize)
    }
}
