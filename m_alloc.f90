module mod_alloc
    use mod_global, only: mks, mkd
    implicit none

    
    interface alloc 
        module procedure salloc, dalloc
    end interface alloc

    contains
        subroutine salloc(square_x, square_y, n_total)
        	implicit none
            integer :: info
            integer(mks) :: n_total
        	real(mks), dimension(:), allocatable :: square_x, square_y, work

        	if (.not.allocated(square_x)) then
        		allocate(square_x(n_total), stat=info)
        	else
        		! deallocate square_x from old size
        	    deallocate(square_x, stat=info)
        	    
        	    ! reallocate square_x with new size
        	    allocate(square_x(n_total), stat=info)

        	endif
        	
        	if (.not.allocated(square_y)) then
                allocate(square_y(n_total), stat=info)
            
            else
        		! deallocate square_x from old size
        	    deallocate(square_y, stat=info)
        	    
        	    ! reallocate square_x with new size
        	    allocate(square_y(n_total), stat=info)

        	endif	
        end subroutine salloc

        subroutine dalloc(square_x, square_y, n_total)
        	implicit none
            integer :: info
            integer(mkd) :: n_total
        	real(mkd), dimension(:), allocatable :: square_x, square_y, work

        	if (.not.allocated(square_x)) then
        		allocate(square_x(n_total), stat=info)
        	else
        		! deallocate square_x from old size
        	    deallocate(square_x, stat=info)
        	    
        	    ! reallocate square_x with new size
        	    allocate(square_x(n_total), stat=info)

        	endif
        	
        	if (.not.allocated(square_y)) then
                allocate(square_y(n_total), stat=info)
            
            else
        		! deallocate square_x from old size
        	    deallocate(square_y, stat=info)
        	    
        	    ! reallocate square_x with new size
        	    allocate(square_y(n_total), stat=info)

        	endif
        end subroutine dalloc
end module mod_alloc