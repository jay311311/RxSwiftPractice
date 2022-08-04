import UIKit
import RxSwift

let disposeBag =  DisposeBag()
//debouce 연산자 : 짧은시간 반복적으로 전달되는 이벤트를 효율적으로 처리
// debouce의 첫 파라미터는 시간 : 이 시간이내에 다른 이벤트가 방생하지 않는다면 마지막 요소를 방출한다.
// 이벤트가 방출되면 타이머를 다시 초기화한다
let buttonTap = Observable<String>.create { observer in
    DispatchQueue.global().async {
        // 0.3초동안 10번 onNext 방출
        for i in 1...10{
            observer.onNext("Tap \(i)")
            Thread.sleep(forTimeInterval: 0.3)
        }
        //1초동안 쓰레드 쉬고
        Thread.sleep(forTimeInterval: 5)
        // 0.5초동안 10번 onNext 방출 & .milliseconds(1000) 보다 작은주기로 방출되기때문에 출력 안됨 + debounce 타이머 초기화
        for i in 11...20{
            observer.onNext("Tap \(i)")
            Thread.sleep(forTimeInterval: 0.5)
        }
        observer.onCompleted()
    }
    return Disposables.create {
        
    }
}

// debouce 연산자는 지정된 시간동안 새로운 이벤트가 방출하지 않으면 가장마지막에 방출된 이벤트를 구독자에게 전달
// debouce첫번째 이벤트가 방출된다음 .milliseconds(1000) /1초/ 타이머 시작 타이머가 완료되기전 새로운 이벤트 방출 -> 타이머 초기화 -> 타이머 재 완료되기까지 대기
// 쓰레드 쉬는 구간과 .milliseconds(1000)타이머 시점에 가장 마지막에 방출된 요소 출력
buttonTap
    .debounce(.milliseconds(1000), scheduler: MainScheduler.instance)
    .subscribe{print($0)}
    .disposed(by: disposeBag)



// throttle 연산자 : 짧은시간 반복적으로 전달되는 이벤트를 효율적으로 처리
let buttonTap1 = Observable<String>.create { observer in
    DispatchQueue.global().async {
        // 0.3초동안 10번 onNext 방출
        for i in 1...10{
            observer.onNext("Tap \(i)")
            Thread.sleep(forTimeInterval: 0.3)
        }
        //1초동안 쓰레드 쉬고
        Thread.sleep(forTimeInterval: 5)
        // 0.5초동안 10번 onNext 방출 & .milliseconds(1000) 보다 작은주기로 방출되기때문에 출력 안됨 + debounce 타이머 초기화
        for i in 11...20{
            observer.onNext("Tap \(i)")
            Thread.sleep(forTimeInterval: 0.5)
        }
        observer.onCompleted()
    }
    return Disposables.create {
        
    }
}

// debouce 연산자는 지정된 시간동안 새로운 이벤트가 방출하지 않으면 가장마지막에 방출된 이벤트를 구독자에게 전달
// debouce첫번째 이벤트가 방출된다음 .milliseconds(1000) /1초/ 타이머 시작 타이머가 완료되기전 새로운 이벤트 방출 -> 타이머 초기화 -> 타이머 재 완료되기까지 대기
// 쓰레드 쉬는 구간과 .milliseconds(1000)타이머 시점에 가장 마지막에 방출된 요소 출력
buttonTap1
    .throttle(.milliseconds(1000), scheduler: MainScheduler.instance)
    .subscribe{print($0)}
    .disposed(by: disposeBag)


// debouce 와 throttle 의 차이점
// throttle :  지정된 주기마다 요소를 하나씩 전달. / 짧은시간동안 반복되는 탭이벤트나 델리게이트 전달시 사용됨
// debouce : next이벤트가 발생한 이후 지정된 시간동안 이벤트가 발생되지 않는다면 마지막으로 방출된 요소를 전달. / 주로 검색기능 / 문자를 입력할 때마다 api 호출하는 건 효율적이지 않음 / 단어입력 완료시 해당 타이머가지나면 api 호출되는게 효율적



//latest 파라미터 유뮤에따른 실행결과 비교
//  next(3) 방출전 2.5초 경과했지만, 원본 observable이 새로운 이벤트를 방출할때까지 기다렸다가 새로운 next(3)방출
func currentTimeString() -> String{
    let f =  DateFormatter()
    f.dateFormat = "yyyy-mm-dd hh:mm:ss.SSS"
    return f.string(from: Date())
}
// next(3) 방출전 2.5초 경과하기떄문에, 이때 가장 최근에 방출된 next(2)를 방출
//Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
//    .debug()
//    .take(15)
//    .throttle(.milliseconds(2500), latest: true, scheduler: MainScheduler.instance)
//    .subscribe{print(currentTimeString(),$0)}
//    .disposed(by: disposeBag)
//


Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
    .debug()
    .take(10)
    .throttle(.milliseconds(2500), latest: false, scheduler: MainScheduler.instance)
    .subscribe{print(currentTimeString(),$0)}
    .disposed(by: disposeBag)
