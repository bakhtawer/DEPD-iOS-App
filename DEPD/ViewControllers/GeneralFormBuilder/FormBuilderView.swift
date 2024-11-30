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
    
    private var buttonTitle: String = ""
    
    private var dateTF: UITextField?
    private var dateFrom: UITextField?
    private var dateTo: UITextField?
    
    private var checkBoxValue: Bool = false
    
    // Initialize the FormBuilderView with an array of fields
    init(fields: [FormField], _ buttonTitle: String = "register_submit".localized()) {
        self.formFields = fields
        self.buttonTitle = buttonTitle
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
        stackView.spacing = 8
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
        submitButton.makeItTheme(text: buttonTitle,
                                 .bold, 16, .appLight)
        submitButton.makeHight(height: 40, true)
        
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
        
        let tfHeight: CGFloat = 50
        
        switch field.fieldType {
        case .text:
            let textField = UITextField()
            textField.placeholder = field.placeholder
            textField.borderStyle = .roundedRect
            textField.tag = fieldIndex  // Use the index to tag the field
            textField.text = value
            textField.makeItThemeTF()
            textField.isUserInteractionEnabled = field.isEnabled
            textField.heightAnchor.constraint(equalToConstant: tfHeight).isActive = true
            
            return textField
            
        case .number:
            let numberField = UITextField()
            numberField.placeholder = field.placeholder
            numberField.keyboardType = .numberPad
            numberField.borderStyle = .roundedRect
            numberField.tag = fieldIndex
            numberField.makeItThemeTF()
            numberField.text = value
            numberField.heightAnchor.constraint(equalToConstant: tfHeight).isActive = true
            numberField.isUserInteractionEnabled = field.isEnabled
            return numberField
            
        case .date:
            dateTF = UITextField()
            guard let dateTF = dateTF else { return UITextField() }
            
            dateTF.placeholder = field.placeholder
            dateTF.keyboardType = .numberPad
            dateTF.borderStyle = .roundedRect
            dateTF.tag = fieldIndex
            dateTF.makeItThemeTF()
            dateTF.text = value?.toFormattedDateShow()
            
            let datePicker = UIDatePicker()
            datePicker.datePickerMode = .date
            datePicker.preferredDatePickerStyle = .wheels
            datePicker.tag = fieldIndex
            datePicker.maximumDate = Date()
            if let date = value?.fromFormattedDate(){
                datePicker.date = date
            }
            dateTF.inputView = datePicker
            
            let dropdownIcon = UIImageView(image: UIImage(systemName: "chevron.down"))
            dropdownIcon.contentMode = .scaleAspectFit
            dropdownIcon.tintColor = .textDark
            
            let containerView = UIView(frame: CGRect(x: 0, y: 0, width: dropdownIcon.frame.width + 32, height: dropdownIcon.frame.height))
            dropdownIcon.frame = CGRect(x: 16, y: 0, width: dropdownIcon.frame.width, height: dropdownIcon.frame.height)
            containerView.addSubview(dropdownIcon)
            
            dateTF.rightView = containerView
            dateTF.rightViewMode = .always
            
            // Add a toolbar with a "Done" button to dismiss the picker
            let toolbar = UIToolbar()
            toolbar.sizeToFit()
            let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneDateButtonTapped))
            toolbar.setItems([doneButton], animated: true)
            dateTF.inputAccessoryView = toolbar
            
            dateTF.heightAnchor.constraint(equalToConstant: tfHeight).isActive = true
            return dateTF
        case .email:
            let textField = UITextField()
            textField.placeholder = field.placeholder
            textField.keyboardType = .emailAddress
            textField.borderStyle = .roundedRect
            textField.tag = fieldIndex  // Use the index to tag the field
            textField.text = value
            textField.makeItThemeTF()
            textField.isUserInteractionEnabled = field.isEnabled
            textField.heightAnchor.constraint(equalToConstant: tfHeight).isActive = true
            
            return textField
            
        case .dropdown:
            let textField = UITextField()
            textField.placeholder = field.placeholder
            textField.borderStyle = .roundedRect
            textField.tag = fieldIndex
            textField.makeItThemeTF() // Apply custom theme
            textField.heightAnchor.constraint(equalToConstant: tfHeight).isActive = true
            
            textField.text = value
            
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
            
            textField.rightView = containerView
            textField.rightViewMode = .always

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
            if value != nil, value != "" {
                placeholderTextView.placeholderLabel.isHidden = true
            }else {
                placeholderTextView.placeholderLabel.isHidden = false
            }
            placeholderTextView.textColor = .textDark
            return placeholderTextView
            
        case .checkbox:
            let checkbox = CheckboxView(labelText: field.placeholder)
            checkbox.makeItThemeHeight(height: 100)
            checkBoxValue = value?.makeItBool ?? false
            checkbox.isChecked = value?.makeItBool ?? false
            checkbox.onToggle = {
                self.checkBoxValue.toggle()
            }
            return checkbox
        case .uploadFile:
            let button = DEPDButton()
            button.makeItTheme(text: field.placeholder, .bold, 18, .textLight, .appGreen)
            button.makeHight(height: 50)
            button.makeButtonIconRight(named: "square.and.arrow.up")
            button.addTapGestureRecognizer {
                self.delegate?.getImageFor(name: field.name)
            }
            return button
        case .uploadedFile:
            let view = UploadedFileView(labelText: field.placeholder,
                                        imageURL: field.value ?? "",
                                        image: field.image)
            view.onToggle = {
                self.delegate?.getImageFor(name: field.name)
            }
            return view
        case .recordYourMessage:
            
            let textField = UITextField()
            textField.placeholder = field.placeholder
            textField.borderStyle = .roundedRect
            textField.tag = fieldIndex  // Use the index to tag the field
            textField.text = value
            textField.isEnabled = false
            textField.makeItThemeTF()
            
            textField.heightAnchor.constraint(equalToConstant: tfHeight).isActive = true
            
            let dropdownIcon = UIImageView(image: UIImage(systemName: "microphone.circle.fill"))
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
            
            return textField
        case .gap:
            let gapView = UIView()
            gapView.heightAnchor.constraint(equalToConstant: 20).isActive = true
            return gapView
        case .dateFrom:
            dateFrom = UITextField()
            guard let dateTF = dateFrom else { return UITextField() }
            
            dateTF.placeholder = field.placeholder
            dateTF.keyboardType = .numberPad
            dateTF.borderStyle = .roundedRect
            dateTF.tag = fieldIndex
            dateTF.makeItThemeTF()
            dateTF.text = value?.toFormattedDateShow()
            
            let datePicker = UIDatePicker()
            datePicker.datePickerMode = .date
            datePicker.preferredDatePickerStyle = .wheels
            datePicker.tag = fieldIndex
            datePicker.maximumDate = Date()
            if let date = value?.fromFormattedDate(){
                datePicker.date = date
            }
            dateTF.inputView = datePicker
            
            let dropdownIcon = UIImageView(image: UIImage(systemName: "chevron.down"))
            dropdownIcon.contentMode = .scaleAspectFit
            dropdownIcon.tintColor = .textDark
            
            let containerView = UIView(frame: CGRect(x: 0, y: 0, width: dropdownIcon.frame.width + 32, height: dropdownIcon.frame.height))
            dropdownIcon.frame = CGRect(x: 16, y: 0, width: dropdownIcon.frame.width, height: dropdownIcon.frame.height)
            containerView.addSubview(dropdownIcon)
            
            dateTF.rightView = containerView
            dateTF.rightViewMode = .always
            
            // Add a toolbar with a "Done" button to dismiss the picker
            let toolbar = UIToolbar()
            toolbar.sizeToFit()
            let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneDateButtonTappedFrom))
            toolbar.setItems([doneButton], animated: true)
            dateTF.inputAccessoryView = toolbar
            
            dateTF.heightAnchor.constraint(equalToConstant: tfHeight).isActive = true
            return dateTF
        case .dateTo:
            dateTo = UITextField()
            guard let dateTF = dateTo else { return UITextField() }
            
            dateTF.placeholder = field.placeholder
            dateTF.keyboardType = .numberPad
            dateTF.borderStyle = .roundedRect
            dateTF.tag = fieldIndex
            dateTF.makeItThemeTF()
            dateTF.text = value?.toFormattedDateShow()
            
            let datePicker = UIDatePicker()
            datePicker.datePickerMode = .date
            datePicker.preferredDatePickerStyle = .wheels
            datePicker.tag = fieldIndex
            datePicker.maximumDate = Date()
            if let date = value?.fromFormattedDate(){
                datePicker.date = date
            }
            dateTF.inputView = datePicker
            
            let dropdownIcon = UIImageView(image: UIImage(systemName: "chevron.down"))
            dropdownIcon.contentMode = .scaleAspectFit
            dropdownIcon.tintColor = .textDark
            
            let containerView = UIView(frame: CGRect(x: 0, y: 0, width: dropdownIcon.frame.width + 32, height: dropdownIcon.frame.height))
            dropdownIcon.frame = CGRect(x: 16, y: 0, width: dropdownIcon.frame.width, height: dropdownIcon.frame.height)
            containerView.addSubview(dropdownIcon)
            
            dateTF.rightView = containerView
            dateTF.rightViewMode = .always
            
            // Add a toolbar with a "Done" button to dismiss the picker
            let toolbar = UIToolbar()
            toolbar.sizeToFit()
            let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneDateButtonTappedTo))
            toolbar.setItems([doneButton], animated: true)
            dateTF.inputAccessoryView = toolbar
            
            dateTF.heightAnchor.constraint(equalToConstant: tfHeight).isActive = true
            return dateTF
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
                    SMM.shared.showWarning(title: "", message: "\(field.placeholder) is required.")
                }
                formData[field.name] = inputView.text ?? ""
            } else if let datePicker = stackView.arrangedSubviews[index] as? UIDatePicker {
                formData[field.name] = datePicker.date.toFormattedDate()
                
            } else if let inputView = stackView.arrangedSubviews[index] as? UITextView {
                if field.isRequired && inputView.text?.isEmpty == true {
                    isValid = false
                    SMM.shared.showWarning(title: "", message: "\(field.placeholder) is required.")
                }
                formData[field.name] = inputView.text ?? ""
            } else if let inputView = stackView.arrangedSubviews[index] as? CheckboxView {
                if field.isRequired && inputView.isChecked == false {
                    isValid = false
                    SMM.shared.showWarning(title: "", message: "\(field.placeholder) is required.")
                }
                formData[field.name] = checkBoxValue.makeItString
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
        if case .dropdown(let options) = formField.fieldType, !options.isEmpty {
            let textField = self.viewWithTag(pickerView.tag) as? UITextField
            textField?.text = options[row]
        }
    }
    
    @objc func doneButtonTapped() {
        UIViewController.top().view.endEditing(true)
    }
    
    @objc func doneDateButtonTapped() {
        if let datePicker = self.dateTF?.inputView as? UIDatePicker {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            self.dateTF?.text = dateFormatter.string(from: datePicker.date)
        }
        UIViewController.top().view.endEditing(true)
    }
    @objc func doneDateButtonTappedFrom() {
        if let datePicker = self.dateFrom?.inputView as? UIDatePicker {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy"
            self.dateFrom?.text = dateFormatter.string(from: datePicker.date)
        }
        UIViewController.top().view.endEditing(true)
    }
    @objc func doneDateButtonTappedTo() {
        if let datePicker = self.dateTo?.inputView as? UIDatePicker {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy"
            self.dateTo?.text = dateFormatter.string(from: datePicker.date)
        }
        UIViewController.top().view.endEditing(true)
    }
}

