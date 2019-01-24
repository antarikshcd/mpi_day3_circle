module mod_mpi_initialize
    use mod_global, only:mk

    contains
        subroutine mpi_initialize(rank, size, name, ierror)
            integer(mk) :: rank, size, ilen, ierror
            character(len=256) :: name


            ! initialize MPI
            call MPI_Init(ierror)
            !print*, 'MPI initializion error signal: ',ierror
            
            ! print the rnak of MPI_COMM_WORLD
            call MPI_Comm_RANK(MPI_COMM_WORLD, rank, ierror)
            !print*, 'MPI rank: ', rank, 'error status: ',ierror
            
            ! print the total number of sizes in the communicator
            call MPI_Comm_Size(MPI_COMM_WORLD, size, ierror)
            !print*, 'MPI size: ', size, 'error status: ',ierror
            
            ! print the processor name
            call MPI_Get_Processor_Name(name, ilen, ierror) 
            !print*,'MPI processor name', name(1:ilen), 'error status: ',ierror

        end subroutine mpi_initialize
module end mod_mpi_initialize
