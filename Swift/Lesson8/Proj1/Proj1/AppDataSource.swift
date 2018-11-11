import UIKit

class AppDataSource {
	
	weak var delegate: AppDataDelegate? = nil
	
	func getMovies(from urlSource: String){
		var apps = [AppItem]()
		guard let url = URL(string: urlSource) else { return }
		let session = URLSession(configuration: .default)
		let task = session.dataTask(with: url) { (data, res, err) in
			if let err = err{
				print(err)
				return
			}
			guard let d = data else { return }
			let dataJSON = try! JSONSerialization.jsonObject(with: d, options: []) as? JSONObject
			let feed = dataJSON!["feed"] as? JSONObject
			let results = feed!["results"] as? JSONArray
			for i in 0..<results!.count{
				let result = results![i]
				let artistName = result["artistName"] as! String
				let name = result["name"] as! String
				let artworkUrl100 = result["artworkUrl100"] as! String
				let url = result["url"] as! String
				apps.append(AppItem(artistName: artistName, name: name, artworkUrl100: artworkUrl100, image: UIImage(), url: url))
				let imageUrl = URL(string: artworkUrl100)!
				let t = session.downloadTask(with: imageUrl) { (loc, res, err) in
					if let err = err {
						print(err)
						return
					}
					if let loc = loc {
						if let data = try? Data(contentsOf: loc) {
							apps[i].image = UIImage(data: data) ?? UIImage()
						}
					}
					DispatchQueue.main.async {
						self.delegate?.appsArrived(apps: apps)
					}
				}
				t.resume()
			}
		}
		task.resume()
	}
}

protocol AppDataDelegate: class {
	func appsArrived(apps: [AppItem])
}

typealias JSONObject = [String: Any]
typealias JSONArray = [JSONObject]
