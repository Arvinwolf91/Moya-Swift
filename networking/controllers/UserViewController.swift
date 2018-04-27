//
//  UserViewController.swift
//  
//
//  Created by Raditia Madya on 11/04/18.
//

import UIKit
import Moya

class UserViewController: UITableViewController {
	
	var users = [User]()
	let userProvider = MoyaProvider<UserService>()
        
    override func viewDidLoad() {
        super.viewDidLoad()
		self.title = "USERS"
		
		userProvider.request(.readUsers) { (result) in
			
			switch result {
			case .success( let response):
				let json = try! JSONSerialization.jsonObject(with: response.data, options: [])
				print(json)
				
				let users = try! JSONDecoder().decode([User].self, from: response.data)
				self.users = users
				self.tableView.reloadData()
				
			case .failure(let error):
				print(error)
			}
		}
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return users.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
	
			let cell = UITableViewCell()
			let user = users[indexPath.row]
			cell.textLabel?.text = user.name
			return cell
    }
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
		let user = users[indexPath.row]
		print(user)
	}
}


