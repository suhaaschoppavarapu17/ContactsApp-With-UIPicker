//
//  SecondViewController.swift
//  Assignment15
//
//  Created by Suhaas Choppavarapu on 9/8/20.
//  Copyright © 2020 Suhaas Choppavarapu. All rights reserved.
//

import UIKit

protocol UpdatedInFVCDelegate{
    func detailsNeedToBeUpdated(firstname: String, lastname: String, phoneNumber: String, dob: String)
}

class SecondViewController: UIViewController, UpdatedDetailsDelegate {
    
    //MARK:- IBOutlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var firstnameLabel: UILabel!
    @IBOutlet weak var lastnameLabel: UILabel!
    @IBOutlet weak var dobLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var editButton: UIButton!
    
    //MARK:- Properties
    
    var image2: String?
    var firstname2: String?
    var lastname2: String?
    var dob2: String?
    var phoneNumber2 : String?
    
    var updatedFirstname: String?
    var updatedLastname: String?
    var updatedPhoneNumber: String?
    var updatedDOB: String?
    
    var updatedInFVC: UpdatedInFVCDelegate?
    
    //MARK:- View Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        firstnameLabel.text = firstname2
        lastnameLabel.text = lastname2
        phoneNumberLabel.text = phoneNumber2
        dobLabel.text = dob2
        imageView.image = UIImage(named: image2!)
        self.navigationItem.hidesBackButton = true
        let backButton = UIBarButtonItem(title: "Back", style: UIBarButtonItem.Style.done, target: self, action: #selector(goBackToFirstView))
        self.navigationItem.leftBarButtonItem = backButton
    }
    
    //MARK:- Segue Methods
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ThirdViewController {
            if updatedFirstname == nil && updatedLastname == nil && updatedPhoneNumber == nil && updatedDOB == nil {
                destination.firstname3 = firstname2
                destination.lastname3 = lastname2
                destination.phoneNumber3 = phoneNumber2
                destination.dob3 = dob2
                destination.updatedDelegate = self
                destination.title = firstname2! + " Details"
            } else {
                destination.firstname3 = updatedFirstname
                destination.lastname3 = updatedLastname
                destination.phoneNumber3 = updatedPhoneNumber
                destination.dob3 = updatedDOB
                destination.updatedDelegate = self
                destination.title = updatedFirstname! + " Details"
            }
        }
    }
    
    // MARK:- IBActions
    @IBAction func editButtonTapped(_ sender: Any){
        performSegue(withIdentifier: "secondSegue", sender: nil)
    }
    
    //MARK:- Helper Methods
    @objc
    func goBackToFirstView() {
        if updatedFirstname != nil || updatedLastname != nil || updatedPhoneNumber != nil || updatedDOB != nil {
            updatedInFVC?.detailsNeedToBeUpdated(firstname: updatedFirstname!, lastname: updatedLastname!, phoneNumber: updatedPhoneNumber!, dob: updatedDOB!)
        }
        onClose()
    }
    
    func onClose(){
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func detailsDidChange(firstname: String, lastname: String, phoneNumber: String, dob: String) {
        updatedFirstname = firstname
        updatedLastname = lastname
        updatedPhoneNumber = phoneNumber
        updatedDOB = dob
        
        firstnameLabel.text = updatedFirstname
        lastnameLabel.text = updatedLastname
        phoneNumberLabel.text = updatedPhoneNumber
        dobLabel.text = updatedDOB
    }
}

