//
//  ViewController.swift
//  MNISTPrediction
//
//  Created by Philipp Gabriel on 18.06.17.
//  Copyright © 2017 Philipp Gabriel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let size = CGSize(width: 28, height: 28)

        guard let image = #imageLiteral(resourceName: "eight").resize(to: size)?.pixelBuffer() else {
            fatalError()
        }

        guard let result = try? MNIST().prediction(image: image) else {
            fatalError()
        }

        print(result.classLabel)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
