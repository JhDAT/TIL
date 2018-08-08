# 프로토콜 - Protocol

- 특정 역할을 수행하기 위한 method, property, 기타 요구사항의 청사진을 정의할수 있습니다.
  - 청사진 : 미래에 대한 계획
- Struct, class, enum형은 프로토콜을 채택(Adopted) 해서 특정 기능을 수행하기 위해 계획해놓은 프로토콜의 요구사항을 실제로 구현할 수 있습니다.
- 어떤 프로토콜의 요구사항은 모두 따르는 타입은 프로토콜을 준수한다(conform)이라고 표현하기도 합니다.
- 타입에서 프로토콜의 요구사항을 충족시키려면 프로토콜이 제시하는 청사진의 기능을 모두 구현해야 합니다.
- 프로토콜은 기능을 정의하고 제시 할 뿐 스스로 기능을 구현하지는 않습니다.

<br>

<br>

## 문법

```swift
protocol 프로토콜 이름 {
    /* 구현부 */
}
```

<br>

<br>

## 구현

- 구현부에서는 프로토콜이 제시할 청사진에 대한 요구사항(?)을 정의합니다.
- property를 요구할때는 var 키워드를 사용합니다.
- `{ get }` 은 읽기만 가능해도 상관없다는 뜻입니다.
- `{ get set }` 은 읽기와 쓰기가 모두 가능한 프로퍼티입니다.
- `func talk()` 를 사용해서 method를 요구하거나 `init()` 을 사용해서 이니셜라이저를 요구할 수도 있습니다.

```swift
protocol Talkable {
    var topic: String { get set }
    var longuage: String { get }
    
    func talk()
    
    init(topic: String, language: String)
}
```

<br>

<br>

## 사용 - 채택 및 준수

- 구조체 Person은 Talkable protocol을 채택하였습니다.
- 
- 프로퍼티가 요구한 mehtod 및 이니셜라이저의 요구도 준수합니다.

```swift
struct Person: Talkable {
    var topic: String
    let language: String	// get을 적어줬기에 기본적으로 let을 사용할 수 있습니다. set 까지 사용할때는 var로 해야 합니다.

    func talk() {
        print("\(topic)에 대해 \(language)로 말합니다")
    }

    init(topic: String, language: String) {
        self.topic = topic
        self.language = language
    }
}
```

- 읽기전용 프로퍼티 language 요구는 연산 프로퍼티로 대체가 가능합니다.
  - `{ return "한국어"}` 와 `{ get { return "한국어"}}`  는 같은 표현입니다.
  - 연산프로퍼티는 gettet, setter를 말합니다.
- 읽기, 쓰기가 가능한 프로퍼티도 연산 프로퍼티로 대체가 가능합니다.

```swift
struct Person: Talkable {    
    var language: String { return "한국어" }
// var language: String { get{return "한국어"} }
    
    var topic: String {
        set {
            self.subject = newValue
        }
        get {
            return self.subject
        }
    }
}
```

<br>

<br>

## 상속

- 프로토콜은 하나 이상의 프로토콜을 상속 받아 기존의 프로토콜의 요구 사항보다 더 많은 요구사항은 추가할 수 있습니다.
- 프로토콜 상속 문법은 클래스의 상속 문법과 유사하지만, 프로토콜은 클래스와 다르게 다중상속이 가능합니다.

<br>

### 상속 - 문법

```swift
protocol 프로토콜 이름: 부모 프로토콜 이름 목록 {
 /* 정의부 */
 }
```

<br>

<br>

### 구현

- 프로토콜 기본적인 구현입니다.

```swift
protocol Readable {
    func read()
}
protocol Writeable {
    func write()
}
```

- 상속받아 추가로 method를 요구할수 있습니다.

```swift
protocol ReadSpeakable: Readable {
    func speak()
}
```

- 클래스와는 다르게 다중상속이 가능하기 때문에 상속 받은 기능도 사용하고 새로운 기능도 만들수 있습니다.

```swift
protocol ReadWriteSpeakable: Readable, Writeable {
    func speak()
}

struct SomeType: ReadWriteSpeakable {
    func read() {
        print("Read")
    }
    func write() {
        print("Write")
    }
    func speak() {
        print("Speak")
    }
}
```

<br>

<br>

### 구현 - 클래스와 프로토콜

- 클래스에서 상속과 프로토콜 채택을 동시에 하려면 상속받으려하는 클래스를 명시하고 그 뒤에 채택할 프로토콜 목록을 작성하면 됩니다.

```swift
class SuperClass: Readable {
    func read() { }
}

class SubClass: SuperClass, Writeable, ReadSpeakable {
    func write() { }
    func speak() { }
}
```

<br>

<br>

## 프로토콜 준수 확인

- is 연산자를 사용하거나 as 연산자를 사용해서 타입캐스팅을 사용해 특정 프로토콜을 준수하는지를 확인할 수 있습니다.

- 다음과 같은 프로토콜이 있습니다.

```swift
protocol Readable {
    func read()
}
protocol Writeable {
    func write()
}

protocol ReadSpeakable: Readable {
    func speak()
}

protocol ReadWriteSpeakable: Readable, Writeable {
    func speak()
}
```

- SuperClass는 Readble이라는 프로토콜을 준수합니다.
- SubClass는 SuperClass를 상속받고 Writeable, ReadSpeakable 프로토콜을 준수합니다.

```swift
class SuperClass: Readable {
    func read() { }
}

class SubClass: SuperClass, Writeable, ReadSpeakable {
    func write() { }
    func speak() { }
}

let sup: SuperClass = SuperClass()

let sub: SubClass = SubClass()
```

- is 연산자를 사용해서 인스턴스가 특정 프로토콜을 준수하는지를 Bool값으로 확인 가능합니다.
- 인스턴스 `sup` 은 Readable 프로토콜을 준수하기 때문에 is ReadSpeakable를 하면 false를 반환합니다.
- 인스턴스 `sub` 은 SuperClass를 상속받고 Writeable, ReadSpeakable 프로토콜을 준수하기 때문에 모든 is에 대해서 true를 반환합니다.

```swift
var someAny: Any = sup
someAny is Readable // true
someAny is ReadSpeakable // false

someAny = sub
someAny is Readable // true
someAny is ReadSpeakable // true
```

- as 연산자를 사용해서 인스턴스가 특정 프로토콜을 준수하는지를 Bool값으로 확인 가능합니다.
- 만약 해당 프로퍼티를 준수한다면 캐스팅을 성공하게 되면서 사용이 가능하고 프로퍼티를 따르고 있지 않다면 캐스팅에 실피하면서 해당 구문이 동작하지 않습니다.

```swift

let sup: SuperClass = SuperClass()
let sub: SubClass = SubClass()

var someAny: Any = sup
someAny = sub
someAny = sup

if let someReadable: Readable = someAny as? Readable {
    someReadable.read()
} // read

if let someReadSpeakable: ReadSpeakable = someAny as? ReadSpeakable {
    someReadSpeakable.speak()
} // 동작하지 않음

someAny = sub

if let someReadable: Readable = someAny as? Readable {
    someReadable.read()
} // read
```

<br>

<br>

- 프로토콜은 사용자의 입장에서 어떤 기능들을 사용할수 있는지를 좀 더 명확하게 알수 있게 해주게 됩니다. 이는 컴파일러도 같습니다. (어떤 기능들을 가지고 있는지를 미리 알게 됩니다.)
- POP와 관련해서 추가적으로 공부를 해봐도 좋을것 같습니다.