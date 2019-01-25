! program to calculate the value of pi using monte carlo method
! MPI Week3 day 3

program main
    use mod_global
    use mod_alloc, only: alloc
    use mod_init
    use mod_random
    use mod_mpi_initialize
    implicit none
    include 'mpif.h'

    ! initialize mpi
    call mpi_initialize(rank, size, name, ierror)

    call initialize(radius, side, n_total, n_circle, x_c, y_c, &
                    pi_tol, pi_diff, k, kmax, root)
    ! allocate the areas of square and circle
    !allocate(area_circle(n_total, n_total), status=info)
    
    ! divide the checking onto processes
    ! if rank is the last process find the remainder 
 
    do while(pi_diff > pi_tol .and. k < kmax)

        ! initialize n_in and n_circle
        n_in = 0
        n_circle = 0
    
        ! distribute the points to the processes
        if (rank .ne. size-1) then
        
            n_end = int(n_total/size)
        else
            n_end = n_total - int(n_total/size)*(size-1)
        
        endif       
        
        
        call alloc(square_x, square_y, n_end)
        
        call gen_random(square_x, square_y, rank)
        
        ! start measuring time
        t1 = MPI_Wtime()  
        
        ! check if random number is within the circle  
   	    do i=1,n_end
                        
            ! calculate the square of the distance of points from circle centre        
            dist_sq = (square_x(i) - x_c)*(square_x(i) - x_c) + &
                      (square_y(i) - y_c)*(square_y(i) - y_c)
        
            if (dist_sq .le. radius*radius) then
                
                ! increment the points that lie within the circle
                n_circle = n_circle + 1
        
            endif             
        
        enddo
                 ! end the time measurement
        t2 = MPI_Wtime()
        ! time for each process
        delta_t = t2 - t1
         
        

        call MPI_Reduce(n_circle, n_in, 1, MPI_DOUBLE_PRECISION, MPI_SUM, &
         	             root, MPI_COMM_WORLD, info)
        ! MPI all reduce to get n_in in all processes
        !call MPI_AllReduce(n_circle, n_in, 1, MPI_DOUBLE_PRECISION, MPI_SUM, &
        ! 	                MPI_COMM_WORLD, info)
 
         ! barrier to ensure that all processes finish executing
        ! and the correct time is reported by rank0.
        !call MPI_Barrier(MPI_COMM_WORLD,ierror) 

        if (rank .eq. root) then
            ! calculate pi for all processes
            pi = real(4)*real(n_in)/real(n_total)
            ! calcualte the difference
            pi_diff = abs(pi - pi_th)
            ! if pi_diff is less than theoretical increase n
                    ! increment for all processes: k
            if (pi_diff > pi_tol) then
                 n_total = n_total*2
            
             endif
            
            print*,'k = ', k
            print*,'pi_diff= ', pi_diff
            print*,'n_total= ', n_total

        endif
         
        call MPI_Barrier(MPI_COMM_WORLD,ierror) 

        ! broadcast pi_diff, n_total
        call MPI_BCast(pi_diff, 1, MPI_DOUBLE_PRECISION, root, &
                        MPI_COMM_WORLD, info)

        ! broadcast pi_diff, n_total
        call MPI_BCast(n_total, 1, MPI_DOUBLE_PRECISION, root, &
                        MPI_COMM_WORLD, info)

        ! add the time
        call MPI_Reduce(delta_t, total_time, 1, MPI_DOUBLE_PRECISION, MPI_SUM, &
        	             root, MPI_COMM_WORLD, info)
        
        
        ! barrier to ensure that all processes finish executing
        ! and the correct time is reported by rank0.

        k = k+1
        
        call MPI_Barrier(MPI_COMM_WORLD,ierror) 
        

    end do ! end while loop
    
    ! calculate pi
    if (rank .eq. 0) then
    
        ! calculate pi
        pi = real(4)*real(n_in)/real(n_total)
 !       print*,'Rank= ', rank, 'N_in= ', n_in
        wall_time = total_time/size
        print*,'Rank= ', rank, 'PI= ', pi 
        print*,'MPI Wall time= ', wall_time, '[s]'
        
        ! generate the save file name
        write(filename, '(A)') 'output.dat' 
        open(10, file=filename, position='append')
        write(10, *) size, wall_time, pi
        close(10)
        call flush(10) 
    endif
     
!    print*,'Nproc= ', size
!    print*,'Rank= ', rank,'n_total= ', n_total
!    print*,'Rank= ', rank,'n_end= ', n_end
!    print*,'Rank= ', rank,'n_circle= ', n_circle  

    !print*, 'seed: ', seed ! debug
    !print*, 'seedsize: ', seedsize !debug
    !print*, 'square=  ' !debug
    !print*, square(1, :) !debug
    !print*, square(2, :) !debug

     ! terminate MPI
    call MPI_Finalize(ierror)
end program main