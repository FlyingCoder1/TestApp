import CropViewController
import UIKit

class MainViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate,
CropViewControllerDelegate  {
    
    let viewModel = MainViewModel()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        
        
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        button.setTitle("+", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        button.setTitleColor(.blue, for: .normal)
        view.addSubview(button)
        button.center = view.center
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    @objc func didTapButton() {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        present(picker, animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else {
            return
        }
        picker.dismiss(animated: true)
      
        viewModel.presentingViewController = self
        viewModel.showCrop(image: image, delegate: self)
    }
    
  
    
    func cropViewController(_ cropViewController: CropViewController, didFinishCancelled cancelled: Bool) {
        cropViewController.dismiss(animated: true)
    }
    
    func cropViewController(_ cropViewController: CropViewController, didCropToImage image: UIImage, withRect cropRect: CGRect, angle: Int) {
        
        cropViewController.dismiss(animated: true)
        
        // Сохраняем обрезанное изображение в галерею
            UIImageWriteToSavedPhotosAlbum(image, self, #selector(imageSave(_:didFinishSavingWithError:contextInfo:)), nil)

        
        let imageView = UIImageView(frame: view.frame)
        imageView.contentMode = .scaleAspectFit
        imageView.image = image
        view.addSubview(imageView)
        
    }
    
    @objc func imageSave(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // Если произошла ошибка при сохранении, выводим сообщение об ошибке
            print("Ошибка сохранения изображения: \(error.localizedDescription)")
        } else {
            // Если изображение успешно сохранено, выводим сообщение об успехе
            print("Изображение успешно сохранено в галерею")
            
        }
    }
}
        

