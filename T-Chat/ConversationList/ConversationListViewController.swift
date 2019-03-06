import UIKit
import Foundation

class ConversationListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var currentThemeColor: UIColor!
    
    
    let namesArray = ["Steve Jobs", "Bill Gates", "Павел Дуров", "Олег Тиньков", "Elon Mask", "Nikola Tesla", "Алан Тьюринг", "Ада Лавлейс", "Альберт Эйнштейн", "Мария Кюри"]
    let messagesArray = ["Порешали чин чинарем", nil, "道德經", "На созвоне", "Ты парень смеклистый", nil, nil, "Кто первый программист?)", "Фура на Владик не ушла(", "Тоси Боси"]
    var datesArray: [Date] = []
    
    
    func fillDatesArray() -> [Date] {
        var now = Date()
        
        func randomNumber() -> Int {
            return Int(arc4random())
        }
        
        for _ in 0...9 {
            datesArray.append(now.addingTimeInterval(TimeInterval(-randomNumber())))
        }
        return datesArray
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
        if let colorData = UserDefaults.standard.object(forKey: "myColor") as? Data,
            let color = NSKeyedUnarchiver.unarchiveObject(with: colorData) as? UIColor {
            currentThemeColor = color
        } else {
            currentThemeColor = .white
        }
        
        navigationController?.navigationBar.barTintColor = currentThemeColor
        view.backgroundColor = currentThemeColor
    }
    
    // MARK: - Navigation

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      
        if let dvc = segue.destination as? ConversationViewController {
       
            if let indexPath = tableView.indexPathForSelectedRow {
                let selectedRow = indexPath.row
                dvc.navTitle = namesArray[selectedRow]
            }
        } else if let themeVC = segue.destination as? ThemesViewController {
            themeVC.themesViewControllerDelegate = self
        }
    }
}

extension ConversationListViewController: ThemesViewControllerDelegate {
    func themesViewController(_ controller: ThemesViewController!, didSelectTheme selectedTheme: UIColor!) {
        self.view.backgroundColor = selectedTheme
        navigationController?.navigationBar.barTintColor = selectedTheme
        currentThemeColor = selectedTheme
        
        tableView.reloadData()
    }
}


extension ConversationListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return namesArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? ConversationListViewCell
        
        
        cell?.nameLabel.text = namesArray[indexPath.row]
        
        if let message = messagesArray[indexPath.row] {
            cell?.messageTextLabel.text = message
        } else {
            cell?.messageTextLabel.font = UIFont(name: "HelveticaNeue-LightItalic", size: 18.0)
            cell?.messageTextLabel.text = "No messages yet"
            cell?.messageTextLabel.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        }
        
        cell?.profImage.layer.cornerRadius = 30
        cell!.profImage.layer.masksToBounds = true
        
        let date = Date()
        let year = Calendar.current.component(.year, from: date)
        let month = Calendar.current.component(.month, from: date)
        let day = Calendar.current.component(.day, from: date)
        
        
        let thisDate = fillDatesArray()[indexPath.row]
        
        let dayInArr = Calendar.current.component(.day, from: thisDate)
        let monthInArr = Calendar.current.component(.month, from: thisDate)
        let yearInArr = Calendar.current.component(.year, from: thisDate)
        
        let mins = Calendar.current.component(.minute, from: thisDate)
        let hours = Calendar.current.component(.hour, from: thisDate)
        
        var min = ""
        var hour = ""
        if mins < 10 {
             min = "0" + String(mins)
        } else {
             min = String(mins)
        }
        
        if hours < 10 {
             hour = "0" + String(hours)
        } else {
             hour = String(hours)
        }
        
        
        if day > dayInArr && month >= monthInArr && year >= yearInArr {
            cell?.dateLabel.text = "\(dayInArr).0\(monthInArr)"
        } else {
            cell?.dateLabel.text = "\(hour):\(min)"
        }
        

        
        if let user = cell?.online {
            if user {
                cell?.backgroundColor = currentThemeColor
            }
        }
        
        if let unread = cell?.hasUnreadMessages {
            if unread {
                cell?.messageTextLabel.font = UIFont.boldSystemFont(ofSize: 18.0)
            }
        }
        
        return cell!
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Online"
        case 1:
            return "History"
        default:
            return nil
        }
    }
    
    func logThemeChanging(selectedTheme: UIColor){
       // print(ThemesViewController.changColor(selectedTheme))
    }
    
}


