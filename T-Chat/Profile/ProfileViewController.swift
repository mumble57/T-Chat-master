import UIKit

class ProfileViewController: UIViewController,UIActionSheetDelegate, UITextViewDelegate {
    
    
    let defaultImage = UIImage(named:"placeholder-user")

    
    @IBOutlet private weak var profileImage: UIImageView!
    @IBOutlet private weak var chooseImageButton: UIButton!
    @IBOutlet private weak var changeProfileButton: UIButton!
    
    @IBOutlet var GCDButton: UIButton!
    @IBOutlet var OperationButton: UIButton!
    @IBOutlet var NameTextView: UITextView!
    @IBOutlet var DescriptionTextView: UITextView!

    var activityInd: UIActivityIndicatorView = UIActivityIndicatorView()
    
    var profileIsEditing = false
    //    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        //print(changeProfileButton.layer.frame)
//        //Stored properties cannot be left in an indeterminate state!!!
//        //аутлет из нил ин инит
//    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        editProfileButtonPress()
        
        //dismiss keyboard
        self.hideKeyboardWhenTappedAround()

        profileImage.layer.cornerRadius = 60

        
        
        //сохраняем имя, описания, фото
        let defaults = UserDefaults.standard
        if let nameData = defaults.string(forKey: "savedName"){
            NameTextView.text = nameData
        }
        if let descriptionData = defaults.string(forKey: "savedDescription"){
            DescriptionTextView.text = descriptionData
        }
        if let imgData = defaults.object(forKey: "savedImage") as? NSData{
            profileImage.image = UIImage(data: imgData as Data)
        }
//        let imgData = UserDefaults.standard.object(forKey: "savedImage") as? NSData
//        if imgData != nil
//        {
//            profileImage.image = UIImage(data: imgData! as Data)}
//        else{
//            profileImage.image = defaultImage}
        profileImage.layer.masksToBounds = true
  

        changeProfileButton.layer.borderWidth = 1
        changeProfileButton.layer.cornerRadius = 10
        
        GCDButton.layer.borderWidth = 1
        GCDButton.layer.cornerRadius = 10
        
        OperationButton.layer.borderWidth = 1
        OperationButton.layer.cornerRadius = 10
    }
    
    //поднимаем текст вью, когда появляется клавиатура
    func textViewDidBeginEditing(_ textView: UITextView){
        moveTextView(textView: NameTextView, moveDistance: -250, up: true)
    }
    //опускаем
    func textViewDidEndEditing(_ textView: UITextView){
        moveTextView(textView: NameTextView, moveDistance: -250, up: false)
    }
    
    func moveTextView(textView: UITextView, moveDistance: Int, up: Bool){
        let moveDuration = 0.3
        let movement: CGFloat = CGFloat(up ? moveDistance : -moveDistance)
        UIView.beginAnimations("animateTextView", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(moveDuration)
        self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement)
        UIView.commitAnimations()

    }

    func editProfileButtonPress(){
        chooseImageButton.setImage(UIImage(named: "cam-icn"), for: .normal)
        //Режим редактирования профиля
        if profileIsEditing {
            chooseImageButton.isHidden = false
            //Настраиваем кнопеки
            changeProfileButton.isHidden = true
            GCDButton.isHidden = false
            OperationButton.isHidden = false
            
            //Настраиваем текст вью
            NameTextView.isEditable = true
            NameTextView.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
            NameTextView.layer.cornerRadius = 10
            
            DescriptionTextView.isEditable = true
            DescriptionTextView.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
            DescriptionTextView.layer.cornerRadius = 20
            

        }
        //Режим простого просмотра профиля
        else{
            chooseImageButton.isHidden = true

            //Настраиваем кнопеки
            changeProfileButton.isHidden = false
            GCDButton.isHidden = true
            OperationButton.isHidden = true
            
            //Настраиваем текст вью
            NameTextView.isEditable = false
            NameTextView.backgroundColor = UIColor.white
            
            DescriptionTextView.isEditable = false
            DescriptionTextView.backgroundColor = UIColor.white

        }
    }
    @IBAction func editProfileButton(_ sender: UIButton) {
        profileIsEditing = true
        editProfileButtonPress()
    }
    
    //func GCD
    @IBAction func GCDActionButton(_ sender: Any) {
        profileIsEditing = false
        editProfileButtonPress()
        
        // наивысший приоритет
        let userInteractiveQueue = DispatchQueue.global(qos: .userInteractive)
        userInteractiveQueue.async {
            DispatchQueue.main.async {
                UserDefaults.standard.set(self.NameTextView.text, forKey: "savedName")
                UserDefaults.standard.set(self.DescriptionTextView.text, forKey: "savedDescription")
                
                self.activityInd.startAnimating()

                //записываем картинку профиля
                let currentImage = self.profileImage.image
                let imageData:NSData = currentImage!.pngData()! as NSData
                UserDefaults.standard.set(imageData, forKey: "savedImage")
                
                let alert = UIAlertController(title: "Данные сохранены", message: nil, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler:{ (UIAlertAction)in
                    self.activityInd.stopAnimating()
                }))
                self.present(alert, animated: true, completion: {
                })

                self.activityInd.center = self.view.center
                self.activityInd.hidesWhenStopped = true
                self.activityInd.style = UIActivityIndicatorView.Style.gray
                self.view.addSubview(self.activityInd)
                
            }


        }

        


    }
    @IBAction func OperationActionButton(_ sender: Any) {
        profileIsEditing = false
        editProfileButtonPress()
        
        UserDefaults.standard.set(NameTextView.text, forKey: "savedName")
        UserDefaults.standard.set(DescriptionTextView.text, forKey: "savedDescription")

    }
    
    @IBAction func closeProfile(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    //MARK: - Choose profile image
    @IBAction func takePhoto(_ sender: UIButton) {
        print("«Выбери изображение профиля»")
        //Create the AlertController and add Its action like button in Actionsheet
        let alert = UIAlertController(title: "Сменить фото профиля", message: nil, preferredStyle: .actionSheet)
        
        //Picker discription
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        alert.addAction(UIAlertAction(title: "Сфотографировать", style: .default , handler:{ (UIAlertAction)in
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera){
                imagePicker.sourceType = UIImagePickerController.SourceType.camera
                self.present(imagePicker ,animated: true, completion: nil)
            }
            
        }))
        
        alert.addAction(UIAlertAction(title: "Выбрать из коллекции" , style: .default , handler:{ (UIAlertAction)in
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
                imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
                self.present(imagePicker ,animated: true, completion: nil)
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Удалить нынешнее фото", style: .destructive , handler:{ (UIAlertAction)in
            self.profileImage.image = self.defaultImage
        }))
        
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler:{ (UIAlertAction)in
            print("Отмена операции, возвращаемся на базу")
        }))
        
        //Показываем алерт
        self.present(alert, animated: true, completion: {
        })
        
    }
    
}

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage{
            profileImage.contentMode = .scaleToFill
            profileImage.image = pickedImage
        }
        picker.dismiss(animated: true, completion: nil)

    }

}
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
        
    }
}


