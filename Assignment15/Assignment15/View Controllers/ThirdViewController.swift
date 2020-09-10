//
//  ThirdViewController.swift
//  Assignment15
//
//  Created by Suhaas Choppavarapu on 9/8/20.
//  Copyright © 2020 Suhaas Choppavarapu. All rights reserved.
//

import UIKit

protocol UpdatedDetailsDelegate {
    func detailsDidChange(firstname: String, lastname: String, phoneNumber: String, dob: String)
}

class ThirdViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    //MARK:- IBOutlets
    @IBOutlet weak var firstnameTextField: UITextField!
    @IBOutlet weak var lastnameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var dobTextField: UITextField!
    
    @IBOutlet weak var submitButton: UIButton!
    
    enum Months: String, CaseIterable {
        case jan, feb, mar, apr, may, jun, jul, aug, sep, oct, nov, dec
    }
    let datesRange = 1 ... 31
    
    var months: [String] = []
    var dates: [String] = []
    var year = ["2020","2019","2018","2017","2016","2015","2014","2013","2012","2011","2010","2009","2008","2007","2006","2005","2004","2003","2002","2001","2000","1999","1998","1997","1996"]
    var textFieldResult = ""
    var textFieldDate = ""
    var textFieldYear = ""
    
    var month = ""
    var date = ""
    var yearSelected = ""
    
    //MARK:- Properties
    
    var updatedDelegate: UpdatedDetailsDelegate?
    
    var firstname3: String?
    var lastname3: String?
    var phoneNumber3: String?
    var dob3: String?
    
    var editedFirstname: String?
    var editedLastname: String?
    var editedPhoneNumber: String?
    var editedDOB: String?
    
    //MARK:- View Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstnameTextField.text = firstname3
        lastnameTextField.text = lastname3
        phoneNumberTextField.text = phoneNumber3
        dobTextField.text = dob3
        
        dobTextField.delegate = self
        
        setup()
        
        months = Months.allCases.map{ $0.rawValue.uppercased() }
        dates = datesRange.map({ String($0) })
    }
    
    // MARK:- IBActions
    @IBAction func submitButtonTapped(_ sender: Any) {
        editedFirstname = firstnameTextField.text
        editedLastname = lastnameTextField.text
        editedPhoneNumber = phoneNumberTextField.text
        editedDOB = dobTextField.text
        updatedDelegate?.detailsDidChange(firstname: editedFirstname!, lastname: editedLastname!, phoneNumber: editedPhoneNumber!, dob: editedDOB!)
        
        let alertController = UIAlertController(title: "Succesfull",
                                                message: "Changes have been saved",
                                                preferredStyle: UIAlertController.Style.alert)
        let alertAction = UIAlertAction(title: "Ok",
                                        style: UIAlertAction.Style.cancel, handler: nil)
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
    
    //MARK:- Helper Methods
    func setup(){
        let picker: UIPickerView
        picker = UIPickerView(frame: CGRect(x: 0, y: 0, width:view.frame.width, height: 300))
        picker.backgroundColor = .white
        
        picker.delegate = self
        picker.dataSource = self
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.black
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(self.donePicker))
        
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.donePicker))
        
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        toolBar.backgroundColor = .black
        
        dobTextField.inputView = picker
        dobTextField.inputAccessoryView = toolBar
    }
    
    @objc func donePicker() {
        view.endEditing(true)
    }
    
    func updateDates(month: String) {
        var yearleap: Int = Int(yearSelected)!
        switch month {
        case "JAN", "MAR", "MAY", "JUL", "AUG", "OCT", "DEC":
            let datesRange = 1 ... 31
            addRangeToDates(range: datesRange)
            return
        case "FEB":
            if yearleap % 4 == 0 {
                let datesRange = 1 ... 29
                addRangeToDates(range: datesRange)
            } else {
                let datesRange = 1 ... 28
                addRangeToDates(range: datesRange)
            }
            return
        default:
            let datesRange = 1 ... 30
            addRangeToDates(range: datesRange)
            return
        }
    }
    
    func addRangeToDates(range: ClosedRange<Int>) {
        dates = range.map({String($0)})
    }
    
    //MARK:- PickerView DataSource Methods
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return months.count
        case 1:
            return dates.count
        default:
            return year.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return months[row]
        case 1:
            return dates[row]
        default:
            return year[row]
        }
    }
    
    //MARK:- PickerView Delegate Methods
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            updateDates(month: months[row])
            pickerView.reloadAllComponents()
        }
        switch component {
        case 0:
            month = months[row]
            textFieldResult = month
        case 1:
            date = dates[row]
            textFieldDate =  date
        default:
            yearSelected = year[row]
            textFieldYear =  yearSelected
        }
        dobTextField.text = textFieldResult + " " + textFieldDate + " " + textFieldYear
    }
}
