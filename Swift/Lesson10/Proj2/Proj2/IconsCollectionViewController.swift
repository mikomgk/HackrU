//
//  IconsCollectionViewController.swift
//  Proj2
//
//  Created by Miko Stern on 11/18/18.
//  Copyright © 2018 Miko Stern. All rights reserved.
//

import UIKit

private let reuseIdentifier = "IconCell"

protocol IconsCollectionViewControllerDelegate: class {
	func didSelectItem(_ item: IconItem)
}

class IconsCollectionViewController: UICollectionViewController {
	weak var delegate: IconsCollectionViewControllerDelegate?
	var icons = [IconItem]()
	let numberOfIconsPerRow = 4
	var collectionHeight: CGFloat{
		let layout = self.collectionViewLayout as! UICollectionViewFlowLayout
		return layout.itemSize.height
	}

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

		for i in 1...8{
			icons.append(IconItem(name: Pokemon(rawValue: i) ?? .charmander, image: UIImage(named: String(i))!))
		}
		let layout = self.collectionViewLayout as! UICollectionViewFlowLayout
		let padding = CGFloat(10)
		let w = self.view.frame.size.width / CGFloat(numberOfIconsPerRow) - padding * 1.5
		layout.itemSize = CGSize(width: w, height: w)
		layout.minimumInteritemSpacing = padding / 2
		layout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
		self.view.subviews[0].backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return icons.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! IconCollectionViewCell
    
        cell.imageView.image = icons[indexPath.item].image
		cell.layer.cornerRadius = 15
		cell.layer.masksToBounds = true
		
		
		
        return cell
    }
	
	override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		delegate?.didSelectItem(icons[indexPath.item])
	}

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}

enum Pokemon: Int{
	case charmander = 1, jigglypuff, meowth, pickachu, pokeball, rattata, squirtle, venonat
	func toCapital() -> String{
		switch self{
		case .charmander:
				return "Charmander"
		case .jigglypuff:
			return "Jigglypuff"
		case .meowth:
			return "Meowth"
		case .pickachu:
			return "Pickachu"
		case .pokeball:
			return "Pokeball"
		case .rattata:
			return "Rattata"
		case .squirtle:
			return "Squirtle"
		case .venonat:
			return "Venonat"
		}
	}
}
