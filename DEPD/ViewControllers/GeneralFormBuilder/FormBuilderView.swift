//
//  FormBuilderView.swift
//  DEPD
//
//  Created by Shahzaib I. Bhatti on 28/09/2024.
//

import UIKit

class FormBuilderView: UIView {
    
    weak var delegate: FormBuilderProtocol?
    
    private var formFields: [FormField] = []
    private var formData: [String: Any] = [:]  // To store the collected form data
    private let stackView = UIStackView()      // To layout fields vertically
    
    // Initialize the FormBuilderView with an array of fields
    init(fields: [FormField]) {
        self.formFields = fields
        super.init(frame: .zero)
        setupForm()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpViews() {
        for field in formFields {
            let inputView = createInputField(for: field)
            stackView.addArrangedSubview(inputView)
        }
    }
    
    // Setup form with fields
    private func setupForm() {
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        
        // Constraints for stack view
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor)
        ])
        
        // Populate fields dynamically
        for field in formFields {
            let inputView = createInputField(for: field)
            stackView.addArrangedSubview(inputView)
        }
        
        // Add Submit Button
        let submitButton = DEPDButton(frame: CGRect(x: 0, y: 0, width: self.viewWidth * 0.8, height: 100))
        submitButton.makeItTheme(text: "register_submit".localized(),
                                 .bold, 16, .appLight)
        
        submitButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        submitButton.addTapGestureRecognizer {[weak self] in
            self?.handleSubmit()
        }
        stackView.addArrangedSubview(submitButton)
    }
    
    private func createInputField(for field: FormField) -> UIView {
        // Find the index of the current field
        let fieldIndex = formFields.firstIndex(of: field) ?? 0
        
        var value = field.value
        if value == "Contact is not available"
            || value == "N/A"
            || value == "Email is not available" {
            value = nil
        }
        
        switch field.fieldType {
        case .text:
            let textField = UITextField()
            textField.placeholder = field.placeholder
            textField.borderStyle = .roundedRect
            textField.tag = fieldIndex  // Use the index to tag the field
            textField.text = value
            textField.makeItThemeTF()
            
            textField.heightAnchor.constraint(equalToConstant: 50).isActive = true
            
            return textField
            
        case .number:
            let numberField = UITextField()
            numberField.placeholder = field.placeholder
            numberField.keyboardType = .numberPad
            numberField.borderStyle = .roundedRect
            numberField.tag = fieldIndex
            numberField.makeItThemeTF()
            numberField.text = value
            numberField.heightAnchor.constraint(equalToConstant: 50).isActive = true
            return numberField
            
        case .date:
            let datePicker = UIDatePicker()
            datePicker.datePickerMode = .date
            datePicker.preferredDatePickerStyle = .compact
            datePicker.tag = fieldIndex
            return datePicker
        case .email:
            let textField = UITextField()
            textField.placeholder = field.placeholder
            textField.keyboardType = .emailAddress
            textField.borderStyle = .roundedRect
            textField.tag = fieldIndex  // Use the index to tag the field
            textField.text = value
            textField.makeItThemeTF()
            
            textField.heightAnchor.constraint(equalToConstant: 50).isActive = true
            
            return textField
            
        case .dropdown:
            let textField = UITextField()
            textField.placeholder = field.placeholder
            textField.borderStyle = .roundedRect
            textField.tag = fieldIndex
            textField.makeItThemeTF() // Apply custom theme
            textField.heightAnchor.constraint(equalToConstant: 50).isActive = true
            
            // Create the picker
            let pickerView = UIPickerView()
            pickerView.delegate = self
            pickerView.dataSource = self
            pickerView.tag = fieldIndex
            
            // Set the picker as the input view for the textField
            textField.inputView = pickerView
            
            let dropdownIcon = UIImageView(image: UIImage(systemName: "chevron.down"))
            dropdownIcon.contentMode = .scaleAspectFit
            dropdownIcon.tintColor = .textDark
            
            let containerView = UIView(frame: CGRect(x: 0, y: 0, width: dropdownIcon.frame.width + 32, height: dropdownIcon.frame.height))
            dropdownIcon.frame = CGRect(x: 16, y: 0, width: dropdownIcon.frame.width, height: dropdownIcon.frame.height)
            containerView.addSubview(dropdownIcon)
            
            if UserDefaults.selectedLanguage ==  "ur" || UserDefaults.selectedLanguage ==  "sd" {
                textField.leftView = containerView
                textField.leftViewMode = .always
            } else {
                textField.rightView = containerView
                textField.rightViewMode = .always
            }

            // Add a toolbar with a "Done" button to dismiss the picker
            let toolbar = UIToolbar()
            toolbar.sizeToFit()
            let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
            toolbar.setItems([doneButton], animated: true)
            textField.inputAccessoryView = toolbar
            
            return textField
        case .textLong:
            let placeholderTextView = PlaceholderTextView()
            placeholderTextView.placeholderLabel.text = field.placeholder
            placeholderTextView.tag = fieldIndex
            placeholderTextView.backgroundColor = .appLight
            placeholderTextView.heightAnchor.constraint(equalToConstant: 150).isActive = true
            placeholderTextView.text = value
            return placeholderTextView
        }
    }
    
    // Validate and collect form data
    @objc private func handleSubmit() {
        formData.removeAll()  // Clear previous data
        var isValid = true
        
        for (index, field) in formFields.enumerated() {
            if let inputView = stackView.arrangedSubviews[index] as? UITextField {
                if field.isRequired && inputView.text?.isEmpty == true {
                    isValid = false
                    SMM.shared.showWarning(title: "", message: "\(field.name) is required.")
                }
                formData[field.name] = inputView.text ?? ""
            } else if let datePicker = stackView.arrangedSubviews[index] as? UIDatePicker {
                formData[field.name] = datePicker.date
                
            } else if let inputView = stackView.arrangedSubviews[index] as? UITextView {
                if field.isRequired && inputView.text?.isEmpty == true {
                    isValid = false
                    SMM.shared.showWarning(title: "", message: "\(field.name) is required.")
                }
                formData[field.name] = inputView.text ?? ""
            }
        }
        
        if isValid {
            print("Form data: \(formData)")
            delegate?.submitForm(data: formData)
        } else {
            SMM.shared.showWarning(title: "", message: "Validation failed.")
            print()
        }
    }
}

extension FormBuilderView: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1 // Single component for a simple dropdown
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        let formField = formFields[pickerView.tag]
        if case .dropdown(let options) = formField.fieldType {
            return options.count
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let formField = formFields[pickerView.tag]
        if case .dropdown(let options) = formField.fieldType {
            return options[row]
        }
        return nil
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let formField = formFields[pickerView.tag]
        if case .dropdown(let options) = formField.fieldType {
            let textField = self.viewWithTag(pickerView.tag) as? UITextField
            textField?.text = options[row]
        }
    }
    
    @objc func doneButtonTapped() {
        UIViewController.top().view.endEditing(true)
    }
}

