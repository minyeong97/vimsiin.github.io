---
layout: post
title: opengl six
categories: [] ---

현재까지의 소스코드이다. 대부분 `learnopengl.com`에서 따왔다.

```
#include <iostream>
#include GL/gl3w.h
#include glfw3.h


const char *vertexShaderSource = #version 330 core\n
    layout (location = 0) in vec3 aPos;\n
    void main()\n
    {\n
       gl_Position = vec4(aPos.x, aPos.y, aPos.z, 1.0);\n
    }\0;
const char *fragmentShaderSource = #version 330 core\n
    out vec4 FragColor;\n
    void main()\n
    {\n
       FragColor = vec4(1.0f, 0.5f, 0.2f, 1.0f);\n
    }\n\0;


int main(void) {
	GLFWwindow* window;

	if (!glfwInit()) {
		std::cout << glfw init failed << std::endl;
		return -1;
	}

	glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, 3);
	glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR, 3);
	glfwWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE);

	window = glfwCreateWindow(640, 480, Hello world, NULL, NULL);
	if (!window) {
		std::cout << glfw window creation failed << std::endl;
		glfwTerminate();
		return -1;
	}

	glfwMakeContextCurrent(window);

	if (gl3wInit()) {
		std::cout << gl3w init failed << std::endl;
		glfwTerminate();
		return -1;
	}





	int vertexShader = glCreateShader(GL_VERTEX_SHADER);
	glShaderSource(vertexShader, 1, &vertexShaderSource, NULL);
	glCompileShader(vertexShader);

	int success;
	char infolog[512];
	glGetShaderiv(vertexShader, GL_COMPILE_STATUS, &success);
	if (success == GL_FALSE) {
		glGetShaderInfoLog(vertexShader, 512, NULL, infolog);
		std::cout << ERROR::SHADER::VERTEX\n << infolog << std::endl;
	}


	int fragmentShader = glCreateShader(GL_FRAGMENT_SHADER);
	glShaderSource(fragmentShader, 1, &fragmentShaderSource, NULL);
	glCompileShader(fragmentShader);

	glGetShaderiv(fragmentShader, GL_COMPILE_STATUS, &success);
	if (success == GL_FALSE) {
		glGetShaderInfoLog(fragmentShader, 512, NULL, infolog);
		std::cout << ERROR::SHADER::FRAGMENT\n << infolog << std::endl;
	}

	
	int shaderProgram = glCreateProgram();
	glAttachShader(shaderProgram, vertexShader);
	glAttachShader(shaderProgram, fragmentShader);
	glLinkProgram(shaderProgram);

	glGetProgramiv(shaderProgram, GL_LINK_STATUS, &success);
	if (success == GL_FALSE) {
		glGetProgramInfoLog(shaderProgram, 512, NULL, infolog);
		std::cout << ERROR::PROGRAM\n << infolog << std::endl;
	}

	glDeleteShader(vertexShader);
	glDeleteShader(fragmentShader);

	


	float vertices[] = {
		0.5f, 0.5f, 0.0f,
		0.5f, -0.5f, 0.0f,
		-0.5f, -0.5f, 0.0f,
		-0.5f, 0.5f, 0.0f,
	};

	int indices[] = {
		0, 1, 3,
		1, 2, 3
	};

	unsigned int VBO, VAO, EBO;

	glGenVertexArrays(1, &VAO);
	glGenBuffers(1, &VBO);
	glGenBuffers(1, &EBO);

	glBindVertexArray(VAO);

	glBindBuffer(GL_ARRAY_BUFFER, VBO);
	glBufferData(GL_ARRAY_BUFFER, sizeof(vertices), vertices, GL_STATIC_DRAW);

	glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, EBO);
	glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(indices), indices, GL_STATIC_DRAW);

	glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 3 * sizeof(float), (void*)0);
	glEnableVertexAttribArray(0);

	glBindBuffer(GL_ARRAY_BUFFER, 0);

	glBindVertexArray(0);





	while (!glfwWindowShouldClose(window)) {

		/* background of opengl */
		glClearColor(0.2f, 0.3f, 0.3f, 1.0f);
		glClear(GL_COLOR_BUFFER_BIT);

		/* program */
		glUseProgram(shaderProgram);
		glBindVertexArray(VAO);
		glDrawElements(GL_TRIANGLES, 6, GL_UNSIGNED_INT, 0);
		

		glfwSwapBuffers(window);
		glfwPollEvents();
	}

	glDeleteVertexArrays(1, &VAO);
	glDeleteBuffers(1, &VBO);
	glDeleteBuffers(1, &EBO);


	glfwTerminate();

	return 0;
}
```

