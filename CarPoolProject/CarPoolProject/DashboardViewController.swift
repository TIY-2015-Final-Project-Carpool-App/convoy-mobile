//
//  FirstViewController.swift
//  CarPoolProject
//
//  Created by Christopher Wainwright Aaron on 7/2/15.
//  Copyright (c) 2015 Christopher Wainwright Aaron. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate {

    @IBOutlet weak var menuView: CVCalendarMenuView!
    @IBOutlet weak var calendarView: CVCalendarView!
    @IBOutlet weak var carpoolTableView: UITableView!

    var shouldShowDaysOut = true
    var animationFinished = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
                
        carpoolTableView.dataSource = self
        carpoolTableView.delegate = self
        
        carpoolTableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        carpoolTableView.backgroundColor = UIColor.clearColor()
        
        RailsRequest.session().getCarpoolIndexWithCompletion { () -> Void in
            
            self.carpoolTableView.reloadData()
        }
        
    }
    
    override func viewWillAppear(animated: Bool) {
            carpoolTableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        calendarView.commitCalendarViewUpdate()
        menuView.commitMenuViewUpdate()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        calendarView.commitCalendarViewUpdate()
        menuView.commitMenuViewUpdate()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("dashCell", forIndexPath: indexPath) as! DashboardTableViewCell
     
        if indexPath.row % 2 == 0 {
            
       //     cell.backgroundColor = UIColor(red:0.44, green:0.65, blue:0.99, alpha:1)
            cell.backgroundColor = UIColor.clearColor()
            cell.layer.borderColor = UIColor(red:0.75, green:0.95, blue:0.47, alpha:1).CGColor
        } else {
            
         //   cell.backgroundColor = UIColor(red:0.75, green:0.95, blue:0.47, alpha:1)
            cell.backgroundColor = UIColor.clearColor()
            cell.layer.borderColor = UIColor(red:0.44, green:0.65, blue:0.99, alpha:1).CGColor
        }
        
        cell.carpoolTitle.text = RailsRequest.session().carpools[indexPath.row]["title"] as? String
        
        cell.bounds.inset(dx: 1, dy: 1)
        cell.layer.cornerRadius = cell.frame.height / 4
        cell.selectionStyle = UITableViewCellSelectionStyle.Blue
        
        let separatorLineView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 568, height: 10))
        separatorLineView.backgroundColor = UIColor.clearColor()
        cell.contentView.backgroundColor = UIColor.clearColor()
        cell.contentView.addSubview(separatorLineView)
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        cell.updateButton.tag = indexPath.row
        cell.detailButton.tag = indexPath.row
        cell.deleteButton.tag = indexPath.row
    
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RailsRequest.session().carpools.count
    }
    
    @IBAction func contactsButton(sender: AnyObject) {
        
        let ccNav = storyboard?.instantiateViewControllerWithIdentifier("carpoolNav") as! UINavigationController
        
        presentViewController(ccNav, animated: true, completion: nil)
    }
    
    func configurationTextField(textField: UITextField!) {
        
        println("Configure alertTextField")
        
        textField.placeholder = "Name"
        
    }
    
    func secondConfigurationTextField(textField: UITextField!) {
        
        textField.placeholder = "description"
    }
    
    func handleCancel(alertView: UIAlertAction!) {
        println("User click Cancel button")
    }
    
    @IBAction func presentCarPoolCreate(sender: AnyObject) {
        
        var alert = UIAlertController(title: "Carpool", message: "Create a title for your carpool", preferredStyle: UIAlertControllerStyle.Alert)

        
        alert.addTextFieldWithConfigurationHandler(configurationTextField)
        alert.addTextFieldWithConfigurationHandler(secondConfigurationTextField)
        
        println(alert.textFields)
        
        alert.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.Cancel, handler:handleCancel))
        
        alert.addAction(UIAlertAction(title: "Enter", style: UIAlertActionStyle.Default, handler: { (action) in
            
            let alertTextField = alert.textFields![0] as! UITextField
            let alertDescriptionTextField = alert.textFields![1] as! UITextField
            RailsRequest.session().title = alertTextField.text
            RailsRequest.session().descript = alertDescriptionTextField.text
            
            RailsRequest.session().createCarpoolWithCompletion({ (carpoolInfo) -> Void in
                println("Carpool has been created")
                
                RailsRequest.session().carpools.append(carpoolInfo)
                
                self.carpoolTableView.reloadData()
            })
        
        }))
        
        self.presentViewController(alert, animated: true, completion: {
            println("completion block")
        })
        
    }
   
    
    @IBAction func updateCarpool(sender: UIButton) {
        
        let title = RailsRequest.session().carpools[sender.tag]["title"] as? String
        let carpool = RailsRequest.session().carpools[sender.tag]
    
        
        var alert = UIAlertController(title: "Carpool", message: "Update for your carpool", preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addTextFieldWithConfigurationHandler(configurationTextField)
        alert.addTextFieldWithConfigurationHandler(secondConfigurationTextField)
        
        let alertNameTextField = alert.textFields![0] as! UITextField
        alertNameTextField.text = title
        
        alert.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.Cancel, handler: handleCancel))
        alert.addAction(UIAlertAction(title: "Enter", style: UIAlertActionStyle.Default, handler: { (action) in
            
            let alertNameTextField = alert.textFields![0] as! UITextField
            RailsRequest.session().title = alertNameTextField.text
            
            let alertDescriptionTextField = alert.textFields![1] as! UITextField
            RailsRequest.session().descript = alertDescriptionTextField.text
            
            RailsRequest.session().updateCarpoolWithCompletion(carpool, completion: { () -> Void in
                
                RailsRequest.session().carpools[sender.tag]["title"] = RailsRequest.session().title
                
              self.carpoolTableView.reloadData()
            })
            
        }))
        
        
        
        self.presentViewController(alert, animated: true, completion: {
            println("completion block")
        })

    }
    
    @IBAction func settingsButton(sender: AnyObject) {
        
        let svc = storyboard?.instantiateViewControllerWithIdentifier("settingsVC") as! SettingsViewController
        presentViewController(svc, animated: true, completion: nil)
    }
    

    @IBAction func deleteCarpool(sender: AnyObject) {
        
        let cellButton = sender as! UIButton
        
        let carpool = RailsRequest.session().carpools[cellButton.tag]
        RailsRequest.session().carpools.removeAtIndex(cellButton.tag)
        carpoolTableView.reloadData()
        
        RailsRequest.session().deleteCarpoolWithCompletion(carpool, completion: { () -> Void in
            println("this has been ran")
        })
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if let cellButton = sender as? UIButton {
            
            if let users = RailsRequest.session().carpools[cellButton.tag]["users"] as? [[String:AnyObject]] {
                
                if let carpoolDetailVC = segue.destinationViewController as? CarpoolDetailViewController {
                    
                    carpoolDetailVC.users = users 
                }
            }
            
        }
        
        if let cellButton = sender as? UIButton {
            
            if let carpoolId = RailsRequest.session().carpools[cellButton.tag]["id"] as? Int {
                
                if let carpoolDetailVC = segue.destinationViewController as? CarpoolDetailViewController {
                   
                    carpoolDetailVC.carpoolId = carpoolId
                }
            }
        }
        
    }



}

