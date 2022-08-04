import UIKit
import RxSwift
//single :  하나의 요소가 방출되는것을 보장하는 연산자
// 두개이상 방출되면 에러가 발생됨
let disposeBag =  DisposeBag()
let sequeence = [1,2,3,4,5,6,7,8,9,10,11,12]


Observable.just(1)
    .subscribe{(print($0))}
    .disposed(by: disposeBag)


Observable.just(11)
    .single()
    .subscribe{(print($0))}
    .disposed(by: disposeBag)


//하나의 요소 방출후 에러발생 시킴
Observable.from(sequeence)
    .single()
    .subscribe{(print($0))}
    .disposed(by: disposeBag)



// single연산자는 하나의 요소가 방출된다고 해서 completed를 발생히키지 않는다.
// 원본 옵저버블에서 complete가 발생할때까지 기다린다.
// 그사이에 다른 요소가 방출되었다면 error를 발생시킴
let subject =  PublishSubject<Int>()

subject.single()
    .subscribe{ print($0) }
    .disposed(by: disposeBag)

subject.onNext(100)

