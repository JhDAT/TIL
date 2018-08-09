# 익스텐션 - extension

- 구조체, 클래스, 열거형, 프로토콜 타입에 새로운 기능을 추가 할 수 있는 기능입니다.
- 기능을 추가하려는 타입의 구현된 소스 코드를 알지 못하거나 볼 수 없다해도, 타입만 알고 있다면 그 타입의 기능을 확장할 수 있습니다.

<br>

- Swift에서 Extension이 타입에 추가 할 수 있는 기능
  - 연산 타입 프로퍼티 / 연산 인스턴스 프로퍼티
  - 타입 메서드 / 인스턴스 메서드
  - 이니셜라이저
  - 서브스크립트
  - 중첩 타입
  - 특정 프로토콜을 준수할 수 있도록 기능 추가
- 익스텐션은 타입에 새로운 기능을 추가할 수는 있지만, 기존에 존재하는 기능을 재정의할 수는 없습니다.

## 문법

```swift
extension 확장할 타입 이름 {
    /* 타입에 추가될 새로운 기능 구현 */
}
```

- 기본 문법외에 기존에 존재하는 타입이 추가적으로 다른 프로토콜을 채택할 수 있도록 확장하는 역할에도 사용됩니다.

```swift
extension 확장할 타입 이름: 프로토콜1, 프로토콜2, 프로토콜3... {
    /* 프로토콜 요구사항 구현 */
}
```

<br>

<br>

## 구현

### 연산프로퍼티 추가

- extension을 사용해서 Int 타입에 두 개의 연산 프로퍼티를 추가한 예제입니다.
- Int 타입의 인스턴스가 홀수인지 짝수인지 판별하여 Bool타입으로 알려주는 연산프로퍼티입니다.
- Extension으로 Int 타입에 추가해준 연산 프로퍼티는 Int 타입의 어떤 인스턴스에도 사용이 가능합니다.
- 인스턴스 연산 프로퍼티를 추가할 수도 있으며 static 키워드를 사용하여 타입 연산 프로퍼티도 추가할 수 있습니다.

<br>

- `isEven` 은 짝수를 `isOdd` 는 홀수는 확인해서 Bool값을 반환합니다.

```swift
extension Int {
    var isEven: Bool {
        return self % 2 == 0
    }
    var isOdd: Bool {
        return self % 2 == 1
    }
}

print(1.isEven) // false
print(2.isEven) // true
print(1.isOdd)  // true
print(2.isOdd)  // false

var number: Int = 3
print(number.isEven) // false
print(number.isOdd) // true

number = 2
print(number.isEven) // true
print(number.isOdd) // false
```

<br>

<br>

### 메서드 추가

- 메서드 익스텐션을 통해서 Int 타입에 인스턴스 메서드인multiply(by:) 메서드를 추가했습니다.

```swift
extension Int {
    func multiply(by n: Int) -> Int {
        return self * n
    }
}

print(3.multiply(by: 2))  // 6
print(4.multiply(by: 5))  // 20

number = 3
print(number.multiply(by: 2))   // 6
print(number.multiply(by: 3))   // 9
```

<br>

<br>

### 이니셜라이저 추가

- 인스턴스를 초기화(이니셜라이즈)할 때 인스턴스 초기화에 필요한 다양한 데이터를 전달받을 수 있도록 여러 종류의 이니셜 라이저를 만들수 있습니다.
- 타입의 정의부에 이니셜라이저를 추가하지 않더라도 익스텐션을 통해 이니셜라이저를 추가할 수 있습니다.
- 익스텐션으로 클래스 타입에 편의 이니셜라이저는 추가할 수 있지만, 지정 이니셜라이저는 추가할 수 없습니다. 지정 이니셜라이저와 디이니셜라이저는 반드시 클래스 타입의 구현부에 위치해야 합니다.
  - 지정 이니셜라이저는 `init` 를 말합니다.
    - 모든 클래스는 하나 이상의 지정 이니셜라이저를 가져야 하머 초기화 과정의 연쇄를 슈퍼클래스로 진행합니다.
  - 편의 이니셜라이저는 `convenience init` 를 말합니다.
    - 특정 쓰임새나 입력 값 타입을 위한 클래스의 인스턴스를 생성하기 위해 사용되는 경우가 있습니다.

```swift
extension String {
    init(int: Int) {
        self = "\(int)"
    }
    
    init(double: Double){
        self = "\(double)"
    }
}

let stringFromInt: String = String(int: 100) 
// "100"

let stringFromDouble: String = String(double: 100.0)    
// "100.0"
```



