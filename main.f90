! program to calculate the value of pi using monte carlo method
! MPI Week3 day 3

program main
    use mod_global
    use mod_alloc, only: alloc
    use mod_init
    use mod_random
    implicit none
    

    call initialize(rank, radius, side, n_total, n_circle, x_c, y_c)
    ! allocate the areas of square and circle
    !allocate(area_circle(n_total, n_total), status=info)
    
    call alloc(square_x, square_y, n_total)

    call gen_random(square_x, square_y, rank)
  ! check if random number is within the circle
      
  	do i=1,n_total
                
        ! calculate the square of the distance of points from circle centre        
        dist_sq = (square_x(i) - x_c)*(square_x(i) - x_c) + &
                  (square_y(i) - y_c)*(square_y(i) - y_c)

        if (dist_sq .le. radius*radius) then
            
            ! increment the points that lie within the circle
            n_circle = n_circle + 1

        endif             

    enddo

    ! calculate pi
    pi = real(4)*real(n_circle)/real(n_total)

    print*,'PI= ', pi 
    print*,'n_total= ', n_total
    print*,'n_circle= ', n_circle  

    !print*, 'seed: ', seed ! debug
    !print*, 'seedsize: ', seedsize !debug
    !print*, 'square=  ' !debug
    !print*, square(1, :) !debug
    !print*, square(2, :) !debug


end program main