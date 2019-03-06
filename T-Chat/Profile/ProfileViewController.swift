import UIKit

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var picker: UIImagePickerController? = UIImagePickerController()
    
    @IBOutlet weak var userPhotoImageView: UIImageView!
    @IBOutlet weak var editButtonOutlet: UIButton!
    @IBOutlet weak var addPhotoButtonOutlet: UIButton!
    @IBAction func addPhotoButton(_ sender: UIButton) {
    
        let alert = UIAlertController(title: nil,
                                      message: nil,
                                      preferredStyle: .actionSheet)
        let selectPhotoAction = UIAlertAction(title: "Выбрать фото",
                                              style: .default)
        { (UIAlertAction) in
            let image = UIImagePickerController()
            image.delegate = self
            image.sourceType = UIImagePickerController.SourceType.photoLibrary
            image.allowsEditing = true
            self.present(image, animated: true, completion: nil)
        }
        let takePhotoAction = UIAlertAction(title: "Сделать фото",
                                            style: .default)
        {(UIAlertAction) in
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
                self.picker!.allowsEditing = false
                self.picker!.sourceType = UIImagePickerController.SourceType.camera
                self.picker!.cameraCaptureMode = .photo
                self.present(self.picker!, animated: true)
            } else {
                
                self.noCameraAlert()
               
            }
        }
        let cancelAction = UIAlertAction(title: "Закрыть",
                                         style: .cancel)
        
        alert.addAction(selectPhotoAction)
        alert.addAction(takePhotoAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    
    func noCameraAlert() {
        let alert = UIAlertController(title: "Камера не найдена",
                                      message: "Устройство не имеет камеры",
                                      preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let chosenImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        userPhotoImageView.image = chosenImage
        
        dismiss(animated: true, completion: nil)
    }

    @IBAction func editButton(_ sender: UIButton) {
        print(#function)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
//        Если убрать комментарий и запустить, то приложение упадет
//        Происходит это потому, что элементы, определенные в .storyboard
//        еще не существуют в этом методе, то есть nil
//        print(editButtonOutlet.frame)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(editButtonOutlet.frame)

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)

        userPhotoImageView.clipsToBounds = true
        addPhotoButtonOutlet.layer.cornerRadius = addPhotoButtonOutlet.frame.height/2
        userPhotoImageView.layer.cornerRadius = addPhotoButtonOutlet.frame.height/2
        
        editButtonOutlet.layer.cornerRadius = 10
        editButtonOutlet.layer.borderWidth = 1
        editButtonOutlet.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        
//        размеры frame в viewDidLoad() отличаются от viewDidAppear() потому,
//        что в последний метод вызывается после того, как autolayout отработал,
//        viewDidLoad() вызывается до. Поэтому в этом методе нежелательно работать с геометрией
        print(editButtonOutlet.frame)
        
    }

}

