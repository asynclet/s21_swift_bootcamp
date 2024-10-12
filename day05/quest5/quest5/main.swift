import Foundation
import RxSwift

let firstCollection = Observable.of("first", "second", "", "third")

func hasEmptyStrings(_ firstCollection: Observable<String>) -> Observable<Bool> {
    return firstCollection
        .map { $0.isEmpty }
        .reduce(false) { $0 || $1 }
}

@MainActor
func main() {
    let disposeBag = DisposeBag()
    let result = hasEmptyStrings(firstCollection)

    result.subscribe(onNext: { value in
        if value {
            print("There are empty strings in the collection")
        } else {
            print("No empty strings in the collection")
        }
    })
    .disposed(by: disposeBag)
}

main()
