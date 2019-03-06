import UIKit
import Foundation

class ConversationListViewCell: UITableViewCell, ConversationCellConfiguration {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var messageTextLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet var profImage: UIImageView!
    
    var name: String?
    
    var message: String?
    
    var date: Date?
    
    var online: Bool = true
    
    var hasUnreadMessages: Bool = true
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

protocol ConversationCellConfiguration : class {
    var name: String? {get set}
    var message: String? {get set}
    var date: Date? {get set}
    var online: Bool {get set}
    var hasUnreadMessages: Bool {get set}
}
