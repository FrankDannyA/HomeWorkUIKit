//
//  ViewController.swift
//  HomeWokUIKit
//
//  Created by Даниил Франк on 20.01.2022.
//

import UIKit

class ColorViewController: UIViewController {

    //MARK: - Prorerties
    var colorDelegate: SetColorDelegate?
    private var redColorView: CGFloat = 30.0
    private var greenColorView: CGFloat = 50.0
    private var blueColorView: CGFloat = 70.0
    private var backgroudnColor: UIColor {
        return UIColor(red: redColorView / 255 , green: greenColorView / 255, blue: blueColorView / 255, alpha: 1.0)
    }
   
    //MARK: - Outlets
    @IBOutlet weak var viewOutlet: UIView!
    
    @IBOutlet weak var redLabel: UILabel!
    @IBOutlet weak var greenLabel: UILabel!
    @IBOutlet weak var blueLabel: UILabel!
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    @IBOutlet weak var redTextField: UITextField!
    @IBOutlet weak var greenTextField: UITextField!
    @IBOutlet weak var blueTextField: UITextField!
    
    //MARK: - Live cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewOutlet.layer.cornerRadius = 10
        
        setupSliders()
        setupLabels()
        setupTF()
        
        showDoneButtonTo(redTextField)
        showDoneButtonTo(greenTextField)
        showDoneButtonTo(blueTextField)
    }
    
    override func viewDidLayoutSubviews() { viewOutlet.backgroundColor = backgroudnColor }
    
    //MARK: - IBActions
    //изменения цветов слайдерами
    @IBAction func redSliderAction() {
        let redColorCodeToString = String(Float(redColorView).rounded())
        redColorView = CGFloat(redSlider.value)
        redLabel.text = redColorCodeToString
        redTextField.text = redColorCodeToString
        //palitraViewOutllet.reloadInputViews()
    }

    @IBAction func greenSliderAction() {
        let greenColorCodeToString = String(Float(greenColorView).rounded())
        greenColorView = CGFloat(greenSlider.value)
        greenLabel.text = greenColorCodeToString
        greenTextField.text = greenColorCodeToString
    }

    @IBAction func blueSliderAction() {
        let blueColorCodeToString = String(Float(blueColorView).rounded())
        blueColorView = CGFloat(blueSlider.value)
        blueLabel.text = blueColorCodeToString
        blueTextField.text = blueColorCodeToString
    }
    
    @IBAction func pressDone() {
        setColor()
        //dismiss(animated: true)
    }
    
    func setColor(){
        colorDelegate?.setColor(color: backgroudnColor)
    }
    
    //MARK: - Private funcs
    
    private func setupLabels(){
        redLabel.text = String(Float(redColorView).rounded())
        greenLabel.text = String(Float(greenColorView).rounded())
        blueLabel.text = String(Float(blueColorView).rounded())
    }
    
    private func setupSliders(){
        redSlider.value = Float(redColorView)
        greenSlider.value = Float(greenColorView)
        blueSlider.value = Float(blueColorView)
    }
    
    private func setupTF(){
        redTextField.placeholder = String(Float(redColorView).rounded())
        greenTextField.placeholder = String(Float(greenColorView).rounded())
        blueTextField.placeholder = String(Float(blueColorView).rounded())
    }
}

extension ColorViewController {
    //show Done button
    private func showDoneButtonTo(_ textField: UITextField){
        let keyboardToolbar = UIToolbar()
        textField.inputAccessoryView = keyboardToolbar
        keyboardToolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done",
                                         style: .done,
                                         target: self,
                                         action: #selector(didTapDone))
        
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                            target: nil,
                                            action: nil)
        
        keyboardToolbar.items = [flexBarButton, doneButton]
    }
    
    @objc private func didTapDone(){
        view.endEditing(true)
    }
}

extension ColorViewController: UITextFieldDelegate {
    
    //hide keyboard when done press
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
        
        if let currentValue = Float(text){
            switch textField.tag {
            case 0:
                redColorView = CGFloat(currentValue)
            case 1:
                greenColorView = CGFloat(currentValue)
            case 2:
                blueColorView = CGFloat(currentValue)
            default:
                break
            }
        }
    }
    
    //hide keyboard when press on view
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
}
