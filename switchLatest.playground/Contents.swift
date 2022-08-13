import UIKit
import RxSwift

// 가장 최근에 방출된 옵저버블을 구독하고, 이옵저브블이 전달하는 이벤트를 구독자에게 전달하는 연산자
let disposebag  = DisposeBag()

enum myError : Error{
    case error
}

let a = PublishSubject<String>()
let b  = PublishSubject<String>()


let observable  =  PublishSubject<Observable<String>>()

observable
    .switchLatest()
    .subscribe{
    print($0)
}
.disposed(by: disposebag)

a.onNext("a")
b.onNext("b")

observable.onNext(a)

a.onNext("a1")

observable.onNext(b)
b.onNext("b2")

a.onCompleted()
b.onCompleted()
observable.onCompleted()


