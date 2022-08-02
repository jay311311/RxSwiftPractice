import UIKit
import RxSwift
var greeting = "Hello, playground"
// elementAt : 특정 인덱스만 방출

let disposeBag =  DisposeBag()
let fruite = ["🍏","🍎","🍊","🍋","🍌","🍇"]


Observable.from(fruite)
    .element(at: 1)
    .subscribe{print($0)}
    .disposed(by: disposeBag)
