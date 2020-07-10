---
layout: post
title: Json file format
categories: [django]
---

## Json file

Json file 이란: JavaScript Object Notation 으로 Javascript 에서 사용하는 데이터 구조이다.

Json은 다음과 같이 recursive 하게 정의된 Object로 정의할 수 있다.

> Json 데이터는 ""(double quotes, 큰 따옴표)로 둘러싸여 있거나 숫자 데이터나 object 또는 object 들의 리스트로 이루어져 있다.
> object는 {} (curly braces, 중괄호) 로 둘러싸여 있어야 하고, 안에는 ""(double quotes, 큰 따옴표) 로 써 있는 이름과 그에 대응하는 Json 데이터로 이루어져 있다. 

다음과 같은 Json 데이터는 잘못되었다 어디가 잘못되었을까?

```json
{
	{
		"name":"minyeongchung",
		"age":40
	}
}
```

object는 {}(curly braces, 중괄호) 안에 대응 관계가 있어야 한다.

```json
{
	"data":{
		"name":"minyeongchung",
		"age":40
	}
}
```

아니면 리스트로 나타내면 된다.
	
```json
[
	{
		"name":"minyeongchung",
		"age":40
	}
]
```

