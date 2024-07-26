//import UIKit
//import AVKit
//import Vision
//
//class ViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {
//    
//    override var prefersStatusBarHidden: Bool {
//        return true
//    }
//    
//    // Declare the views and labels programmatically
//    let belowView: UIView = {
//        let view = UIView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
//    
//    let objectNameLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.textAlignment = .center
//        label.textColor = .white
//        label.font = UIFont.boldSystemFont(ofSize: 18)
//        return label
//    }()
//    
//    let accuracyLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.textAlignment = .center
//        label.textColor = .white
//        label.font = UIFont.systemFont(ofSize: 16)
//        return label
//    }()
//    
//    var model = FC_new().model
//    var captureSession: AVCaptureSession?
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        setupCamera()
//        setupBelowView()
//    }
//    
//    func setupCamera() {
//        captureSession = AVCaptureSession()
//        
//        guard let captureSession = captureSession,
//              let captureDevice = AVCaptureDevice.default(for: .video),
//              let input = try? AVCaptureDeviceInput(device: captureDevice) else { return }
//        
//        captureSession.addInput(input)
//        captureSession.startRunning()
//        
//        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
//        previewLayer.frame = view.frame
//        view.layer.addSublayer(previewLayer)
//        
//        let dataOutput = AVCaptureVideoDataOutput()
//        dataOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoQueue"))
//        captureSession.addOutput(dataOutput)
//    }
//    
//    func setupBelowView() {
//        // Add belowView to the main view
//        view.addSubview(belowView)
//        belowView.backgroundColor = .black.withAlphaComponent(0.6)
//        belowView.clipsToBounds = true
//        belowView.layer.cornerRadius = 15.0
//        belowView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
//        
//        // Add objectNameLabel and accuracyLabel to belowView
//        belowView.addSubview(objectNameLabel)
//        belowView.addSubview(accuracyLabel)
//        
//        // Set constraints for belowView
//        NSLayoutConstraint.activate([
//            belowView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            belowView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            belowView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
//            belowView.heightAnchor.constraint(equalToConstant: 100)
//        ])
//        
//        // Set constraints for objectNameLabel
//        NSLayoutConstraint.activate([
//            objectNameLabel.topAnchor.constraint(equalTo: belowView.topAnchor, constant: 10),
//            objectNameLabel.leadingAnchor.constraint(equalTo: belowView.leadingAnchor, constant: 10),
//            objectNameLabel.trailingAnchor.constraint(equalTo: belowView.trailingAnchor, constant: -10)
//        ])
//        
//        // Set constraints for accuracyLabel
//        NSLayoutConstraint.activate([
//            accuracyLabel.topAnchor.constraint(equalTo: objectNameLabel.bottomAnchor, constant: 5),
//            accuracyLabel.leadingAnchor.constraint(equalTo: belowView.leadingAnchor, constant: 10),
//            accuracyLabel.trailingAnchor.constraint(equalTo: belowView.trailingAnchor, constant: -10)
//        ])
//    }
//    
//    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
//        guard let pixelBuffer: CVPixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
//        
//        guard let model = try? VNCoreMLModel(for: model) else { return }
//        let request = VNCoreMLRequest(model: model) { (finishedReq, err) in
//            guard let results = finishedReq.results as? [VNClassificationObservation],
//                  let firstObservation = results.first else { return }
//            
//            let name = firstObservation.identifier
//            let acc = Int(firstObservation.confidence * 100)
//            
//            DispatchQueue.main.async {
//                self.objectNameLabel.text = name
//                self.accuracyLabel.text = "Accuracy: \(acc)%"
//            }
//        }
//        
//        try? VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:]).perform([request])
//    }
//}
//
// ViewController.swift
//
//import UIKit
//
//class ViewController: UIViewController {
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
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        view.backgroundColor = .systemBackground
//        
//        configureNavigationItem()
//        configureBarButtons()
//        
//        view.addSubview(imagePreview)
//        view.addSubview(labelPreview)
//        
//        imagePicker.delegate = self
//        imagePicker.allowsEditing = true
//        imagePicker.sourceType = .camera
//    }
//    
//    override func viewDidLayoutSubviews() {
//        
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
//        present(imagePicker, animated: true)
//    }
//
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
//        labelPreview.isHidden = true
//        
//        imagePreview.image = pickedImage
//
//        imagePicker.dismiss(animated: true)
//    }
//
//}

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
    
    private let labelResultContainer: UIView = {
        let uiView = UIView()
        uiView.backgroundColor = .red.withAlphaComponent(0.5)
        uiView.layer.cornerRadius = 16
        uiView.translatesAutoresizingMaskIntoConstraints = false
        return uiView
    }()
    
    private let labelResult: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 11)
        label.textAlignment = .left
        label.text = ""
        label.lineBreakMode = .byCharWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let padding = CGFloat(14)
    
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
        view.addSubview(labelResultContainer)
        
        labelResultContainer.addSubview(labelResult)
    }
    
    override func viewDidLayoutSubviews() {
        
        let insets = self.view.safeAreaInsets
        
        imagePreview.topAnchor.constraint(equalTo: view.topAnchor, constant: insets.top).isActive = true
        imagePreview.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -insets.bottom).isActive = true
        imagePreview.leftAnchor.constraint(equalTo: view.leftAnchor, constant: insets.left).isActive = true
        imagePreview.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -insets.right).isActive = true
        
        labelPreview.topAnchor.constraint(equalTo: imagePreview.topAnchor).isActive = true
        labelPreview.bottomAnchor.constraint(equalTo: imagePreview.bottomAnchor).isActive = true
        labelPreview.leftAnchor.constraint(equalTo: imagePreview.leftAnchor).isActive = true
        labelPreview.rightAnchor.constraint(equalTo: imagePreview.rightAnchor).isActive = true
        
        labelResultContainer.leftAnchor.constraint(equalTo: view.leftAnchor, constant: insets.left+padding).isActive = true
        labelResultContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -insets.bottom-padding).isActive = true
        labelResultContainer.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -(view.bounds.width / 2)).isActive = true
        
        labelResult.topAnchor.constraint(equalTo: labelResultContainer.topAnchor, constant: padding).isActive = true
        labelResult.bottomAnchor.constraint(equalTo: labelResultContainer.bottomAnchor, constant: -padding).isActive = true
        labelResult.leftAnchor.constraint(equalTo: labelResultContainer.leftAnchor, constant: padding).isActive = true
        labelResult.rightAnchor.constraint(equalTo: labelResultContainer.rightAnchor, constant: -padding).isActive = true
        
        labelResultContainer.heightAnchor.constraint(equalTo: labelResult.heightAnchor, constant: padding * 2).isActive = true
        
        // Hide result label
        labelResultContainer.isHidden = true
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
        present(imagePicker, animated: true)
    }
    
    private func setResultLabel(resultString: String) {
        print("Result string:\n\(resultString)")
        labelResult.text = resultString
        labelResultContainer.heightAnchor.constraint(equalTo: labelResult.heightAnchor, constant: padding * 2).isActive = true
    }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // Load captured photo
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let pickedImage = info[.editedImage]
        
        guard let pickedImage = pickedImage as? UIImage else {
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
            let sortedResults = classificationResults.sorted { $0.confidence > $1.confidence}
            
            var resultString = ""
            
            // Get top 3 prediction results with highest confidence
            for i in 0...2 {
                resultString += "\(sortedResults[i].identifier.capitalized), confidence: \(sortedResults[i].confidence)\n"
            }
            
            // Show results label in the main thread
            DispatchQueue.main.async {
                self?.labelResultContainer.isHidden = false
            }
            
            // Updating results label text
            self?.setResultLabel(resultString: resultString)
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
