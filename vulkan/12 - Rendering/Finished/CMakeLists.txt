cmake_minimum_required(VERSION 3.1)
project(VulkanTutorial)

find_package(Vulkan COMPONENTS glslc REQUIRED)
find_program(glslc_executable NAMES glslc HINTS Vulkan::glslc)
find_package(GLFW3 REQUIRED)

function(compile_shader target)
    cmake_parse_arguments(PARSE_ARGV 1 arg "" "SOURCE;OUTPUT" "")
	add_custom_command(
		OUTPUT ${arg_OUTPUT}
		DEPENDS ${arg_SOURCE}
		COMMAND
			${glslc_executable}
			-o "${arg_OUTPUT}"
			"${CMAKE_CURRENT_SOURCE_DIR}/${arg_SOURCE}"
	)
    target_sources(${target} PRIVATE ${arg_OUTPUT})
endfunction()

set(SHADERS
	shaders/shader.vert
	shaders/shader.frag
)

set(SOURCES
	app.cpp
	app.h
	commands.h
	config.h
	device.h
	engine.cpp
	engine.h
	frame.h
	frameBuffer.h
	instance.h
	logging.h
	pipeline.h
	queue_families.h
	shaders.h
	swapchain.h
	sync.h
	main.cpp
)

add_executable(${PROJECT_NAME} ${SOURCES} ${SHADERS})
source_group("Shader Files" FILES ${SHADERS})
set_property(TARGET ${PROJECT_NAME} PROPERTY CXX_STANDARD 17)
target_link_libraries(${PROJECT_NAME} PUBLIC Vulkan::Vulkan glfw ${OPENGL_LIBRARIES})
set_target_properties(${PROJECT_NAME} PROPERTIES
	VS_DEBUGGER_WORKING_DIRECTORY "${CMAKE_SOURCE_DIR}"
	XCODE_GENERATE_SCHEME TRUE
	XCODE_SCHEME_WORKING_DIRECTORY "${CMAKE_SOURCE_DIR}"
)

compile_shader(${PROJECT_NAME}
	ENV opengl 
	SOURCE shaders/shader.vert
	OUTPUT "${CMAKE_CURRENT_SOURCE_DIR}/shaders/vertex.spv"
)
compile_shader(${PROJECT_NAME}
	SOURCE shaders/shader.frag
	OUTPUT "${CMAKE_CURRENT_SOURCE_DIR}/shaders/fragment.spv"
)
