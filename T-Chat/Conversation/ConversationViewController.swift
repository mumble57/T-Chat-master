
import UIKit

class ConversationViewController: UIViewController {
    
    
    var navTitle: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = navTitle
        navigationController?.navigationItem.title = navTitle
    }

}




extension ConversationViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IncomingMessageCell", for: indexPath) as! ConversationViewCell
        
        return cell
        
    }
    
}