extension DashboardViewController: CVCalendarViewDelegate
{
    func preliminaryView(viewOnDayView dayView: DayView) -> UIView
    {
        let circleView = CVAuxiliaryView(dayView: dayView, rect: dayView.bounds, shape: CVShape.Circle)
        circleView.fillColor = .colorFromCode(0xCCCCCC)
        return circleView
    }
    
    func preliminaryView(shouldDisplayOnDayView dayView: DayView) -> Bool
    {
        if (dayView.isCurrentDay) {
            return true
        }
        return false
    }
    
    func supplementaryView(viewOnDayView dayView: DayView) -> UIView
    {
        let π = M_PI
        
        let ringSpacing: CGFloat = 12.0
        let ringInsetWidth: CGFloat = 1.0
        let ringVerticalOffset: CGFloat = -1
        var ringLayer: CAShapeLayer!
        let ringLineWidth: CGFloat = 2.0
        let ringLineColor: UIColor = .blueColor()
        
        var newView = UIView(frame: dayView.bounds)
        
        let diameter: CGFloat = (newView.bounds.width) - ringSpacing
        let radius: CGFloat = diameter / 2.0
        
        let rect = CGRectMake(newView.frame.midX-radius, newView.frame.midY-radius-ringVerticalOffset, diameter, diameter)
        
        ringLayer = CAShapeLayer()
        newView.layer.addSublayer(ringLayer)
        
        ringLayer.fillColor = nil
        ringLayer.lineWidth = ringLineWidth
        ringLayer.strokeColor = ringLineColor.CGColor
        
        var ringLineWidthInset: CGFloat = CGFloat(ringLineWidth/2.0) + ringInsetWidth
        let ringRect: CGRect = CGRectInset(rect, ringLineWidthInset, ringLineWidthInset)
        let centrePoint: CGPoint = CGPointMake(ringRect.midX, ringRect.midY)
        let startAngle: CGFloat = CGFloat(-π/2.0)
        let endAngle: CGFloat = CGFloat(π * 2.0) + startAngle
        let ringPath: UIBezierPath = UIBezierPath(arcCenter: centrePoint, radius: ringRect.width/2.0, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        ringLayer.path = ringPath.CGPath
        ringLayer.frame = newView.layer.bounds
        
        return newView
    }
    
    func supplementaryView(shouldDisplayOnDayView dayView: DayView) -> Bool
    {
//        if (Int(arc4random_uniform(3)) == 1)
//        {
//            return true
//        }
        return false
    }
}


extension DashboardViewController: CVCalendarViewDelegate {
    func presentationMode() -> CalendarMode {
        return .MonthView
    }
    
    func firstWeekday() -> Weekday {
        return .Sunday
    }
    
    func shouldShowWeekdaysOut() -> Bool {
        return shouldShowDaysOut
    }
    
