import UIKit

class MovieCell: UITableViewCell {
	@IBOutlet weak var movieImage: UIImageView!
	@IBOutlet weak var title: UILabel!
	@IBOutlet weak var director: UILabel!
	
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
		
    }

}
