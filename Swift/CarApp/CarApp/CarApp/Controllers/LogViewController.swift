//
//  LogViewController.swift
//  CarApp
//
//  Created by Miko Stern on 12/21/18.
//  Copyright © 2018 Miko Stern. All rights reserved.
//

import UIKit

class LogViewController: UIViewController {
	
	override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		
//		let url = URL(string: "https://carlogapp.herokuapp.com/image")!
//		print(url)
//		URLSession(configuration: .default).dataTask(with: url, completionHandler: { (data, res, err) in
//			let dataJSON = try? JSONSerialization.jsonObject(with: data!, options: []) as? JSONObject
//			let rows = dataJSON!!["rows"]! as? JSONArray
//			let row = rows![0]
//			let imageStr = row["image"] as! String
//			print(imageStr)
//			let d = Data(base64Encoded: imageStr)
//			let image = UIImage(data: d!)
//			DispatchQueue.main.async {
//				self.imageView.image = image
//			}
//		}).resume()
    }
}