class CheckboxView: UIView {
    
    // MARK: - Properties
    private let checkboxButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "square"), for: .normal)
        button.tintColor = .gray
        return button
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.makeItTheme(.bold, 12, .textDark)
        return label
    }()
    
    var isChecked: Bool = false {
        didSet {
            updateCheckboxAppearance()
        }
    }
    
    // Closure to notify about changes
    var onToggle: (() -> Void)?
    
    // MARK: - Initializers
    init(labelText: String) {
        super.init(frame: .zero)
        label.text = labelText
        setupViews()
        setupConstraints()
        
        // Add tap gesture to toggle checkbox
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapCheckbox))
        addGestureRecognizer(tapGesture)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
        setupConstraints()
        
        // Add tap gesture to toggle checkbox
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapCheckbox))
        addGestureRecognizer(tapGesture)
    }
    
    // MARK: - Setup Methods
    private func setupViews() {
        addSubview(checkboxButton)
        addSubview(label)
        
        checkboxButton.addTarget(self, action: #selector(didTapCheckbox), for: .touchUpInside)
    }
    
    private func setupConstraints() {
        checkboxButton.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            checkboxButton.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            checkboxButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            checkboxButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            checkboxButton.widthAnchor.constraint(equalToConstant: 24),
            checkboxButton.heightAnchor.constraint(equalToConstant: 24),
            
            label.leadingAnchor.constraint(equalTo: checkboxButton.trailingAnchor, constant: 8),
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor),
            label.topAnchor.constraint(equalTo: topAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    // MARK: - Checkbox Toggle
    @objc private func didTapCheckbox() {
        isChecked.toggle()
        onToggle?() // Notify about the toggle action
    }
    
    private func updateCheckboxAppearance() {
        let imageName = isChecked ? "checkmark.square.fill" : "square"
        checkboxButton.setImage(UIImage(systemName: imageName), for: .normal)
        checkboxButton.tintColor = isChecked ? .systemBlue : .gray
    }
}

class UploadedFileView: UIView {

    // MARK: - Properties
    private let editButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "pencil.line"), for: .normal)
        button.tintColor = .textDark
        return button
    }()

    private let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.makeItTheme(.bold, 16, .appBlue)
        return label
    }()

    private let lineView: UIView = {
        let line = UIView()
        line.backgroundColor = .appBlue
        return line
    }()

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    // Closure to notify about changes
    var onToggle: (() -> Void)?

    // MARK: - Initializers
    init(labelText: String, imageURL: String, image: UIImage?) {
        super.init(frame: .zero)
        label.text = labelText
        setupViews()
        setupConstraints()
        
        if let image = image {
            imageView.image = image
        }else {
            // Load image from URL (using Kingfisher, URLSession, etc.)
            guard let imageURL = URL(string: imageURL) else { return }
            imageView.kf.setImage(with: imageURL)
        }
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
        setupConstraints()
    }

    // MARK: - Setup Methods
    private func setupViews() {
        addSubview(editButton)
        addSubview(label)
        addSubview(lineView)
        addSubview(imageView)
        
        editButton.addTarget(self, action: #selector(didTapEditButton), for: .touchUpInside)
    }

    private func setupConstraints() {
        editButton.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        lineView.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            // Edit button constraints
            editButton.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            editButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            editButton.widthAnchor.constraint(equalToConstant: 24),
            editButton.heightAnchor.constraint(equalToConstant: 24),

            // Label constraints
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            label.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            label.trailingAnchor.constraint(equalTo: editButton.leadingAnchor, constant: -8),

            // Line view constraints
            lineView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 12),
            lineView.leadingAnchor.constraint(equalTo: leadingAnchor),
            lineView.trailingAnchor.constraint(equalTo: trailingAnchor),
            lineView.heightAnchor.constraint(equalToConstant: 2),

            // Image view constraints
            imageView.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: 8),
            imageView.leadingAnchor.constraint(equalTo: lineView.leadingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 150),
            imageView.widthAnchor.constraint(equalToConstant: 150),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }

    // MARK: - Checkbox Toggle
    @objc private func didTapEditButton() {
        onToggle?()
    }
}
