//import UIKit
//import CoreML
//import Vision
//
//class ViewController: UIViewController {
//    private let viewModel = ResultViewModel()
//
//    // Machine learning model
//    private var model: VNCoreMLModel? = nil
//    private var Model: VNCoreMLModel {
//        get {
//            guard let unwrappedModel = model else {
//                fatalError("model is nil!")
//            }
//            return unwrappedModel
//        }
//    }
//    
//    private let imagePicker = UIImagePickerController()
//    
//    private let cameraBarButton = UIBarButtonItem(barButtonSystemItem: .camera, target: nil, action: nil)
//    
//    private let imagePreview: UIImageView = {
//        let imageView = UIImageView()
//        imageView.backgroundColor = .systemBackground
//        imageView.contentMode = .scaleAspectFit
//        imageView.clipsToBounds = true
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        return imageView
//    }()
//    
//    private let labelPreview: UILabel = {
//        let label = UILabel()
//        label.numberOfLines = 0
//        label.textColor = .label
//        label.font = UIFont.systemFont(ofSize: 16)
//        label.textAlignment = .center
//        label.lineBreakMode = .byWordWrapping
//        label.text = "Press the camera button to take a flower picture!"
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//    
//    private let padding = CGFloat(14)
//    private var resultString: String? // Variable to hold the result string
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        // Load machine learning model
//        guard let importedModel = try? VNCoreMLModel(for: FC_new().model) else {
//            fatalError("Cannot import model!")
//        }
//        
//        model = importedModel
//        
//        imagePicker.delegate = self
//        imagePicker.allowsEditing = true
//        imagePicker.sourceType = .camera
//        
//        view.backgroundColor = .systemBackground
//        
//        configureNavigationItem()
//        configureBarButtons()
//        
//        view.addSubview(imagePreview)
//        view.addSubview(labelPreview)
//        
//        // Initial constraints setup
//        setupConstraints()
//    }
//    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        // Additional layout adjustments if needed
//    }
//    
//    private func setupConstraints() {
//        let insets = self.view.safeAreaInsets
//        
//        imagePreview.topAnchor.constraint(equalTo: view.topAnchor, constant: insets.top).isActive = true
//        imagePreview.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -insets.bottom).isActive = true
//        imagePreview.leftAnchor.constraint(equalTo: view.leftAnchor, constant: insets.left).isActive = true
//        imagePreview.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -insets.right).isActive = true
//        
//        labelPreview.topAnchor.constraint(equalTo: imagePreview.topAnchor).isActive = true
//        labelPreview.bottomAnchor.constraint(equalTo: imagePreview.bottomAnchor).isActive = true
//        labelPreview.leftAnchor.constraint(equalTo: imagePreview.leftAnchor).isActive = true
//        labelPreview.rightAnchor.constraint(equalTo: imagePreview.rightAnchor).isActive = true
//    }
//    
//    private func configureNavigationItem() {
//        navigationItem.title = "Flower Finder"
//        navigationItem.setRightBarButtonItems([cameraBarButton], animated: true)
//    }
//
//    private func configureBarButtons() {
//        cameraBarButton.target = self
//        cameraBarButton.action = #selector(cameraButtonPressed)
//    }
//    
//    // On camera button pressed
//    @objc private func cameraButtonPressed() {
//        print("Camera button pressed")
//        present(imagePicker, animated: true)
//    }
//    
//    private func navigateToResultViewController() {
//        let resultVC = ResultViewController()
//        resultVC.resultString = self.resultString
//        navigationController?.pushViewController(resultVC, animated: true)
//    }
//    
//    
//
//}
//
//extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
//    
//
//
//    // Load captured photo
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        
//        let pickedImage = info[.editedImage]
//        
//        guard let pickedImage = pickedImage as? UIImage else {
//            fatalError("Failed to set picked image to preview!")
//        }
//        
//        imagePreview.image = pickedImage
//        labelPreview.isHidden = true
//        
//        // Convert into CIImage before passing the captured photo into machine learning model
//        guard let convertedCIImage = CIImage(image: pickedImage) else {
//            fatalError("Failed to convert UIImage into CIImage")
//        }
//        
//        // Pass captured photo into machine learning model
//        detectFlower(image: convertedCIImage)
//        
//        imagePicker.dismiss(animated: true)
//    }
//    
//    private func detectFlower(image: CIImage) {
//        let request = VNCoreMLRequest(model: Model) { [weak self] (request, error) in
//            guard let classificationResults = request.results as? [VNClassificationObservation] else { return }
//
//            // Get the most confident result
//            if let topResult = classificationResults.first {
//                let flowerName = topResult.identifier.capitalized
//                
//                // Lookup flower details using the view model
//                if let flower = self?.viewModel.getFlowerDetails(for: flowerName) {
//                    // Add the flower to the collection
//                    self?.viewModel.addToCollection(flower: flower)
//                } else {
//                    print("Flower not found in dictionary: \(flowerName)")
//                }
//                
//                DispatchQueue.main.async {
//                    self?.navigateToResultViewController()
//                }
//            }
//        }
//        
//        let handler = VNImageRequestHandler(ciImage: image)
//        do {
//            try handler.perform([request])
//        } catch {
//            print(error)
//        }
//    }
//
//}
//



