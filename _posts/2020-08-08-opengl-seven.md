---
layout: post
title: opengl seven
categories: []
---

삼차원으로 바꾸기 위해서 다음과 같이 코드를 조금 고쳐 보았다.

```c
#include <iostream>
#include "GL/gl3w.h"
#include "glfw3.h"
#include "glm/glm.hpp"
#include "glm/gtc/type_ptr.hpp"
#include "glm/gtc/matrix_transform.hpp"

#define MouseSensitivity 1.0f
#define KeyboardSensitivity 1.0f

glm::vec4 the_vec(0.0f);
glm::vec3 position(0.0f);
glm::vec3 front;
glm::vec3 up(0.0f, 1.0f, 0.0f);
glm::vec3 worldup(0.0f, 1.0f, 0.0f);
glm::vec3 right(1.0f, 0.0f, 0.0f);
float pitch = 0.0f;
float yaw = 0.0f;
bool firstTime = true;

const unsigned int WIDTH = 800;
const unsigned int HEIGHT = 600;

float lastX = WIDTH/2;
float lastY = HEIGHT/2;

void processMouse(GLFWwindow *window, double xpos, double ypos) {
	if (firstTime) {
		lastX = xpos;
		lastY = ypos;
		firstTime = false;
	}

	float xoffset = xpos - lastX;
	float yoffset = ypos - lastY;

	lastX = xpos;
	lastY = ypos;

	yaw += xoffset * MouseSensitivity;
	pitch += yoffset * MouseSensitivity;
}

void processInput(GLFWwindow *window) {
	front.x = cos(glm::radians(pitch)) * cos(glm::radians(yaw));
	front.y = sin(glm::radians(pitch));
	front.z = cos(glm::radians(pitch)) * sin(glm::radians(yaw));
	front = glm::normalize(front);
	right = glm::normalize(glm::cross(front, worldup));
	up = glm::normalize(glm::cross(right, front));

	if (glfwGetKey(window, GLFW_KEY_W) == GLFW_PRESS)
		position += front * MouseSensitivity;
	if (glfwGetKey(window, GLFW_KEY_S) == GLFW_PRESS)
		position -= front * MouseSensitivity;
	if (glfwGetKey(window, GLFW_KEY_D) == GLFW_PRESS)
		position += right * MouseSensitivity;
	if (glfwGetKey(window, GLFW_KEY_A) == GLFW_PRESS)
		position -= right * MouseSensitivity;
}

const char *vertexShaderSource = "#version 330 core\n"
    "layout (location = 0) in vec3 aPos;\n"
	"uniform mat4 model;"
	"uniform mat4 view;"
	"uniform mat4 ;"
    "void main()\n"
    "{\n"
    "   gl_Position = projection * view * model * vec4(aPos, 1.0f);\n"
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
	window = glfwCreateWindow(WIDTH, HEIGHT, "Hello world", NULL, NULL);
	if (!window) {
		std::cout << "glfw window creation failed" << std::endl;
		glfwTerminate();
		return -1;
	}

	glfwMakeContextCurrent(window);
	glfwSetCursorPosCallback(window, processMouse);

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

		glm::mat4 projection = glm::perspective(glm::radians(30.0f), (float)WIDTH/(float)HEIGHT, 0.1f, 100.0f);
		unsigned int transLoc = glGetUniformLocation(shaderProgram, "projection");
		glUniform4fv(transLoc, 1, glm::value_ptr(projection));	

		glm::mat4 view = glm::lookAt(position, position + front, up);
		transLoc = glGetUniformLocation(shaderProgram, "view");
		glUniform4fv(transLoc, 1, glm::value_ptr(view));	

		glm::mat4 model(1.0f);
		transLoc = glGetUniformLocation(shaderProgram, "trans");
		glUniform4fv(transLoc, 1, glm::value_ptr(model));	

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

우선 삼차원으로 가기 위해서는 행렬들의 곱이 필요하자. 행렬들의 곱으로 인해서 우리가 적용한 값들이 실제 삼차원을 보이게 된다. 그래서 우선 셰이더에 이러한 형태로 `gl_Position`을 바꾸어놓자.

```
gl_Position = projection * view * model * vec4(aPos, 1.0f);
```

우선, 기존의 좌표계인 `aPos`에 1.0f를 붙여서 `vec4`로 만든다. 그런 다음 `model` 행렬, `view` 행렬, `projection` 행렬을 차례로 곱하면 된다. 

```
#version 330 core
layout (location = 0) in vec3 aPos;
uniform mat4 model;
uniform mat4 view;
uniform mat4 projection;
void main() {
	gl_Position = projection * view * model * vec4(aPos, 1.0f);
}
```

그럼 각각의 값들은 어떻게 전달하는가? 우선 `aPos`는 `VAO`로 전달하게 된다. 이는 후에 좀 더 자세히 설명하기로 한다. 그럼 `Uniform`이라고 되어 있는 변수들은 그럼 값을 어떻게 지정할까? 이 값들은 프레임이 변할 때마다 수시로 바뀌는 값들인데, 이를 변경하는 방법은 다음과 같다. 
```
unsigned int loc = glGetUniformLocation(<program-id>, "<var-name>");
glUniformMatrix4fv(loc, 1, GL_FALSE, glm::value_ptr(<glm-style-value>));	
```

우선, `glGetUniformLocation` 함수를 사용해서 이 셰이더 안의 변수명을 통해 위치를 알아낸다. 그리고 그 변수의 종류에 따라 맞는 함수를 사용해서(이 경우에는 `mat4`이기 때문에 `glUniformMatrix4fv`를 사용) 그 값을 설정하는 것이다. 이 함수는 근데 빨라야 할 것 같다. 왜냐하면 매 프레임마다 새로 써주는 함수이기 때문이다. 이 값이 어디에 존재하는지 궁금하다. 시스템 메모리에 존재할까 아니면 디바이스 메모리에 존재할까? 그것을 좀 더 공부가 필요하다.

그럼 이제 각각의 행렬들의 값을 실제로 어떻게 유도해내는지 봐야한다. 우선 `glm`을 사용하면 아주 간단하다. `model`같은 경우는 `mat4(1.0f)`로 시작해서, 다음과 같은 변환을 계속 해서 내가 원하는 방향에 놓으면 된다. 이 행렬은 내가 원하는 모델의 위치, 회전, 확대 등을 정하는 행렬이다.

```
glm::mat4 model(1.0f);
model = glm::rotate(model, glm::radian(1.0f), glm::vec3(1.0f, 2.0f, 3.0f));
model = glm::translate(model, glm::radina(2.0f, 0.0f, 0.0f));
```

대표적인 함수들을 살펴보자면, `glm::rotate`는 (행렬, 각도, 축(vec3로 표현)) 된다. `glm::translate` 도 마찬가지로 (행렬, 벡터)이고, `glm::scale`도 (행렬, 벡터)이다. 스케일 같은 경우는 각 축으로 확대하고 싶은 값을 정하여 벡터를 만들면 된다.

다음으로 `view` 행렬이다. 이 함수는 카메라의 위치와 카메라가 쳐보다고 있는 위치를 참고해서 주변 사물을 카메라의 시점으로 바꾸어주는 행렬이다. 이 행렬은 `glm::lookAt` 함수를 사용하면 된다. 이 함수는 (카메라의 위치, 카메라가 쳐다보고 있는 곳의 위치, 카메라의 위쪽 벡터) 를 가져가면 이를 반환해준다.

다음으로 `projection`이다. 이 행렬은 카메라의 시점을 화면에 맵핑해주는 행렬이다. 이 함수는 `glm::perspective` 함수를 사용해서 구현할 수 있다. 이 함수는 (카메라의 fov, 화면비율, 최단가시거리, 최장가시거리) 를 주면 된다.

그런데 화면에 아무것도 뜨지 않는다. 왜 그럴까. 이곳 저곳 고쳐보았는데 안되어서 로그 파일을 살펴보니, 다음과 같은 문구가 있었다. 

```
ERROR::SHADER::VERTEX
0:3(51): error: `model' redeclared
0:5(16): error: `projection' undeclared
0:5(16): error: operands to arithmetic operators must be numeric
0:5(16): error: operands to arithmetic operators must be numeric
0:5(16): error: operands to arithmetic operators must be numeric

