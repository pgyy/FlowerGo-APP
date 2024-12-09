import UIKit
import SwiftUI

class ResultViewController: UIViewController {
    
    var resultString: String? // Holds the classifier result as a string
    private var viewModel = ResultViewModel() // The shared view model
    private var showAllFlowers = false // State to track if AllFlowersView should be displayed
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set background color
        view.backgroundColor = UIColor(named: "LightGreen") ?? UIColor.systemBackground
        
        // Main vertical stack view
        let mainStackView = UIStackView()
        mainStackView.axis = .vertical
        mainStackView.alignment = .fill
        mainStackView.distribution = .equalSpacing
        mainStackView.spacing = 24
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mainStackView)
        
        // Add classifier result section
        if let resultString = resultString {
            let classifierResult = extractClassifierResult(resultString)
            viewModel.addFlower(classifierResult) // Add the result to the collected flowers
            let classifierResultCard = ResultCardView(result: classifierResult, viewModel: viewModel)
            let hostingView = viewForHosting(classifierResultCard)
            mainStackView.addArrangedSubview(hostingView)
        } else {
            // Add a section for all flowers only if there is no result
            let allFlowersCard = viewForHosting(AllFlowersView(viewModel: viewModel))
            mainStackView.addArrangedSubview(allFlowersCard)
        }
        
        // Add constraints for main stack view
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            mainStackView.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -80)
        ])
        
        // Add a button to navigate to the CollectionView
        let showCollectionButton = UIButton(type: .system)
        showCollectionButton.setTitle("Show Collection", for: .normal)
        showCollectionButton.setTitleColor(.white, for: .normal)
        showCollectionButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        showCollectionButton.backgroundColor = UIColor.systemBlue
        showCollectionButton.layer.cornerRadius = 12
        showCollectionButton.addTarget(self, action: #selector(showCollection), for: .touchUpInside)
        showCollectionButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(showCollectionButton)
        
        NSLayoutConstraint.activate([
            showCollectionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            showCollectionButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            showCollectionButton.widthAnchor.constraint(equalToConstant: 200),
            showCollectionButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func viewForHosting<Content: View>(_ view: Content) -> UIView {
        let hostingController = UIHostingController(rootView: view)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        return hostingController.view
    }
    
    private func extractClassifierResult(_ resultString: String) -> String {
        // Extract the top result from the classifier output
        let results = resultString.split(separator: "\n").map { String($0) }
        return results.first ?? "Unknown"
    }
    
    @objc private func showCollection() {
        // Navigate to AllFlowersView regardless of result visibility
        let AFV = AllFlowersView(viewModel: viewModel)
        let hostingController = UIHostingController(rootView: AFV)
        navigationController?.pushViewController(hostingController, animated: true)
    }
}
