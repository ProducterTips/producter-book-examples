//: Playground - noun: a place where people can play

import UIKit

protocol SleepDelegate {
    func canISleep() -> Bool
}

class Human: SleepDelegate {
    func canISleep() -> Bool {
        return false
    }
}

class Cat {
    var delegate: SleepDelegate?
    
    func wantsToSleep() {
        if let master = delegate {
            if master.canISleep() {
                print("Go To Sleep")
            } else {
                print("No")
            }
        }
    }
}


let myCat = Cat()
myCat.delegate = Human()

myCat.wantsToSleep()