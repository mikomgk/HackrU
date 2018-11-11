import UIKit

class AppsTableViewController: UITableViewController {
	@IBOutlet var table: UITableView!
	
	var myApps = [AppItem]()

    override func viewDidLoad() {
        super.viewDidLoad()

		let appsUrl = "https://rss.itunes.apple.com/api/v1/us/ios-apps/new-apps-we-love/all/50/explicit.json"
		let ADS = AppDataSource()
		ADS.delegate = self
		ADS.getMovies(from: appsUrl)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myApps.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AppCell")!
		let row = indexPath.row
		cell.textLabel!.text = myApps[row].name
		cell.detailTextLabel!.text = myApps[row].artistName
		cell.imageView!.image = myApps[row].image
		cell.imageView!.layer.cornerRadius = 15
		cell.imageView!.layer.masksToBounds = true
		return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
         return true
    }

	override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
			myApps.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } /*else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }   */
    }

    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
		myApps.insert(myApps.remove(at: fromIndexPath.row), at: to.row)
		tableView.moveRow(at: fromIndexPath, to: to)
    }

    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }

}

extension AppsTableViewController: AppDataDelegate{
	func appsArrived(apps: [AppItem]) {
		self.myApps = apps
		self.table.reloadData()
	}
}
