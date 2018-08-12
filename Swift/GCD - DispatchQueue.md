# GCD

- CGD는 Grand Central Dispatch로 멀티코어 프로세서 시스템에 대한 응용 프로그램 지원을 최적화하기 위해 Apple에서 개발한 기술로 스레드 관리와 실행에 대한 책임을 어플리케이션 레벨이 아닌 운영체제 레벨에서 관리하도록 한 기술입니다.
- 작업의 단위는 Block이라 불리며 DispatchQueue가 이 Block들을 관리 합니다.
- CGD는 각 어플리케이션에서 생성된 DispatchQueue가 이 Block들을 관리 합니다.
- CGD는 각 어플리케이션에서 생성된 DispatchQueue를 읽는 멀티코어 실행 엔진을 가지고 있으며, 이것이 Queue에 등록된 각 작업을 꺼내 스레드에 할당합니다.
- 실질적으로 개발자는 내부 동작을 자세히 알 필요 없이 Queue에 작업을 넘기기만 하면 된다는 장점이 있습니다.
- 또 스레드를 직접 생성하고 관리하는 것에 비해 관리 용이성과 이식성, 성능이 증가합니다.

<br>

<br>

## DispatchQueue

- GCD는 앱이 블록객체 형태로 작업을 전송할 수 있는 FIFO Queue(대기열)을 제공하고 관리합니다.
- Queue에 전달된 작업은 시스템이 전적으로 관리하는 a pool of threads(스레드 풀)에서 실행됩니다.
- 작업이 실행될 스레드는 보장이 되지 않습니다.
- DispatchQueue는 2개의 타입이 있습니다. 둘 모두 FIFO 순서로 처리 합니다
  1. 앱을 실행하면 시스템이 자동으로 메인스레드 위에서 동작하는 Main 큐(Serial Queue)를 만들어서 수행
  2. 추가적으로 여러 개의 Global 큐(Concurrent Queue)를 만들어서 큐를 관리합니다.
- 각 작업은 sync(동기)와 async(비동기) 방식으로 실행 가능하지만 Main 큐에서는 async만 사용 가능합니다.
  - sync큐에 작업을 추가하면 작업이 끝날때까지 기다립니다.
  - async큐에 작업을 추가하면 작업이 끝나는지의 여부와 관계없이 다음 작업을 진행합니다.

<br>

<br>

## System DispatchQueue 

- system에서 제공되는 Queue는 Main과 Global이 있으며 앱 실행시 같이 실행됩니다.

<br>

### Main

- UI와 관련된 작업은 모두 main 큐를 통해서 수행하며 Serial Queue에 해당됩니다.

- MainQueue를 sync 메서드로 동작시키면 Dead Lock 상태에 빠집니다.

  - Dead Lock : 서로 다른 2개의 작업이 서로 끝나기만을 기다리는 교착상태를 말합니다.
    - 예를들어 하나의 사다리가 있고 2명의 위 아래에 있을때 한명을 내려가려고 하고 한명을 올라가려고 하는데 서로 상대방이 비켜 줄때까지 기다리는 상태를 말합니다.

  ```swift
  DispatchQueue.main.async { } 
  ```

<br>

<br>

### Global

- UI를 제외한 작업에서 사용하며 Concurrent Queue에 해당합니다.

- sync과 async 메서드 모두를 사용 가능합니다

- QoS 클래스를 지정해서 우선 순위를 설정 할수 있습니다.

  ```swift
  DispatchQueue.global().async { }
  DispatchQueue.global(qos: .utility).sync { }
  ```

<br>

<br>

### Main과 Global

- Main과 Globla을 어떻게 배치하냐에 따라서 결과가 다르게 나옵니다.

- UI작업은 Main 큐에 배치하지만 어떠한 동작을 수행하고 난 다음에 UI를 변경해 주고 싶은 상황이 있을수도 있습니다.
  - 그럴때 많은 시간이 걸리는 작업을 Main 큐에 배치한다면 앱이 멈춰있는것처럼 보이기 때문에 해당 작업은 Global 큐로 작업하고 완료가 되면 UI작업을 Main 큐에서 진행하도록 해야 할것입니다.
  - 그럴때는 global 큐 내부에 Main 큐를 사용하겠다고 해서 사용할수 있습니다.
- 아래 실행결과는 4 -> 3 -> 1 -> 2 또는 4 -> 1-> 3 -> 2입니다.
  - 서로 다른 Global 큐에서 동작하고 있기 때문에 어떤게 먼저 끝날지는 정확하게 알기 힘듭니다.
  - 하지만 우선 Global 큐에게 일을 시키고 내려가다가 Main 큐를 만나서 Main큐의 작업을 하고 이후에 Global 큐에서 작업이 끝났다고 알려주게 됩니다. Global큐 내부에 있는 Main 큐는 for문이 종료 된 후에 동작하게 됩니다.

