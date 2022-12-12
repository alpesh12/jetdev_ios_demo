//
//  AccountViewController.swift
//  JetDevsHomeWork
//
//  Created by Gary.yao on 2021/10/29.
//

import UIKit
import Kingfisher

class AccountViewController: UIViewController {
    
    @IBOutlet weak var nonLoginView: UIView!
    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var daysLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var headImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
        setUpView()
        
    }
    
    @IBAction func loginButtonTap(_ sender: UIButton) {
        AppDelegate.sharedDelegate().gotoLoginScreen()
    }
    
    func setUpView() {
        
        guard let userData = UserDefaults.standard.value(forKey: "userDetails") as? Data else {
            nonLoginView.isHidden = false
            loginView.isHidden = true
            return
        }
        
        do {
            let userDetail = try JSONDecoder().decode(User.self, from: userData)
            nameLabel.text = userDetail.userName
            if let profileUrl = URL(string: userDetail.userProfileURL) {
                self.headImageView.kf.setImage(with: profileUrl, placeholder: UIImage(named: "Avatar"), options: nil, progressBlock: nil, completionHandler: nil)
            } else {
                self.headImageView.image = UIImage(named: "Avatar")
            }
            let days = dayDifference(start: userDetail.createdAt)
            daysLabel.text = "Created \(days) days ago"
            nonLoginView.isHidden = true
            loginView.isHidden = false
        } catch {
            nonLoginView.isHidden = false
            loginView.isHidden = true
            print(error.localizedDescription)
        }
        
    }
    
    func dayDifference(start: String = "", end: String = "") -> Int {
        let calendar = Calendar.current
        
        // Replace the hour (time) of both dates with 00:00
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let createdAt = dateFormatter.date(from: start) ?? Date()
        let date1 = calendar.startOfDay(for: createdAt)
        var date2 = calendar.startOfDay(for: Date())
        if(end != "") {
            let createdAt = dateFormatter.date(from: end) ?? Date()
            date2 = calendar.startOfDay(for: createdAt)
        }
        let days = calendar.dateComponents([.day], from: date1, to: date2).day
        return (days ?? 0)
    }
}
