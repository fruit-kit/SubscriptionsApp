//
//  MenuViewController.swift
//  Subscriptions
//
//  Created by Robert Kotrutsa on 01.11.2023.
//

import UIKit
import Lottie
import Firebase
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore
import UserNotifications

class HomeViewController: UIViewController, WithUser {
    
    // MARK: - Properties
    
    var user: User?
    
    var subscriptions: [Subscription] = [] {
        didSet {
            recalculateTotalCost()
        }
    }
    
    var totalCost: Decimal = 0.00 {
        didSet {
            if totalCost < 0.00 {
                totalCost = 0.00
            }
            labelCost.text = String(format: "Total cost of subscriptions: \n$%.2f".localized(), self.totalCost.floatValue)
        }
    }
    
    private let router: HomeRouter = Router.shared
    
    // MARK: - Outlets
    
    @IBOutlet weak var totalCostView: UIView!
    
    @IBOutlet weak var labelCost: UILabel!
    
    @IBOutlet weak var addSubButton: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .backgroundColorVC
        
        setupTitle()
        
        setupTotalCostView()
        
        setupTableView()
        
        setupBackButton()
        
        loadSubscriptionsFromUserDefaults()
        
        readDataFromFirestore(for: user)
    }
    
    // MARK: - Actions
    
    @IBAction func addSubButtonPressed(_ sender: Any) {
        
        router.openSubList(from: self, animated: true)
    }
    
    // MARK: - Public Methods
    
    func addSubscription(_ subscription: Subscription) {
        
        guard let uid = Auth.auth().currentUser?.uid else {
            print("User is not authenticated.")
            return
        }
        
        subscriptions.insert(subscription, at: 0)
        tableView.reloadData()
        
        // MARK: Firestore
        
        let db = Firestore.firestore()
        
        let subscriptionsCollection = db.collection("users").document(uid).collection("subscriptions")
        
        for subscription in subscriptions {
            
            let documentRef = subscriptionsCollection.document(subscription.subType.rawValue)
            
            documentRef.setData([
                "nameOfSubscription": subscription.subType.rawValue,
                "subscriptionTerm": subscription.subscriptionTerm ?? "N/A",
                "subPrices": subscription.subPrices,
                "currentPrice": subscription.currentPrice ?? 0.00,
                "additionalInformation": subscription.additionalInformation,
                "currentDescription": subscription.currentDescription ?? "N/A"
            ]) { error in
                if let error = error {
                    print("Error when saving to Firestore: \(error)")
                } else {
                    print("Data successfully saved to Firestore")
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        self.saveSubscriptionsToUserDefaults()
                    }
                }
            }
        }
    }
    
    // MARK: - Private Methods
    
    private func recalculateTotalCost() {
        totalCost = 0.00
        
        for (_, value) in self.subscriptions.enumerated() {
            totalCost += value.currentPrice ?? 0.00
        }
    }
    
    private func readDataFromFirestore(for user: User?) {
        
        guard let user else { return }
        
        let db = Firestore.firestore()
        let uid = user.uid
        
        let subscriptionsCollection = db.collection("users").document(uid).collection("subscriptions")
        
        subscriptionsCollection.getDocuments { [weak self] (snapshot, error) in
            guard let snapshot, error == nil else {
                print("Error getting documents: \(String(describing: error?.localizedDescription))")
                return
            }
            
            var subscriptionsArray = [Subscription]()
            
            for document in snapshot.documents {
                
                let data = document.data()
                let nameOfSubscription = data["nameOfSubscription"] as? String ?? "N/A"
                let subscriptionTerm = data["subscriptionTerm"] as? String ?? "N/A"
                let subPrices = data["subPrices"] as? [Double] ?? [0.00]
                let currentPrice = (data["currentPrice"] as? NSNumber)?.decimalValue ?? Decimal(0.00)
                let additionalInformation = data["additionalInformation"] as? [String] ?? ["N/A"]
                let currentDescription = data["currentDescription"] as? String ?? "N/A"
                
                guard let subType = SubType(rawValue: nameOfSubscription) else { continue }
                
                let subscription = Subscription(
                    subType: subType,
                    subscriptionTerm: subscriptionTerm,
                    subPrices: subPrices,
                    currentPrice: currentPrice,
                    additionalInformation: additionalInformation,
                    currentDescription: currentDescription)
                subscriptionsArray.append(subscription)
                print(subscriptionsArray)
            }
            self?.didFinishReadingSubscriptions(subscriptionsArray)
        }
        
    }
    
    private func saveSubscriptionsToUserDefaults() {
        
        do {
            let encodedData = try JSONEncoder().encode(subscriptions)
            
            UserDefaults.standard.set(encodedData, forKey: "subscriptions")
            
            UserDefaults.standard.synchronize()
            
        } catch {
            print("Error when encoding subscriptions: \(error)")
        }
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    private func loadSubscriptionsFromUserDefaults() {
        
        if let data = UserDefaults.standard.data(forKey: "subscriptions") {
            do {
                let decodedSubscriptions = try JSONDecoder().decode([Subscription].self, from: data)
                
                subscriptions = decodedSubscriptions
                
            } catch {
                print("Error when decoding subscriptions: \(error)")
            }
        }
    }
    
    private func setupTableView() {
        
        tableView.delegate = self
        
        tableView.dataSource = self
        
        tableView.separatorStyle = .none
        
        registerTableViewCell()
    }
    
    private func registerTableViewCell() {
        
        let subNib = UINib(nibName: NibNames.subCell, bundle: Bundle.main)
        tableView.register(subNib, forCellReuseIdentifier: NibNames.subCell)
    }
    
    private func setupTotalCostView() {
        
        setuplabelCost()
        
        setupAddSubButton()
        
        if let mainColor = UIColor(named: "mainColor") {
            
            totalCostView.backgroundColor = mainColor
        }
        totalCostView.layer.cornerRadius = 20
        totalCostView.layer.shadowColor = UIColor.black.cgColor
        totalCostView.layer.shadowOpacity = 0.25
        totalCostView.layer.shadowOffset = CGSize(width: 0, height: 10)
        totalCostView.layer.shadowRadius = 10.0
    }
    
    private func setuplabelCost() {
        
        labelCost.text = DefaultValues.totalCostLabel
        labelCost.font = .systemFont(ofSize: 24)
        labelCost.numberOfLines = 0
        labelCost.textColor = .backgroundColorVC
    }
    
    private func setupTitle() {
        
        title = DefaultValues.subscriptionsTitle
    }
    
    private func setupBackButton() {
        
        let backButton = UIBarButtonItem()
        backButton.tintColor = .tabBarItemAccent
        navigationItem.backBarButtonItem = backButton
    }
    
    private func setupAddSubButton() {
        
        let animationView = LottieAnimationView(name: AnimationNames.plus)
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()
        animationView.isUserInteractionEnabled = false
        addSubButton.addSubview(animationView)
        
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.centerXAnchor.constraint(equalTo: addSubButton.centerXAnchor).isActive = true
        animationView.centerYAnchor.constraint(equalTo: addSubButton.centerYAnchor).isActive = true
        
        animationView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        animationView.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
}

// MARK: - TableViewDelegate

extension HomeViewController: UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int { 1 }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool { true }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { [weak self] (action, indexPath) in
            
            guard let self = self else { return }
            
            let deletedSubscription = self.subscriptions[indexPath.row]
            
            self.subscriptions.remove(at: indexPath.row)
            
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            if let uid = Auth.auth().currentUser?.uid {
                
                let subscriptionsCollection = Firestore.firestore().collection("users").document(uid).collection("subscriptions")
                
                subscriptionsCollection.document(deletedSubscription.subType.rawValue).delete { error in
                    if let error = error {
                        print("Error when deleting from Firestore: \(error)")
                    } else {
                        print("Data successfully deleted from Firestore")
                        
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                            self.saveSubscriptionsToUserDefaults()
                        }
                    }
                }
            }
        }
        
        deleteAction.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        
        return [deleteAction]
    }
    
}

// MARK: - TableViewDataSource

extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { subscriptions.count }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let index = indexPath.row
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NibNames.subCell, for: indexPath) as?  SubTableViewCell else { return UITableViewCell() }
        
        cell.fillCell(with: subscriptions[index])
        
        cell.backgroundColor = .backgroundColorVC.withAlphaComponent(0.0)
        cell.selectionStyle = .none
        
        return cell
    }
    
}

// MARK: - SubscriptionDelegate

extension HomeViewController {
    
    func didFinishReadingSubscriptions(_ subscriptions: [Subscription]) {
        
        print("didFinishReadingSubscriptions called")
        
        self.subscriptions = subscriptions
        
        DispatchQueue.main.async {
            
            self.tableView.reloadData()
            self.saveSubscriptionsToUserDefaults()
        }
    }
    
}