```swift
DispatchQueue.global().async { [weak self] in
    for _ in 0...900_000_000 { _ = 1 + 1 }
    print("1")
    DispatchQueue.main.async {
        self?.testView.frame.origin.y += 250
        self?.view.backgroundColor = UIColor.yellow
        print("2")
    }
}

DispatchQueue.global().async {
    for _ in 0...900_000_000 { _ = 1 + 1 }
    print("3")
}

print("4")
self.testView.frame.origin.y += 250
self.view.backgroundColor = UIColor.yellow
}
```

<br><br>

###  DispatchWorkItem

- 수행할 작업을 캡슐화해서 관리 할때 사용합니다.
- Dispatch Queue에 등록하거나 직접 실행할수도 있습니다.
- 작업 수행 도중 취소가 가능하며, 비동기로 실행한 작업을 동기작업처런 완료 될때까지 대기 하게도 할수 있습니다.

```swift
func dispatchWorkItemExample() {
    var number = 2
    let workItem = DispatchWorkItem {
        number += 3
    }
    // Queue 에 등록하지 않고 직접 실행
    workItem.perform()
    // Queue 에 등록하여 실행
    DispatchQueue.global().async(execute: workItem)
    // 작업이 끝나면 특정 큐에 수행해야 할 작업 지정
    workItem.notify(queue: DispatchQueue.global()) {
        print("number :", number)
    }
}
```

- 조금 더 자세한 예제를 보면 다음과 같습니다.

  - workItem을 반환하는 함수가 있습니다. workItem의 타입은 DispatchWorkItem입니다.
  - 내부 내용은 1부터 2천만까지 카운터를 하면서 25%마다 출력하고 for문이 종료되면 done을 출력합니다.

  ```swift
  private func createDispatchWorkItem() -> DispatchWorkItem {
      let workItem = DispatchWorkItem {
          let bigNumber = 20_000_000
          let divideNumber = 5_000_000
          for i in 1...bigNumber {
              i % divideNumber == 0 ? print(i / divideNumber * 25,
                                            "%") : ()
          }
          print("done")
      }
      return workItem
  }
  ```

  - DispatchWorkItem는 수행할 작업을 캡슐화 해놓았기때문에 DispatchQueue에 넣어서 하용하거나 직접 실행해 줘야 합니다.
    - label의 경우에는 번들아이디와 같이 1개만 존재해야 합니다.

  ```swift
  private func concurrentQueue() {
      let workItem = createDispatchWorkItem()
      let myQueue = DispatchQueue(label: "kr.jhdat.myQueue", attributes: .concurrent)
      
      myQueue.sync(execute: workItem) 
      print("before waiting")
      print("after waiting")
  }
  
  // 실행결과
  25 %
  50 %
  75 %
  100 %
  done
  before waiting
  after waiting
  ```

  - 같은 큐는 async(비동기)로 작업해 봤습니다.
  - 비동기 작업이기 때문에 우선 아래 있는 print를 출력하고 계산이 종료되면 DispatchWorkItem 내부에 있는 print를 출력합니다.

  ```swift
  private func concurrentQueue() {
      let workItem = createDispatchWorkItem()
      let myQueue = DispatchQueue(label: "kr.jhdat.myQueue", attributes: .concurrent) 
  	myQueue.async(execute: workItem)
  
      print("before waiting")
      print("after waiting")
  }
  
  // 실행결과
  before waiting
  after waiting
  25 %
  50 %
  75 %
  100 %
  done
  ```

  - 추가로 .wait() 메서드를 사용하면 async(비동기)가 종료될때까지 기다려 줍니다.

  ```swift
  private func concurrentQueue() {
      let workItem = createDispatchWorkItem()
      let myQueue = DispatchQueue(label: "kr.jhdat.myQueue", attributes: .concurrent) 
  	myQueue.async(execute: workItem)
  
      print("before waiting")
      workItem.wait()
      print("after waiting")
  }
  
  // 실행결과
  before waiting
  25 %
  50 %
  75 %
  100 %
  done
  after waiting
  ```

<br>

<br>

## DispatchQueue.Attributes 

- .concurrent - Concurrent Queue 생성 (Global Queue)하며 옵션을 미 지정시 기본적으로 Serial Queue로 생성됩니다
- .initiallyInactive 작업을 수행하고 싶은 시점에 별도로 activate() 메서드를 사용해서 호출하도록 설정합니다.

```swift
let myQueue = DispatchQueue(label: "kr.jhdat.myQueue", attributes: .concurrent)

let myQueue = DispatchQueue(label: "kr.myQueue.Init", attributes: .initiallyInactive)
myQueue.activate()		// 실행하고 싶은 시점에 넣으면 됩니다.
```



​	