    func didSelectDayView(dayView: CVCalendarDayView) {
        let date = dayView.date
        println("\(calendarView.presentedDate.commonDescription) is selected!")
        
//        if supplementaryView(shouldDisplayOnDayView: DayView) -> true {
//            
//            
//        }
    }
    
    func presentedDateUpdated(date: CVDate) {
        //        if monthLabel.text != date.globalDescription && self.animationFinished {
        //            let updatedMonthLabel = UILabel()
        //            updatedMonthLabel.textColor = monthLabel.textColor
        //            updatedMonthLabel.font = monthLabel.font
        //            updatedMonthLabel.textAlignment = .Center
        //            updatedMonthLabel.text = date.globalDescription
        //            updatedMonthLabel.sizeToFit()
        //            updatedMonthLabel.alpha = 0
        //            updatedMonthLabel.center = self.monthLabel.center
        //
        //            let offset = CGFloat(48)
        //            updatedMonthLabel.transform = CGAffineTransformMakeTranslation(0, offset)
        //            updatedMonthLabel.transform = CGAffineTransformMakeScale(1, 0.1)
        //
        //            UIView.animateWithDuration(0.35, delay: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
        //                self.animationFinished = false
        //                self.monthLabel.transform = CGAffineTransformMakeTranslation(0, -offset)
        //                self.monthLabel.transform = CGAffineTransformMakeScale(1, 0.1)
        //                self.monthLabel.alpha = 0
        //
        //                updatedMonthLabel.alpha = 1
        //                updatedMonthLabel.transform = CGAffineTransformIdentity
        //
        //                }) { _ in
        //
        //                    self.animationFinished = true
        //                    self.monthLabel.frame = updatedMonthLabel.frame
        //                    self.monthLabel.text = updatedMonthLabel.text
        //                    self.monthLabel.transform = CGAffineTransformIdentity
        //                    self.monthLabel.alpha = 1
        //                    updatedMonthLabel.removeFromSuperview()
        //            }
        //
        //            self.view.insertSubview(updatedMonthLabel, aboveSubview: self.monthLabel)
        //        }
    }
    
    func topMarker(shouldDisplayOnDayView dayView: CVCalendarDayView) -> Bool {
        return true
    }
    
    func dotMarker(shouldShowOnDayView dayView: CVCalendarDayView) -> Bool {
        let day = dayView.date.day
        let randomDay = Int(arc4random_uniform(31))
        if day == randomDay {
            return true
        }
        
        return false
    }
    
    func dotMarker(colorOnDayView dayView: CVCalendarDayView) -> [UIColor] {
        let day = dayView.date.day
        
        let red = CGFloat(arc4random_uniform(600) / 255)
        let green = CGFloat(arc4random_uniform(600) / 255)
        let blue = CGFloat(arc4random_uniform(600) / 255)
        
        let color = UIColor(red: red, green: green, blue: blue, alpha: 1)
        
        let numberOfDots = Int(arc4random_uniform(3) + 1)
        switch(numberOfDots) {
        case 2:
            return [color, color]
        case 3:
            return [color, color, color]
        default:
            return [color] // return 1 dot
        }
    }
    
    func dotMarker(shouldMoveOnHighlightingOnDayView dayView: CVCalendarDayView) -> Bool {
        return true
    }
}

// MARK: - CVCalendarViewAppearanceDelegate

extension DashboardViewController: CVCalendarViewAppearanceDelegate {
    func dayLabelPresentWeekdayInitallyBold() -> Bool {
        return false
    }
    
    func spaceBetweenDayViews() -> CGFloat {
        return 2
    }
}

// MARK: - CVCalendarMenuViewDelegate

extension DashboardViewController: CVCalendarMenuViewDelegate {
    // firstWeekday() has been already implemented.
}

// MARK: - IB Actions

extension DashboardViewController {
    @IBAction func switchChanged(sender: UISwitch) {
        if sender.on {
            calendarView.changeDaysOutShowingState(false)
            shouldShowDaysOut = true
        } else {
            calendarView.changeDaysOutShowingState(true)
            shouldShowDaysOut = false
        }
    }
    
    @IBAction func todayMonthView() {
        calendarView.toggleCurrentDayView()
    }
    
    /// Switch to WeekView mode.
    @IBAction func toWeekView(sender: AnyObject) {
        calendarView.changeMode(.WeekView)
    }
    
    /// Switch to MonthView mode.
    @IBAction func toMonthView(sender: AnyObject) {
        calendarView.changeMode(.MonthView)
    }
    
    @IBAction func loadPrevious(sender: AnyObject) {
        calendarView.loadPreviousView()
    }
    
    
    @IBAction func loadNext(sender: AnyObject) {
        calendarView.loadNextView()
    }
}

// MARK: - Convenience API Demo

extension DashboardViewController {
    func toggleMonthViewWithMonthOffset(offset: Int) {
        let calendar = NSCalendar.currentCalendar()
        let calendarManager = calendarView.manager
        let components = Manager.componentsForDate(NSDate()) // from today
        
        components.month += offset
        
        let resultDate = calendar.dateFromComponents(components)!
        
        self.calendarView.toggleViewWithDate(resultDate)
    }
}


