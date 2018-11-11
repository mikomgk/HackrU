import UIKit

class DetailsViewController: UIViewController {
	
	@IBOutlet weak var appImage: UIImageView!
	@IBOutlet weak var nameLbl: UILabel!
	@IBOutlet weak var artistLbl: UILabel!
	@IBOutlet weak var detailNavigation: UINavigationItem!
	
	@IBOutlet weak var urlBtn: UIButton!
	var app: AppItem? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
		
		appImage.image = app?.image
		nameLbl.text = app?.name
		artistLbl.text = app?.artistName
		urlBtn.setTitle(app?.url, for: .normal)
		detailNavigation.title = app?.name
		appImage.layer.cornerRadius = 15
		appImage.layer.masksToBounds = true
    }
	
	@IBAction func openUrl(_ sender: Any) {
		guard let url = URL(string: (app?.url)!) else { return }
		UIApplication.shared.open(url, options: [:]) { bool in
			return
		}
	}
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
