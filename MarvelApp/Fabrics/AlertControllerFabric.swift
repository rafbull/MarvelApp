//
//  AlertControllerFabric.swift
//  MarvelApp
//
//  Created by Rafis on 18.06.2024.
//

import UIKit

final class AlertControllerFabric {
    static func createAlerController(title: String, message: String, actionTitle: String) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: actionTitle, style: .default)
        alertController.addAction(action)
        return alertController
    }
}
