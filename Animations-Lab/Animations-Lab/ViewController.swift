//
//  ViewController.swift
//  AnimationsPractice
//
//  Created by Benjamin Stone on 10/8/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var animationSpeed = Double() {
        didSet {
            animationStepper.value = animationSpeed
            animationLabel.text = "Animation Time: \(animationStepper.value)"
        }
    }
    
    var movingDistance = CGFloat() {
           didSet {
            distanceStepper.value = Double(movingDistance)
               distanceLabel.text = "Distance: \(distanceStepper.value)"
           }
    }
    
    var animationsOptions: [UIView.AnimationOptions] = [.repeat, .autoreverse, .curveEaseIn, .curveEaseOut, .curveLinear]
    
    var indexOfOptionsArr = Int() {
        didSet {
            optionsPicker.reloadAllComponents()
        }
    }
    
    lazy var blueSquare: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        return view
    }()
    
    lazy var buttonYStackView: UIStackView = {
       let buttonStack = UIStackView()
        buttonStack.axis = .horizontal
        buttonStack.alignment = .center
        buttonStack.distribution = .equalSpacing
        buttonStack.spacing = 30
        return buttonStack
    }()
    
    lazy var buttonXStackView: UIStackView = {
       let buttonStack = UIStackView()
        buttonStack.axis = .horizontal
        buttonStack.alignment = .fill
        buttonStack.distribution = .equalSpacing
        buttonStack.spacing = 30
        buttonStack.addArrangedSubview(leftButton)
        buttonStack.addArrangedSubview(rightButton)
        return buttonStack
    }()
    
    lazy var stepperStackview: UIStackView = {
        let stepperStack = UIStackView()
        stepperStack.axis = .horizontal
        stepperStack.alignment = .center
        stepperStack.distribution = .equalSpacing
        stepperStack.spacing = 30
        stepperStack.addArrangedSubview(animationStepper)
        stepperStack.addArrangedSubview(distanceStepper)
        return stepperStack
    }()
    
    lazy var labelStackview: UIStackView = {
        let labelStack = UIStackView()
        labelStack.axis = .horizontal
        labelStack.alignment = .center
        labelStack.distribution = .equalSpacing
        labelStack.spacing = 30
        labelStack.addArrangedSubview(animationLabel)
        labelStack.addArrangedSubview(distanceLabel)
        return labelStack
    }()
    
    lazy var upButton: UIButton = {
       let button = UIButton()
        button.setTitle("Move square up", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .cyan
        button.addTarget(self, action: #selector(animateSquareUp(sender:)), for: .touchUpInside)
        return button
    }()
    
    lazy var downButton: UIButton = {
       let button = UIButton()
        button.setTitle("Move square down", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .cyan
        button.addTarget(self, action: #selector(animateSquareDown(sender:)), for: .touchUpInside)
        return button
    }()
    
    lazy var leftButton: UIButton = {
       let button = UIButton()
        button.setTitle("Move square left", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .cyan
        button.addTarget(self, action: #selector(animateSquareLeft(sender:)), for: .touchUpInside)
        return button
    }()
    
    lazy var rightButton: UIButton = {
       let button = UIButton()
        button.setTitle("Move square right", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .cyan
        button.addTarget(self, action: #selector(animateSquareRight(sender:)), for: .touchUpInside)
        return button
    }()
    
    lazy var animationStepper: UIStepper = {
        let stepper = UIStepper()
        stepper.minimumValue = 1
        stepper.maximumValue = 5
        stepper.backgroundColor = .cyan
        stepper.addTarget(self, action: #selector(animateSpeed(sender:)), for: .touchUpInside)
        return stepper
    }()
    
     lazy var distanceStepper: UIStepper = {
            let stepper = UIStepper()
            stepper.minimumValue = 100
            stepper.maximumValue = 200
            stepper.stepValue = 10
            stepper.backgroundColor = .cyan
            stepper.addTarget(self, action: #selector(animateSquareDistance(sender:)), for: .touchUpInside)
            return stepper
    }()
    
    lazy var animationLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var distanceLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var optionsPicker: UIPickerView = {
        let picker = UIPickerView()
        picker.delegate = self
        picker.dataSource = self
        return picker
    }()
    
    lazy var blueSquareHeightConstaint: NSLayoutConstraint = {
        blueSquare.heightAnchor.constraint(equalToConstant: 200)
    }()
    
    lazy var blueSquareWidthConstraint: NSLayoutConstraint = {
        blueSquare.widthAnchor.constraint(equalToConstant: 200)
    }()
    
    lazy var blueSquareCenterXConstraint: NSLayoutConstraint = {
        blueSquare.centerXAnchor.constraint(equalTo: view.centerXAnchor)
    }()
    
    lazy var blueSquareCenterYConstraint: NSLayoutConstraint = {
        blueSquare.centerYAnchor.constraint(equalTo: view.centerYAnchor)
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureConstraints()
        animationSpeed = 2
        movingDistance = 150
        indexOfOptionsArr = 1
        optionsPicker.selectRow(indexOfOptionsArr, inComponent: 0, animated: false)
    }
    
    @IBAction func animateSquareUp(sender: UIButton) {
        let oldOffset = blueSquareCenterYConstraint.constant
        blueSquareCenterYConstraint.constant = oldOffset - movingDistance
        UIView.animate(withDuration: animationSpeed, delay: 0, options: [animationsOptions[indexOfOptionsArr]], animations: { [unowned self] in
            self.view.layoutIfNeeded()
        }, completion: { (done) in
            self.blueSquareCenterYConstraint.constant = oldOffset
        })
    }
    
    @IBAction func animateSquareDown(sender: UIButton) {
        let oldOffset = blueSquareCenterYConstraint.constant
        blueSquareCenterYConstraint.constant = oldOffset + movingDistance
        UIView.animate(withDuration: animationSpeed, delay: 0, options: [animationsOptions[indexOfOptionsArr]], animations: { [unowned self] in
            self.view.layoutIfNeeded()
        }, completion: { (done) in
            self.blueSquareCenterYConstraint.constant = oldOffset
        })
    }
    
    @objc func animateSquareLeft(sender: UIButton) {
        let oldOffset = blueSquareCenterXConstraint.constant
        blueSquareCenterXConstraint.constant = oldOffset - movingDistance
        UIView.animate(withDuration: animationSpeed, delay: 0, options: [animationsOptions[indexOfOptionsArr]], animations: { [unowned self] in
            self.view.layoutIfNeeded()
        }, completion: { (done) in
            self.blueSquareCenterXConstraint.constant = oldOffset
        })
    }
    
    @objc func animateSquareRight(sender: UIButton) {
        let oldOffset = blueSquareCenterXConstraint.constant
        blueSquareCenterXConstraint.constant = oldOffset + movingDistance
       UIView.animate(withDuration: animationSpeed, delay: 0, options: [animationsOptions[indexOfOptionsArr]], animations: { [unowned self] in
            self.view.layoutIfNeeded()
        }, completion: { (done) in
            self.blueSquareCenterXConstraint.constant = oldOffset
        })
    }
    
    @objc func animateSpeed(sender: UIStepper) {
        animationSpeed = sender.value
    }
    
    @objc func animateSquareDistance(sender: UIStepper) {
        movingDistance = CGFloat(sender.value)
    }
    
    private func addSubviews() {
        view.addSubview(blueSquare)
        addStackViewSubviews()
        view.addSubview(buttonYStackView)
        view.addSubview(buttonXStackView)
        view.addSubview(stepperStackview)
        view.addSubview(labelStackview)
        view.addSubview(optionsPicker)
    }
    
    private func addStackViewSubviews() {
        buttonYStackView.addSubview(upButton)
        buttonYStackView.addSubview(downButton)
    }
    
    private func configureConstraints() {
        constrainBlueSquare()
        constrainUpButton()
        constrainDownButton()
        constrainStackViews()
        constainPicker()
    }
    
    private func constrainUpButton() {
        upButton.translatesAutoresizingMaskIntoConstraints = false
        upButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    
    private func constrainDownButton() {
        downButton.translatesAutoresizingMaskIntoConstraints = false
        downButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        downButton.trailingAnchor.constraint(equalTo:buttonYStackView.trailingAnchor).isActive = true
    }
    
    
    private func constrainBlueSquare() {
        blueSquare.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            blueSquareHeightConstaint,
            blueSquareWidthConstraint,
            blueSquareCenterXConstraint,
            blueSquareCenterYConstraint
        ])
    }
    
    private func constainPicker() {
        optionsPicker.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            optionsPicker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            optionsPicker.topAnchor.constraint(equalTo: labelStackview.bottomAnchor, constant: 10),
            optionsPicker.heightAnchor.constraint(equalToConstant: 100),
            optionsPicker.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
    }
    
    private func constrainStackViews() {
        buttonYStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonXStackView.translatesAutoresizingMaskIntoConstraints = false
        stepperStackview.translatesAutoresizingMaskIntoConstraints = false
        labelStackview.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            buttonYStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonYStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            buttonYStackView.heightAnchor.constraint(equalToConstant: 50),
            buttonYStackView.widthAnchor.constraint(equalTo: view.widthAnchor),
            
            buttonXStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonXStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -200),
            buttonXStackView.heightAnchor.constraint(equalToConstant: 50),
            buttonXStackView.widthAnchor.constraint(equalTo: view.widthAnchor),
            
            stepperStackview.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stepperStackview.bottomAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            stepperStackview.heightAnchor.constraint(equalToConstant: 50),
            stepperStackview.widthAnchor.constraint(equalTo: view.widthAnchor),
            
            labelStackview.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            labelStackview.topAnchor.constraint(equalTo: stepperStackview.bottomAnchor, constant: 30),
            labelStackview.heightAnchor.constraint(equalToConstant: 20),
            labelStackview.widthAnchor.constraint(equalTo: view.widthAnchor),
        ])
    }
}

extension ViewController : UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return animationsOptions.count
    }
    
    
}

extension ViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        let optionsForPicker = ["Repeat","Auto Reverse","Curve Ease-In","Curve Ease-Out","Curve Linear"]
        
        let currentOption = optionsForPicker[row]
        return currentOption
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        indexOfOptionsArr = row
    }
}

