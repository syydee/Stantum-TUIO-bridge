# should be either OSC_HOST_BIG_ENDIAN or OSC_HOST_LITTLE_ENDIAN
# Apple Mac OS X: OSC_HOST_BIG_ENDIAN
# Win32: OSC_HOST_LITTLE_ENDIAN
# i386 GNU/Linux: OSC_HOST_LITTLE_ENDIAN

TARGET = main
CPPSOURCES = $(shell ls *.cpp)
PPOBJECTS = $(CPPSOURCES:.cpp=.o)
OSCSOURCES = $(shell ls oscpack/ip/posix/*.cpp oscpack/osc/*.cpp)
OSCOBJECTS = $(OSCSOURCES:.cpp=.o)
TUIOSOURCES = TuioServer.cpp
TUIOOBJECTS = $(TUIOSOURCES:.cpp=.o)
INCLUDES = -Ioscpack
CFLAGS = -DLINUX -DOSC_HOST_LITTLE_ENDIAN -DNDEBUG -DPMALSA $(INCLUDES)
CXXFLAGS = $(CFLAGS)

all: $(TARGET)

install: $(TARGET)
	cp libsmt-linux/libSMT.so /usr/lib/
	cp main /usr/bin/statum-tuio

$(TARGET): $(CPPOBJECTS) $(OSCOBJECTS) $(TUIOOBJECTS) main.cpp
	g++ $(CXXFLAGS) -Llibsmt-linux -lSMT -lpthread $(OSCOBJECTS) $(TUIOOBJECTS) -o $@ main.cpp

clean:
	rm -f $(TARGET) $(CPPOBJECTS) $(OSCOBJECTS) $(TUIOOBJECTS)
