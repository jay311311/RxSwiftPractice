import UIKit
import RxSwift

//startWith : 옵저버블 시퀀스 앞에 새로운 요소 추가하는 연산자(LIFO)
let disposedBag =  DisposeBag()
let sequence = [1,2,3,4,5,6]
Observable.from(sequence)
    .startWith(0)
    .startWith(-1,-2)
    .startWith(-3)
    .subscribe{ print($0)}
    .disposed(by: disposedBag)
