import UIKit

class ItunesDataSource{

	weak var delegate: ItunesDataSourceDelegate?
	
	func getItems(urlSources: [String]){
		var results = [RssResult]()
		var rssCount = 0
		for i in 0..<urlSources.count{
			rssCount += 1
			guard let url = URL(string: urlSources[i]) else { return }
			let session = URLSession(configuration: .default)
			let task = session.dataTask(with: url) { (data, res, err) in
				if let err = err{
					print(err)
					return
				}
				guard let d = data else { return }
				let rssResult = try! JSONDecoder().decode(RssResult.self, from: d)
				results.append(rssResult)
				if rssCount == urlSources.count - 1{
					DispatchQueue.main.async {
						self.delegate?.itemsRecieved(items: results)
					}
				}
			}
			task.resume()
		}
	}
}

protocol ItunesDataSourceDelegate: class {
	func itemsRecieved(items: [RssResult])
}
