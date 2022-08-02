import UIKit
import RxSwift
// skip 연산자는 특정 요소 무시

let disposeBag =  DisposeBag()

let sequeence = [1,2,3,4,5,6,7,8,9,10,11,12]

// 처음 3개 요소 무시 ,  인덱스가아닌 갯수
Observable.from(sequeence)
    .skip(3)
    .subscribe{print("skip : \($0)")}
    .disposed(by: disposeBag)

// false를 return 한이후에는 모든 요소 방출
// 필터와 달리 한번만 필터한 이후 이후 요소 방충
Observable.from(sequeence)
    .skipWhile{ !$0.isMultiple(of: 2)}
    .subscribe{print("skipWhile : \($0)")}
    .disposed(by: disposeBag)


// skipUntil : ObservableType을 파라미터로 받아 해당 파라미터가 이벤트를 방출하기저까지 원본  Observable이 방출하는 이벤트를 무시한다

let subject = PublishSubject<Int>()
let trriger = PublishSubject<Int>()

subject.skip(until: trriger)
    .subscribe{print("skipUntil : \($0)")}
    .disposed(by: disposeBag)


subject.onNext(1)

trriger.onNext(5)

subject.onNext(10)
