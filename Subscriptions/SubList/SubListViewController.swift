//
//  SubListViewController.swift
//  Subscriptions
//
//  Created by Robert Kotrutsa on 10.11.2023.
//

import UIKit

class SubListViewController: UIViewController {
    
    // MARK: - Properties
    
    var filteredSubscriptions: [Subscription] = []
    
    var originalSubList: [Subscription] = []
    
    var subList: [Subscription] = [
        Subscription(
            subType: .Netflix,
            subPrices: [4.99, 7.49, 9.99],
            additionalInformation: [
                "Basic:".localized() +
                "\n" +
                "\n▶ Unlimited ad-free movies, TV shows, and mobile games".localized() +
                "\n▶ Watch on 1 supported device at a time".localized() +
                "\n▶ Watch in HD".localized() +
                "\n▶ Download on 1 supported device at a time".localized(),
                                    
                "Standard:".localized() +
                "\n" +
                "\n▶ Unlimited ad-free movies, TV shows, and mobile games".localized() +
                "\n▶ Watch on 2 supported devices at a time".localized() +
                "\n▶ Watch in Full HD".localized() +
                "\n▶ Download on 2 supported devices at a time".localized() +
                "\n▶ Option to add 1 extra member who doesn't live with you".localized(),
                                    
                "Premium:".localized() +
                "\n" +
                "\n▶ Unlimited ad-free movies, TV shows, and mobile games".localized() +
                "\n▶ Watch on 4 supported devices at a time".localized() +
                "\n▶ Watch in Ultra HD".localized() +
                "\n▶ Download on 6 supported devices at a time".localized() +
                "\n▶ Option to add up to 2 extra members who don't live with you".localized() +
                "\n▶ Netflix spatial audio".localized()
            ]
        ),
        Subscription(
            subType: .Google,
            subPrices: [1.99, 2.99, 9.99],
            additionalInformation: [
                "Basic:".localized() +
                "\n" +
                "\n▶ 100 GB of storage".localized() +
                "\n▶ Access to Google experts".localized() +
                "\n▶ Share with up to 5 others".localized() +
                "\n▶ More Google Photos editing features".localized() +
                "\n▶ Extra member benefits".localized() +
                "\n▶ Monitor the dark web".localized(),
                
                "Standard:".localized() +
                "\n" +
                "\n▶ 200 GB of storage".localized() +
                "\n▶ Access to Google experts".localized() +
                "\n▶ Share with up to 5 others".localized() +
                "\n▶ More Google Photos editing features".localized() +
                "\n▶ Extra member benefits".localized() +
                "\n▶ Monitor the dark web".localized(),
                
                "Premium:".localized() +
                "\n" +
                "\n▶ 2 TB of storage".localized() +
                "\n▶ Access to Google experts".localized() +
                "\n▶ Share with up to 5 others".localized() +
                "\n▶ More Google Photos editing features".localized() +
                "\n▶ Extra member benefits".localized() +
                "\n▶ Monitor the dark web".localized()
            ]
        ),
        Subscription(
            subType: .iCloud,
            subPrices: [0.99, 2.99, 10.99, 32.99, 64.99],
            additionalInformation: [
                "iCloud+ with 50 GB storage:".localized() +
                "\n" +
                "\n▶ 50 GB of storage".localized() +
                "\n▶ iCloud Private Relay".localized() +
                "\n▶ Hide My Email".localized() +
                "\n▶ Custom Email Domain".localized() +
                "\n▶ HomeKit Secure Video support for one camera".localized() +
                "\n▶ Share everything with up to five other family members".localized(),
                    
                "iCloud+ with 200 GB storage:".localized() +
                "\n" +
                "\n▶ 200 GB of storage".localized() +
                "\n▶ iCloud Private Relay".localized() +
                "\n▶ Hide My Email".localized() +
                "\n▶ Custom Email Domain".localized() +
                "\n▶ HomeKit Secure Video support for up to five cameras".localized() +
                "\n▶ Share everything with up to five other family members".localized(),
                
                "iCloud+ with 2 TB storage:".localized() +
                "\n" +
                "\n▶ 2 TB of storage".localized() +
                "\n▶ iCloud Private Relay".localized() +
                "\n▶ Hide My Email".localized() +
                "\n▶ Custom Email Domain".localized() +
                "\n▶ HomeKit Secure Video support for an unlimited number of cameras".localized() +
                "\n▶ Share everything with up to five other family members".localized(),
                
                "iCloud+ with 6 TB storage:".localized() +
                "\n" +
                "\n▶ 6 TB of storage".localized() +
                "\n▶ iCloud Private Relay".localized() +
                "\n▶ Hide My Email".localized() +
                "\n▶ Custom Email Domain".localized() +
                "\n▶ HomeKit Secure Video support for an unlimited number of cameras".localized() +
                "\n▶ Share everything with up to five other family members".localized(),
                
                "iCloud+ with 12 TB storage:".localized() +
                "\n" +
                "\n▶ 12 TB of storage".localized() +
                "\n▶ iCloud Private Relay".localized() +
                "\n▶ Hide My Email".localized() +
                "\n▶ Custom Email Domain".localized() +
                "\n▶ HomeKit Secure Video support for an unlimited number of cameras".localized() +
                "\n▶ Share everything with up to five other family members".localized()
            ]
        ),
        Subscription(
            subType: .AppleMusic,
            subPrices: [5.99, 10.99, 16.99],
            additionalInformation: [
                "Student:".localized() +
                "\n" +
                "\n▶ 100 million songs and more than 30,000 expert-curated playlists".localized() +
                "\n▶ Request any track, album, playlist, or station simply by asking Siri or with Type to Siri".localized() +
                "\n▶ Free trial with no commitment".localized() +
                "\n▶ Stream ad-free music".localized() +
                "\n▶ Original shows, concerts, and exclusives — and live and on‑demand radio stations hosted by artists".localized() +
                "\n▶ Available on Apple devices".localized() +
                "\n▶ The Apple Music Classical app — featuring the largest classical catalog in the world".localized() +
                "\n▶ Available on other supported devices".localized() +
                "\n▶ Spatial Audio with Dolby Atmos".localized() +
                "\n▶ Full catalog in lossless audio".localized() +
                "\n▶ Apple Music Sing, with beat‑by-beat lyrics and adjustable vocals".localized() +
                "\n▶ Download 100,000 songs to your library, access your entire library from any device, and listen online or off".localized() +
                "\n▶ See what your friends are listening to".localized(),
                
                "Individual:".localized() +
                "\n" +
                "\n▶ 100 million songs and more than 30,000 expert-curated playlists".localized() +
                "\n▶ Request any track, album, playlist, or station simply by asking Siri or with Type to Siri".localized() +
                "\n▶ Free trial with no commitment".localized() +
                "\n▶ Stream ad-free music".localized() +
                "\n▶ Original shows, concerts, and exclusives — and live and on‑demand radio stations hosted by artists".localized() +
                "\n▶ Available on Apple devices".localized() +
                "\n▶ The Apple Music Classical app — featuring the largest classical catalog in the world".localized() +
                "\n▶ Available on other supported devices".localized() +
                "\n▶ Spatial Audio with Dolby Atmos".localized() +
                "\n▶ Full catalog in lossless audio".localized() +
                "\n▶ Apple Music Sing, with beat‑by-beat lyrics and adjustable vocals".localized() +
                "\n▶ Download 100,000 songs to your library, access your entire library from any device, and listen online or off".localized() +
                "\n▶ See what your friends are listening to".localized(),
                
                "Family:".localized() +
                "\n" +
                "\n▶ 100 million songs and more than 30,000 expert-curated playlists".localized() +
                "\n▶ Request any track, album, playlist, or station simply by asking Siri or with Type to Siri".localized() +
                "\n▶ Free trial with no commitment".localized() +
                "\n▶ Stream ad-free music".localized() +
                "\n▶ Original shows, concerts, and exclusives — and live and on‑demand radio stations hosted by artists".localized() +
                "\n▶ Available on Apple devices".localized() +
                "\n▶ The Apple Music Classical app — featuring the largest classical catalog in the world".localized() +
                "\n▶ Available on other supported devices".localized() +
                "\n▶ Spatial Audio with Dolby Atmos".localized() +
                "\n▶ Full catalog in lossless audio".localized() +
                "\n▶ Apple Music Sing, with beat‑by-beat lyrics and adjustable vocals".localized() +
                "\n▶ Download 100,000 songs to your library, access your entire library from any device, and listen online or off".localized() +
                "\n▶ See what your friends are listening to".localized() +
                "\n▶ Unlimited access for up to six people".localized() +
                "\n▶ Personal music library for each family member".localized() +
                "\n▶ Personalized recommendations for each family member".localized()
            ]
        ),
        Subscription(
            subType: .AppleTV,
            subPrices: [4.99],
            additionalInformation: [
                "▶ 7 days free, then 4.99 US$/month".localized() +
                "\n▶ Share Apple TV+ with your family".localized()
            ]
        ),
        Subscription(
            subType: .AppleArcade,
            subPrices: [6.99],
            additionalInformation: [
                "▶ Free 1 month trial".localized() +
                "\n▶ Unlimited access to 200+ incredibly fun games, with more added all the time".localized() +
                "\n▶ No ads".localized() +
                "\n▶ No interruptions".localized() +
                "\n▶ No in-app purchases".localized() +
                "\n▶ Play online, offline, and across your favorite Apple devices".localized() +
                "\n▶ Share your subscription with up to five people".localized()
            ]
        ),
        Subscription(
            subType: .AppleNews,
            subPrices: [0.00, 12.99],
            additionalInformation: [
                "AppleNews (Always free):".localized() +
                "\n" +
                "\n▶ Top stories chosen by editors, personalized for you".localized() +
                "\n▶ My Sports with scores, standings, and highlights".localized() +
                "\n▶ Apple News Today and In Conversation 🎧".localized() +
                "\n▶ Local news".localized() +
                "\n▶ Private and secure reading".localized() +
                "\n▶ CarPlay".localized(),
                    
                "AppleNews+:" +
                "\n" +
                "\n▶ Top stories chosen by editors, personalized for you".localized() +
                "\n▶ My Sports with scores, standings, and highlights".localized() +
                "\n▶ Apple News Today and In Conversation 🎧".localized() +
                "\n▶ Local news".localized() +
                "\n▶ Private and secure reading".localized() +
                "\n▶ CarPlay".localized() +
                "\n▶ 1 month free".localized() +
                "\n▶ Hundreds of magazines and leading newspapers".localized() +
                "\n▶ Apple News+ audio stories 🎧".localized() +
                "\n▶ Local news from top regional sources".localized() +
                "\n▶ Sports coverage from local and premium publications".localized() +
                "\n▶ Reading online and off across devices".localized() +
                "\n▶ Cover-to-cover magazines".localized() +
                "\n▶ Family Sharing for up to six".localized()
            ]
        ),
        Subscription(
            subType: .AppleFitness,
            subPrices: [9.99],
            additionalInformation: [
                "▶ 1 month free".localized() +
                "\n▶ Find it in the Fitness app. Available with iPhone, iPad, Apple TV, and Apple Watch".localized() +
                "\n▶ 12 workout types, everything from HIIT to Yoga. Meditation, too".localized() +
                "\n▶ From beginner to advanced. And 5 to 45 minutes".localized() +
                "\n▶ Custom Plans automatically built for you".localized() +
                "\n▶ Supercharge your experience with real-time metrics from Apple Watch".localized()
            ]
        ),
        Subscription(
            subType: .AppleOne,
            subPrices: [12.95, 16.95],
            additionalInformation: [
                "Individual:".localized() +
                "\n" +
                "\n▶ iCloud+ 50 GB ($0.99/mo.)".localized() +
                "\n▶ TV+ ($6.99/mo.)".localized() +
                "\n▶ Music ($6.49/mo.)".localized() +
                "\n▶ Arcade ($6.99/mo.)".localized(),
                    
                "Family:".localized() +
                "\n" +
                "\n▶ iCloud+ 200 GB ($2.99/mo.)".localized() +
                "\n▶ TV+ ($6.99/mo.)".localized() +
                "\n▶ Music ($9.99/mo.)".localized() +
                "\n▶ Arcade ($6.99/mo.)".localized()
            ]
        ),
        Subscription(
            subType: .Spotify,
            subPrices: [2.49, 4.99, 6.49, 7.99],
            additionalInformation: [
                "Premium Student:".localized() +
                    "\n" +
                    "\n▶ 1 verified Premium account".localized() +
                    "\n▶ Discount for students who meet the conditions".localized() +
                    "\n▶ Cancel anytime".localized(),
                    
                    "Premium Individual:".localized() +
                    "\n" +
                    "\n▶ 1 Premium account".localized() +
                    "\n▶ Cancel anytime".localized(),
                    
                    "Premium Duo:".localized() +
                    "\n" +
                    "\n▶ 2 Premium accounts".localized() +
                    "\n▶ Cancel anytime".localized(),
                    
                    "Premium Family:".localized() +
                    "\n" +
                    "\n▶ 6 Premium accounts".localized() +
                    "\n▶ Blocking music with age restrictions".localized() +
                    "\n▶ Cancel anytime".localized()
            ]
        ),
        Subscription(
            subType: .XboxGamePass,
            subPrices: [9.99, 16.99],
            additionalInformation: [
                "PC:".localized() +
                "\n" +
                "\n▶ Get your first 14 days for $1, then $9.99/mo.".localized() +
                "\n▶ Hundreds of high-quality games on PC".localized() +
                "\n▶ New games on day one".localized() +
                "\n▶ Member deals & discounts".localized() +
                "\n▶ EA Play membership".localized(),
                
                "Ultimate:".localized() +
                "\n" +
                "\n▶ Get your first 14 days for $1, then $16.99/mo.".localized() +
                "\n▶ Hundreds of high-quality games on console, PC, and cloud".localized() +
                "\n▶ New games on day one".localized() +
                "\n▶ Member deals, discounts, and Perks".localized() +
                "\n▶ Online console multiplayer".localized() +
                "\n▶ EA Play membership".localized()
            ]
        ),
        Subscription(
            subType: .PlayStationNow,
            subPrices: [9.99, 14.99, 17.99],
            additionalInformation: [
                "Essential:".localized() +
                "\n" +
                "\n▶ Monthly games".localized() +
                "\n▶ Online multiplayer".localized() +
                "\n▶ Exclusive discounts".localized() +
                "\n▶ Exclusive content".localized() +
                "\n▶ Cloud storage".localized() +
                "\n▶ Share Play".localized() +
                "\n▶ Game Help".localized(),
                    
                "Extra:".localized() +
                "\n" +
                "\n▶ Monthly games".localized() +
                "\n▶ Online multiplayer".localized() +
                "\n▶ Exclusive discounts".localized() +
                "\n▶ Exclusive content".localized() +
                "\n▶ Cloud storage".localized() +
                "\n▶ Share Play".localized() +
                "\n▶ Game Help".localized() +
                "\n▶ Game Catalog".localized() +
                "\n▶ Ubisoft+ Classics".localized(),
                    
                "Premium:".localized() +
                "\n" +
                "\n▶ Monthly games".localized() +
                "\n▶ Online multiplayer".localized() +
                "\n▶ Exclusive discounts".localized() +
                "\n▶ Exclusive content".localized() +
                "\n▶ Cloud storage".localized() +
                "\n▶ Share Play".localized() +
                "\n▶ Game Help".localized() +
                "\n▶ Game Catalog".localized() +
                "\n▶ Ubisoft+ Classics".localized() +
                "\n▶ Classics Catalog".localized() +
                "\n▶ Game trials".localized() +
                "\n▶ Cloud streaming".localized()
            ]
        ),
        Subscription(
            subType: .Audible,
            subPrices: [7.95, 14.99],
            additionalInformation: [
                "Audible plus:".localized() +
                "\n" +
                "\n▶ Free 30-day trial, then $7.95 per month".localized() +
                "\n▶ Originals".localized() +
                "\n▶ Audiobooks".localized() +
                "\n▶ Sleep tracks".localized() +
                "\n▶ Meditation programs".localized() +
                "\n▶ Podcasts".localized(),
                
                "Audible premium plus:".localized() +
                "\n" +
                "\n▶ Free 30-day trial, then $14.95 per month".localized() +
                "\n▶ Enjoy everything Audible Plus offers plus 1 title per month from an extended selection of best sellers and new releases" .localized()
            ]
        ),
        Subscription(
            subType: .iVi,
            subPrices: [2.99],
            additionalInformation: [
                "▶ New series and movies Ivy's exclusives, as well as thousands of movies and TV series from around the world".localized() +
                "\n▶ Simultaneous viewing on five devices Smart TV, smartphones, tablets, set-top boxes, etc".localized() +
                "\n▶ Maximum image and sound quality 4K, HDR, FHD, 5.1".localized() +
                "\n▶ Lack of advertising does not apply to TV channels".localized() +
                "\n▶ Downloading to mobile more than 10,000 TV series and movies".localized()
            ]
        ),
        Subscription(
            subType: .Megogo,
            subPrices: [2.69, 2.99, 5.49],
            additionalInformation: [
                "Light:".localized() +
                "\n" +
                "\n▶ Number of TV channels 290".localized() +
                "\n" +
                "\nMOVIES, SERIES, CARTOONS".localized() +
                "\n▶ Number of movies 10000+".localized() +
                "\n▶ 10% off on premieres".localized() +
                "\n▶ Collection of movies, series, and cartoons in Full HD, HDR, 3D, 4K without ads".localized() +
                "\n" +
                "\nCHANNELS".localized() +
                "\n▶ Sports Channels".localized() +
                "\n▶ Educational channels: Discovery, History HD, MEGA HD".localized() +
                "\n▶ Movie channels Comedy Central, FILMBOX, [M] COMEDY HD".localized() +
                "\n" +
                "\nAUDIOBOOKS AND PODCASTS".localized() +
                "\n▶ More than 900 audiobooks in the mobile app".localized(),
                
                "Optimal:".localized() +
                "\n" +
                "\n▶ Number of TV channels 380".localized() +
                "\n" +
                "\nMOVIES, SERIES, CARTOONS".localized() +
                "\n▶ Number of movies 11000+".localized() +
                "\n▶ 10% off on premieres".localized() +
                "\n▶ Collection of movies, series, and cartoons in Full HD, HDR, 3D, 4K without ads".localized() +
                "\n▶ Paramount+ movie collection".localized() +
                "\n" +
                "\nCHANNELS".localized() +
                "\n▶ Sports Channels".localized() +
                "\n▶ Educational channels: Discovery, History HD, MEGA HD".localized() +
                "\n▶ Movie channels Comedy Central, FILMBOX, [M] COMEDY HD".localized() +
                "\n▶ Premium channels Viasat, Cine+, FOX, Eurosport and others".localized() +
                "\n▶ Premium channels for children: Nickelodeon, Nick Jr., Tiji".localized() +
                "\n" +
                "\nAUDIOBOOKS AND PODCASTS".localized() +
                "\n▶ More than 900 audiobooks in the mobile app".localized(),
                
                "Maximal:".localized() +
                "\n" +
                "\n▶ Number of TV channels 405".localized() +
                "\n" +
                "\nMOVIES, SERIES, CARTOONS".localized() +
                "\n▶ Number of movies 15000+".localized() +
                "\n▶ 10% off on premieres".localized() +
                "\n▶ Collection of movies, series, and cartoons in Full HD, HDR, 3D, 4K without ads".localized() +
                "\n▶ Paramount+ movie collection".localized() +
                "\n▶ HBO's top series: \"The Last of Us\", \"Game of Thrones\", \"Euphoria\", and others".localized() +
                "\n" +
                "\nCHANNELS".localized() +
                "\n▶ Sports Channels".localized() +
                "\n▶ Educational channels: Discovery, History HD, MEGA HD".localized() +
                "\n▶ Movie channels Comedy Central, FILMBOX, [M] COMEDY HD".localized() +
                "\n▶ Premium channels Viasat, Cine+, FOX, Eurosport and others".localized() +
                "\n▶ Premium channels for children: Nickelodeon, Nick Jr., Tiji".localized() +
                "\n" +
                "\nAUDIOBOOKS AND PODCASTS".localized() +
                "\n▶ More than 900 audiobooks in the mobile app".localized()
            ]
        ),
        Subscription(
            subType: .YouTube,
            subPrices: [1.59, 2.69, 3.99],
            additionalInformation: [
                "Student:".localized() +
                    "\n" +
                    "\n▶ Get 1 month free".localized() +
                    "\n▶ Eligible students only".localized() +
                    "\n▶ Annual verification required".localized(),
                    
                    "Individual:".localized() +
                    "\n" +
                    "\n▶ Get 1 month free".localized(),
                    
                    "Family:".localized() +
                    "\n" +
                    "\n▶ Get 1 month free".localized() +
                    "\n▶ Add up to 5 family members (ages 13+) in your household".localized()
            ]
        )
    ]
    
