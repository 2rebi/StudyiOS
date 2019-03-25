//
//  ViewController.swift
//  ColorPicker
//
//  Created by Valkyrie on 22/03/2019.
//  Copyright © 2019 Valkyrie. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private struct ColorComponent {
        typealias SliderTag = Int
        typealias Component = Int
        
        static let count = 4
        
        static let red = 0
        static let green = 1
        static let blue = 2
        static let alpha = 3
        
        static func tag(`for`: Component) -> Int {
            return `for` + 100
        }
        
        static func component(from: SliderTag) -> Component {
            return from - 100
        }
    }
    
    private struct ViewTag {
        static let sliderRed = 100
        static let sliderGreen = 101
        static let sliderBlue = 102
        static let sliderAlpha = 103
    }
    
    private let rgbStep: Float = 255.0
    private let numberOfRGBStep = 256
    private let numberOfAlphaStep = 11
    
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var pickerView: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 0..<self.pickerView.numberOfComponents {
            let numberOfRows: Int = self.pickerView.numberOfRows(inComponent: i)
            self.pickerView.selectRow(numberOfRows - 1, inComponent: i, animated: false)
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func sliderValueChange(_ sender: UISlider) {
        guard (ViewTag.sliderRed...ViewTag.sliderAlpha).contains(sender.tag) else {
            print("wrong slider tag")
            return
        }
        
        let component: Int = ColorComponent.component(from: sender.tag)
        let row: Int
        
        if component == ColorComponent.alpha {
            row = Int(sender.value * 10)
        } else {
            row = Int(sender.value)
        }
        
        self.pickerView.selectRow(row, inComponent: component, animated: false)
        
        self.matchViewColorWithCurrentValue()
    }
    
    
    private func matchViewColorWithCurrentValue() {
        guard let redSlider = self.view.viewWithTag(ViewTag.sliderRed) as? UISlider,
            let greentSlider = self.view.viewWithTag(ViewTag.sliderGreen) as? UISlider,
            let blueSlider = self.view.viewWithTag(ViewTag.sliderBlue) as? UISlider,
            let alphaSlider = self.view.viewWithTag(ViewTag.sliderAlpha) as? UISlider
            else {
                return
        }
        
        self.colorView.backgroundColor = UIColor(red: CGFloat(redSlider.value / rgbStep), green: CGFloat(greentSlider.value / rgbStep), blue: CGFloat(blueSlider.value / rgbStep), alpha: CGFloat(alphaSlider.value))
    }
    
}


extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return ColorComponent.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == ColorComponent.alpha {
            return self.numberOfAlphaStep
        } else {
            return self.numberOfRGBStep
        }
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == ColorComponent.alpha {
            return String(format: "%1.1lf", Double(row) * 0.1)
        } else {
            return "\(row)"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let sliderTag: Int = ColorComponent.tag(for: component)
        
        guard let slider = self.view.viewWithTag(sliderTag) as? UISlider else {
            return
        }
        
        if component == ColorComponent.alpha {
            slider.setValue(Float(row) / 10.0, animated: false)
        } else {
            slider.setValue(Float(row), animated: false)
        }
        
        self.matchViewColorWithCurrentValue()
    }
    
}
