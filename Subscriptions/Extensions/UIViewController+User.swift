//
//  UIViewController+User.swift
//  Subscriptions
//
//  Created by Yury Vozleev on 11.12.2023.
//

import UIKit

import FirebaseAuth

protocol WithUser: UIViewController {
    var user: User? { get set }
}
