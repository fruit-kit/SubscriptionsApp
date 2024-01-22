//
//  SubPlanViewController.swift
//  Subscriptions
//
//  Created by Robert Kotrutsa on 16.11.2023.
//

import UIKit

class SubPlanViewController: UIViewController {
    
    // MARK: - Properties
    
    private var defaultTitleOfDescription = DefaultValues.defaultTitleOfDescription
    
    private var defaultDescriptionImage = UIImage(named: DefaultValues.defaultImage)
    
    private var textOfDescription = DefaultValues.defaultTextOfDescription
    
    private var currentPriceIndex = 0
    
    private var currentPrice: Decimal = 0.0
    
    private var selectedSubscription: Subscription?
    
    // MARK: Outlets
    
    @IBOutlet weak var descriptionView: UIView!
    
    @IBOutlet weak var descriptionImage: UIImageView!
    
    @IBOutlet weak var titleOfDescription: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var selectPlanSegmentControl: UISegmentedControl!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var addSelectedPlanButton: UIButton!
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .backgroundColorVC
        
        setupTitle()
        
        setupContainerView()
        
        setupDescriptionView()
        
        setupDatePicker()
        
        if let subscription = selectedSubscription {
            setPricesForSegments(subscription: subscription)
        }
    }
    
    // MARK: - Actions
    
    @IBAction func segmentControlValueChanged(_ sender: UISegmentedControl) {
        
        currentPriceIndex = sender.selectedSegmentIndex
        updateDescriptionLabelWithCurrentPrice()
    }
    
    @IBAction func addSelectedPlanButtonPressed(_ sender: Any) {
        
        guard var selectedSubscription = selectedSubscription else {
            print("Error: no subscription selected")
            return
        }
        
        guard !isSubscriptionAlreadyAdded(subscription: selectedSubscription) else {
            
            let alertController = UIAlertController(title: "Error", message: "This subscription has already been added. \nDelete an existing subscription to add a new one.", preferredStyle: .alert)
            
            let alertAction = UIAlertAction(title: "Ok", style: .cancel)
            
            alertController.addAction(alertAction)
            
            self.present(alertController, animated: true)
            
            return
        }
        
        selectedSubscription.currentPrice = currentPrice
        selectedSubscription.currentDescription = textOfDescription
        
        let selectedDate = datePicker.date
        
        if let expirationDate = Calendar.current.date(byAdding: .month, value: 1, to: selectedDate) {
            
            let dateFormatter = DateFormatter()
            
            dateFormatter.dateFormat = "dd MMMM yyyy"
            
            let formattedExpirationDate = dateFormatter.string(from: expirationDate)
            
            selectedSubscription.subscriptionTerm = formattedExpirationDate
        }
        
        (self.navigationController?.viewControllers.first as? HomeViewController)?.addSubscription(selectedSubscription)
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Methods
    
    func configureSubPlanInfoFor(subTitle: String, subIcon: UIImage, subscription: Subscription) {
        
        self.defaultTitleOfDescription = subTitle
        self.defaultDescriptionImage = subIcon
        self.selectedSubscription = subscription
    }
    
    func setPricesForSegments(subscription: Subscription) {
        
        guard let segmentControl = selectPlanSegmentControl else {
            print(ErrorMessages.segmentControlNil)
            return
        }
        
        segmentControl.removeAllSegments()
        
        for (index, price) in subscription.subPrices.enumerated() {
            segmentControl.insertSegment(withTitle: "$\(price)", at: index, animated: false)
        }
        
        if currentPriceIndex >= 0 && currentPriceIndex < subscription.subPrices.count {
            segmentControl.selectedSegmentIndex = currentPriceIndex
        } else {
            segmentControl.selectedSegmentIndex = 0
            currentPriceIndex = 0
        }
        
        updateDescriptionLabelWithCurrentPrice()
    }
    
    func configureSubPlanInfoFor(subscription: Subscription, additionalInfo: String, currentPriceIndex: Int) {
        
        self.selectedSubscription = subscription
        self.textOfDescription = additionalInfo
        self.currentPriceIndex = currentPriceIndex
    }
    
    // MARK: - Private Methods
    
    private func setupDatePicker() {
        
        if let oneMonthAgo = Calendar.current.date(byAdding: .month,
                                                   value: -1,
                                                   to: Date()) {
            datePicker.minimumDate = oneMonthAgo
        }
        
        datePicker.maximumDate = Date()
        
        if let datePickerLabel = datePicker.value(forKey: "textColor") as? UIColor {
            
            datePicker.setValue(UIColor.colorTitleVC, forKey: "textColor")
                }
    }
    
    private func isSubscriptionAlreadyAdded(subscription: Subscription) -> Bool {
        if let homeViewController = self.navigationController?.viewControllers.first as? HomeViewController {
            return homeViewController.subscriptions.contains(where: { $0.subType == subscription.subType })
        }
        return false
    }
    
    private func setupTitle() {
        
        title = DefaultValues.selectPlanTitle
    }
    
    private func setupDescriptionView() {
        
        setupInfoSubList()
        
        if let mainColor = UIColor(named: "mainColor") {
            descriptionView.backgroundColor = mainColor
        }
        descriptionView.layer.cornerRadius = 20
        descriptionView.layer.shadowColor = UIColor.black.cgColor
        descriptionView.layer.shadowOpacity = 0.25
        descriptionView.layer.shadowOffset = CGSize(width: 0, height: 10)
        descriptionView.layer.shadowRadius = 10.0
    }
    
    private func setupInfoSubList() {
        
        titleOfDescription.font = .systemFont(ofSize: 29)
        titleOfDescription.textColor = .backgroundColorVC
        
        guard let titleOfDescription = titleOfDescription, let selectedSubscription = selectedSubscription else {
            print(ErrorMessages.errorNilMessage)
            return
        }
        
        titleOfDescription.text = selectedSubscription.subType.rawValue
        
        guard let descriptionImage = descriptionImage else {
            print(ErrorMessages.errorNilImageMessage)
            return
        }
        
        if let subscriptionImage = selectedSubscription.subType.image {
            descriptionImage.image = subscriptionImage
        } else {
            print(ErrorMessages.subscriptionImageNil)
            descriptionImage.image = UIImage(named: DefaultValues.defaultImage)
        }
        
        currentPriceIndex = selectPlanSegmentControl.selectedSegmentIndex
        
        updateDescriptionLabelWithCurrentPrice()
    }
    
    private func updateDescriptionLabelWithCurrentPrice() {
        
        guard let selectedSubscription = selectedSubscription else {
            print(ErrorMessages.selectedSubscriptionNil)
            return
        }
        
        let currentPrice = selectedSubscription.subPrices[currentPriceIndex]
        
        self.currentPrice = Decimal(currentPrice)
        
        let currentDescription = selectedSubscription.additionalInformation[currentPriceIndex]
        
        descriptionLabel.text = "Cost per month:".localized() +
        " $\(currentPrice)" +
        "\n" +
        "\n\(currentDescription)"
        descriptionLabel.font = .systemFont(ofSize: 20)
        descriptionLabel.textColor = .backgroundColorVC
    }
    
    private func setupContainerView() {
        
        setupSelectPlanSegmentControl()
        
        setupAddSelectedPlanButton()
        
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = 0.25
        containerView.layer.shadowOffset = CGSize(width: 0, height: 10)
        containerView.layer.shadowRadius = 10.0
    }
    
    private func setupSelectPlanSegmentControl() {
        
        
        let normalTextAttributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.foregroundColor: UIColor.tabBarItemAccent,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)
        ]
        
        selectPlanSegmentControl.setTitleTextAttributes(normalTextAttributes, for: .normal)
        
        if let mainColor = UIColor(named: "mainColor") {
            selectPlanSegmentControl.selectedSegmentTintColor = mainColor
        }
        
        let selectedTextAttributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.foregroundColor: UIColor.backgroundColorVC,
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)
        ]
        
        selectPlanSegmentControl.setTitleTextAttributes(selectedTextAttributes, for: .selected)
    }
    
    private func setupAddSelectedPlanButton() {
        
        if let mainColor = UIColor(named: "mainColor") {
            addSelectedPlanButton.backgroundColor = mainColor
        }
        addSelectedPlanButton.setTitle("Add subscription".localized(), for: .normal)
        addSelectedPlanButton.layer.cornerRadius = 10
        addSelectedPlanButton.titleLabel?.textColor = .backgroundColorVC
        
        addSelectedPlanButton.layer.shadowColor = UIColor.black.cgColor
        addSelectedPlanButton.layer.shadowOpacity = 0.25
        addSelectedPlanButton.layer.shadowOffset = CGSize(width: 0, height: 10)
        addSelectedPlanButton.layer.shadowRadius = 10.0
    }
    
}
