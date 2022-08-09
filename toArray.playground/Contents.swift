import UIKit
import RxSwift

//toArray : 원본 옵저버블이 방출하는 모든 요소를 하나의 배열로 방출하는 연산자

let disposeBag =  DisposeBag()
let sequence  = [1,2,3,4,5,6,7,8,9]

var subject  =  PublishSubject<Int>()


subject
    .toArray()
    .subscribe{print($0)}
    .disposed(by: disposeBag)


subject.onNext(1)
subject.onNext(2)
subject.onNext(3)

subject.onCompleted()
