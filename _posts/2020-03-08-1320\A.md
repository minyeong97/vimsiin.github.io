---
layout: post
title: 1320\A
categories: [codeforce]
---

[problem](https://codeforces.com/contest/1320/problem/A)

첫 시도

```c++
#include <iostream>

int find_max(int *arr, int start, int size) {
	int max = 0;
	int temp;

	if (start + 1 == size) return arr[start];

	for (int i = start + 1; i < size; i++) {
		if (arr[i] - arr[start] == i - start) {
			temp = find_max(arr, i, size);
			if (max < temp) max = temp;
		}
	}

	return max + arr[start];
}

int service(int *arr, int size) {
	int max = find_max(arr, 0, size);
	int temp;

	for (int i = 1; i < size; i++) {
		temp = find_max(arr, i, size);
		if (max < temp)
				max = temp;
	}

	return max;
}

int main(void) {
	int n;
	std::cin >> n;

	int *beauty = new int[n];

	for (int i = 0; i < n; i++)
		std::cin >> beauty[i]; 

	std::cout << service(beauty, n);

	return 0;
}
```

아이디어: 우선 주어진 배열의 첫 번째 원소에서 시작하여 조건에 맞는 합을 추산하는 함수를 `get_max`라고 하자. 그런데 첫 번째 원소부터 시작하지 않을 수 도 있기 때문에 모든 위치에서 시작하는 것을 고려해야 한다. 그것을 해주는 함수가 `service`이다.

`get_max`함수에서는 우선 첫 번째 원소부터 시작한다고 가정하고 그로부터 모든 원소까지의 조건을 체크하면서 자기 자신을 `recursive`하게 부른다.

시간 복잡도 분석: 개똥마이다. 우선 최악의 경우를 생각해보자. 모든 원소가 `increment`하여 배열의 모든 `substring`이 조건에 부합하다고 하자. 그러면 `service`함수에서 총 `n`번을 돌려야 하고, 한 번 돌릴 때마다 `get_max` 함수를 호출한다. `get_max`함수는 총 `n`번 검사하는데 그럴 때마다 다시 `get_max`를 호출한다. 이것의 복잡도를 구하기 위해선 다음 식을 풀면된다.

```
g(n) = g(n-1) + g(n-2) + g(n-3) + ... + g(1) +k
```

이 식을 푸는 방법은 g(n-1)을 위와 같은 식으로 교체하고, 이를 반복하면 된다. 그러면 결국 `g(n)=2^n`이라는 결론을 얻게 된다. 개똥망

그러면 어떻게 해야 하는가. 다음과 같은 것을 생각했다.

```
bi-bj = i - j
bi - i = bj - j
```

이므로 결국 이 값들이 모두 같은 것들을 찾으면 된다. 

```
#include <iostream>

int main(void) {

	int n;
	std::cin >> n;

	int *beauty = new int[n];

	for (int i = 0; i < n; i++)
		std::cin >> beauty[i]; 

	// O(n)
	int min = beauty[0];
	int max = beauty[0];
	for (int i = 1; i < n; i++) {
		if (min > beauty[i] - i)
			min = beauty[i] - i;
		if (max < beauty[i] - i)
			max = beauty[i] - i;
	}


	int size = max - min + 1;
	int *res = new int[size];
	
	for (int i = 0; i < size; i++)
		res[i] = 0;

	for (int i = 0; i < n; i++)
		res[beauty[i] - i - min] += beauty[i];
	
	int max_res = res[0];
	for (int i = 1; i < size; i++) {
		if (max_res < res[i])
			max_res = res[i];
	}


	std::cout << max_res;

	delete[] res;
	delete[] beauty;

	return 0;
}
```

아이디어: 배열들을 모두 순회하여 `bi-i`값의 최대값과 최소값을 구한다.(O(n)) 그런 다음 최소값과 최대값을 참고하여 결과를 넣을 배열을 생성한다. 그런 다음 배열을 순회하면서 각 값에 해당하는 `index`들을 `offset`으로 바꾸고 그것에 해당하는 값을 배열에 추가한다.(O(n)) 그리고 다시 배열을 순회하면서 최대값을 찾는다. (O(n))

이렇게 돌렸는데도 7번째 샘플에서 실패했다. 이유는 다음과 같다.

숫자 크기 때문이다. 들어오는 배열의 크기는 2*10^5, 최대값은 4*10^5. 일반 `int`가 담을 수 있는 크기는 32767 까지 밖에 안된다. `unsigned int`도 65535까지밖에 표현이 안되므로, 더 큰것을 써야 한다. `long int`는 21억까지 표현할 수 있으므로 이것을 써야 한다.


