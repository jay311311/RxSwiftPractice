import UIKit
import RxSwift


let disposeBag =  DisposeBag()

let sequeence = [1,2,3,4,5,6,7,8,9,10,11,12]

Observable.from(sequeence)
    .filter{$0.isMultiple(of: 4)}
    .subscribe{print($0)}
    .disposed(by: disposeBag)
