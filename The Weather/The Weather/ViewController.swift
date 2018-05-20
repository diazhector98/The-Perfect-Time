//
//  ViewController.swift
//  The Weather
//
//  Created by Hector Diaz on 7/15/16.
//  Copyright © 2016 Hector Diaz. All rights reserved.
//

import UIKit
import Canvas
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}


class ViewController: UIViewController {
    @IBOutlet var currentSummaryImage: UIImageView!
    @IBOutlet var nextSummaryImage: UIImageView!
    @IBOutlet var nextNextSummaryImage: UIImageView!

    @IBOutlet var messageView: CSAnimationView!
    @IBOutlet var message: UILabel!
    
    @IBOutlet var background: UIImageView!
    
    @IBOutlet var degreeMeasure: UIButton!
    
    

    @IBAction func changeMeasure(_ sender: AnyObject) {
        
        
        if currentMax.text != ""{
        
        if degreeMeasure.currentTitle == "Cº" {
        
            currentMax.text = String(changeToFahr(currentMax.text!)) + "º"
            currentMin.text = String(changeToFahr(currentMin.text!)) + "º"
            
            nextMax.text = String(changeToFahr(nextMax.text!)) + "º"
            nextMin.text = String(changeToFahr(nextMin.text!)) + "º"
            
            nextNextMax.text = String(changeToFahr(nextNextMax.text!)) + "º"
            nextNextMin.text = String(changeToFahr(nextNextMin.text!)) + "º"
            

           // minTemp.text = 

            minTemp.text = String(changeToFahr(minTemp.text!)) + "º"
            maxTemp.text = String(changeToFahr(maxTemp.text!)) + "º"
            
            degreeMeasure.setTitle("Fº", for: UIControlState())

        
        } else {
        
            currentMax.text = String(changeToCelsius(currentMax.text!)) + "º"
            currentMin.text = String(changeToCelsius(currentMin.text!)) + "º"
            
            nextMax.text = String(changeToCelsius(nextMax.text!)) + "º"
            nextMin.text = String(changeToCelsius(nextMin.text!)) + "º"
            
            nextNextMax.text = String(changeToCelsius(nextNextMax.text!)) + "º"
            nextNextMin.text = String(changeToCelsius(nextNextMin.text!)) + "º"
            
  
            /*
            minTemp.text = minTemp.text?.substringToIndex((minTemp.text?.endIndex.predecessor().predecessor())!)
            minTemp.text?.removeAtIndex((minTemp.text?.startIndex)!)

 */
            minTemp.text = String(changeToCelsius(minTemp.text!)) + "º"
            maxTemp.text = String(changeToCelsius(maxTemp.text!)) + "º"

            
            
            degreeMeasure.setTitle("Cº", for: UIControlState())

        
        
        }
        
        }
        
    }
    
    
    
    var times:[String:String] = ["AM":"Morning" , "PM":"Afternoon", "Night":"Night"]
    
    /*
 
     rain shwrs
     clear
     some clouds
     heavy rain
     light rain
     cloudy
     risk tstorm
 
 
 */
    var summaries:[String:String] = ["rain shwrs":"Rain", "clear":"Sun", "some clouds":"Partly Cloudy Day", "heavy rain":"Torrential Rain", "light rain":"Light Rain", "cloudy":"Cloud", "risk tstorm": "Storm"]
    
    
    @IBOutlet var maxTemp: UILabel!
    @IBOutlet var minTemp: UILabel!
    
    @IBOutlet var currentTime: UILabel!
    @IBOutlet var currentMax: UILabel!
    @IBOutlet var currentMin: UILabel!
    
    @IBOutlet var nextTime: UILabel!
    @IBOutlet var nextMax: UILabel!
    @IBOutlet var nextMin: UILabel!
    
    @IBOutlet var nextNextTime: UILabel!
    @IBOutlet var nextNextMax: UILabel!
    @IBOutlet var nextNextMin: UILabel!
    
    
    let perfectTimeQuotes = ["share a cup of tea", "watch Netflix", "catch some Pokemon", "drink a cup of coffee","take a 5 min break", "share your ideas", "use a funny hat", "tell a joke", "learn a new word", "try to dance salsa", "do a Harry Potter marathon", "call in sick", "check if you have superpowers", "change your hairstyle", "look at some old pictures", "plant a tree", "recycle your bottles", "cook something new", "do(or try to do) something from Pinterest", "learn a magic trick", "take a nap", "prank call someone", "donate some money to charity"]
    
