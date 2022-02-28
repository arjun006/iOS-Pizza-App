//
//  PizzaViewController.swift
//  Assignment2_PizzaApp
//
//  Created by arjun devakumar on 2021-10-24.
//

import UIKit

class PizzaViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate{
    
    
    //Pizza Types
    let pizzaTypes = ["The Original", "Vegeterian Fiesta Pizza", "Spicy Pulled Pork Pizza"]
    let pizzaDescriptions = ["Pepperoni, cheese, green onions. Served with extra tomato sauce and three types of cheese.", "Roasted red peppers, caramelized onions, sundried organic tomatoes, feta, and spinach, on a thin crust with pesto sauce.","Slow-roasted pulled pork with a special spicy and smoky BBQ pizza sauce."]
    @IBOutlet weak var PizzaTypePicker: UIPickerView!
    @IBOutlet weak var PizzaSizeControl: UISegmentedControl!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var quantityStepper: UIStepper!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var pizzaQuantity: UILabel!
    @IBOutlet weak var placeOrder: UIButton!
    @IBOutlet weak var receiptLabel: UILabel!
    @IBOutlet weak var startOver: UIButton!
    var pizzaType = "The Original"
    var pizzaSize = "Medium"
    var pizzaCost = 17.50
    var subtotal = 0.0
    var tax = 0.0
    var total:Double = 0.0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.PizzaTypePicker.dataSource = self
        self.PizzaTypePicker.delegate = self
        PizzaTypePicker.selectRow(0, inComponent: 0, animated: true)
        descriptionLabel.text = pizzaDescriptions[0]
        self.PizzaSizeControl.selectedSegmentIndex = 1
        self.quantityStepper.value = 1
        self.pizzaQuantity.text = "1"
        // Do any additional setup after loading the view.
       
    }
    
    //Assign Picker view columns and number of items
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pizzaTypes.count
    }
    //Populate pizza types in Picker view
    func pickerView(_ pickerView: UIPickerView, titleForRow row:Int, forComponent component: Int) -> String? {
        return pizzaTypes[row]
    }
    //Update description for selected pizza type
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedIndex = self.PizzaTypePicker.selectedRow(inComponent: 0)
        self.pizzaType = pizzaTypes[selectedIndex]
        descriptionLabel.text = pizzaDescriptions[selectedIndex]
        descriptionLabel.sizeToFit()
        descriptionLabel.preferredMaxLayoutWidth = 700
        descriptionLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
    }
    
    //Pizza size change control
    @IBAction func segmentChanged(_ sender: Any) {
        print(PizzaSizeControl.selectedSegmentIndex)
        let psize = PizzaSizeControl.selectedSegmentIndex
        if(psize == 0){
            self.pizzaSize = "Small"
            self.pizzaCost = 15.50
        } else if(psize == 1){
            self.pizzaSize = "Medium"
            self.pizzaCost = 17.50
        } else if(psize == 2) {
            self.pizzaSize = "Large"
            self.pizzaCost = 21.50
        }
    }
    
    //Update pizza quantity
    @IBAction func stepperChange(_ sender: Any) {
        pizzaQuantity.text =  "\(Int(quantityStepper.value))"
    }
    //Place order Action Sheet
    @IBAction func orderPlaced(_ sender: Any) {
        let box = UIAlertController(title: "Almost Done!", message: "Are you sure you are ready to place this order", preferredStyle: .actionSheet)
        
        box.addAction(UIAlertAction(title: "OK", style: .default, handler: {
            action in
            self.subtotal = self.pizzaCost * self.quantityStepper.value
            self.tax = self.subtotal * 0.13
            self.total = self.subtotal + self.tax
            self.receiptLabel.text = "Pizza Type: \(self.pizzaType)\nSize:  \(self.pizzaSize)\nQuantity: \(Int(self.quantityStepper.value))\nSubtotal: \(String(format: "%.2f", self.subtotal))\nTax: \(String(format:"%.2f", self.tax))\nFinal Total: \(String(format:"%.2f",self.total))"
//            self.receiptLabel.text = ""
            self.receiptLabel.sizeToFit()
            self.receiptLabel.preferredMaxLayoutWidth = 700
            self.receiptLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
            
        }))
        box.addAction(UIAlertAction(title: "CANCEL", style: .destructive, handler: nil))
        
        self.present(box, animated: true)
    }
    
    @IBAction func startOver(_ sender: Any) {
        receiptLabel.text = ""
        self.viewDidLoad()
    }
    
}

