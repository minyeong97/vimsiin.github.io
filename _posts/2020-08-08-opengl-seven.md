---
layout: post
title: opengl seven
categories: []
---

삼차원으로 바꾸기 위해서 다음과 같이 코드를 조금 고쳐 보았다.

```
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


