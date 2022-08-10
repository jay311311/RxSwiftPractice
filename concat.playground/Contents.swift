import UIKit
import RxSwift

//concat : 두개 옵저버블을 연결하는 연산자
let disposedBag =  DisposeBag()
let big = ["A","B", "C","D", "E"]
let small = ["a","b", "c","d", "e"]


let Big  = Observable.from(big)
let Small  = Observable.from(small)


Observable.concat(Big,Small)
    .subscribe{print($0)}
    .disposed(by: disposedBag)


Big.concat(Small)
    .subscribe{print($0)}
    .disposed(by: disposedBag)



Small.concat(Big)
    .subscribe{print($0)}
    .disposed(by: disposedBag)


