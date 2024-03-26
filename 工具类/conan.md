一个简单的包管理工具



# 安装
pip install conan

# 版本
conan --version

# 升级
pip install conan --upgrade  

# 搜索包
conan search poco --remote=conan-center
conan search libpng -r=conan-center



第一次使用



# 查看  
conan inspect poco/1.9.4

# 配置文件名  
conanfile.txt

# 设置默认编译版本 
conan profile update settings.compiler.libcxx=libstdc++11 default

# 安装库
conan install .. 


# cmake使用例子
cmake_minimum_required(VERSION 2.8.12)
project(MD5Encrypter)

add_definitions("-std=c++11")

include(${CMAKE_BINARY_DIR}/conanbuildinfo.cmake)
conan_basic_setup()

add_executable(md5 md5.cpp)
target_link_libraries(md5 ${CONAN_LIBS})

 

# linux构建命令
$ cmake .. -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Release
$ cmake --build .































拍照 T1S1

获取结果 