    @IBOutlet var textField: UITextField!
    
    
    @IBAction func searchCity(_ sender: AnyObject) {
        
        let quoteNumber = Int(arc4random_uniform(UInt32(perfectTimeQuotes.count)))
        
        
        result.center = CGPoint(x: self.result.center.x - 600, y: self.result.center.y)

        var wasSuccesful = false;
        //Aqui se consigue la página del clima
        let attemptedurl = URL(string: "http://www.weather-forecast.com/locations/" + textField.text!.replacingOccurrences(of: " ", with: "-") + "/forecasts/latest")
        //si consigue la página que proceda
        if let url = attemptedurl {
            
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            
            //si consigue obtener los datos del url
            
            if let urlContent = data{
                
                
                let webContent = NSString(data: urlContent, encoding: String.Encoding.utf8.rawValue)
               

                let webArray = webContent?.components(separatedBy: "3 Day Weather Forecast Summary:</b><span class=\"read-more-small\"><span class=\"read-more-content\"> <span class=\"phrase\">")
                
                //let todayArray = webContent?.componentsSeparatedByString("Max.&nbsp;Temp<span class=\"not_in_print\"><br /></span>(<span class=\"tempu\">C</span>)</div></th><td class=\"num_cell dark temp-color1\"><span class=\"temp\">")
                
               
                
                
                if webArray?.count > 1 /*&& todayArray?.count > 1 */{
                    
                    let summaryArray = webArray![1].components(separatedBy: "</tr><tr><th><div class=\"h-words\">Summary</div></th><td align=\"center\" class=\"med wphrase\"><div><b>")
                    
                    let timeZone = webArray![1].components(separatedBy: "</tr><tr valign=\"top\"><td class=\"date-header period\" style=\"background-color: #999999;\"><div class=\"pname\">")
                    
                    
                    let currentSummary = summaryArray[1].components(separatedBy: "</b>")
                    
                    //Resumen de hoy
                    
                    let nextSummary = currentSummary[1].components(separatedBy: "<b>")
                    //Resumen siguiente
                    
                    let nextNextSummary = currentSummary[2].components(separatedBy: "<b>")
                    //Resumen del siguiente siguient
                    
                    /*Done currentTime[0] da lo que es ahora*/
                    let currentTime = timeZone[1].components(separatedBy: "</div>")
                    
                    let nextTime = currentTime[1].components(separatedBy: "</div></td><td class=\"date-header period\" style=\"background-color: #999999;\"><div class=\"pname\">")
                    let nextTimeArray = nextTime[0].components(separatedBy: "\"pname\">")
                    
                    let nextNextArray = currentTime[2].components(separatedBy: "<div class=\"pname\">")
                    
                    //Get the first three "timezones"

                    
                    let weatherArray = webArray![1].components(separatedBy: "</span>")
                    
                    
                    
                    let todayArray2 = webArray![1].components(separatedBy: "Max.&nbsp;Temp")
                    let todayArray3 = webArray![1].components(separatedBy: "Min.&nbsp;Temp")
                    

                    
                    let todayMax = todayArray2[1].components(separatedBy: "<span class=\"temp\">")
                    let maxTempArr = todayMax[1].components(separatedBy: "</span>")
                    let tonightMax = maxTempArr[1].components(separatedBy: "<span class=\"temp\">")
                    let nextMax = todayMax[2].components(separatedBy: "</span>")
                    let nextNextMax = todayMax[3].components(separatedBy: "</span>")

                    
                    let todayMin = todayArray3[1].components(separatedBy: "<span class=\"temp\">")
                    let minTempArr = todayMin[1].components(separatedBy: "</span>")
                    let nextMin = todayMin[2].components(separatedBy: "</span")
                    let nextNextMin = todayMin[3].components(separatedBy: "</span")


                    
                    if weatherArray.count > 1 /*&& todayArray2.count > 1*/ {
                        
                        //MARK: Today Forecast
                        
                        //let todayMax = todayArray2[0]
                        //print(todayMax)
                        
                        wasSuccesful = true;
                        
                    
                        
                        //MARK: Sacar el 3 day forecast
                        
                        let weatherSummary = weatherArray[0].replacingOccurrences(of: "&deg;", with: "º")
                        

                        let summary = weatherSummary.components(separatedBy: "(")
                        let summaryArray = summary[0].components(separatedBy: ".")
                        
                        //Get the max temperature for three days
                    
                        let maxArray = weatherSummary.components(separatedBy: "max")
                        let maxTempArray = maxArray[1].components(separatedBy: "on")
                        
                        
                        //Get the min temperature for three days
                        let minArray = weatherSummary.components(separatedBy: "min")
                        let minTempArray = minArray[1].components(separatedBy: "on")
                        
                        
                        //Get the summary for three days
                        var summaryLabelText = " "
                        if summaryArray.count == 1{
                        
                            summaryLabelText = summaryLabelText + summaryArray[0]
                        
                        } else {
                        
                            summaryLabelText = summaryLabelText + summaryArray[0]
                            summaryLabelText = summaryLabelText +  "\n" + summaryArray[1]

                        
                        }
                        
                        
                        DispatchQueue.main.async(execute: {

                            self.degreeMeasure.setTitle("Cº", for: UIControlState())
                            
                            self.currentSummaryImage.image = UIImage(named: "\(self.summaries[currentSummary[0]]!).png")
                            self.nextSummaryImage.image = UIImage(named: "\(self.summaries[nextSummary[1]]!).png")
                            self.nextNextSummaryImage.image = UIImage(named: "\(self.summaries[nextNextSummary[1]]!).png")


                            
                            self.message.text = "The perfect time to \n" + self.perfectTimeQuotes[quoteNumber]
                            self.currentTime.text = self.times[currentTime[0]]!

                            self.background.image = UIImage(named: "\(self.times[currentTime[0]]!).jpg")
                            
                            self.currentMax.text = "\(maxTempArr[0])º"
                            self.currentMin.text = "\(minTempArr[0])º"
                            
                            self.nextTime.text = self.times[nextTimeArray[1]]!

                            self.nextMax.text = "\(nextMax[0])º"
                            self.nextMin.text = "\(nextMin[0])º"
                            
                            self.nextNextTime.text = self.times[nextNextArray[1]]!


                            self.nextNextMax.text = "\(nextNextMax[0])º"
                            self.nextNextMin.text = "\(nextNextMin[0])º"
                            
                            self.result.text = summaryLabelText
                            
                            
                            self.minTemp.text = maxTempArray[0]
                            
                            self.minTemp.text = self.minTemp.text?.substring(to: (<#T##Collection corresponding to your index##Collection#>.index(before: self.minTemp.text?.characters.index(before: self.minTemp.text?.endIndex)))!)
                            self.minTemp.text?.remove(at: (self.minTemp.text?.startIndex)!)
                            
                            self.maxTemp.text = minTempArray[0]
                            
                            self.maxTemp.text = self.maxTemp.text?.substring(to: (<#T##Collection corresponding to your index##Collection#>.index(before: self.maxTemp.text?.characters.index(before: self.maxTemp.text?.endIndex)))!)
                            self.maxTemp.text?.remove(at: (self.maxTemp.text?.startIndex)!)
                           
                            
                        })
                        
                        
                    
                    
                    }
                    
                    
                    
                    
                    
                    
                    
                    
                }
            }
            
            if wasSuccesful == false {
            
                self.result.text = "Couldn't find that city's weather"
            
            }
        }) 
        
            
        task.resume()
        } else{
        
            self.result.text = "Couldn't find that city's weather"

        
        }
        
        UIView.animate(withDuration: 1.5, animations: {
            self.result.center = CGPoint(x: self.result.center.x + 600, y: self.result.center.y)
            
        })
        
        messageView.startCanvasAnimation()
        
    }
    
    @IBOutlet var result: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let url = URL(string: "https://freegeoip.net/json/")!
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            
            
            if let urlContent = data{
                
                do{
                    
                    let jsonData = try JSONSerialization.jsonObject(with: urlContent, options: JSONSerialization.ReadingOptions.mutableContainers)
                    
                    
                    if let jsonDataDict = jsonData as? [AnyHashable: Any]{
                    
                    
                        DispatchQueue.main.async(execute: {
                            // code her
                            self.textField.text = String(describing: jsonDataDict["city"]!)
                        })
                    
                    }
                    
                   /*
 
 */
                    
                } catch {
                    
                    print("JSON Serialization Failed")
                    
                    
                }
                
                
            }
            
            
            
        }) 
        
