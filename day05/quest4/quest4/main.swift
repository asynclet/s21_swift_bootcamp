import Foundation
import RxSwift

let firstCollection = Observable.of("first", "second", "third")

func hasStringsLongerThan(_ firstCollection: Observable<String>, length: Int = 5) -> Observable<Bool> {
    return firstCollection
        .map { $0.count > length }
        .reduce(false) { $0 || $1 }
}

@MainActor
func main() {
    let disposeBag = DisposeBag()
    let result = hasStringsLongerThan(firstCollection)

    result.subscribe(onNext: { value in
        if value {
            print("There are strings longer than 5 characters")
        } else {
            print("No strings longer than 5 characters")
        }
    })
    .disposed(by: disposeBag)
}

main()
