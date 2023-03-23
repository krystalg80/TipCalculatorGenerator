//
//  ViewController.swift
//  TipCalculatorStarter
//
//  Created by Chase Wang on 9/19/17.
//  Copyright © 2017 Make School. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Properties
    
    // 1 (at the top of the file inside the class, outside of other functions)
        var isDefaultStatusBar = true

        // 2 (inside the class outside of the other functions)
        override var preferredStatusBarStyle: UIStatusBarStyle {
            return isDefaultStatusBar ? .default : .lightContent
        }
    
    
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var themeSwitch: UISwitch!
    
    @IBOutlet weak var inputCardView: UIView!
    @IBOutlet weak var billAmountTextField: BillAmountTextField!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var tipPercentSegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var outputCardView: UIView!
    @IBOutlet weak var tipAmountTitleLabel: UILabel!
    @IBOutlet weak var tipAmountLabel: UILabel!
    @IBOutlet weak var totalAmountTitleLabel: UILabel!
    @IBOutlet weak var totalAmountLabel: UILabel!
    
    
    
    
    
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setTheme(isDark: false)
        
        billAmountTextField.calculateButtonAction = {
            self.calculate()
        }
    }
        // functions
            func calculate() {
                // dismiss keyboard if it's displayed
                if self.billAmountTextField.isFirstResponder {
                    self.billAmountTextField.resignFirstResponder()
                    
                    // 1
                    guard let billAmountText = self.billAmountTextField.text,
                            let billAmount = Double(billAmountText) else {
                                clear()
                                return
                    }
                    
                    let roundedBillAmount = (100 * billAmount).rounded() / 100
                    
                    // 2
                    let tipPercent: Double
                        switch tipPercentSegmentedControl.selectedSegmentIndex {
                        case 0:
                            tipPercent = 0.15
                        case 1:
                            tipPercent = 0.18
                        case 2:
                            tipPercent = 0.20
                        default:
                            preconditionFailure("Unexpected index.")
                        }
                    
                    
                    let tipAmount = roundedBillAmount * tipPercent
                    let roundedTipAmount = (100 * tipAmount).rounded() / 100
                    
                    // 3
                    let totalAmount = roundedBillAmount + roundedTipAmount
                    
                    // Update UI
                    self.billAmountTextField.text = String(format: "%.2f", roundedBillAmount)
                    self.tipAmountLabel.text = String(format: "%.2f", roundedTipAmount)
                    self.totalAmountLabel.text = String(format: "%.2f", totalAmount)
                    
                    
                }
                
            }
            
            func clear() {
        billAmountTextField.text = nil
        tipPercentSegmentedControl.selectedSegmentIndex = 0
        tipAmountLabel.text = "$0.00"
        totalAmountLabel.text = "$0.00"
    }
    
            func setupViews() {
                    headerView.layer.shadowOffset = CGSize(width: 0, height: 1)
                    headerView.layer.shadowOpacity = 0.10
                    headerView.layer.shadowColor = UIColor.black.cgColor
                    headerView.layer.shadowRadius = 35
                    
                // set card view corners
                    inputCardView.layer.cornerRadius = 8
                    inputCardView.layer.masksToBounds = true
                    
                    outputCardView.layer.cornerRadius = 8
                    outputCardView.layer.masksToBounds = true
                    
                    resetButton.layer.cornerRadius = 8
                    resetButton.layer.masksToBounds = true
                // set card borders
                    outputCardView.layer.borderWidth = 1
                    outputCardView.layer.borderColor = UIColor.tcHotPink.cgColor

                
    }
            func setTheme(isDark: Bool) {
                let theme = isDark ? ColorTheme.dark : ColorTheme.light

                    view.backgroundColor = theme.viewControllerBackgroundColor

                    headerView.backgroundColor = theme.primaryColor
                    titleLabel.textColor = theme.primaryTextColor

                    inputCardView.backgroundColor = theme.secondaryColor

                    billAmountTextField.tintColor = theme.accentColor
                    tipPercentSegmentedControl.tintColor = theme.accentColor

                    outputCardView.backgroundColor = theme.primaryColor
                    outputCardView.layer.borderColor = theme.accentColor.cgColor

                    tipAmountTitleLabel.textColor = theme.primaryTextColor
                    totalAmountTitleLabel.textColor = theme.primaryTextColor

                    tipAmountLabel.textColor = theme.outputTextColor
                    totalAmountLabel.textColor = theme.outputTextColor

                    resetButton.backgroundColor = theme.secondaryColor
                
                isDefaultStatusBar = theme.isDefaultStatusBar
                setNeedsStatusBarAppearanceUpdate()
    }
    
            // MARK: - IBActions
            
            @IBAction func themeToggled(_ sender: UISwitch) {
                if sender.isOn {
                    setTheme(isDark: sender.isOn)
                        } else {
                            // 👉 Toggle off
                            setTheme(isDark: false)
                }
            }
            
           @IBAction func tipPercentChanged(_ sender: UISegmentedControl) {
                calculate()
            }
            
          @IBAction func resetButtonTapped(_ sender: Any) {
                clear()
            }
            
            
        }
    

