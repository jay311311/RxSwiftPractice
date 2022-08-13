import UIKit
import RxSwift

//zip : 순서쌍을 맞춰서 방출
let disposebag  = DisposeBag()

enum myError : Error{
    case error
}


let greeting = PublishSubject<String>()
let languages  = PublishSubject<String>()


Observable.zip(greeting,languages){first, second -> String in
    return "\(first)  \(second)"
}.subscribe{print($0)}
    .disposed(by: disposebag)

greeting.onNext("hello")
languages.onNext("world")

languages.onNext("World")
greeting.onNext("Hello")

languages.onNext("Rxswift")
greeting.onNext("Hi")
greeting.onCompleted()

//greeting.onError(myError.error)
languages.onNext("swiftUI")
languages.onCompleted()

