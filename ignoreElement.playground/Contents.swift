import UIKit
import RxSwift

// ignoreElement  :  next 이벤트를 필터링(제외) 한다. completed이벤트 또는 error 이벤트 전달

let disposeBag =  DisposeBag()

let fruite = ["🍏","🍎","🍊","🍋","🍌","🍇"]

Observable.from(fruite)
    .ignoreElements()
    .subscribe{print($0)}
    .disposed(by:disposeBag)
