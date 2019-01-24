
#----------------------------------------------------------------------
#  Makefile : circle_mpi_day3
#  Version  : 1                                                         
#  Author   : Antariksh Dicholkar                                                      
#  Created  : 23-01-2019
#----------------------------------------------------------------------
SHELL       = /bin/sh
TARGET      = pi.exe
#----------------------------------------------------------------------
#  Compiler settings (Linux)
#----------------------------------------------------------------------
F77         = mpif90
CC          = cc
DEBUG       = -C
DEBUG       = 
OPT         = 
FFLAGS      = $(OPT) -free -xO3 $(DEBUG) #-xvpara -xO0 -xO3 -g -fast -xvector=simd
CFLAGS      = -O
LD          = $(F77)
LDFLAGS     = 
CPP         = /lib/cpp
DEFINE      = 
LIBS        = 

#----------------------------------------------------------------------
#  Search path for RCS files                                           
#----------------------------------------------------------------------
VPATH = ./RCS

#----------------------------------------------------------------------
#  Additional suffix rules                                             
#----------------------------------------------------------------------
.SUFFIXES : .inc .inc,v .f,v .c,v
.f,v.f :
	 co $*.f

.c,v.c :
	 co $*.c

.inc,v.inc :
	 co $*.inc

#----------------------------------------------------------------------
#  Binary directory
#----------------------------------------------------------------------
bindir      = $(HOME)/bin

#----------------------------------------------------------------------
#  Default target
#----------------------------------------------------------------------
all: $(TARGET)

#----------------------------------------------------------------------
#  Object files:                                                       
#  NOTE: you HAVE to sort the objects files such that no file will 
#  depend on files below it ! in this example, the diffuse2.f and .o
#  depends on all he module files (i named them m_*.f), and the m_init
#  depends (USE) the m_diffuse; thus m_diffuse HAS to be compiled 
#  before m_init and before diffuse2
#----------------------------------------------------------------------
OBJS =	m_global.o\
        m_alloc.o\
        m_init.o\
        m_random.o\
        main.o
	
#----------------------------------------------------------------------
#  Dependencies:                                                       
#  NOTE: add the dependencies here explicitly ! 
#  
#----------------------------------------------------------------------
main.o: main.f90 m_global.o m_alloc.o m_init.o 
	$(F77) $(FFLAGS)  -c main.f90
m_random.o: m_random.f90 m_global.o m_alloc.o m_init.o
	$(F77) $(FFLAGS)  -c m_random.f90	
m_init.o: m_init.f90 m_global.o m_alloc.o 
	$(F77) $(FFLAGS)  -c m_init.f90
m_alloc.o: m_alloc.f90 m_global.o 
	$(F77) $(FFLAGS)  -c m_alloc.f90
m_global.o: m_global.f90 
	$(F77) $(FFLAGS)  -c m_global.f90



#----------------------------------------------------------------------
#  link                                                                
#----------------------------------------------------------------------
$(TARGET): $(OBJS)
	$(LD) -o $(TARGET) $(LDFLAGS) $(OBJS) $(LIBS)

#----------------------------------------------------------------------
#  Install                                                             
#----------------------------------------------------------------------
install: $(TARGET)
	(cp -f $(TARGET) $(bindir))

#----------------------------------------------------------------------
#  Run                                                                 
#----------------------------------------------------------------------
run: $(TARGET)
	$(TARGET)

#----------------------------------------------------------------------
#  Clean                                                               
#----------------------------------------------------------------------
new: cleanall $(TARGET)
cleanall:
	rm -f $(OBJS)
	rm -f *.dat
	rm -f *.bck
	rm -f *.lst
	rm -f *.mod
	rm -f *.l
	rm -f *.L

clean:
	rm -f *.dat
	rm -f *.bck

