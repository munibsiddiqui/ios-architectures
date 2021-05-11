# iOS Architectures

## API

- [Beer API](https://punkapi.com/documentation/v2)



## Reference

1. Started from [Pawel Krawiec](https://github.com/tailec)'s [ios-architecture](https://github.com/tailec/ios-architecture) & [Bo-Young PARK](https://github.com/fimuxd)'s [BringMyOwnBeer-](https://github.com/fimuxd/BringMyOwnBeer-)
2. Studied MVVM+RxSwift with [Miguel Lin](https://github.com/gannasong)'s [RxSwift-MVVM-Demo](https://github.com/gannasong/RxSwift-MVVM-Demo)
3. Studied Coodinator Pattern with [wojciech-kulik](https://github.com/wojciech-kulik)'s [Swift-MVVMC-Demo](https://github.com/wojciech-kulik/Swift-MVVMC-Demo)
4. Studied Clean Architecture with [Oleh](https://github.com/kudoleh)'s [iOS-Clean-Architecture-MVVM](https://github.com/kudoleh/iOS-Clean-Architecture-MVVM)

Thank for people of this list!



## Screenshots

| List | Search | Random |
| :--: | :----: | :----: |
<img src = "./screenshots/1.png" width = 400> | <img src = "./screenshots/2.png" width = 400> | <img src = "./screenshots/3.png" width = 400> |



## 0. Shared

Image Download - Kingfisher



## 1. [MVC - storyboard](https://github.com/Goeun1001/ios-architectures/tree/master/MVC-storyboard)

UI - Storyboard

Network - URLSession



## 2. [MVC - snapKit](https://github.com/Goeun1001/ios-architectures/tree/master/MVC-snapKit)

UI - SnapKit

Network - URLSession



## 3. [MVP - snapKit](https://github.com/Goeun1001/ios-architectures/tree/master/MVP-snapKit)

UI - SnapKit, Then

Network - URLSession



## 4. [MVVM - RxSwift - storyboard](https://github.com/Goeun1001/ios-architectures/tree/master/MVVM-RxSwift-storyboard)

UI - Storyboard, RxDatasource

Network - RxURLSession

Unit Tests 👌 - RxTest



## 4-1. [MVVM - RxSwift - xcodegen](https://github.com/Goeun1001/ios-architectures/tree/master/MVVM-RxSwift-xcodegen)

UI - Storyboard, RxDatasource

Network - RxURLSession

Unit Tests 👌 - RxTest

Xcodegen 👌

```
$ brew install xcodegen
```

```
$ cd MVVM-RxSwift-xcodegen/
$ xcodegen
```



## 4-2. [MVVM - RxSwift - tuist](https://github.com/Goeun1001/ios-architectures/tree/master/MVVM-RxSwift-tuist)

UI - Storyboard, RxDatasource

Network - RxURLSession

Unit Tests 👌 - RxTest

Tuist 👌

```
$ bash <(curl -Ls https://install.tuist.io)
```

```
$ cd MVVM-RxSwift-tuist/
$ tuist generate
```



## 5. [MVVM - RxSwift - snapKit](https://github.com/Goeun1001/ios-architectures/tree/master/MVVM-RxSwift-snapKit)

UI - SnapKit, Then, RxDatasource

Network - Moya

Unit Tests 👌 - RxTest



## 5-1. [MVVM - RxSwift - coreData](https://github.com/Goeun1001/ios-architectures/tree/master/MVVM-RxSwift-coreData)

UI - SnapKit, Then, RxDatasource

Network - RxURLSession

Repositoy Pattern - CoreData

Unit Tests 👌 - RxTest, Nimble



## 5-2. [MVVM - RxSwift - realm](https://github.com/Goeun1001/ios-architectures/tree/master/MVVM-RxSwift-realm)

UI - SnapKit, Then, RxDatasource

Network - RxURLSession

Repositoy Pattern - Realm

Unit Tests 👌 - RxTest, Nimble



## 5-3. [MVVM - RxSwift - sqlite](https://github.com/Goeun1001/ios-architectures/tree/master/MVVM-RxSwift-sqlite)

UI - SnapKit, Then, RxDatasource

Network - RxURLSession

Repositoy Pattern - Sqlite3

Unit Tests 👌 - RxTest, Nimble



## 5-4. Clean - MVVM

sub framework👌 - CleanFrameworks.zip



## 6. [MVVM-C - RxSwift](https://github.com/Goeun1001/ios-architectures/tree/master/MVVM-C-RxSwift)

UI - SnapKit, Then, RxDatasource

Network - Moya

Unit Tests 👌 - RxTest, Nimble, Quick

CI - Github Actions 👌



## 6-1. [MVVM-C - RxSwift - Swinject](https://github.com/Goeun1001/ios-architectures/tree/master/MVVM-C-RxSwift-swinject)

UI - SnapKit, Then, RxDatasource

Network - Moya

Unit Tests 👌 - RxTest, Nimble, Quick

CI - Github Actions 👌

DI - Swinject



## 7. [MVVM - RxSwift - RxFlow](https://github.com/Goeun1001/ios-architectures/tree/master/MVVM-RxSwift-rxflow)

UI - SnapKit, Then, RxDatasource

Network - Moya

Unit Tests 👌 - RxTest

❗️ **Alert** : I used **' DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) '** Because If tabbarflow does not navigate to a total of 3 flows, it cannot navigate to an alert. If you know a better solution, please PR!



## 7-1. Clean Architecture - MVVM - RxSwift - RxFlow - Swinject



## 8. ReactorKit - RxFlow

UI - SnapKit, Then, RxDatasource

Network - Moya

Unit Tests 👌

❗️ **Alert** : I used **' DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) '** Because If tabbarflow does not navigate to a total of 3 flows, it cannot navigate to an alert. If you know a better solution, please PR!



## 9. RIBs

## 10. VIPER

## 11. VIP

## 



## 💕 WAITING YOUR PR for the better codes.