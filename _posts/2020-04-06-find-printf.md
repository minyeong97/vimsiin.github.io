---
layout: post
title: find printf
categories: [linux]
---

`printf` 함수가 어떻게 작동되는지 궁금해서 뒤져보았다.

분명 이 함수의 선언은 <stdio.h>에 있는 것이 분명하다. 

```
locate stdio.h
```
를 해보면 실제 위치가 나오게 된다. 그런데 이것은 선언만 존재하는 것이기 때문에 실제 구현을 살펴야 한다.

구현을 살펴보기 위해서 리눅스 소스 코드를 다운 받으면 되는 줄 알았다.

그래서 리누스 토르발스의 깃헙 페이지에 있는 리눅스를 다운 받았다.

거기에서 printf의 정의를 찾아보려고 했다.


그래서 찾아보니까 이 유틸리티들은 운영체제와 또 다른 부분이라는 것을 깨달았다. 그 함수들이 운영체제의 일부분에 관여하지 몰라도 운영체제의 필수 부분은 아닐 수도 있다는 생각이 들었다. 

계속 검색을 한 결과 gnu에서 구현한 clib라는 것이 있다는 것을 알아냈다. 그곳 [홈페이지](https://www.gnu.org/software/libc/)에서 가장 최근 버전을 다운 받았다. 즉 `clib`의 최신버전이다. 그것을 다운 받고 그곳에서 `cscope -R`을 했는데 다음과 같은 결과를 얻었다.

```
__fortify_function int
printf(const char *__restrict __fmt, ...)
{
	return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
}
```

이렇게 되어 있다.

궁금한 것이 생겼는데, int 앞에 붙는 `__fortify_function`은 도대체 어떤 문법인가? 그리고 `const char *__restrict __fmt`부분도 이해가 안되는 문법이다.

잘 모르겠지만 우선 넘어갔다. 그래서 저기에서 호출한 함수로 가보았다.

```
int
attribute_hidden
__printf_chk (int flag, const char *fmt, ...)
{
	va_list arg;
	int done;

	va_start (arg, fmt);
	done = __nldbl___vfprintf_chk (stdout, flag, fmt, arg);
	va_end (arg);

	return done;
}
```

모르는게 더 많아졌다. 우선 `...`을 해결해야 한다. 이 부분은 찾아보니, C언에서 가변인자를 것이었다. 생각보다 유명한 놈이었다. 이 부분을 사용하려면 먼저 다음과 같은 라이브러리를 포함해야 한다.

```
#include <stdarg.h>
```

`va_list`라고 하는 것은 변수들의 시작 주소를 가리키는 포인터에 불과하다. 실제로 내부를 보면 `char *`로 구성되어 있다.

`va_start`는 방금 생성한 `va_list` 변수를 맨 처음 매개변수의 주소로 초기화시켜준다. 이때 이 변수와 같이 매개변수의 개수를 같이 받아야 한다. 이것은 매크로로, 정의를 보면 알 수 있다.


```
int
attribute_compat_text_section
__nldbl___vfprintf_chk (FILE *s, int flag, const char *fmt, va_list ap)
{
  unsigned int mode = PRINTF_LDBL_IS_DBL;
  if (flag > 0)
    mode |= PRINTF_FORTIFY;

  return __vfprintf_internal (s, fmt, ap, mode);
}
```

보면, 다른 함수를 호출하고 있는데, 플래그가 존재한다. 계속해서 호출한 함수를 쫓아가보자. 그런데 보면  `__vfprintf_internal`함수는 이 라이브러리 내에 존재하지 않는 다는 것을 알 수 있다.

그래서 다시 리누스 토르발스가 작성한 `linux`로 넘어가기로 하자. 여기에서 검색을 해본 결과 `__vfprintf_internal`라는 함수는 존재하지 않았지만, `vfprintf`라는 함수는 존재했다.

그 정의를 써 보면 다음과 같다.

```
int vfprintf(FILE * file, const char *format, va_list args)
{
	acpi_cpu_flags flags;
	int length;

	flags = acpi_os_acquire_lock(acpi_gbl_print_lock);
	length = vsnprintf(acpi_gbl_print_buffer,
			   sizeof(acpi_gbl_print_buffer), format, args);

	(void)fwrite(acpi_gbl_print_buffer, length, 1, file);
	acpi_os_release_lock(acpi_gbl_print_lock, flags);

	return (length);
}
```

이 함수를 조금 더 살펴보자면, 가져오는 것이 `FILE *`형태와 포맷과 매개변수 리스트들이다. 우선 `acpi_os_acquire`함수가 무엇을 하는지 살펴보자ㅏ.

이 함수는 다음과 같다.

```
acpi_cpu_flags acpi_os_acquire_lock(acpi_handle handle)
{
	acpi_os_wait_semaphore(handle, 1, 0xFFFF);
	return (0);
}
```

우선 반환형이 `acpi_cpu_flags`이다. 이 형태는 어떤 형태일까? 구글을 해봤다.

구글에는 잘 나오지 않아서, 그냥 정의를 찾아봤다. 정의를 찾아보니 다음과 같다.

```
#define acpi_cpu_flags			acpi_size
```

음 그럼 `acpi_size`는 무엇인가?

이를 찾아보니 다음과 같이 나왓다.

```
typedef u32 acpi_size;
```

여기에서 `#define`과 `typedef`를 살펴보고 넘어가야 할 것 같다.
포스트를 쓰고 왔다.

이제 계속하자면, 위의 줄을 파악해보자. 이 뜻은 u32라는 자료형이 있었는데, 이것을 `acpi_size`로 사용하겠다는 뜻이다.

그래서 또 따라갔다.

결국은 다음을 찾아냇다.

```
typedef unsigned int u32
```

결국에는 위의 함수는 다음과 같이 쓸 수 있는 것이다.

```
unsigned int acpi_os_acquire_lock(acpi_handle handle)
{
	acpi_os_wait_semaphore(handle, 1, 0xFFFF);
	return (0);
}
```

`acpi_os_wait_semaphore`라는 함수가 무엇을 하는지 알아야 한다.

이 내요은 많이 복잡하기 때문에 세마포어를 다룰 때 다시 해야할 것 같다.
생각보다 코드가 길다.

그것이 끝났다면 다음과 같이 `vsnprintf`라는 함수를 사용하게 된다. 이것을 받고 나면, `length`라는 것을 얻게 된다.

이 함수는 굉장히 흥미로운 함수이다. 이 함수는 매우 길기 때문에 모든 것을 다 나열할 수는 없지만, 다음과 같은 부분은 존재한다.

```
		qualifier = -1;
		if (*format == 'h' || *format == 'l' || *format == 'L') {
			qualifier = *format;
			++format;

			if (qualifier == 'l' && *format == 'l') {
				qualifier = 'L';
				++format;
			}
		}

		switch (*format) {
		case '%':

			pos = acpi_ut_bound_string_output(pos, end, '%');
			continue;

		case 'c':

			if (!(type & ACPI_FORMAT_LEFT)) {
				while (--width > 0) {
					pos =
					    acpi_ut_bound_string_output(pos,
									end,
									' ');
				}
			}

			c = (char)va_arg(args, int);
			pos = acpi_ut_bound_string_output(pos, end, c);

			while (--width > 0) {
				pos =
				    acpi_ut_bound_string_output(pos, end, ' ');
			}
			continue;

		case 's':

			s = va_arg(args, char *);
			if (!s) {
				s = "<NULL>";
			}
			length = (s32)acpi_ut_bound_string_length(s, precision);
			if (!(type & ACPI_FORMAT_LEFT)) {
				while (length < width--) {
					pos =
					    acpi_ut_bound_string_output(pos,
									end,
									' ');
				}
			}

			for (i = 0; i < length; ++i) {
				pos = acpi_ut_bound_string_output(pos, end, *s);
				++s;
			}

			while (length < width--) {
				pos =
				    acpi_ut_bound_string_output(pos, end, ' ');
			}
			continue;

		case 'o':

			base = 8;
			break;

		case 'X':

			type |= ACPI_FORMAT_UPPER;
			/* FALLTHROUGH */

		case 'x':

			base = 16;
			break;

		case 'd':
		case 'i':

			type |= ACPI_FORMAT_SIGN;

		case 'u':

			break;

		case 'p':

			if (width == -1) {
				width = 2 * sizeof(void *);
				type |= ACPI_FORMAT_ZERO;
			}

			p = va_arg(args, void *);
			pos =
			    acpi_ut_format_number(pos, end, ACPI_TO_INTEGER(p),
						  16, width, precision, type);
			continue;
```

확실하지는 않지만, 우리가 `printf`를 할 때에 쓰는 포맷들 (`%c`, `%d`) 등을 처리하는 코드같다. 아마 내 생각에는 이 함수는 `acpi_gbl_print_buffer`라는 곳에다 포맷들을 쫙 정리해서 다시 저장을 시키고, 반환 값으로 그 버퍼에 저장한 것의 길이를 반환하는 것이다.

`acpi_gbl_print_buffer` 부분을 찾아보자. 