ERROR::PROGRAM
error: linking with uncompiled/unspecialized shader
```

이를 고치기 위해서 다양한 시도를 해보았는데, 결국 셰이더의 변수명을 잘못 쓴 것이었다. 나머지는 아주 잘 작동한다. 개발 초기에 그러나 `glEnable(GL_DEPTH_TEST)`를 하지 말자. 이러면 설정이 성공적이어도 보이지 않을 수 있다. 또 하기 쉬운 실수는 셰이더의 변수 형태에 따른 지정함수를 사용하지 않은 것이다. 쉬운 실수이기 때문에 주의하도록 하자.

이제 input에 관련하여 이야기를 해보자. 우선 이는 윈도우 관리 프로그램과의 대화가 중요하다. 이런 입력처리를 하기 위해서는 콜백함수를 사용하거나, 특정 처리 함수를 무한루프 속에 넣어놓는 방법도 존재한다. 그리고 키보드 입력과 마우스 입력은 상당히 다르게 처리한다. 우선 키보드 입력은 무한루프를 돌게 하는 것이 좋다. 그 이유는 마우스와 달리 키보드는 특정 키를 길게 쭉 눌러서 pan 하거나 navigate하는 경우가 존재하기 때문이다. 그에 대한 이유는, 이런 움직임이 시간에 따라 일정해야 하기 때문에, 지난 처리로부터 지난 시간을 측정해야 하기 때문이다. 사실 콜백함수로도 구현할 수 있다. 그러나 무한루프가 더 편한 듯 하다. 그래서 다음과 같이 무한 루프 안에 지난 식나을 측정하고, 

```
float currentTime = glfwGetTime();
deltaTime = currentTime - lastTime;
lastTime = currentTime;
```

속도에 이 `deltaTime`을 곱해서 움직임을 변화시켜야 한다. 여기에서 `lastTime`은 글로벌 변수로 미리 초기화시켜놓는 것이 좋다. 아니면 다음과 같이 함수가 처음 작동되었는지를 나타내는 `firstTime`이라는 `bool`을 정의해서 사용한다.
```c
if (firstTime) {
	lastX = xpos;
	lastY = ypos;
	firstTime = false;
}

