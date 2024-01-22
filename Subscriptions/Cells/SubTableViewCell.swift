//
//  SubTableViewCell.swift
//  Subscriptions
//
//  Created by Robert Kotrutsa on 02.11.2023.
//

import UIKit

class SubTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var nameOfSubscription: UILabel!
    
    @IBOutlet weak var daysCount: UILabel!
    
    @IBOutlet weak var imageOfSubscription: UIImageView!
    
    @IBOutlet weak var subPrice: UILabel!
    
    @IBOutlet weak var viewCell: UIView!
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureTableViewcell()
    }
    
    // MARK: - Overrides
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        
        nameOfSubscription.text = ""
        daysCount.text = ""
        subPrice.text = ""
        imageOfSubscription.image = nil
    }
    
    // MARK: - Public Methods
    
    func fillCell(with subscription: Subscription) {
        
        prepareForReuse()
        
        nameOfSubscription.text = subscription.subType.rawValue
        
        if let subscriptionTerm = subscription.subscriptionTerm {
            daysCount.text = "\(subscriptionTerm)"
        } else {
            daysCount.text = "Term: N/A"
        }
        
        imageOfSubscription.image = subscription.subType.image
        subPrice.text = String(format: "$%.2f", (subscription.currentPrice?.floatValue ?? 0.0))
    }
    
    // MARK: - Private Methods
    
    private func configureTableViewcell() {
        
        setupNameOfSubscription()
        
        setupDaysCount()
        
        setupSubPrice()
        
        if let mainColor = UIColor(named: "mainColor") {
            viewCell.backgroundColor = mainColor
        }
        viewCell.layer.cornerRadius = 20
        viewCell.layer.shadowColor = UIColor.black.cgColor
        viewCell.layer.shadowOpacity = 0.25
        viewCell.layer.shadowOffset = CGSize(width: 0, height: 10)
        viewCell.layer.shadowRadius = 10.0
    }
    
    private func setupNameOfSubscription() {
        
        nameOfSubscription.font = .systemFont(ofSize: 22)
        nameOfSubscription.textColor = .backgroundColorVC
    }
    
    private func setupDaysCount() {
        
        daysCount.font = .systemFont(ofSize: 15)
        daysCount.textColor = .tabBarItemAccent
    }
    
    private func setupSubPrice() {
        
        subPrice.font = .systemFont(ofSize: 18)
        subPrice.textColor = .tabBarItemAccent
    }
    
}