오늘부터 할 것은 바로 입력과 그것을 처리하는 코드를 만들 것이다. 그리고 그것이 우리의 사각형의 렌더링에 어떤 영향을 주게 만들 것이다. 우선 큰 그림을 보자면, `glBindVertexArray`로 버퍼에 복사한 `VAO`, `VBO`와 `EBO`들은 모두 `shader` 프로그램 안에서 `location`이라는 인터페이스로 작용하게 된다. 우리가 버퍼에 올려 놓은 데이터를 셰이더 프로그램에서는 가장 처음의 `layout (location = 0) in vec3 aPos;` 으로, 셰이더 안의 이름이 지정된 변수로 변환된다. 우리는 이제 여기에서 다양한 `uniform`변수들을 선언하면서, 최종적인 위치가 될 `gl_Position`의 변수를 변환할 수 있다. 그래서 나는 다음과 같이 셰이더 프로그램을 변형하였다. 

```
#version 330 core

layout (location = 0) in vec3 aPos;
uniform vec4 trans;

void main()
{
   gl_Position = vec4(aPos.x, aPos.y, aPos.z, 1.0) + trans;
};
```

이렇게 되면 새로운 변수 trans를 만들었고, 이를 우리가 위치시킨 `VAO`의 정보와 덧셈을 한 다음에, 그것을 최종적인 그리는 위치로 결정하겠다는 것이다. 그러면 우리는 어떻게 여기의 `trans` 변수와 인터렉션을 할 수 있을까? 그것은 바로 다음과 같은 코드를 통해서 할 수 있다.


```
unsigned int transLoc = glGetUniformLocation(shaderProgram, "trans");
glUniform4fv(transLoc, 1, glm::value_ptr(the_vec));	
```

우선, `glGetUniformLocation()` 함수는 프로그램 아이디(절대 셰이더 아이디가 아니다) 와 그 셰이더 안에서의 변수명(당연하지만 틀리면 안된다) 을 통해서 그 변수의 위치를 알려준다(cloation) 그리고 설정하려는 변수의 종류에 따라서(이 경우는 vec4 이기 때문에 glUniform4fv 함수를 사용함) 특정 함수를 골라서 사용하면 된다. 여기에서 그 값을 설정하는 방법이 여러가지가 있다. 우선 `glUniform` 함수는 아주 많은 종류가 있다. 우선 이름은 glUniform{1|2|3|4}{f|i|ui}{|v} 처럼 생겼는데, 여기에서 맨 처음의 숫자는 이 벡터의 길이이다. 그리고 두 번째는 이 벡터가 `float`이면 `f`, `int`면 `i`, `unsigned int`이면 `ui`인 식이다. 그리고 마지막 `v`가 붙으면, 이 함수는 벡터로 전달받고, 아닌 경우에는 각 값을 나열하는 방식으로 값을 전달받는다. 우리는 전자의 경우를 사용할 것이다. 

