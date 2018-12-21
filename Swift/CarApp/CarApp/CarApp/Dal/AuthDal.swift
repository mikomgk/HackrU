//
//  AuthDal.swift
//  CarApp
//
//  Created by Miko Stern on 12/19/18.
//  Copyright © 2018 Miko Stern. All rights reserved.
//

import Foundation

class AuthDal{
	
	public static let shared = AuthDal()
	let baseLoginUrl = "https://carlogapp.herokuapp.com/signup"
	
	private init(){}
	
	func send(user: LoginUser, callback: @escaping (Data?, Error?)->()){
		let signup = user is RegisterUser
		var registerUser: RegisterUser!
		if signup{
			registerUser = user as? RegisterUser
		}
		var url = URLComponents(string: baseLoginUrl)!
		url.queryItems = [URLQueryItem(name: "signup", value: signup.description)]
		print(url.string!)
		let userJson = try! JSONEncoder().encode(signup ? registerUser : user)
		print(String(data: userJson, encoding: .utf8)!)
		var request = URLRequest(url: url.url!)
		request.httpMethod = "POST"
		request.setValue("application/json", forHTTPHeaderField: "Content-Type")
		request.httpBody = userJson
		URLSession.shared.dataTask(with: request) { (data, res, err) in
			callback(data, err)
		}.resume()
	}
}