import UIKit
import CoreML
import Vision

class ViewController: UIViewController {

    // Machine learning model
    private var model: VNCoreMLModel? = nil
    private var Model: VNCoreMLModel {
        get {
            guard let unwrappedModel = model else {
                fatalError("model is nil!")
            }
            return unwrappedModel
        }
    }
    
    private let imagePicker = UIImagePickerController()
    private let viewModel = ResultViewModel() // Shared view model for managing flower data
    
    private let cameraBarButton = UIBarButtonItem(barButtonSystemItem: .camera, target: nil, action: nil)
    
    private let imagePreview: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemBackground
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let labelPreview: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.text = "Press the camera button to take a flower picture!"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let padding = CGFloat(14)
    private var resultString: String? // Variable to hold the result string
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load machine learning model
        guard let importedModel = try? VNCoreMLModel(for: FC_new().model) else {
            fatalError("Cannot import model!")
        }
        model = importedModel
        
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .camera
        
        view.backgroundColor = .systemBackground
        
        configureNavigationItem()
        configureBarButtons()
        
        view.addSubview(imagePreview)
        view.addSubview(labelPreview)
        
        // Initial constraints setup
        setupConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // Additional layout adjustments if needed
    }
    
    private func setupConstraints() {
        let insets = self.view.safeAreaInsets
        
        imagePreview.topAnchor.constraint(equalTo: view.topAnchor, constant: insets.top).isActive = true
        imagePreview.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -insets.bottom).isActive = true
        imagePreview.leftAnchor.constraint(equalTo: view.leftAnchor, constant: insets.left).isActive = true
        imagePreview.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -insets.right).isActive = true
        
        labelPreview.topAnchor.constraint(equalTo: imagePreview.topAnchor).isActive = true
        labelPreview.bottomAnchor.constraint(equalTo: imagePreview.bottomAnchor).isActive = true
        labelPreview.leftAnchor.constraint(equalTo: imagePreview.leftAnchor).isActive = true
        labelPreview.rightAnchor.constraint(equalTo: imagePreview.rightAnchor).isActive = true
    }
    
    private func configureNavigationItem() {
        navigationItem.title = "Flower Finder"
        navigationItem.setRightBarButtonItems([cameraBarButton], animated: true)
    }

    private func configureBarButtons() {
        cameraBarButton.target = self
        cameraBarButton.action = #selector(cameraButtonPressed)
    }
    
    // On camera button pressed
    @objc private func cameraButtonPressed() {
        print("Camera button pressed")
        present(imagePicker, animated: true)
    }
    
    private func navigateToResultViewController() {
        let resultVC = ResultViewController()
        resultVC.resultString = self.resultString
//        resultVC.viewModel = self.viewModel // Pass the shared view model
        navigationController?.pushViewController(resultVC, animated: true)
    }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // Load captured photo
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let pickedImage = info[.editedImage] as? UIImage else {
            fatalError("Failed to set picked image to preview!")
        }
        
        imagePreview.image = pickedImage
        labelPreview.isHidden = true
        
        // Convert into CIImage before passing the captured photo into machine learning model
        guard let convertedCIImage = CIImage(image: pickedImage) else {
            fatalError("Failed to convert UIImage into CIImage")
        }
        
        // Pass captured photo into machine learning model
        detectFlower(image: convertedCIImage)
        
        imagePicker.dismiss(animated: true)
    }
    
    // Detect flower with machine learning model
    private func detectFlower(image: CIImage) {
        let request = VNCoreMLRequest(model: Model) { [weak self] (request, error) in
            guard let classificationResults = request.results as? [VNClassificationObservation] else { return }
            
            // Sort prediction results by its confidence
            let sortedResults = classificationResults.sorted { $0.confidence > $1.confidence }
            
            // Extract the top result
            if let topResult = sortedResults.first {
                let flowerName = topResult.identifier.capitalized
                self?.resultString = flowerName
                
                // Automatically add the flower to the collection
                self?.viewModel.addFlower(flowerName)
                
                // Navigate to ResultViewController
                DispatchQueue.main.async {
                    self?.navigateToResultViewController()
                }
            }
        }
        
        let handler = VNImageRequestHandler(ciImage: image)
        
        // Perform prediction
        do {
            try handler.perform([request])
        } catch {
            print(error)
        }
    }
}



