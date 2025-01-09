//
//  ViewController.swift
//  ThirdWeek
//
//  Created by BAE on 1/8/25.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    
    let pickerView = UIPickerView()
    @IBOutlet var userTextField: UITextField!
    @IBOutlet var mapView: MKMapView!
    @IBOutlet var secondTextField: UITextField!
    
    let ssss = UIView()
    
    let list = ["가", "나", "다", "라", "마", "바", "사"]
    let array = ["1", "2", "3", "4", "5", "6", "7"]
    
    var currentList = ""
    var currentArray = ""
        
    override func viewDidLoad() {
        super.viewDidLoad()
        configPicker()
        configTextField()
        configMapView()
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
}

// MARK: 맵뷰 설정
extension ViewController: MKMapViewDelegate {
    func configMapView() {
        let center = CLLocationCoordinate2D(latitude: 37.654658, longitude: 127.050008)
        let annotation = MKPointAnnotation()
        
        mapView.delegate = self
        mapView.isZoomEnabled = true
        mapView.showsCompass = true
        mapView.showsScale = true
        mapView.showsUserLocation = true
        mapView.region = MKCoordinateRegion(center: center, latitudinalMeters: 1000, longitudinalMeters: 1000)
        
        annotation.coordinate = center
        annotation.title = "씨드큐브 창동"
        mapView.addAnnotation(annotation)
    }
    
    func mapView(_ mapView: MKMapView, didSelect annotation: any MKAnnotation) {
        let region = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: annotation.coordinate.latitude, longitudinalMeters: annotation.coordinate.longitude)
        mapView.setRegion(region, animated: true)
    }
}

// MARK: 텍스트필드 설정
extension ViewController: UITextFieldDelegate {
    func configTextField() {
        userTextField.delegate = self
        secondTextField.tintColor = .red
        secondTextField.inputView = pickerView
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        // 만약 일부 뷰에서는 이러한 기능이 필요치 않다면, 아예 delegate를 지정해주지 않으면 됨.
        switch textField {
        case userTextField:
            view.endEditing(true)
            return true
        case secondTextField:
            return true
        default:
            return true
        }
    }
    
}

// MARK: 피커뷰 설정
extension ViewController:UIPickerViewDelegate, UIPickerViewDataSource {
    func configPicker() {
        pickerView.dataSource = self
        pickerView.delegate = self
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return component == 0 ? list.count : array.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        2
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return component == 0 ? list[row] : array[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if component == 0 {
            currentList = list[row]
            
        } else if component == 1 {
            currentArray = array[row]
        }
        
        secondTextField.text = "\(currentList) | \(currentArray)"
        
    }
    
}
