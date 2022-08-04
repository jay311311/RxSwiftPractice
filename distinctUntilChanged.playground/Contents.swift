import UIKit
import RxSwift

// distinctUntilChanged : 동일한 요소가 연속적으로 방출되는것을 막아주는 연산자
struct Person{
    let name : String
    let age : Int
}

let disposeBag = DisposeBag()
let numbers = [1,2,2,3,3,4,4,4,5,5,5,8,2,7]
let tupels = [(1,"하나"), (1,"일"), (1, "one")]
let person = [
    Person(name: "Elen", age: 12),
    Person(name: "Tom", age: 12),
    Person(name: "Peter", age: 32)
]

// keypath로 속성을 기준으로
Observable.from(person)
    .distinctUntilChanged(at: \.name)
    .subscribe{print("keyPath : \($0)")}
    .disposed(by: disposeBag)


// equltable은 0 이면 키 , 1이면 value를 의미
Observable.from(tupels)
    .distinctUntilChanged {  $0.0}
    .subscribe{print("equtable : \($0)")}
    .disposed(by: disposeBag)

Observable.from(numbers)
    .distinctUntilChanged{ $0.isMultiple(of: 2) && $1.isMultiple(of: 2)
    }
    .subscribe{print("compare : \($0)")}
    .disposed(by: disposeBag)


Observable.from(numbers)
    .distinctUntilChanged()
    .subscribe{print("default : \($0)")}
    .disposed(by: disposeBag)

