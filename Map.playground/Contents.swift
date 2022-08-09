import UIKit
import RxSwift



// map :  원본 옵저버블이 방출하는 요소를 대상으로 함수를 실행하고 새로운 옵저버를 리턴하는 연산자
let disposeBag =  DisposeBag()
let sequence  =  ["A", "BB", "CCCC"]

Observable.from(sequence)
    .map{"hello  \($0.count)"}
    .subscribe{ print($0)}
    .disposed(by: disposeBag)



// concatMap :  nil을 필터링하는 연산자, 값이 nil이면 추출하지 않고, nil이 아니면 값을 unwraping 해서 보여준다

let subject  =  PublishSubject<String?>()

subject
    .compactMap{$0}
    .subscribe{ print($0)}
    .disposed(by: disposeBag)

Observable<Int>.interval(.milliseconds(300), scheduler: MainScheduler.instance)
    .take(10)
    .map{ _ in Bool.random() ? "star" : nil}
    .subscribe(onNext : { subject.onNext($0)})
    .disposed(by: disposeBag)


