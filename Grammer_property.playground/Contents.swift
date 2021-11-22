import UIKit


/*
    저장프로퍼티:
        단순한 값을 저장하고 있는 프로퍼티
        변수 또는 상수 키워드를 이용해서 사용가능
 
 */

//struct Student {
//    var name: String
//    var age: Int
//}
//
//var atlas = Student(name: "아틀라스", age: 20)
//print(atlas)


/*
    연산프로퍼티:
        실제값을 저장하고 있는 것이 아니라 get/set 으로 값을 탐색하고
        간접적으로 다른 프로퍼티의 값을 설정할 수 있다.
 
 */

struct WeeklySalary {
    var hourlyWage: Double
    var workingHours: Double
    
    var wage: Double {
        get {
            return hourlyWage * workingHours
        }
        
        set {
            workingHours = newValue / hourlyWage
        }
    }
}

var myWeeklySalary = WeeklySalary(hourlyWage: 10000, workingHours: 4)
//print(myWeeklySalary)
//print(myWeeklySalary.wage)
//myWeeklySalary.wage = 50000
//print(myWeeklySalary.workingHours)



/*
    프로퍼티 옵저버:
        프로퍼티의 새 값이 설정 될 때 마다 이벤트를 감지할 수 있다.
        willSet / didSet
    
 */

struct Student {
    var name: String {
        willSet {
            print("\(name) -> \(newValue)로 변경예정입니다.")
        }
        
        didSet {
            print("\(oldValue) -> \(name)로 변경되었습니다.")
        }
    }
}

var atlas = Student(name: "아틀라스")
atlas.name = "atlas"


/*
    타입프로퍼티
        static을 이용해서 선언가능하다
        인스턴스 생성을 하지 않아도 사용할 수 있다.
        저장프로퍼티, 연산프로퍼티로 사용이 가능하다
 */


struct SomeStruct{
    static var storedTypeProperty = "Some Value"
    static var computedTypeProperty: Int {
        return 1
    }
}


SomeStruct.storedTypeProperty
SomeStruct.computedTypeProperty

print("\(SomeStruct.storedTypeProperty)")
print("\(SomeStruct.computedTypeProperty)")
