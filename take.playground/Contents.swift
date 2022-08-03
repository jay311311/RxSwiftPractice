import UIKit
import RxSwift


//take : 처음 n개 이벤트만 방출하는 연산자
let disposeBag =  DisposeBag()
let sequeence = [1,2,3,4,5,6,7,8,9,10,11,12]

Observable.from(sequeence)
    .take(5)
    .subscribe{print("take : \($0)")}
    .disposed(by: disposeBag)


//takeWhile : 조건을 충족하는 동안 이벤트 방출
//default는 .exclusive이고 , .inclusiv인경우 마지막에 확인한 값까지 방출
Observable.from(sequeence)
    .take(while: {!$0.isMultiple(of: 2)}, behavior: .inclusive)
    .subscribe{print("takeWhile : \($0)")}
    .disposed(by: disposeBag)


//takeUntil
let subject = PublishSubject<Int>()
let trigger = PublishSubject<Int>()


subject.take(until: trigger)
    .subscribe{print("takeUntil_Obser : \($0)")}
    .disposed(by: disposeBag)

subject.onNext(1)
subject.onNext(3)
subject.onNext(5)
trigger.onNext(7)
subject.onNext(10)

// 변경된값이 10보다 초과하면, false로 return 허고 구독자로 전달한다
let subject1 = PublishSubject<Int>()
subject1.take(until:{ $0 > 10 })
    .subscribe{print("takeUntil_pred : \($0)")}
    .disposed(by: disposeBag)

subject1.onNext(1)
subject1.onNext(3)
// 10을 초과하는 값을 방출하면 ture를 리턴하고 전달하지 않고 completed 방출
subject1.onNext(15)



//takeLast : 원본 옵저버블의 마지막 n개 이벤트만 방출

let subject3 =  PublishSubject<Int>()

subject3.takeLast(2)
    .subscribe{  print($0)}
    .disposed(by: disposeBag)

//10번 돌면서 마지막 2개를 버퍼에 담아둠
(1...10).forEach{subject3.onNext($0)}

// 버퍼의 2개 공간중 하나에 3 등록
subject3.onNext(3)
// completed 되면  버퍼에 갖고있던 요소 방출
subject3.onCompleted()
