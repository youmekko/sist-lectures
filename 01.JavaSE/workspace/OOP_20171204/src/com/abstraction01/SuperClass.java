package com.abstraction01;

//부모 역할 클래스
public abstract class SuperClass {
	
	//추상화
	/*
	
	- 추상(抽象)의 사전적 의미:여러 가지 사물이나 개념에서 공통되는 특성이나 속성 따위를 추출하여 파악하는 작용. 
	- 예를 들어, '남자', '여자'라는 표현에서 공통적인 특성을 가지고 표현한다면 '사람'이라고 표현 가능.
	- 추상화 과정에서 추상은 구체적인 표현보다는 개념적인 표현을 사용한다.
	- 구체적 구현 전에 개념적 표현부터 정의할때 추상화 사용.
	- 추상화 구현은 일부만 구현한 경우 추상클래스(abstract class), 전체적으로 구현한 경우 인터페이스(interface)로 구현.
	
	*/
	
	//추상 클래스(abstract class)
	/*
	
	- 클래스는 필드, 메소드(생성자, getter, setter 포함)로 구성된다.
	- 메소드 중에 abstract 키워드를 붙인 추상 메소드가 있다면 클래스는 추상 클래스여야 한다.
	- 추상 메소드는 메소드 시그니처만 존재하고 구현 내용(코드 블럭 전체)이 없다. 메소드에 대한 구현은 자식 클래스에 정의해야 한다. 오버라이딩(Overriding) 의무사항.
	- 예를 들어, Cat 클래스와 Dog 클래스가 있다면, 둘 다 bark() 메소드가 존재한다. Cat은 '야옹'이라고 액션을 취해야 하고, Dog는 '멍멍'이라고 액션을 취해야 한다. Animal 추상 클래스에서 bark() 메소드는 추상 메소드로 선언한다.
	- 형식
	public abstract class 클래스명 {
		
		//필드
		//메소드
		
		//메소드중 일부가 추상 메소드
		public abstract 반환자료형 메소드이름(매개변수 리스트);
		
	}
	- 주의) 자기 자신을 가지고 객체 생성 불가. 자식 클래스에 대한 부모 클래스 역할만 한다.
	- 주의) (추상) 메소드 자신을 직접 호출할 수 없다. 자식 객체(instance)를 통해서 접근 가능.
	- 자바에서 제공하는 대표적인 추상 클래스는 Number 클래스이다. intValue(), doubleValue() 메소드 등이 추상 메소드로 등록되어 있다.
	
	
	*/
	
	//일반 메소드
	public void method1() {
		System.out.println("SuperClass의 method1()");
	}
	
	//추상 메소드
	public abstract void method2();

}
