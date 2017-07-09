//
//  ViewController.swift
//  MNISTPrediction
//
//  Created by Philipp Gabriel on 18.06.17.
//  Copyright © 2017 Philipp Gabriel. All rights reserved.
//

import UIKit

extension UIImage {
    
    func resize(to newSize: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(CGSize(width: newSize.width, height: newSize.height), true, 1.0)
        self.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return resizedImage
    }
    
    func buffer() -> CVPixelBuffer? {
        var pixelBuffer: CVPixelBuffer? = nil
        
        let width = Int(self.size.width)
        let height = Int(self.size.height)
        
        CVPixelBufferCreate(kCFAllocatorDefault, width, height, kCVPixelFormatType_OneComponent8, nil, &pixelBuffer)
        CVPixelBufferLockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue:0))
        
        let colorspace = CGColorSpaceCreateDeviceGray()
        let bitmapContext = CGContext(data: CVPixelBufferGetBaseAddress(pixelBuffer!), width: width, height: height, bitsPerComponent: 8, bytesPerRow: CVPixelBufferGetBytesPerRow(pixelBuffer!), space: colorspace, bitmapInfo: 0)!
        
        bitmapContext.draw(self.cgImage!, in: CGRect(x: 0, y: 0, width: width, height: height))
        
        return pixelBuffer
    }
}

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let size = CGSize(width: 28, height: 28)

        guard let result = try? MNIST().prediction(image: #imageLiteral(resourceName: "eight").resize(to: size).buffer()!) else {
            print("failed")
            return
        }
        
        print(result.classLabel)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