float xoffset = xpos - lastX;
float yoffset = -(ypos - lastY);

lastX = xpos;
lastY = ypos;

yaw += xoffset * MouseSensitivity;
pitch += yoffset * MouseSensitivity;

if (pitch > 89.0f) pitch = 89.0f;
if (pitch < -89.0f) pitch = -89.0f;

update();
```


```c
#include <iostream>
#include "GL/gl3w.h"
#include "glfw3.h"
#include "glm/glm.hpp"
#include "glm/gtc/type_ptr.hpp"
#include "glm/gtc/matrix_transform.hpp"
#include "glm/gtx/transform.hpp"

#define MouseSensitivity 5.0f
#define KeyboardSensitivity 10.0f

glm::vec4 the_vec(0.0f);
glm::vec3 position = glm::vec3(0.0f, 0.0f, -1.0f);
glm::vec3 front;
glm::vec3 worldfront;
glm::vec3 up;
glm::vec3 worldup = glm::vec3(0.0f, 1.0f, 0.0f);
glm::vec3 right;
float pitch = 0.0f;
float yaw = 0.0f;
float lastTime = 0.0f;
float deltaTime = 0.0f;
bool firstTime = true;

const unsigned int WIDTH = 800;
const unsigned int HEIGHT = 600;

float lastX = WIDTH/2;
float lastY = HEIGHT/2;

void update() {
	front.x = cos(glm::radians(pitch)) * cos(glm::radians(yaw));
	front.y = sin(glm::radians(pitch));
	front.z = cos(glm::radians(pitch)) * sin(glm::radians(yaw));
	front = glm::normalize(front);
	right = glm::normalize(glm::cross(front, worldup));
	up = glm::normalize(glm::cross(right, front));
}

