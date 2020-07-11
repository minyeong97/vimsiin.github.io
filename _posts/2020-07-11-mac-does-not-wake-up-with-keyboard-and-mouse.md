---
layout: post
title: mac does not wake up with keyboard and mouse
categories: []
---

맥북을 처음 구매했는데 처음부터 자잘한 문제들이 봉착했다. 첫 번째 문제는 컴퓨터가 오랜 시간 idle해서 sleep으로 되었을 때 컴퓨터 전원 버튼 외에는 그 컴퓨터를 깨울 방법이 없던 것이었다. 이것이 나에게 큰 문제였던 이유는 external monitor를 사용했기 때문에 맥북이 항상 닫혀 있어 전원 버튼에 접근을 하지 못했기 때문이다. 그래서 이것은 큰 문제였다.

결과적으로 이 행동방식은 정상적인 행동이 아니었다. 이는 애플 코리아 직원에게 확인받은 것이다. 맥북에서는 기존 메인 메모리에 존재하는 데이터를 안전하게 디스크에 옮겨 놓는 `safe sleep`이라는 모드가 전원 버튼 외에는 다시 구동시킬 방법이 없다고 하지만, 이는 해당 사항이 없었다. 맥북에 어떤 곳에도 `safe sleep`에 관한 설정이 존재하지 않기 때문이다. 이는 오직 애플 홈페이지에만 존재했다. 

이를 해결하기 위해서는 우선 컴퓨터를 꺼야 한다. 그 이후 전원버튼을 10초 이상 길게 누른다. 애플 로고가 뜨면서 부팅을 할 것 같으면서 다시 검은색 화면이 뜨면 성공한 것이다. 이 상태에서 전원버튼을 눌렀다 떼서 부팅을 시작한 직후 바로 `option + command + R + P` 라는 괴상한 조합을 20초 이상 누르면(생각보다 길다) 처음에 애플로고가 뜨고 사라지며, 검은색 화면이 오래 지속된다. 이 때 그 괴상한 키 조합을 뗴지 않고 애플로고가 다시 나올 때까지 누르고 있어야 한다. 이를 활용하면 `sleep`문제가 해결된다.