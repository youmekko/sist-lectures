package com.bank009;

import java.util.Scanner;

//(콘솔)서비스 관리 클래스
public class AccountService {

	//(콘솔)서비스 관련 필드, 액션 메소드 구성
	//instance variable
	private AccountDAO dao = new AccountDAO();
	
	//계좌생성하기 메소드
	//->클래스(객체) 외부에서 접근 가능한 메소드 선언은 public 접근제한자
	public void createAccount(Scanner sc) {
		
		//외부 입력->계좌번호, 계좌주, 초기입금액
		//계좌 생성(Account 객체 생성) 및 (배열)저장소에 저장 -> 메소드 호출로 대체
		//메시지 출력
		
		//next() - 한 단어 단위 입력. 공백 기준으로 단어 구분. nextLine() 메소드와 혼용시 줄바꿈 문자 처리 필요.
		//nextLine() - 한 문장 단위 입력. 
		
		System.out.println("------------");
		System.out.println("계좌 생성");
		System.out.println("------------");
		System.out.print("계좌번호:");
		String ano = sc.next();
		System.out.print("계좌주:");
		String owner = sc.next();
		System.out.print("초기입금액:");
		int balance = sc.nextInt();

		//계좌 객체 생성 및 (배열)저장소 저장
		//->AccountDAO 클래스의 createAccount() 인스턴스 메소드 호출로 대체
		//->메소드 시그니처 분석
		//->public void createAccount(String ano, String owner, int balance)
		this.dao.createAccount(ano, owner, balance);
		
		
		System.out.println("결과:계좌가 생성되었습니다.");
	}
	
	
	// 계좌 목록보기 메소드
	public void accountList() {

		System.out.println("-----------");
		System.out.println("계좌목록");
		System.out.println("-----------");
		System.out.println(this.dao.accountList());

	}
	
	
	// 예금하기 메소드
	public void deposit(Scanner sc) {
		System.out.println("-----------");
		System.out.println("예금");
		System.out.println("-----------");

		System.out.print("계좌번호: ");
		String ano = sc.next();

		System.out.print("예금액: ");
		int balance = sc.nextInt();

		this.dao.deposit(ano, balance);

		System.out.println("결과: 예금이 성공되었습니다.");
	}
	
	
	// 출금하기 메소드
	public void withdraw(Scanner sc) {
		System.out.println("-----------");
		System.out.println("출금");
		System.out.println("-----------");

		System.out.print("계좌번호: ");
		String ano = sc.next();

		System.out.print("출금액: ");
		int balance = sc.nextInt();

		this.dao.withdraw(ano, balance);

		System.out.println("결과: 출금이 성공되었습니다.");
	}
	
}
