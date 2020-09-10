//
//  ViewController.swift
//  Assignment15
//
//  Created by Suhaas Choppavarapu on 9/8/20.
//  Copyright © 2020 Suhaas Choppavarapu. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UpdatedInFVCDelegate {
    
    //MARK:- IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK:- Properties
    var images = [["ginger", "turmeric", "cumin", "poppy seed", "black pepper", "garlic"],
                  ["milk", "yogurt", "ghee", "cheese","butter", "cream"],
                  ["cheetos", "nachos", "french fries", "popcorn","pringles", "tostitos"],
                  ["coke", "whiskey", "beer", "vodka", "club soda", "red bull"]]
    var firstnames = [["Anil", "Ayush", "Anish","Abhinay", "Arjun", "Aarya"],
                      ["Bhanu", "Britany","Bannu", "Bharath","Bhivesh", "Bryan"],
                      ["Chaitu", "Chinni","charitha", "Ceaser","Catherine", "Camreo"],
                      ["Dinesh", "Dhruva","Daddy", "Don","Diana", "Drakshayini"]]
    
    var lastnames = [["Anil", "Ayush", "Anish","Abhinay", "Allu", "Aarya"],
                     ["Bhanu", "Britany","Bannu", "Bharath","Bhivesh", "Bryan"],
                     ["Chaitu", "Chinni","charitha", "Ceaser","Catherine", "Camreo"],
                     ["Dinesh", "Dhruva","Daddy", "Don","Diana", "Drakshayini"]]
    
    var phoneNumbers = [["6715439890", "8978654387", "7577747756", "6715439890", "8978654387", "7577747756"],
                        ["9089876757", "9878876540", "9089876757", "9878876540", "9089876757", "9878876540"],
                        ["9897867567", "6175654388", "9089876757", "9878876540", "9089876757", "9878876540"],
                        ["9897867567", "6175654388", "9089876757", "9878876540", "9089876757", "9878876540"]]
    
    var dobs = [["FEB 18 1996", "MAR 1 1998", "AUG 19 1999", "DEC 31 1999", "JUN 16 1999","MAY 17 1996"],
                ["SEP 27 1996", "NOV 9 1996", "OCT 29 1996", "JAN 23 1996", "JUL 1 2000", "APR 22 1999"],
                ["FEB 18 1996", "MAR 1 1998", "AUG 19 1999", "DEC 31 1999", "JUN 16 1999", "MAY 17 1996"],
                ["SEP 27 1996", "NOV 9 1996", "OCT 29 1996", "JAN 23 1996", "JUL 1 2000", "APR 22 1999"]]
    
    var indexValue: Int = 0
    var sectionCount: Int = 0
    
    var finalUpdatedFirstname: String?
    var finalUpdatedLastname: String?
    var finalUpdatedPhoneNumber: String?
    var finalUpdatedDOB: String?
    
    var sortedNames: [[String]] = []
    
    //MARK:- View Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = UIColor.lightGray
        tableView.tableFooterView = UIView()
        
        for row in firstnames {
            sortedNames.append(row.sorted())
            
        }
    }
    
    // MARK:- Segue Methods
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? SecondViewController {
            destination.firstname2 = sortedNames[sectionCount][indexValue]
            destination.lastname2 = lastnames[sectionCount][indexValue]
            destination.dob2 = dobs[sectionCount][indexValue]
            destination.phoneNumber2 = phoneNumbers[sectionCount][indexValue]
            destination.image2 = images[sectionCount][indexValue]
            destination.title = sortedNames[sectionCount][indexValue] + " Info"
            destination.updatedInFVC = self
        }
    }
    
    //MARK:- Helper Methods
    func detailsNeedToBeUpdated(firstname: String, lastname: String, phoneNumber: String, dob: String) {
        finalUpdatedFirstname = firstname
        finalUpdatedLastname = lastname
        finalUpdatedPhoneNumber = phoneNumber
        finalUpdatedDOB = dob
        
        sortedNames[sectionCount].remove(at: indexValue)
        lastnames[sectionCount].remove(at: indexValue)
        phoneNumbers[sectionCount].remove(at: indexValue)
        dobs[sectionCount].remove(at: indexValue)
        
        sortedNames[sectionCount].insert(finalUpdatedFirstname!, at: indexValue)
        lastnames[sectionCount].insert(finalUpdatedLastname!, at: indexValue)
        phoneNumbers[sectionCount].insert(finalUpdatedPhoneNumber!, at: indexValue)
        dobs[sectionCount].insert(finalUpdatedDOB!, at: indexValue)
        tableView.reloadData()
    }
}

//MARK:- UITableViewDataSource and UITableViewDelegate Methods
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return firstnames.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return firstnames[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FirstTableViewCell.identifier) as? FirstTableViewCell else {
            return UITableViewCell()
        }
        cell.firstnameLabel.text = sortedNames[indexPath.section][indexPath.row]
        cell.lastnameLabel.text = lastnames[indexPath.section][indexPath.row]
        cell.dobLabel.text = dobs[indexPath.section][indexPath.row]
        cell.imageView1.image = UIImage(named: images[indexPath.section][indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        sectionCount = indexPath.section
        indexValue = indexPath.row
        performSegue(withIdentifier: "firstSegue", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var headertitle: String?
        if section == 0{
            headertitle = "A"
        }
        if section == 1{
            headertitle = "B"
        }
        if section == 2{
            headertitle = "C"
        }
        if section == 3{
            headertitle = "D"
        }
        return headertitle
    }
}

