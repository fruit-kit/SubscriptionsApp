//
//  SubListTableViewCell.swift
//  Subscriptions
//
//  Created by Robert Kotrutsa on 11.11.2023.
//

import UIKit
import Lottie

class SubListTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var imageOfSubscription: UIImageView!
    
    @IBOutlet weak var nameOfSubscription: UILabel!
    
    @IBOutlet weak var animationImage: UIImageView!
    
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
    
    // MARK: - Private Methods
    
    private func configureTableViewcell() {
        
        setupNameOfSubscription()
        
        setupAnimationImage()
        
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
        
        nameOfSubscription.font = .systemFont(ofSize: 25)
        nameOfSubscription.textColor = .backgroundColorVC
    }
    
    // FIXME: Fix the same code
    
    private func setupAnimationImage() {
        
        let animationView = LottieAnimationView(name: AnimationNames.plus)
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()
        animationView.isUserInteractionEnabled = false
        
        animationImage.addSubview(animationView)
        
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.centerXAnchor.constraint(equalTo: animationImage.centerXAnchor).isActive = true
        animationView.centerYAnchor.constraint(equalTo: animationImage.centerYAnchor).isActive = true
        
        animationView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        animationView.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
}
