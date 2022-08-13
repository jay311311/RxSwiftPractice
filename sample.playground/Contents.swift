import UIKit
import RxSwift

// 트리거 옵저버브링 Next이벤트 전달할때마다 데이터 옵저브블이 Next이벤트를 방출하지만, 동일한 Next를 방출하지는 않는 연산자 (<->withLatestFrom)
let disposebag  = DisposeBag()

enum myError : Error{
    case error
}

let trigger = PublishSubject<Void>()
let data  = PublishSubject<String>()

data.sample(trigger)
    .subscribe{ print($0) }
    .disposed(by: disposebag)


trigger.onNext(())
data.onNext("hi")
trigger.onNext(())


trigger.onNext(())
trigger.onNext(())


data.onCompleted()
trigger.onNext(())
