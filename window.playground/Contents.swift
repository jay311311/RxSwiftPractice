import UIKit
import RxSwift

//window : 옵저버블을 방출 하는 옵저버블을 리턴한다 =. innerObservable
// .AddRef는 옵저버블이고 구독할수 있다.
let dispposeBag =  DisposeBag()

Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
    .window(timeSpan: .seconds(5), count: 3, scheduler: MainScheduler.instance)
    .take(5)
    .subscribe{ print($0)
        if let observable = $0.element{
            observable.subscribe{print(" inner : \($0)")}
        }
    }
    .disposed(by: dispposeBag)
