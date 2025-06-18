## ✨ 서비스 설명
![image](https://github.com/user-attachments/assets/0247ee41-69df-427e-b571-c331129ee096)
![image](https://github.com/user-attachments/assets/062212fc-b707-4b2d-b4db-2b96361048dc)
![image](https://github.com/user-attachments/assets/0ba3025e-5709-45a0-93f8-41a2d571aa97)
![image](https://github.com/user-attachments/assets/361029b3-add6-46d2-a5ee-3e4b31210807)
![image](https://github.com/user-attachments/assets/f26194fe-e7a5-47f8-88f8-0ce78e7eeedb)


## 💬 코드 설명

### 📁 `cell`

화면에 보여지는 다양한 셀들을 모아놓은 폴더입니다.

* **ChatBubbleCell.swift**: 채팅 메시지를 말풍선 형태로 보여주는 셀입니다.
* **GuideCell.swift / GuideCollectionViewCell.swift**: 가이드를 보여줄 때 사용하는 셀입니다.
* **MemberCell.swift**: 멤버 정보를 보여주는 셀입니다.
* **SituationCell.swift**: 상황 정보를 담는 셀입니다.
* **TendencyCell.swift**: 성향을 표현할 때 사용하는 셀입니다.

---

### 📁 `layout`

컬렉션뷰 셀 배치 방식을 커스터마이징한 파일들이 들어 있습니다.

* **MemberCollectionViewFlowLayout.swift**: 멤버 셀 가로 스크롤 레이아웃
* **SituationCollectionViewFlowLayout.swift**: 상황 셀 가로 스크롤 레이아웃
* **TendencyCollectionViewFlowLayout.swift**: 성향 선택 셀 가로 스크롤 레이아웃

---

### 📁 `model`

앱에서 쓰이는 데이터 모델을 정의한 파일들입니다.

* **Guide.swift**: 상황에 따른 가이드 정보를 담는 모델
* **Member.swift**: 캐릭터(멤버)의 기본 정보 모델
* **Message.swift**: 채팅 메시지 구조를 정의
* **Situation.swift**: 상황(시나리오)에 대한 데이터 구조
* **User.swift**: 유저(나)의 정보 모델

---

### 📁 `service`

Firestore 또는 외부 API와 통신할 때 쓰는 로직들입니다.

* **GuideService.swift**: 가이드 관련 Firestore 작업
* **MemberService.swift**: 멤버 관련 Firestore 작업
* **OpenAIService.swift**: OpenAI API와 연결하는 기능
* **SituationService.swift**: 상황 관련 Firestore 기능
* **UserService.swift**: 사용자 정보 저장/불러오기

---

### 📁 `test`

개발 중 테스트용 코드들이 들어있는 공간입니다.

* **DataAddTest.swift**: 샘플 데이터를 Firestore에 넣을 때 사용

---

### 📁 `util`

공통적으로 자주 쓰이는 기능들을 정리한 유틸 파일들입니다.

* **KeyManager.swift**: 키 값 불러오는 코드
* **UIColor.swift**: 색상 hex 코드로 초기화할 수 있도록 도와주는 확장

---

### 📁 `viewController`

각 화면을 구성하는 뷰컨트롤러 모음입니다.

* **AddMemberViewController.swift**: 새로운 멤버를 추가할 때 쓰는 화면
* **ChatPrefaceViewController.swift**: 채팅 시작 전에 설정 입력받는 모달
* **ChatViewController.swift**: 실제로 채팅이 이루어지는 메인 채팅창
* **GuideListViewController.swift**: 상황에 맞는 가이드들을 리스트로 보여주는 화면
* **HomeViewController.swift**: 앱 첫 홈 화면
* **LogInViewController.swift**: 로그인 화면
* **MemberSettingViewController.swift**: 멤버 선택 및 추가 화면
* **MyPageViewController.swift**: 마이페이지
* **SignUpViewController.swift**: 회원가입 화면
* **SituationViewController.swift**: 상황을 고르는 화면
* **StartViewController.swift**: 앱을 처음 실행했을 때 나오는 시작 화면

---

### 📄 `AppDelegate.swift`
앱 실행 시 초기 설정을 담당하며, Firebase 초기화도 여기서 이루어집니다.


## 🌈 시연 영상
https://youtu.be/FClXDosum94
<br><br>

## 🔀 Git 브랜치 전략

이 프로젝트는 **혼자서 개발**하는 개인 프로젝트이기에, 아래와 같은 이유로 별도의 브랜치를 나누지 않고 `main` 브랜치에서 바로 작업을 진행했습니다.

1. 병합(Pull Request) 리뷰 과정이 불필요하기 때문에 단순한 흐름 유지가 효율적이라고 판단
2. 작업 컨텍스트(branch) 전환 최소화로 생산성 유지
3. 대신, 필요 시 커밋 단위로 되돌릴 수 있도록 커밋 메시지를 명확하게 관리

협업이 아니라면 복잡한 Git flow 보다는 **일관된 커밋 컨벤션과 깔끔한 히스토리 관리**가 더 중요하다고 판단했습니다.

<br><br>


## 🎮 Git 커밋 컨벤션

| 태그         | 의미                   | 예시 커밋 메시지                   |
| ---------- | -------------------- | --------------------------- |
| `feat`     | 새로운 기능 추가            | `feat: 로그인 기능 구현`           |
| `fix`      | 버그 수정                | `fix: 유저 생성 시 발생하던 오류 해결`   |
| `chore`    | 빌드, 설정 등 잡무          | `chore: Firebase 설정 파일 추가`  |
| `docs`     | 문서 수정                | `docs: README 사용법 추가`       |
| `style`    | 코드 스타일 수정 (기능 변화 없음) | `style: 들여쓰기 및 공백 정리`       |
| `refactor` | 코드 리팩토링 (기능 변화 없음)   | `refactor: 중복 로직 함수로 분리`    |
| `test`     | 테스트 코드 추가/수정         | `test: 유닛 테스트 케이스 작성`       |
| `build`    | 배포 관련 설정 변경          | `build: 배포용 Firebase 설정 추가` |

> 💡 커밋 메시지는 `이모지 + 태그: 내용` 형태로 작성합니다. 예: `💾 feat: 사용자 정보 저장 기능 구현`

<br><br>
