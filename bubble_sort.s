# bubble_sort.s
# Bubble Sort implementation for custom RV32I Processor
# ----------------------------------------------------

# --- DATA INITIALIZATION ---
# Initialize Array in memory: arr = [5, 2, 9, 1, 7]
# x0 is always 0
addi x5, x0, 5     # x5 = 5
sw x5, 0(x0)       # arr[0] = 5
addi x5, x0, 2     # x5 = 2
sw x5, 4(x0)       # arr[1] = 2
addi x5, x0, 9     # x5 = 9
sw x5, 8(x0)       # arr[2] = 9
addi x5, x0, 1     # x5 = 1
sw x5, 12(x0)      # arr[3] = 1
addi x5, x0, 7     # x5 = 7
sw x5, 16(x0)      # arr[4] = 7

# --- BUBBLE SORT START ---
# x6 = N = 5 (Total elements)
addi x6, x0, 5

outer_loop:
    # x7 = swapped_flag = 0
    addi x7, x0, 0
    # x28 = i = 1
    addi x28, x0, 1
    
    # if N <= 1, exit sorting
    addi x29, x0, 1
    bge x28, x6, end_sort 

    # x29 = arr_ptr = 0
    addi x29, x0, 0

inner_loop:
    lw x30, 0(x29)       # load arr[j]
    lw x31, 4(x29)       # load arr[j+1]

    # if arr[j+1] >= arr[j], do not swap
    bge x31, x30, no_swap 

    # swap
    sw x31, 0(x29)       # arr[j] = arr[j+1]
    sw x30, 4(x29)       # arr[j+1] = arr[j]
    addi x7, x0, 1       # swapped_flag = 1

no_swap:
    addi x29, x29, 4     # advance array pointer
    addi x28, x28, 1     # i += 1

    # if i < N, continue inner_loop
    blt x28, x6, inner_loop

    # if swapped == 0, sorting is complete
    beq x7, x0, end_sort

    # N -= 1 (Optimization: the last element is already sorted!)
    addi x6, x6, -1

    # jump back to outer loop
    jal x0, outer_loop

end_sort:
    # Load the sorted array back into registers for easy viewing
    lw x10, 0(x0)     # x10 will hold 1
    lw x11, 4(x0)     # x11 will hold 2
    lw x12, 8(x0)     # x12 will hold 5
    lw x13, 12(x0)    # x13 will hold 7
    lw x14, 16(x0)    # x14 will hold 9
    
infinite_loop:
    jal x0, infinite_loop
