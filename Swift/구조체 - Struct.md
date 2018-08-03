# 구조체 - Struct

- 구조체는 클래스와 거의 동일하게 동작하지만 가장 큰 차이점이 타입에 있습니다.
- 구조체(Struct)는 value 타입 / 클래스(class)는 reference 타입
- 타입의 이름은 대문자 카멜케이스를 사용해서 정의합니다.

<br>

## 문법

```swift
struct 이름 { /* 구현부 */}
```

<br>

<br>

## Struct Property / method

```swift
struct Sample {
    var mutableProperty: Int = 100
    let immutableProperty: Int = 100
    
    // static 키워드를 사용하면 타입 자체가 사용하는 프로퍼티가 됩니다.
    static var typeProperty: Int = 100
    
    // 인스턴스가 사용하는 메서드입니다.
    func instanceMethod() {
        print("instance method")
    }
    
    // 타입 자체가 사용하는 메서드입니다.
    static func typeMethod() {
        print("type method")
    }
}
```

<br>

<br>

## Struct 사용

- class와는 다르게 value타입으로 사용할때마다 값이 복사가 됩니다.
- 타입 메서드는 타입 자체가 사용하는 메서드입니다. 
- 인스턴스 메서드는 인스턴스로 생성 후 사용합니다.
- `let` `var` 로 가변, 불변 인스턴스를 생성가능하며 `let` 사용시 property 값을 변경할 수 없습니다.

```swift
struct Student {
    var name: String = "unknown"
    var 'class': String = "Swift"
    
    // 타입 메서드
    static func selfIntroduce() {
        print("학생타입입니다.")
    }
    
    // 인스턴스 메서드
    func selfIntroduce() {
        print("저는 \(self.class)반 \(name)입니다.")
    }
}

// 타입 메서드 사용
Strudent.selfIntroduce()

// 가변 인스턴스 생성
var jhdat: Student = Student()
jhdat.name = "JhDAT"
jhdat.class = "swift"
jhdat.selfIntroduce() // 저는 swift반 JhDAT입니다.

// 불변 인스턴스 생성
let jin: Student = Student()
//jin.name = "JhDAT"	// 컴파일 오류 발생

jin.selfIntroduce()	// 저는 Swift반 unknown입니다.
```

