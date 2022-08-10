import UIKit
import RxSwift

//merge : 여러 옵저버블이 방출하는 이벤트를 하나의 옵저버블에서 방출하도록 병합한다
let disposedBag =  DisposeBag()

let firstNum = BehaviorSubject(value: 1)
let secondNum = BehaviorSubject(value: 2)
let thirdNum = BehaviorSubject(value: 3)

Observable.of(firstNum, secondNum,thirdNum)
    .merge(maxConcurrent: 2)
    .subscribe{ print($0)}
    .disposed(by: disposedBag)


firstNum.onNext(4)
secondNum.onNext(5)
firstNum.onCompleted()
secondNum.onCompleted()
