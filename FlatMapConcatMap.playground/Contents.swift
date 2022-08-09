import UIKit
import RxSwift


let dispoaseBag =  DisposeBag()
let redCircle =  "🔴"
let orangeCircle =  "🟠"
let yellowCircle =  "🟡"

let redHeart =  "❤️"
let orangeHeart =  "🧡"
let yellowHeart =  "💛"

//concatMap : interleaving을 허용하지 않음, 앞의 inner Observable이 끝날때까지 기다렸다가 진행됨(끼어들기 불가능, 생성된 순서대로)


Observable.from([orangeCircle, redCircle,  yellowCircle])
    .concatMap { cirlce  -> Observable<String> in
        switch cirlce {
        case redCircle:
            // 여기 return 되는게 innerObservable
            return  Observable.repeatElement(redHeart)
                .take(5)
        case yellowCircle:
            return  Observable.repeatElement(yellowHeart)
                .take(5)
        case orangeCircle :
            return  Observable.repeatElement(orangeHeart)
                .take(5)
        default:
          return  Observable.just("")
        }
    }
// 여기서 방출되는게 resultObservarble
    .subscribe{print($0)}
    .disposed(by: dispoaseBag)





// flatMapLatest   : 가장최근 이너 옵저버블에서만 이벤트 방출
let sourceObservable  = PublishSubject<String>()
let trigger  = PublishSubject<Void>()

sourceObservable
    .flatMapLatest { cirlce  -> Observable<String> in
        switch cirlce {
        case redCircle:
            // 여기 return 되는게 innerObservable
            return  Observable<Int>.interval(.milliseconds(300), scheduler: MainScheduler.instance)
                .map{_ in redHeart}
                .take(until: trigger)
        case yellowCircle:
            return Observable<Int>.interval(.milliseconds(300), scheduler: MainScheduler.instance)
                .map{_ in yellowHeart}
                .take(until: trigger)
        case orangeCircle :
            return Observable<Int>.interval(.milliseconds(300), scheduler: MainScheduler.instance)
                .map{_ in orangeHeart}
                .take(until: trigger)
        default:
          return  Observable.just("")
        }
    }
// 여기서 방출되는게 resultObservarble
    .subscribe{print("flatMapLatest : \($0)")}
    .disposed(by: dispoaseBag)

sourceObservable.onNext(redCircle)

// yellow inner Obserbaler이 생성되는순간, 이전 redCircle의 innerObserbale 은 사라진다.
DispatchQueue.main.asyncAfter(deadline: .now() + 1){
    sourceObservable.onNext(yellowCircle)
}
DispatchQueue.main.asyncAfter(deadline: .now() + 2){
    sourceObservable.onNext(orangeCircle)
}
// 첫번쨰 innerObserbaler 재사용 하지 않는다.
DispatchQueue.main.asyncAfter(deadline: .now() + 2){
    sourceObservable.onNext(redCircle)
}

// 모든 이너 옵저버블 중지
DispatchQueue.main.asyncAfter(deadline: .now() + 10){
    trigger.onNext(())
}



// flatMapFirst : 가장먼저 이벤크를 방출한 innerObservable에서만 이벤트를 방출하는 연산자, 가장먼저 실행되는(from 의 첫번재) innerObservarble만 방출
Observable.from([orangeCircle, redCircle,  yellowCircle])
    .flatMapFirst { cirlce  -> Observable<String> in
        switch cirlce {
        case redCircle:
            // 여기 return 되는게 innerObservable
            return  Observable.repeatElement(redHeart)
                .take(5)
        case yellowCircle:
            return  Observable.repeatElement(yellowHeart)
                .take(5)
        case orangeCircle :
            return  Observable.repeatElement(orangeHeart)
                .take(5)
        default:
          return  Observable.just("")
        }
    }
// 여기서 방출되는게 resultObservarble
    .subscribe{print($0)}
    .disposed(by: dispoaseBag)


// flatMap : 평탄화 작업으로 innerObservable을 통해 resultObserbale 생성, interleaving 허용, 그래서 첫번째것이 끝날떄까지 기다리지 않는다.


Observable.from([orangeCircle, redCircle,  yellowCircle])
    .flatMap { cirlce  -> Observable<String> in
        switch cirlce {
        case redCircle:
            // 여기 return 되는게 innerObservable
            return  Observable.repeatElement(redHeart)
                .take(5)
        case yellowCircle:
            return  Observable.repeatElement(yellowHeart)
                .take(5)
        case orangeCircle :
            return  Observable.repeatElement(orangeHeart)
                .take(5)
        default:
          return  Observable.just("")
        }
    }
// 여기서 방출되는게 resultObservarble
    .subscribe{print($0)}
    .disposed(by: dispoaseBag)


