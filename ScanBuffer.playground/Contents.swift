import UIKit
import RxSwift

// scan :  원본이 방출하는 수와 구독자가 방출하는 수가 같다
let disposeBag = DisposeBag()

Observable.range(start: 1, count: 10)
    .scan(0, accumulator: +)
    .subscribe{ print($0) }
    .disposed(by: disposeBag)


//buffer :

Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
    .buffer(timeSpan: .seconds(5), count: 3, scheduler: MainScheduler.instance)
    .take(5)
    .subscribe{ print($0)}
    .disposed(by: disposeBag)
