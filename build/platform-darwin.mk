include $(SRC_PATH)build/arch.mk
SHAREDLIB_DIR = $(PREFIX)/lib
SHAREDLIBSUFFIX = dylib
SHAREDLIBSUFFIXFULLVER=$(FULL_VERSION).$(SHAREDLIBSUFFIX)
SHAREDLIBSUFFIXMAJORVER=$(SHAREDLIB_MAJORVERSION).$(SHAREDLIBSUFFIX)
CURRENT_VERSION := 2.6.0
COMPATIBILITY_VERSION := 2.6.0
SHLDFLAGS = -dynamiclib -twolevel_namespace -undefined dynamic_lookup \
	-fno-common -headerpad_max_install_names -install_name \
	$(SHAREDLIB_DIR)/$(LIBPREFIX)$(PROJECT_NAME).$(SHAREDLIBSUFFIXMAJORVER)
SHARED = -dynamiclib
SHARED += -current_version $(CURRENT_VERSION) -compatibility_version $(COMPATIBILITY_VERSION)
CFLAGS += -Wall -fPIC -MMD -MP
CXXFLAGS += -stdlib=libc++ -std=c++17
LDFLAGS += -stdlib=libc++
ifeq ($(ARCH), arm64)
CFLAGS += -arch arm64
LDFLAGS += -arch arm64
endif
ifeq ($(USE_STACK_PROTECTOR), Yes)
CFLAGS += -fstack-protector-all
endif
ifeq ($(ASM_ARCH), x86)
ASMFLAGS += -DPREFIX
ifeq ($(ARCH), x86_64)
CFLAGS += -arch x86_64
LDFLAGS += -arch x86_64
ASMFLAGS += -f macho64
else
CFLAGS += -arch i386
LDFLAGS += -arch i386
ASMFLAGS += -f macho
LDFLAGS += -read_only_relocs suppress
endif
endif

