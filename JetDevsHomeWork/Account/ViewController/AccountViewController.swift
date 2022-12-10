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
        // Do any additional setup after loading the view.
        setUpView()
        
    }
    
    @IBAction func loginButtonTap(_ sender: UIButton) {
        AppDelegate.sharedDelegate().gotoLoginScreen()
    }
    
    func setUpView() {
        if let userData = UserDefaults.standard.value(forKey: "userDetails") as? Data {
            let userDetail = try? JSONDecoder().decode(User.self, from: userData)
            if(userDetail != nil) {
                nameLabel.text = userDetail?.userName
                let profileUrl = userDetail?.userProfileURL
                headImageView.kf.setImage(with: URL(string: profileUrl!)!, placeholder: UIImage(named: "Avatar"), options: nil, progressBlock: nil, completionHandler: nil)
                let days = dayDifference(start: userDetail!.createdAt)
                daysLabel.text = "Created \(days) days ago"
                nonLoginView.isHidden = true
                loginView.isHidden = false
            } else {
                nonLoginView.isHidden = false
                loginView.isHidden = true
            }
        } else {
            nonLoginView.isHidden = false
            loginView.isHidden = true
        }
    }
    
    func dayDifference(start: String = "", end: String = "") -> Int {
        let calendar = Calendar.current
        
        // Replace the hour (time) of both dates with 00:00
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let createdAt = dateFormatter.date(from: start)
        let date1 = calendar.startOfDay(for: createdAt!)
        var date2 = calendar.startOfDay(for: Date())
        if(end != "") {
            let createdAt = dateFormatter.date(from: end)
            date2 = calendar.startOfDay(for: createdAt!)
        }
        let days = calendar.dateComponents([.day], from: date1, to: date2).day
        return days!
    }
}
