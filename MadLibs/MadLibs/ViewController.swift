//
//  ViewController.swift
//  MadLibs
//
//  Created by Jamario Davis on 7/6/20.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var verbTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var numberOfPetsLabel: UILabel!
    @IBOutlet weak var animalSegmentedControl: UISegmentedControl!
    @IBOutlet weak var numberSlider: UISlider!
    @IBOutlet weak var numberOfPetsStepper: UIStepper!
    @IBOutlet weak var happyEndingSwitch: UISwitch!
    @IBOutlet weak var containerView: UIView!
    
    var myMusic: AVAudioPlayer?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        let path = Bundle.main.path(forResource: "space-exploration.wav", ofType:nil)!
            let url = URL(fileURLWithPath: path)
             myMusic?.prepareToPlay()
             myMusic?.numberOfLoops = -1
             myMusic?.play()
            do {
                myMusic = try AVAudioPlayer(contentsOf: url)
                myMusic?.play()
            } catch {
                // Could not play music file
            }
             songLoop()
    }
    @IBAction func lessOrMoreValueDidChanged(_ sender: UISegmentedControl) {
    // If user taps on less -> hide the container view
        if sender.selectedSegmentIndex == 0{
            containerView.isHidden = true
        // If user taps on more -> show the container view
        } else if sender.selectedSegmentIndex == 1{
            containerView.isHidden = false
        }
    }
    @IBAction func sliderDidChanged(_ sender: UISlider) {
        // Update the label on the left of the slider base on the current value
        numberLabel.text = "\(Int(sender.value))"
    }
    @IBAction func stepperDidChange(_ sender: UIStepper) {
        // Update the label on the left of the stepper base on the current value
        numberOfPetsLabel.text = "\(Int(sender.value))"
    }
    @IBAction func createStoryDidTapped(_ sender: UIButton) {
        let animal = animalSegmentedControl.titleForSegment(at: animalSegmentedControl.selectedSegmentIndex)
        let happEnding = happyEndingSwitch.isOn ? "Now they live happily ever after" : "Things didn't turn out too well..."
        let story = "At the age of \(ageTextField.text!), \(firstNameTextField.text!) took a trip to \(locationTextField.text!) with \(Int(numberOfPetsStepper.value)) pet in order to \(verbTextField.text!) with a \(animal!).  \(firstNameTextField.text!) decided to buy \(Int(numberSlider.value)) \(animal!)'s. \(happEnding)."
        print(story)
        
        let alertController = UIAlertController(title: "My Story", message: story, preferredStyle: .alert)
        let action = UIAlertAction(title: "Shake phone to clear text fields", style: .default, handler: nil)
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
    func songLoop() {
        myMusic?.numberOfLoops = -1
    }
    // Shake gesture function
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        firstNameTextField.text! = ""
        locationTextField.text! = ""
        verbTextField.text! = ""
        ageTextField.text! = ""
        numberLabel.text = "0"
        numberOfPetsLabel.text = "0"
        numberOfPetsStepper.value = 0
        numberSlider.value = Float(Int(0))
        animalSegmentedControl.actionForSegment(at: 0)
        containerView.isHidden = true
    }
  }   // End of the class

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
