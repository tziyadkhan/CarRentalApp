//
//  AccountPageController.swift
//  CarRentalApp
//
//  Created by Ziyadkhan on 22.10.23.
//

import UIKit
import Lottie
class AccountPageController: UIViewController {

    @IBOutlet weak var myAnimation: LottieAnimationView!
    override func viewDidLoad() {
        super.viewDidLoad()
        myAnimation.play()
        myAnimation.loopMode = .autoReverse
    }
 
}
