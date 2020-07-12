---
layout: post
title: how to crawl image from site using selenium and urllib
categories: []
---

selenium을 사용해서 다양한 정보를 긁어올 수 있다. 텍스트 같은 경우에는 해당 `element`를 가져온 다음에 그것에 `text` 등의 attribute를 접근하면 가능하다. 그런데 이미지 같은 경우에는 다른 방법을 사용하는 것이 좋다. 이를 사용하기 위해서는 `urllib`이라는 라이브러리를 만드는 것이다. 이 사용방법은 다음과 같다. 다나와의 한 제품 이미지를 가지고 시험해보았다.

```python
if __name__ == '__main__':
    import urllib.request
    from selenium import webdriver

    options = webdriver.ChromeOptions()
    options.add_argument('--headless')
    options.add_argument('--no-sandbox')
    options.add_argument('--disable-dev-shm-usage')

    driver = webdriver.Chrome('/home/vimsiin/chromedriver', options=options)
    driver.get('http://prod.danawa.com/info/?pcode=10753032&keyword=x-t4&cate=12337485')

    img = driver.find_elements_by_xpath("//img[@id='baseImage']")
    src = img[0].get_attribute('src')

    urllib.request.urlretrieve(src, 'test.jpg')

    driver.close()
```

이것을 하다가 403 http 에러가 날 수도 있다. 이 에러는 서버가 요청 사항을 잘 알아 들었지만, 요청 사항을 들어줄 수 없다고 명시하는 경우이다. 이 경우는 대부분 서버가 파이썬 스크립트의 정체를 알아채리고, 요청을 거절하는 경우가 많다. 이를 위해서는 간단히 header를 바꾸어주면 된다. 현재 사용하는 urllib의 urlretrieve함수를 사용하는 것으로는 header를 바꿀 수 없기 때문에 URLopener라는 함수를 사용해야 한다. 이 함수는 그러나 오래되었고, 지원이 중단되었기 때문에 사용시 주의해야 한다. 나는 다만 원하는 작업을 해치워주었기 때문에 그런 단점에도 불구하고 사용하는 중이다.

```python
	...
    src = img[0].get_attribute('src')
    opener = urllib.request.URLopener()
    opener.addheader('User-Agent', 'chrome')
    opener.retrieve(src, 'img/'+str(count)+'.jpg')
```
