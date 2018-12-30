//
//  ViewController.swift
//  CarApp
//
//  Created by Miko Stern on 12/16/18.
//  Copyright © 2018 Miko Stern. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	let auth = Auth.shared
	var token: String?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		//auth.deleteToken()
		
//		let i = UIImage(named: "plus")
//		let d: Data = i!.pngData()!
//		let b = d.base64EncodedString()
//			.addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed)!
//		print(b)
//		var body = "key=".data(using: .utf8)!
//		body.append(d)
//
//
//		var url = URLComponents(string: "https://carlogapp.herokuapp.com/image")!
//		url.queryItems = [URLQueryItem(name: "image", value: "save")]
//		print(url.string!)
//		var request = URLRequest(url: url.url!)
//		request.httpMethod = "POST"
//		request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
//		request.httpBody = body
//		print("d is going to be send")
//		URLSession.shared.dataTask(with: request) { (data, res, err) in
//			print(data)
//		}.resume()
//		print("d sent")
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		token = auth.getToken()
		if token == nil{//TODO: check if logic
			performSegue(withIdentifier: "auth", sender: nil)
		}else{
			performSegue(withIdentifier: "app", sender: nil)
		}
	}
}

extension CharacterSet {
	static let urlQueryValueAllowed: CharacterSet = {
		let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
		let subDelimitersToEncode = "!$&'()*+,;="
		
		var allowed = CharacterSet.urlQueryAllowed
		allowed.remove(charactersIn: generalDelimitersToEncode + subDelimitersToEncode)
		return allowed
	}()
}
