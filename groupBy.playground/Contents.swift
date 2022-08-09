import UIKit
import RxSwift
// groupBy : 옵저버블이 방출하는 요소를 원하는 기준으로 그루핑
// 저장된 key가 있음,

let dispoaseBag  = DisposeBag()
let word = ["Apple","Banana", "orange", "pineApple"]

// 해당 기준으로 그룹나누면 3개그룹 (.count)
// flatMap을 사용하면 completed시점에 배렬로 방출함
Observable.from(word)
   // .groupBy{ $0.count }
    .groupBy{$0.first ?? Character(" ")}
    .flatMap{$0.toArray()}
    .subscribe{ print($0)}
    .disposed(by: dispoaseBag)


//키와  옵저버블을 리턴하는  옵저버블의 요소 확인

Observable.from(word)
    .groupBy{ $0.count }
    .subscribe(onNext : { observable in
        print("===key : \(observable.key)===")
        observable.subscribe{print("    \($0)")}
    })
    .disposed(by: dispoaseBag)


Observable.range(start: 1, count: 10)
    .groupBy{$0.isMultiple(of: 2)}
    .subscribe(onNext:{ group in
        print("\(group.key)")
        group.subscribe{print( "    \($0)")}
    })
    .disposed(by: dispoaseBag)