        task.resume()
        
        
        
    }

    
    
    //MARK: Change from Fº TO Cº and viceversa
    
    
    func changeToFahr(_ celsiusValue: String) -> Float{
    
        var valuetoChange = celsiusValue.replacingOccurrences(of: "º", with: "\0")
        valuetoChange.remove(at: valuetoChange.characters.index(before: valuetoChange.endIndex))
        
        let newValue = Float(valuetoChange)! * (9/5) + 32
        return newValue
    
    
    
    }
    
    func changeToCelsius(_ fahrValue: String) -> Float{
        
        var valuetoChange = fahrValue.replacingOccurrences(of: "º", with: "\0")
        valuetoChange.remove(at: valuetoChange.characters.index(before: valuetoChange.endIndex))
        
        let newValue = (Float(valuetoChange)! - 32) * (5/9)
        
        return newValue
        
        
        
    }
    

    
    //MARK: Shake to clear
    override func motionBegan(_ motion: UIEventSubtype, with event: UIEvent?) {
        
        if event?.subtype == UIEventSubtype.motionShake {
        
            DispatchQueue.main.async(execute: {
                

                
                self.message.text = "The perfect time to ..."
                self.currentTime.text = ""
                
                self.currentMax.text = ""
                self.currentMin.text = ""
                
                self.nextTime.text = ""
                
                self.nextMax.text = ""
                self.nextMin.text = ""
                
                self.nextNextTime.text = ""
                
                
                self.nextNextMax.text = ""
                self.nextNextMin.text = ""
                
                self.result.text = ""
                self.minTemp.text = ""
                self.maxTemp.text = ""
                
                
                
            })
        
        
        
        }
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Controlling the keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField!) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
        
    }
    
    


}

