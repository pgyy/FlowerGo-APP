//import UIKit
//import SwiftUI
//
//class ResultViewController: UIViewController {
//    
//    var resultString: String?
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        view.backgroundColor = .systemBackground
//        
//        if let resultString = resultString {
//            let results = resultString.split(separator: "\n").map { String($0) }
//            let resultCards = results.map { ResultCardView(result: $0) }
//            
//            let stackView = UIStackView(arrangedSubviews: resultCards.map { UIHostingController(rootView: $0).view })
//            stackView.axis = .vertical
//            stackView.alignment = .fill
//            stackView.distribution = .equalSpacing
//            stackView.spacing = 12
//            stackView.translatesAutoresizingMaskIntoConstraints = false
//            
//            view.addSubview(stackView)
//            
//            NSLayoutConstraint.activate([
//                stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//                stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
//                stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
//            ])
//        }
//    }
//}

import UIKit
import SwiftUI

class ResultViewController: UIViewController {
    
    var resultString: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        if let resultString = resultString {
            let results = resultString.split(separator: "\n").map { String($0) }
            let resultCards = results.map { ResultCardView(result: $0) }
            
            let stackView = UIStackView(arrangedSubviews: resultCards.map { viewForHosting($0) })
            stackView.axis = .vertical
            stackView.alignment = .fill
            stackView.distribution = .equalSpacing
            stackView.spacing = 12
            stackView.translatesAutoresizingMaskIntoConstraints = false
            
            view.addSubview(stackView)
            
            NSLayoutConstraint.activate([
                stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
            ])
        }
    }
    
    private func viewForHosting<Content: View>(_ view: Content) -> UIView {
        let hostingController = UIHostingController(rootView: view)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        return hostingController.view
    }
}
