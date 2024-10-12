import Foundation
import RxSwift

let firstCollection = Observable.of("first", "second", "third")

func areAllStringsLongerThan(_ firstCollection: Observable<String>, length: Int = 5) -> Observable<Bool> {
    return firstCollection
        .map { $0.count > length }
        .reduce(true) { $0 && $1 }
}

@MainActor
func main() {
    let disposeBag = DisposeBag()
    let result = areAllStringsLongerThan(firstCollection)
    
    result.subscribe(onNext: { value in
        if value {
            print("All strings are longer than 5 characters")
        } else {
            print("Not all strings are longer than 5 characters")
        }
    })
    .disposed(by: disposeBag)
}

main()
