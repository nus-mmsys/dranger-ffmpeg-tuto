# use pkg-config for getting CFLAGS and LDLIBS
FFMPEG_LIBS=    libavdevice                        \
                libavformat                        \
                libavfilter                        \
                libavcodec                         \
                libswresample                      \
                libswscale                         \
                libavutil                          \

SDL_LIBS =

CFLAGS += -Wall -g
CFLAGS := $(shell pkg-config --cflags $(FFMPEG_LIBS)) $(CFLAGS) `sdl-config --cflags --libs`
LDLIBS := $(shell pkg-config --libs $(FFMPEG_LIBS)) $(LDLIBS) -lSDLmain -lSDL -lm

EXAMPLES=       tutorial01                      \
                tutorial02                       \
                tutorial03                  \
                tutorial04                  \
                tutorial05                        \
                tutorial06                    \
                tutorial07                                    

OBJS=$(addsuffix .o,$(EXAMPLES))

# the following examples make explicit use of the math library
avcodec:           LDLIBS += -lm
decoding_encoding: LDLIBS += -lm
muxing:            LDLIBS += -lm
resampling_audio:  LDLIBS += -lm

.phony: all clean-test clean

all: $(OBJS) $(EXAMPLES)

clean-test:
	$(RM) test*.pgm test.h264 test.mp2 test.sw test.mpg

clean: clean-test
	$(RM) $(EXAMPLES) $(OBJS)