void processMouse(GLFWwindow *window, double xpos, double ypos) {
	/*
	if (firstTime) {
		lastX = xpos;
		lastY = ypos;
		firstTime = false;
	}

	float xoffset = xpos - lastX;
	float yoffset = -(ypos - lastY);

	lastX = xpos;
	lastY = ypos;

	yaw += xoffset * MouseSensitivity;
	pitch += yoffset * MouseSensitivity;

	if (pitch > 89.0f) pitch = 89.0f;
	if (pitch < -89.0f) pitch = -89.0f;

	update();
	*/
}

void processInput(GLFWwindow *window) {

	if (glfwGetKey(window, GLFW_KEY_ESCAPE) == GLFW_PRESS)
		glfwSetWindowShouldClose(window, true);

	float velocity = KeyboardSensitivity * deltaTime;
	if (glfwGetKey(window, GLFW_KEY_W) == GLFW_PRESS)
		position += front * velocity;
	if (glfwGetKey(window, GLFW_KEY_S) == GLFW_PRESS)
		position -= front * velocity;
	if (glfwGetKey(window, GLFW_KEY_D) == GLFW_PRESS)
		position += right * velocity;
	if (glfwGetKey(window, GLFW_KEY_A) == GLFW_PRESS)
		position -= right * velocity;

	velocity = velocity * MouseSensitivity;
	if (glfwGetKey(window, GLFW_KEY_L) == GLFW_PRESS)
		yaw += velocity;
	if (glfwGetKey(window, GLFW_KEY_J) == GLFW_PRESS)
		yaw -= velocity;
	if (glfwGetKey(window, GLFW_KEY_I) == GLFW_PRESS)
		pitch += velocity;
	if (glfwGetKey(window, GLFW_KEY_K) == GLFW_PRESS)
		pitch -= velocity;
		
	update();
}

const char *vertexShaderSource = "#version 330 core\n"
    "layout (location = 0) in vec3 aPos;\n"
	"uniform mat4 model;\n"
	"uniform mat4 view;\n"
	"uniform mat4 projection;\n"
    "void main()\n"
    "{\n"
    "   gl_Position = projection * view * model * vec4(aPos, 1.0f);\n"
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

	window = glfwCreateWindow(WIDTH, HEIGHT, "Hello world", NULL, NULL);
	if (!window) {
		std::cout << "glfw window creation failed" << std::endl;
		glfwTerminate();
		return -1;
	} glfwMakeContextCurrent(window);

	glfwSetCursorPosCallback(window, processMouse);
	glfwSetInputMode(window, GLFW_CURSOR, GLFW_CURSOR_DISABLED);


	if (gl3wInit()) {
		std::cout << "gl3w init failed" << std::endl;
		glfwTerminate();
		return -1;
	}


	//glEnable(GL_DEPTH_TEST);


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


	update();


	while (!glfwWindowShouldClose(window)) {
		float currentTime = glfwGetTime();
		deltaTime = currentTime - lastTime;
		lastTime = currentTime;

		processInput(window);

		/* background of opengl */
		glClearColor(0.2f, 0.3f, 0.3f, 1.0f);
		glClear(GL_COLOR_BUFFER_BIT);

		/* program */
		glUseProgram(shaderProgram);

		glm::mat4 projection = glm::perspective(glm::radians(30.0f), (float)WIDTH/(float)HEIGHT, 0.1f, 100.0f);
		//projection = glm::mat4(1.0f);
		unsigned int transLoc = glGetUniformLocation(shaderProgram, "projection");
		glUniformMatrix4fv(transLoc, 1, GL_FALSE, glm::value_ptr(projection));	

		glm::mat4 view = glm::lookAt(position, position + front, up);
		//view = glm::mat4(1.0f);
		transLoc = glGetUniformLocation(shaderProgram, "view");
		glUniformMatrix4fv(transLoc, 1, GL_FALSE, glm::value_ptr(view));	


		glBindVertexArray(VAO);

		glm::mat4 model = glm::mat4(1.0f);
		transLoc = glGetUniformLocation(shaderProgram, "model");
		glUniformMatrix4fv(transLoc, 1, GL_FALSE, glm::value_ptr(model));

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

