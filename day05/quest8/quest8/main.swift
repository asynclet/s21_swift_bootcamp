import Foundation
import RxSwift

let secondCollection = Observable.of("text1", "text2", "text3")

func getStringArray(from collection: Observable<String>) -> Single<[String]> {
    return collection.toArray()
}

@MainActor
func main() {
    let disposeBag = DisposeBag()
    let result = getStringArray(from: secondCollection)

    result.subscribe(onSuccess: { stringArray in
        print("Array of strings: \(stringArray)")
    }).disposed(by: disposeBag)
}

main()