전자의 경우를 사용하는 경우, 우리는 벡터들과 행렬을 많이 다루어야 하는데, 이를 위해 `OpenGL`에서 행렬과 벡터를 다루기 쉽도록 만든 라이브러리가 존재한다. 그것이 바로 `GLM`이다. [glm website](https://glm.g-truc.net/) 에 보면, 파일들을 다운 받을 수 있다. 우선 파일들을 다운 받으면 다음과 같이 되어 있다.

```
.
├── cmake
├── CMakeLists.txt
├── copying.txt
├── doc
├── glm
├── readme.md
├── test
└── util
```
우리가 필요한 헤더 파일들은 모두 `glm`에만 존재한다. 여기 안의 파일들은 모조리 다 `header` 파일들이기 때문에, 이를 `include` 폴더에 넣어주기만 하면 된다. 그래서 우리의 프로젝트 디렉토리는 다음과 같이 생기게 된다.

```
.
├── include
│   ├── GL
│   ├── glfw3.h
│   ├── glm
│   └── KHR
├── lib
│   └── libglfw3.a
├── Makefile
├── src
│   ├── gl3w.c
│   ├── glfw_test.c
│   └── glut_test.c
├── start
├── test
└── test.c
```

몇몇개의 `start`같은 파일들은 `xpra`를 쉽게 시작하기 위한 `bash` 명령들이다. 그리고 헤더파일들을 추가했다.

```
#include <iostream>
#include "GL/gl3w.h"
#include "glfw3.h"
#include "glm/glm.hpp"
#include "glm/gtc/type_ptr.hpp"
```

이제 우리는 입력을 받고, 그것에 따라서 값에 변화를 주어야 한다. 다음 코들르 보면 이해가 될 수 있다.

```
void processInput(GLFWwindow *window) {
	if (glfwGetKey(window, GLFW_KEY_W) == GLFW_PRESS)
		the_vec += glm::vec4(0.0f, 0.001f, 0.0f, 0.0f);
	if (glfwGetKey(window, GLFW_KEY_S) == GLFW_PRESS)
		the_vec -= glm::vec4(0.0f, 0.001f, 0.0f, 0.0f);
	if (glfwGetKey(window, GLFW_KEY_D) == GLFW_PRESS)
		the_vec += glm::vec4(0.001f, 0.0f, 0.0f, 0.0f);
	if (glfwGetKey(window, GLFW_KEY_A) == GLFW_PRESS)
		the_vec -= glm::vec4(0.001f, 0.0f, 0.0f, 0.0f);
}
```

이렇게 하고, `processInput()` 함수를 매번 `while`문으로 실행하면 된다. 현재까지의 코드는 다음과 같다.

```
#include <iostream>
#include "GL/gl3w.h"
#include "glfw3.h"
#include "glm/glm.hpp"
#include "glm/gtc/type_ptr.hpp"

glm::vec4 the_vec(0.0f);
void processInput(GLFWwindow *window);

const char *vertexShaderSource = "#version 330 core\n"
    "layout (location = 0) in vec3 aPos;\n"
	"uniform vec4 trans;"
    "void main()\n"
    "{\n"
    "   gl_Position = vec4(aPos.x, aPos.y, aPos.z, 1.0) + trans;\n"
    "}\0";

const char *fragmentShaderSource = "#version 330 core\n"
    "out vec4 FragColor;\n"
    "void main()\n"
    "{\n"
    "   FragColor = vec4(1.0f, 0.5f, 0.2f, 1.0f);\n"
    "}\n\0";


int main(void) {
	GLFWwindow* window;

	if (!glfwInit()) {
		std::cout << "glfw init failed" << std::endl;
		return -1;
	}

	glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, 3);
	glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR, 3);
	glfwWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE);

	window = glfwCreateWindow(640, 480, "Hello world", NULL, NULL);
	if (!window) {
		std::cout << "glfw window creation failed" << std::endl;
		glfwTerminate();
		return -1;
	}

	glfwMakeContextCurrent(window);

	if (gl3wInit()) {
		std::cout << "gl3w init failed" << std::endl;
		glfwTerminate();
		return -1;
	}





	int vertexShader = glCreateShader(GL_VERTEX_SHADER);
	glShaderSource(vertexShader, 1, &vertexShaderSource, NULL);
	glCompileShader(vertexShader);

	int success;
	char infolog[512];
	glGetShaderiv(vertexShader, GL_COMPILE_STATUS, &success);
	if (success == GL_FALSE) {
		glGetShaderInfoLog(vertexShader, 512, NULL, infolog);
		std::cout << "ERROR::SHADER::VERTEX\n" << infolog << std::endl;
	}


	int fragmentShader = glCreateShader(GL_FRAGMENT_SHADER);
	glShaderSource(fragmentShader, 1, &fragmentShaderSource, NULL);
	glCompileShader(fragmentShader);

	glGetShaderiv(fragmentShader, GL_COMPILE_STATUS, &success);
	if (success == GL_FALSE) {
		glGetShaderInfoLog(fragmentShader, 512, NULL, infolog);
		std::cout << "ERROR::SHADER::FRAGMENT\n" << infolog << std::endl;
	}

	
	int shaderProgram = glCreateProgram();
	glAttachShader(shaderProgram, vertexShader);
	glAttachShader(shaderProgram, fragmentShader);
	glLinkProgram(shaderProgram);

	glGetProgramiv(shaderProgram, GL_LINK_STATUS, &success);
	if (success == GL_FALSE) {
		glGetProgramInfoLog(shaderProgram, 512, NULL, infolog);
		std::cout << "ERROR::PROGRAM\n" << infolog << std::endl;
	}

	glDeleteShader(vertexShader);
	glDeleteShader(fragmentShader);

	


	float vertices[] = {
		0.5f, 0.5f, 0.0f,
		0.5f, -0.5f, 0.0f,
		-0.5f, -0.5f, 0.0f,
		-0.5f, 0.5f, 0.0f,
	};

	int indices[] = {
		0, 1, 3,
		1, 2, 3
	};

	unsigned int VBO, VAO, EBO;

	glGenVertexArrays(1, &VAO);
	glGenBuffers(1, &VBO);
	glGenBuffers(1, &EBO);

	glBindVertexArray(VAO);

	glBindBuffer(GL_ARRAY_BUFFER, VBO);
	glBufferData(GL_ARRAY_BUFFER, sizeof(vertices), vertices, GL_STATIC_DRAW);

	glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, EBO);
	glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(indices), indices, GL_STATIC_DRAW);

	glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 3 * sizeof(float), (void*)0);
	glEnableVertexAttribArray(0);

	glBindBuffer(GL_ARRAY_BUFFER, 0);

	glBindVertexArray(0);





	while (!glfwWindowShouldClose(window)) {
		processInput(window);

		/* background of opengl */
		glClearColor(0.2f, 0.3f, 0.3f, 1.0f);
		glClear(GL_COLOR_BUFFER_BIT);

		/* program */
		glUseProgram(shaderProgram);
		glBindVertexArray(VAO);
		glDrawElements(GL_TRIANGLES, 6, GL_UNSIGNED_INT, 0);

		unsigned int transLoc = glGetUniformLocation(shaderProgram, "trans");
		glUniform4fv(transLoc, 1, glm::value_ptr(the_vec));	

		glfwSwapBuffers(window);
		glfwPollEvents();
	}

	glDeleteVertexArrays(1, &VAO);
	glDeleteBuffers(1, &VBO);
	glDeleteBuffers(1, &EBO);


	glfwTerminate();

	return 0;
}

void processInput(GLFWwindow *window) {
	if (glfwGetKey(window, GLFW_KEY_W) == GLFW_PRESS)
		the_vec += glm::vec4(0.0f, 0.001f, 0.0f, 0.0f);
	if (glfwGetKey(window, GLFW_KEY_S) == GLFW_PRESS)
		the_vec -= glm::vec4(0.0f, 0.001f, 0.0f, 0.0f);
	if (glfwGetKey(window, GLFW_KEY_D) == GLFW_PRESS)
		the_vec += glm::vec4(0.001f, 0.0f, 0.0f, 0.0f);
	if (glfwGetKey(window, GLFW_KEY_A) == GLFW_PRESS)
		the_vec -= glm::vec4(0.001f, 0.0f, 0.0f, 0.0f);
}
```