//
//import UIKit
//import CoreML
//import Vision
//
//class ViewController: UIViewController {
//
//    // Machine learning model
//    private var model: VNCoreMLModel? = nil
//    private var Model: VNCoreMLModel {
//        get {
//            guard let unwrappedModel = model else {
//                fatalError("model is nil!")
//            }
//            return unwrappedModel
//        }
//    }
//    
//    private let imagePicker = UIImagePickerController()
//    
//    private let cameraBarButton = UIBarButtonItem(barButtonSystemItem: .camera, target: nil, action: nil)
//    
//    private let imagePreview: UIImageView = {
//        let imageView = UIImageView()
//        imageView.backgroundColor = .systemBackground
//        imageView.contentMode = .scaleAspectFit
//        imageView.clipsToBounds = true
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        return imageView
//    }()
//    
//    private let labelPreview: UILabel = {
//        let label = UILabel()
//        label.numberOfLines = 0
//        label.textColor = .label
//        label.font = UIFont.systemFont(ofSize: 16)
//        label.textAlignment = .center
//        label.lineBreakMode = .byWordWrapping
//        label.text = "Press the camera button to take a flower picture!"
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//    
//    private let padding = CGFloat(14)
//    private var resultString: String? // Variable to hold the result string
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        // Load machine learning model
//        guard let importedModel = try? VNCoreMLModel(for: FC_new().model) else {
//            fatalError("Cannot import model!")
//        }
//        
//        model = importedModel
//        
//        imagePicker.delegate = self
//        imagePicker.allowsEditing = true
//        imagePicker.sourceType = .camera
//        
//        view.backgroundColor = .systemBackground
//        
//        configureNavigationItem()
//        configureBarButtons()
//        
//        view.addSubview(imagePreview)
//        view.addSubview(labelPreview)
//        
//        // Initial constraints setup
//        setupConstraints()
//    }
//    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        // Additional layout adjustments if needed
//    }
//    
//    private func setupConstraints() {
//        let insets = self.view.safeAreaInsets
//        
//        imagePreview.topAnchor.constraint(equalTo: view.topAnchor, constant: insets.top).isActive = true
//        imagePreview.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -insets.bottom).isActive = true
//        imagePreview.leftAnchor.constraint(equalTo: view.leftAnchor, constant: insets.left).isActive = true
//        imagePreview.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -insets.right).isActive = true
//        
//        labelPreview.topAnchor.constraint(equalTo: imagePreview.topAnchor).isActive = true
//        labelPreview.bottomAnchor.constraint(equalTo: imagePreview.bottomAnchor).isActive = true
//        labelPreview.leftAnchor.constraint(equalTo: imagePreview.leftAnchor).isActive = true
//        labelPreview.rightAnchor.constraint(equalTo: imagePreview.rightAnchor).isActive = true
//    }
//    
//    private func configureNavigationItem() {
//        navigationItem.title = "Flower Finder"
//        navigationItem.setRightBarButtonItems([cameraBarButton], animated: true)
//    }
//
//    private func configureBarButtons() {
//        cameraBarButton.target = self
//        cameraBarButton.action = #selector(cameraButtonPressed)
//    }
//    
//    // On camera button pressed
//    @objc private func cameraButtonPressed() {
//        print("Camera button pressed")
//        present(imagePicker, animated: true)
//    }
//    
//    private func navigateToResultViewController() {
//        let resultVC = ResultViewController()
//        resultVC.resultString = self.resultString
//        navigationController?.pushViewController(resultVC, animated: true)
//    }
//}
//
//extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
//    
//    // Load captured photo
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        
//        let pickedImage = info[.editedImage]
//        
//        guard let pickedImage = pickedImage as? UIImage else {
//            fatalError("Failed to set picked image to preview!")
//        }
//        
//        imagePreview.image = pickedImage
//        labelPreview.isHidden = true
//        
//        // Convert into CIImage before passing the captured photo into machine learning model
//        guard let convertedCIImage = CIImage(image: pickedImage) else {
//            fatalError("Failed to convert UIImage into CIImage")
//        }
//        
//        // Pass captured photo into machine learning model
//        detectFlower(image: convertedCIImage)
//        
//        imagePicker.dismiss(animated: true)
//    }
//    
//    // Detect flower with machine learning model
//    private func detectFlower(image: CIImage) {
//        
//        let request = VNCoreMLRequest(model: Model) { [weak self] (request, error) in
//            
//            guard let classificationResults = request.results as? [VNClassificationObservation] else { return }
//            
//            // Sort prediction results by its confidence
//            let sortedResults = classificationResults.sorted { $0.confidence > $1.confidence}
//            
//            var resultString = ""
//            
//            // Get top 3 prediction results with highest confidence
//            for i in 0...2 {
//                resultString += "\(sortedResults[i].identifier.capitalized)\n"
//            }
//            
//            // Save the result string
//            self?.resultString = resultString
//            
//            // Navigate to ResultViewController
//            self?.navigateToResultViewController()
//        }
//        
//        let handler = VNImageRequestHandler(ciImage: image)
//        
//        // Perform prediction
//        do {
//            try handler.perform([request])
//        } catch {
//            print(error)
//        }
//    }
//}
