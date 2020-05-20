//
//  ViewController.swift
//  Booking Management


import UIKit
import FSCalendar

class ViewController: UIViewController {
    
    //MARK: UI objects used...
    
    @IBOutlet weak var bookingTypePicker: UIPickerView!
    
    @IBOutlet weak var checkInBtn: UIButton!
    @IBOutlet weak var checkInviewLine: UIView!
    
    @IBOutlet weak var checkOutBtn: UIButton!
    @IBOutlet weak var checkOutviewLine: UIView!
    
    @IBOutlet weak var mainCalView: UIView!
    @IBOutlet weak var calView: FSCalendar!
    
    @IBOutlet weak var selectedDateLbl: UILabel!
    @IBOutlet weak var bookNowBtn: UIButton!
    
    //MARK: variables used...
    var selectedType: String?
    var typeList = ["Hotel","Flight","Package"]
    var calModel = CalModel()
    
    //storing booked date
    var flightBooking = NSMutableArray()
    var hotelBokking = NSMutableArray()
    var packageBooking = NSMutableArray()
    
    //for calender manage
    fileprivate let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    fileprivate let gregorian = Calendar(identifier: .gregorian)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSelectTypePickerCal()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        mainCalView.isHidden = true
    }
    
    func setupSelectTypePickerCal()
    {
        //for picker
        bookingTypePicker.delegate = self
        bookingTypePicker.dataSource = self
        
        //for calender
        calView.delegate = self
        calView.dataSource = self
    }
    
    @IBAction func OnBookNowbuttonClicked(_ sender: Any) {
        if calModel.bookType == 0 {
            
        }
        else if calModel.bookType == 1 {
            
        }
        else if calModel.bookType == 2 {
            
        }
    }
    
    @IBAction func OnCheckInClicked(_ sender: Any) {
        checkInStutas(bool: false, alpha: 1)
        checkOutStutas(bool: true, alpha: 0.5)
    }
    
    @IBAction func OnCheckOutClicked(_ sender: Any) {
        
        checkOutStutas(bool: false, alpha: 1)
        checkInStutas(bool: true, alpha: 0.5)
    }
    
    
    func checkOutStutas(bool : Bool,alpha: CGFloat)
    {
        checkOutviewLine.isHidden = bool
        checkOutBtn.backgroundColor = UIColor(red: 175.0/255.0, green: 156.0/255.0, blue: 255.0/255.0, alpha: alpha)
    }
    
    func checkInStutas(bool : Bool,alpha: CGFloat)
    {
        checkInviewLine.isHidden = bool
        checkInBtn.backgroundColor = UIColor(red: 175.0/255.0, green: 156.0/255.0, blue: 255.0/255.0, alpha: alpha)
        
    }
    func manageCalView()
    {
        mainCalView.isHidden = false
        checkOutviewLine.isHidden = true
        checkOutBtn.backgroundColor = UIColor(red: 175.0/255.0, green: 156.0/255.0, blue: 255.0/255.0, alpha: 0.5)
        if calModel.bookType == 1 {
            checkInBtn.setTitle("Departure", for: .normal)
            checkOutBtn.setTitle("Return", for: .normal)
        }
        else
        {
            checkInBtn.setTitle("CheckIn", for: .normal)
            checkOutBtn.setTitle("CheckOut", for: .normal)
        }
    }
    
}
extension ViewController: UIPickerViewDelegate,UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return typeList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return typeList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedType = typeList[row]
        calModel.bookType = row
        manageCalView()
        print("did select",typeList[row])
    }
}

extension ViewController : FSCalendarDelegate , FSCalendarDataSource{
    // MARK:- FSCalendarDelegate
   
    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        if date .compare(Date()) == .orderedAscending {
            return false
        }
        else {
            return true
        }
    }
    
    func calendar(_ calendar: FSCalendar, shouldDeselect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        return monthPosition == .current
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print("did select date \(self.formatter.string(from: date))")
    }
    
    func calendar(_ calendar: FSCalendar, didDeselect date: Date) {
        print("did deselect date \(self.formatter.string(from: date))")
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, eventDefaultColorsFor date: Date) -> [UIColor]? {
        if self.gregorian.isDateInToday(date) {
            return [UIColor.orange]
        }
        return [appearance.eventDefaultColor]
    }
}
