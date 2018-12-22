//
//  Auth.swift
//  CarApp
//
//  Created by Miko Stern on 12/16/18.
//  Copyright © 2018 Miko Stern. All rights reserved.
//

import Foundation
import CommonCrypto

class Auth{
	
	public static let shared = Auth()
	weak var delegate: AuthDelegate?
	let authDal = AuthDal.shared
	let salt = "car@OnTarget"
	let TOKEN = "token"
	let SERVICE_NAME = "CarApp"
	let wrongCertificateMessage = "שם משתמש או סיסמה שגויים"
	let basicErrorMessage = "קרתה שגיאה אנא נסה שוב מאוחר יותר"
	lazy var keyChainToken: KeychainPasswordItem = {
		return KeychainPasswordItem(service: SERVICE_NAME, account: TOKEN)
	}()
	
	private init (){}
	
	func loginSignup(withUser user: LoginUser){
		let saltedPassword = user.password + salt
		let passwordData = sha256(string: saltedPassword)!
		let passwordHexString = passwordData.hexString
		print(passwordHexString)
		user.password = passwordHexString
		
		authDal.send(user: user) { (data, error) in
			var success = false
			var err: String? = nil
			if let error = error{//TODO: check type of errors
				err = self.basicErrorMessage
				print(error)
			}else if let data = data{
				let token = String(data: data, encoding: .utf8)
				if token == nil || token!.isEmpty{
					print(self.wrongCertificateMessage)
					err = self.wrongCertificateMessage
				}else{
					print(token!)
					self.saveToken(token!)
					success = true
				}
			}
			print("going to update screen")
			DispatchQueue.main.async {
				print("updating....")
				self.delegate?.onLogin(success: success, withError: err)
			}
			print("update sent")
		}
	}
	
	private func saveToken(_ token: String) -> Bool{
		do{
			try keyChainToken.savePassword(token)
			return true
		}catch{
			print("Error Saving to keychain \(error)")
			return false
		}
	}
	
	func getToken() -> String?{
		do{
			return try keyChainToken.readPassword()
		}catch{
			return nil
		}
	}
	
	func deleteToken() -> Bool{
		do{
			try keyChainToken.deleteItem()
			return true
		}catch{
			return false
		}
	}
	
	func updateToken(_ token: String) -> Bool{
		return saveToken(token)
	}
	
	private func sha256(string: String) -> Data? {
		guard let messageData = string.data(using:String.Encoding.utf8) else { return nil }
		var digestData = Data(count: Int(CC_SHA256_DIGEST_LENGTH))
		
		_ = digestData.withUnsafeMutableBytes {digestBytes in
			messageData.withUnsafeBytes {messageBytes in
				CC_SHA256(messageBytes, CC_LONG(messageData.count), digestBytes)
			}
		}
		return digestData
	}
}

class LoginUser: Encodable{
	let email: String
	var password: String
	
	init(email: String, password: String){
		self.email = email
		self.password = password
	}
}

class RegisterUser: LoginUser{
	let firstName: String
	let lastName: String
	
	init(email: String, password: String, firstName: String, lastName: String){
		self.firstName = firstName
		self.lastName = lastName
		super.init(email: email, password: password)
	}
	
	private enum CodingKeys: String, CodingKey {
		case firstName, lastName
	}
	
	override func encode(to encoder: Encoder) throws {
		try super.encode(to: encoder)
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(firstName, forKey: .firstName)
		try container.encode(lastName, forKey: .lastName)
	}
}

protocol AuthDelegate: class {
	func onLogin(success: Bool, withError err: String?)
}

extension Data{
	var hexString: String {
		return map { String(format: "%02hhx", $0) }.joined()
	}
	
	var string64base: String{
		return self.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0))
	}
}
