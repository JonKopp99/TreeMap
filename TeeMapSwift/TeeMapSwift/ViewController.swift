//
//  ViewController.swift
//  TeeMapSwift
//
//  Created by Jonathan Kopp on 10/28/20.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let valueAr = self.getRandomData(length: 10)
        generateSquares(rect: self.view.frame, values: valueAr)
    }
    
    /// Creates a treemap based on values and frame passed in
    func generateSquares(rect: CGRect, values: [Int]) {
        if values.count <= 1 {
            // Create square view and add tap recognizer
            let square = UIView()
            square.frame = rect
            square.backgroundColor = getRandomColor()
            square.tag = values[0]
            square.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.squareTapped(_:))))
            self.view.addSubview(square)
            return
        }
        // Get sum of all values in array
        var sum: CGFloat = 0.0
        values.forEach({sum += CGFloat($0)})
        // Find half the sum of array
        let half: CGFloat = sum / 2.0
        // Find middle index based on half the sum of array
        var midIndex = values.count - 1;
        var midCounter: CGFloat = 0.0;
        var firstTotal: CGFloat = 0.0;
        for (i, value) in values.enumerated() {
            if (midCounter > half) {
                midIndex = i
                break
            }
            midCounter += CGFloat(value)
            // Calculate sum of first half
            firstTotal += CGFloat(value)
        }
        // Split into halves based on middle sum index of original value array
        let firstHalf = Array(values[0..<midIndex])
        let secondHalf = Array(values[midIndex..<(values.count)])
        // Get sum of second array
        let secondTotal: CGFloat = sum - firstTotal
        // Get ratio of square based on sums of both arrays
        var squareRatio: CGFloat = firstTotal / (firstTotal + secondTotal)
        if firstTotal + secondTotal < 0.0 {
            squareRatio = 0.1
        }
        // Calculate size of new frames based on square location
        var firstRect, secondRect: CGRect
        let width = rect.width
        let height = rect.height
        if (height > width) { // Horizontal Square
            let heightRatio: CGFloat = height * squareRatio;
            firstRect = CGRect(x: rect.origin.x, y: rect.origin.y, width: width, height: heightRatio);
            secondRect = CGRect(x: rect.origin.x, y: rect.origin.y + heightRatio, width: width, height: height - heightRatio);
        } else { // Vertical Sqaure
            let widthRatio: CGFloat = width * squareRatio;
            firstRect = CGRect(x: rect.origin.x, y: rect.origin.y, width: widthRatio, height: height);
            secondRect = CGRect(x: rect.origin.x + widthRatio, y: rect.origin.y, width: width - widthRatio, height: height);
        }
        // Recursively call with new values and frames
        generateSquares(rect: firstRect, values: firstHalf)
        generateSquares(rect: secondRect, values: secondHalf)
    }
    
    /// Creates a random integer array from 1-50 based on input length
    func getRandomData(length: Int) -> [Int] {
        var valueArray = [Int]()
        for _ in 0...10 {
            valueArray.append(Int.random(in: 1...50))
        }
        return valueArray
    }
    /// Returns a random color
    func getRandomColor() -> UIColor {
        let red:CGFloat = CGFloat(drand48())
        let green:CGFloat = CGFloat(drand48())
        let blue:CGFloat = CGFloat(drand48())
        return UIColor(red:red, green: green, blue: blue, alpha: 1.0)
    }
    /// Logs the value of square that's been tapped
    @objc func squareTapped(_ sender: UITapGestureRecognizer) {
        print("Value @ Square: ", sender.view?.tag ?? -1)
    }
}

