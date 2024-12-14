import UIKit

protocol Navigator {
    func push(_ viewController: UIViewController, animated: Bool)
    func pop(animated: Bool)
    func setRoot(_ viewController: UIViewController, animated: Bool)
}
