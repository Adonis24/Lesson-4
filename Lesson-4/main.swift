//
//  main.swift
//  Lesson-4
//
//  Created by Чернецова Юлия on 30/11/2018.
//  Copyright © 2018 Чернецов Роман. All rights reserved.
//

import Foundation

//Перечисления
//1. Двигатель (включен/выключен)
enum EngineState: String {
    case on = "двигатель включен"
    case off = "двигатель выключен"
}

//2.  Окна автомобилей
enum WindowState: String{
    case open = "окна открыты"
    case close = "окна закрыты"
}


//3. Изменение грузоподъемности для фуры в зависимости от давления в подушках
enum TrunkMode:String{
    case light = "Грузоподъемность до 2.5"
    case midle = "Грузоподъемность от 2.5 до 10 тонн"
    case hard = "Грузоподъемность свыше 10 тонн"
}

enum SportMode:String{
    case turnOn = "Спорт режим включен"
    case turnOff = "Спорт режим выключен"
}





//************************----------****************************
// автомобиль
class Car {
    //Свойства
    let yearOfManufacture: Int
    let maxTrunkVolume: Double
    var mark: String
    var engineState: EngineState
    var windowState: WindowState {
        willSet{ if newValue == .open{
            print("Окна сейчас откроются!")
        } else{
            print("Окна сейчас закроются!")
            }
        }
    }
  
    static var carCount = 0

    //метод открытия окон
    func changeCarState(){
        if self.windowState == .open{
            print("Запрещено открывать окна!!!")
        }
    }
    //Инициализация
    //#1

    init(yearOfManufacture: Int, maxTrunkVolume: Double, mark: String,engineState: EngineState,windowState: WindowState){
   
    self.yearOfManufacture = yearOfManufacture
    self.maxTrunkVolume = maxTrunkVolume
    self.mark = mark
    self.engineState = engineState
    self.windowState = windowState
  
    Car.carCount+=1
    }
}

//Класс грузовой автомобиль - наследник клсса Car
class trunkCar: Car {
    let  heightWork:Int // высота кузова
    var  trunMode: TrunkMode
    var  carrying:Double //Текущий вес груза
    {
        didSet {
            print("Загрузили \(carrying) кг.")
        }
    }//реальная номинальная грузоподъемность
    
    override func changeCarState(){
        if carrying>=0.0 && carrying<=2500.0 {
            trunMode = TrunkMode.light}
        else if carrying>2500.0 && carrying<=10000.0 {
            trunMode = TrunkMode.midle
        }
        else if carrying>10000.0 {
            trunMode = TrunkMode.hard
        }
        print("\(trunMode.rawValue)")
    }
    
    func printTrunk() {
        print("""
            Марка: \(mark),
            высота кузова: \(heightWork),
            режим грузоподъемности:\(trunMode.rawValue),
            текущий вес груза: \(carrying),
            год выпуска: \(yearOfManufacture),
            максимальная грузоподъемность: \(maxTrunkVolume),
            состояние двигателя: \(engineState.rawValue),
            состояние окон: \(windowState.rawValue)
            """)
    }
 
    
    init(yearOfManufacture: Int, maxTrunkVolume: Double, mark: String, engineState: EngineState, windowState: WindowState,heightWork:Int,trunMode:TrunkMode,carrying:Double){
        self.heightWork = heightWork
        self.trunMode = trunMode
        self.carrying = carrying
        super.init(yearOfManufacture: yearOfManufacture, maxTrunkVolume: maxTrunkVolume, mark: mark, engineState: engineState, windowState: windowState)
    }
    
}

//Класс легковой автомобиль - наследник класса Car
class sportCar: Car{
    let  countHorsePower: Int
    var  sportMode: SportMode
    
    override func changeCarState() {
       
        if sportMode == .turnOn
        { sportMode = .turnOff } else {sportMode = .turnOn}
        print("\(sportMode.rawValue)")
        
    }
    
    func printSport() {
        print("""
            Марка: \(mark),
            лошадиных сил: \(countHorsePower),
            спорт режим :\(sportMode.rawValue),
            год выпуска: \(yearOfManufacture),
            максимальная грузоподъемность: \(maxTrunkVolume),
            состояние двигателя: \(engineState.rawValue),
            состояние окон: \(windowState.rawValue)
            """)
    }
    init(yearOfManufacture: Int, maxTrunkVolume: Double, mark: String, engineState: EngineState, windowState: WindowState,countHorsePower:Int,sportMode: SportMode){
        
        self.countHorsePower = countHorsePower
        self.sportMode = .turnOff
        super.init(yearOfManufacture: yearOfManufacture, maxTrunkVolume: maxTrunkVolume, mark: mark, engineState: engineState, windowState: windowState)
    }
}
// 1. Выводим данные по легковой машине с инициализацией без параметров - по умолчанию
print("Инициализация 1-го лекового автомобиля")
//var car1 = Car(yearOfManufacture:2012,maxTrunkVolume:200.0,mark:"Mitsubishi",engineState:.on,windowState:.close)
//print("Создано \(Car.carCount) экземпляра" )
var car1 = sportCar(yearOfManufacture:2012,maxTrunkVolume:200.0,mark:"Mitsubishi",engineState:.on,windowState:.close,countHorsePower:200,sportMode:.turnOff)
car1.printSport()
print("\n")
print("Изменяем спорт-режим")
car1.changeCarState()
car1.windowState = WindowState.open
print("\n")
car1.printSport()

print("\n")
print("Создано \(Car.carCount) экземпляров" )
print("Инициализация 2-го грузового автомобиля")
var car2 = trunkCar(yearOfManufacture:2012,maxTrunkVolume:20000.0,mark:"Man",engineState:.on,windowState:.close,heightWork:400,trunMode:.light,carrying:2000.0)

car2.printTrunk()
print("\n")
print("Загружаем 4 тонны")
car2.carrying += 4000.0
print("Устанавливаем режим грузоподъемности в зависимости от загруженного веса")
car2.changeCarState()
print("\n")
car2.printTrunk()