    // MARK: - Outlets
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var subListTableView: UITableView!
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .backgroundColorVC
        subListTableView.backgroundColor = .backgroundColorVC
        
        setupTitle()
        
        setupSearcBar()
        
        setupTableView()
        
        setupBackButton()
        
        reloadDataSubscriptions()
    }
    
    // MARK: - Private Methods
    
    private func reloadDataSubscriptions() {
        
        self.originalSubList = self.subList
        self.filteredSubscriptions = self.subList
    }
    
    private func setupSearcBar() {
        
        searchBar.placeholder = "Search Subscription".localized()
        searchBar.searchTextField.textColor = .tabBarItemAccent
        searchBar.backgroundColor = .clear
        searchBar.backgroundImage = UIImage()
        searchBar.isTranslucent = true
        searchBar.barStyle = .default
    }
    
    private func setupBackButton() {
        
        let backButton = UIBarButtonItem()
        backButton.tintColor = .tabBarItemAccent
        navigationItem.backBarButtonItem = backButton
    }
    
    private func registerTableViewCell() {
        
        let subNib = UINib(nibName: NibNames.subListCell, bundle: Bundle.main)
        subListTableView.register(subNib, forCellReuseIdentifier: NibNames.subListCell)
    }
    
    private func setupTitle() {
        
        title = DefaultValues.subListTitle
    }
    
    private func setupTableView() {
        
        subListTableView.delegate = self
        subListTableView.dataSource = self
        subListTableView.separatorStyle = .none
        
        registerTableViewCell()
    }
    
}

