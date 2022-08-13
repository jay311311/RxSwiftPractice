import UIKit
import RxSwift

// reduce : 시드값과 옵저버블이 방출하는 요소를  대상으로 클로절ㄹ 실행하고 최종결과를 옵저버블로 방출하는 연산자
let disposebag  = DisposeBag()

enum myError : Error{
    case error
}

let o  = Observable.range(start: 1, count: 5)

print("======= scan")

o.scan(0, accumulator: +)
    .subscribe{print($0)}
    .disposed(by: disposebag)

print("=====reduce")
o.reduce(0, accumulator: +)
    .subscribe{ print($0) }
    .disposed(by: disposebag)
