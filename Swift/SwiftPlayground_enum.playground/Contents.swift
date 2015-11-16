//: Playground - noun: a place where people can play

import UIKit

enum China: Int {
    case Guangzhou = 0
    case Beijing
    
    var description: String {
        switch self {
            case Guangzhou:
                return "广州"
            case Beijing:
                return "北京"
        }
    }
}

class City {
    var name = China.Guangzhou
}

let guangzhou = City()

print(guangzhou.name.description)
print(China.Guangzhou.description)