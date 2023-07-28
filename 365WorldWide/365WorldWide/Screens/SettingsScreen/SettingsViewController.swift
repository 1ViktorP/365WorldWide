//
//  SettingsViewController.swift
//  YourLucky
//
//  Created by MacBook on 07.07.2023.
//

import UIKit
import MessageUI
import StoreKit

class SettingsViewController: UIViewController {
    
    private var collectionView: UICollectionView!
    private let settingsList = Settings()
    private var coordinator: MainCoordinator!

    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        setUpCollectionView()
    }
    

    private func setUp() {
        self.view.backgroundColor = .mainBGColor
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Menu"
        guard let navigationController = navigationController else { return }
        coordinator = MainCoordinator(navigationController: navigationController)
    }
    
    private func setUpCollectionView() {
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: generateLayout())
        self.view.addSubview(collectionView)
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(SettingsCollectionViewCell.self, forCellWithReuseIdentifier: SettingsCollectionViewCell.reuseIdentifier)
        
        NSLayoutConstraint.activate([
            
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        collectionView.reloadData()
    }
    
    func generateLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout (sectionProvider: { (sectionIndex: Int,
                                                                              layoutEnvironment: NSCollectionLayoutEnvironment)
            -> NSCollectionLayoutSection? in
                return self.generateLayoutSection()
        })
        return layout
    }
    
    private func generateLayoutSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        let fullSizeItem = NSCollectionLayoutItem(layoutSize: itemSize)
        fullSizeItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 7, trailing: 0)
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(83))
        
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [fullSizeItem])
        let section = NSCollectionLayoutSection(group: group)
        return section
    }

    func rateUs() {
        if #available(iOS 14.0, *) {
            guard let scene = view.window?.windowScene else { return }
            SKStoreReviewController.requestReview(in: scene)
        } else {
            SKStoreReviewController.requestReview()
        }
    }
    
    private func feedBack() {
        let composer = MFMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            composer.mailComposeDelegate = self
            composer.setToRecipients(["your.email"])
            composer.setSubject("Your great app: support")
            composer.setMessageBody("Hello, ", isHTML: false)
            present(composer, animated: true, completion: nil)
        } else {
            alertMessageForFeedback()
        }
    }
    
    private func alertMessageForFeedback() {
        let alertAction = UIAlertAction(title: "OK", style: .cancel)
        let message = "Unfortunately this function is not available at the moment. Please try again later and check the activity of your mail in the settings."
        let alertController = UIAlertController(title: "Dear user", message: message, preferredStyle: .actionSheet)
        alertController.addAction(alertAction)
        self.present(alertController, animated: true)
    }
    
    func vibrationSwitchTapped(isOn: Bool) {
        if isOn {
            UserDefaults.standard.set(true, forKey: "vibrations")
            UIDevice.vibrate()
        } else {
            UserDefaults.standard.set(false, forKey: "vibrations")
        }
    }
    
    func notificationSwitchTapped(isOn: Bool) {
        if isOn {
            UserDefaults.standard.set(true, forKey: "notification")
            if let appSettings = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(appSettings) {
                UIApplication.shared.open(appSettings)
            }
        } else {
            UserDefaults.standard.set(false, forKey: "notification")
        }
    }
    
    func reminderSwitchTapped(isOn: Bool) {
        UIDevice.vibrate()
        if isOn {
            NotificationManager.requestNotifications()
            UserDefaults.standard.set(true, forKey: "eventReminder")
        } else {
            NotificationManager.disableNotifications()
            UserDefaults.standard.set(false, forKey: "eventReminder")
        }
    }

}

extension SettingsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
 
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return settingsList.settingsList.count
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SettingsCollectionViewCell.reuseIdentifier, for: indexPath) as! SettingsCollectionViewCell
        cell.disclosureIcon.isHidden = false
        cell.switchButton.isHidden = true
            if indexPath.row < settingsList.settingsList.count {
                cell.titleLabel.text = settingsList.settingsList[indexPath.row]
                cell.descriptionLabel.text = settingsList.settingsDescription[indexPath.row]
                cell.isUserInteractionEnabled = true
                cell.contentView.isUserInteractionEnabled = true
                if indexPath.row == 0 {
                    cell.disclosureIcon.isHidden = true
                    cell.switchButton.isHidden = false
                    if UserDefaults.standard.bool(forKey: "notification") == false {
                        cell.toogleHandler(false)
                    } else {
                        cell.toogleHandler(true)
                    }
                } else if indexPath.row == 1 {
                    cell.disclosureIcon.isHidden = true
                    cell.switchButton.isHidden = false
                    if UserDefaults.standard.bool(forKey: "vibrations") == false {
                        cell.toogleHandler(false)
                    } else {
                        cell.toogleHandler(true)
                    }
                } else if indexPath.row == 2 {
                    if UserDefaults.standard.bool(forKey: "eventReminder") == false {
                        cell.toogleHandler(false)
                    } else {
                        cell.toogleHandler(true)
                    }
                }
            }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            UIDevice.vibrate()
            let cell = collectionView.cellForItem(at: indexPath) as! SettingsCollectionViewCell
            switch indexPath.row {
            case 0:
                var isOn = false
                if UserDefaults.standard.bool(forKey: "notification") == false {
                    isOn = false
                } else {
                    isOn = true
                }
                isOn.toggle()
                cell.toogleHandler(isOn)
                notificationSwitchTapped(isOn: isOn)
            case 1:
                var isOn = false
                if UserDefaults.standard.bool(forKey: "vibrations") == false {
                    isOn = false
                } else {
                    isOn = true
                }
                isOn.toggle()
                cell.toogleHandler(isOn)
                vibrationSwitchTapped(isOn: isOn)
            case 2:
                var isOn = false
                if UserDefaults.standard.bool(forKey: "eventReminder") == false {
                    isOn = false
                } else {
                    isOn = true
                }
                isOn.toggle()
                cell.toogleHandler(isOn)
                reminderSwitchTapped(isOn: isOn)
            case 3: coordinator.openTermsVC(isTerms: true)
            case 4: coordinator.openTermsVC(isTerms: false)
            case 5: rateUs()
            case 6: feedBack()
            case 7: coordinator.openSavedEventsVC()
            default: break
            }
        }
}

extension SettingsViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}


