//
//  AddViewController.swift
//  CarApp
//
//  Created by Miko Stern on 1/15/19.
//  Copyright © 2019 Miko Stern. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {

	var addType: Addable!{
		didSet{
			print("set addViewType to \(addType.rawValue)")
		}
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
	
	enum Addable: String{
		case refuel, service, expense
	}
}
