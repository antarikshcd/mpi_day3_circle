module mod_random
    use mod_global, only: mk, seed, seedsize, i

    contains
        subroutine gen_random(square_x, square_y, rank)
        	implicit none
        	real(mk), dimension(:) :: square_x, square_y
        	integer(mk) :: rank    

        	! random number generator

            call random_seed(size=seedsize)

            if (.not.allocated(seed)) then
                allocate(seed(seedsize))
            endif
            
            do i=1,seedsize
    	        seed(i) = 1238239 + rank*8365
            enddo

            call random_seed(put=seed)
            call random_number(square_x) !generate the random x-coordiantes of the points
            call random_number(square_y) !generate the random y-coordinates of the corresponding points

        end subroutine gen_random
end module mod_random