// MARK: UITableViewDataSource

extension SubListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { subList.count }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let index = indexPath.row
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NibNames.subListCell, for: indexPath) as?  SubListTableViewCell else { return UITableViewCell() }
        
        cell.nameOfSubscription.text = subList[index].subType.rawValue
        cell.imageOfSubscription.image = subList[index].subType.image
        
        cell.backgroundColor = .backgroundColorVC.withAlphaComponent(0.0)
        cell.selectionStyle = .none
        
        return cell
    }
    
}

// MARK: UITableViewDelegate

extension SubListViewController: UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int { 1 }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool { true }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let subPlanViewController = SubPlanViewController(nibName: NibNames.subPlanViewController, bundle: nil)
        
        let selectedSubscription = subList[indexPath.row]
        
        let currentPriceIndex = 0
        let additionalInfo = selectedSubscription.additionalInformation[currentPriceIndex]
        subPlanViewController.configureSubPlanInfoFor(subscription: selectedSubscription, additionalInfo: additionalInfo, currentPriceIndex: currentPriceIndex)
        
        navigationController?.pushViewController(subPlanViewController, animated: true)
    }
    
}

// MARK: UISearchBarDelegate

extension SubListViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.isEmpty {
            subList = originalSubList
        } else {
            let filteredSubscriptions = originalSubList.filter { $0.subType.rawValue.lowercased().contains(searchText.lowercased()) }
            subList = filteredSubscriptions
        }
        
        subListTableView.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
        originalSubList = subList
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        subList = originalSubList
        subListTableView.reloadData()
    }
}
