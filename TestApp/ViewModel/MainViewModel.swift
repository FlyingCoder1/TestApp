import UIKit
import CropViewController

class MainViewModel: NSObject {
    
    var presentingViewController: UIViewController?
    

    
    
    func showCrop(image: UIImage, delegate: CropViewControllerDelegate) {
        let vc = CropViewController(croppingStyle: .default, image: image)
        vc.aspectRatioPreset = .presetSquare
        vc.aspectRatioLockEnabled = true
        
        
        vc.doneButtonColor = .systemRed
        vc.cancelButtonColor = .systemRed
        vc.toolbarPosition = .top
        vc.doneButtonTitle = "Save"
        vc.cancelButtonTitle = "Back"
        vc.delegate = delegate
        
   

        // Добавляем UIView с желтой рамкой
           let yellowBorderView = UIView(frame: CGRect(x: 11, y: 172, width:371, height: 371))
           yellowBorderView.layer.borderColor = UIColor.yellow.cgColor
           yellowBorderView.layer.borderWidth = 2.0
           yellowBorderView.isUserInteractionEnabled = false
           vc.cropView.addSubview(yellowBorderView)

        if let presentingViewController = presentingViewController {
                    presentingViewController.present(vc, animated: true)
                } else {
                    print("No presenting view controller set.")
                }
    }
    
}
