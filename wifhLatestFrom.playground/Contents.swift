import UIKit
import RxSwift
let disposebag  = DisposeBag()

enum myError : Error{
    case error
}

// 트리거 옵저버블이 Next이벤트를 방출하면 데이터 옵저버블이 ㄹ가장 최근에 방출한 Next 이벤트를 구독자에게 전달하는 연산자
let trigger = PublishSubject<Void>()
let languages  = PublishSubject<String>()

trigger.withLatestFrom(languages)
    .subscribe{print($0)}
    .disposed(by: disposebag)


languages.onNext("hi")

languages.onNext("hello")
trigger.onNext(())
trigger.onNext(())

//languages.onCompleted()
trigger.onNext(())
trigger.onCompleted()
