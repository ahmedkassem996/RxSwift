import UIKit
import RxSwift
import RxCocoa
import RxRelay

var str = "Hello, playground"

/*
 Observable (sequence)- emits events (notification of change) asyncrously.
 Observer - subscribe to Observable in order to receive events.
 
 Subject = Observable + Observer
     - PublishSubject - Only emits new elements to subscribers.
     - BehaviorSubject - emits the last element to new subscribers.
     - ReplaySubject - emits a buffer size of element to new subscribers.
     - asyncSubject - emits only the last next event in the sequence, and only when the subject receives a complete event.
 
 Relays = Wraper around subjects that never complete.
     - BublishRelay
     - behaviorRelay
*/


// Publish Subject
let pubSub = PublishSubject<String>()

pubSub.onNext("pubSub El 1")

let ob1 = pubSub.subscribe(onNext:{
    elem in
    print(elem)
})

pubSub.onNext("pubSub El 2")

// Behavior Subject
let behSub = BehaviorSubject<String>(value: "pubSub El 1")
let beh1 = behSub.subscribe(onNext:{
    elem in
    print(elem)
})

// Replay Subject
let rebSub = ReplaySubject<Int>.create(bufferSize: 3)
rebSub.onNext(1)
rebSub.onNext(2)
rebSub.onNext(3)

let rebSub1 = rebSub.map({
    elem in
    elem * 2
    }).subscribe(onNext:{
    elem in
    print(elem)
})

// Async Subject
let asySub = AsyncSubject<String>()
asySub.onNext("asySub El 1")
asySub.onNext("asySub El 2")
asySub.onNext("asySub El 3")

asySub.onCompleted()

let asySub1 = asySub.subscribe(onNext:{
    elem in
    print(elem)
})

// Publish Relay
let pubRel = PublishRelay<String>()
pubRel.accept("pubRel El 1")

let pubRel1 = pubRel.subscribe(onNext:{
    elem in
    print(elem)
})
pubRel.accept("pubRel El 2")

// Behavior Relay
let behRel = BehaviorRelay<String>(value: "Behrel El 1")

behRel.accept("behRel El 2")
let behRel1 = behRel.subscribe(onNext:{
    elem in
    print(elem)
})
behRel.accept("behRel El 3")
