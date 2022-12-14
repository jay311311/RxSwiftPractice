import UIKit
import RxSwift


let dispoaseBag =  DisposeBag()
let redCircle =  "๐ด"
let orangeCircle =  "๐ "
let yellowCircle =  "๐ก"

let redHeart =  "โค๏ธ"
let orangeHeart =  "๐งก"
let yellowHeart =  "๐"

//concatMap : interleaving์ ํ์ฉํ์ง ์์, ์์ inner Observable์ด ๋๋ ๋๊น์ง ๊ธฐ๋ค๋ ธ๋ค๊ฐ ์งํ๋จ(๋ผ์ด๋ค๊ธฐ ๋ถ๊ฐ๋ฅ, ์์ฑ๋ ์์๋๋ก)


Observable.from([orangeCircle, redCircle,  yellowCircle])
    .concatMap { cirlce  -> Observable<String> in
        switch cirlce {
        case redCircle:
            // ์ฌ๊ธฐ return ๋๋๊ฒ innerObservable
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
// ์ฌ๊ธฐ์ ๋ฐฉ์ถ๋๋๊ฒ resultObservarble
    .subscribe{print($0)}
    .disposed(by: dispoaseBag)





// flatMapLatest   : ๊ฐ์ฅ์ต๊ทผ ์ด๋ ์ต์ ๋ฒ๋ธ์์๋ง ์ด๋ฒคํธ ๋ฐฉ์ถ
let sourceObservable  = PublishSubject<String>()
let trigger  = PublishSubject<Void>()

sourceObservable
    .flatMapLatest { cirlce  -> Observable<String> in
        switch cirlce {
        case redCircle:
            // ์ฌ๊ธฐ return ๋๋๊ฒ innerObservable
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
// ์ฌ๊ธฐ์ ๋ฐฉ์ถ๋๋๊ฒ resultObservarble
    .subscribe{print("flatMapLatest : \($0)")}
    .disposed(by: dispoaseBag)

sourceObservable.onNext(redCircle)

// yellow inner Obserbaler์ด ์์ฑ๋๋์๊ฐ, ์ด์  redCircle์ innerObserbale ์ ์ฌ๋ผ์ง๋ค.
DispatchQueue.main.asyncAfter(deadline: .now() + 1){
    sourceObservable.onNext(yellowCircle)
}
DispatchQueue.main.asyncAfter(deadline: .now() + 2){
    sourceObservable.onNext(orangeCircle)
}
// ์ฒซ๋ฒ์จฐ innerObserbaler ์ฌ์ฌ์ฉ ํ์ง ์๋๋ค.
DispatchQueue.main.asyncAfter(deadline: .now() + 2){
    sourceObservable.onNext(redCircle)
}

// ๋ชจ๋  ์ด๋ ์ต์ ๋ฒ๋ธ ์ค์ง
DispatchQueue.main.asyncAfter(deadline: .now() + 10){
    trigger.onNext(())
}



// flatMapFirst : ๊ฐ์ฅ๋จผ์  ์ด๋ฒคํฌ๋ฅผ ๋ฐฉ์ถํ innerObservable์์๋ง ์ด๋ฒคํธ๋ฅผ ๋ฐฉ์ถํ๋ ์ฐ์ฐ์, ๊ฐ์ฅ๋จผ์  ์คํ๋๋(from ์ ์ฒซ๋ฒ์ฌ) innerObservarble๋ง ๋ฐฉ์ถ
Observable.from([orangeCircle, redCircle,  yellowCircle])
    .flatMapFirst { cirlce  -> Observable<String> in
        switch cirlce {
        case redCircle:
            // ์ฌ๊ธฐ return ๋๋๊ฒ innerObservable
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
// ์ฌ๊ธฐ์ ๋ฐฉ์ถ๋๋๊ฒ resultObservarble
    .subscribe{print($0)}
    .disposed(by: dispoaseBag)


// flatMap : ํํํ ์์์ผ๋ก innerObservable์ ํตํด resultObserbale ์์ฑ, interleaving ํ์ฉ, ๊ทธ๋์ ์ฒซ๋ฒ์งธ๊ฒ์ด ๋๋ ๋๊น์ง ๊ธฐ๋ค๋ฆฌ์ง ์๋๋ค.


Observable.from([orangeCircle, redCircle,  yellowCircle])
    .flatMap { cirlce  -> Observable<String> in
        switch cirlce {
        case redCircle:
            // ์ฌ๊ธฐ return ๋๋๊ฒ innerObservable
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
// ์ฌ๊ธฐ์ ๋ฐฉ์ถ๋๋๊ฒ resultObservarble
    .subscribe{print($0)}
    .disposed(by: dispoaseBag)


