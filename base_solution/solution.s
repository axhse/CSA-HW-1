	.file	"solution.c"
	.intel_syntax noprefix
	.text
	.globl	base_array
	.bss
	.align 32
	.type	base_array, @object
	.size	base_array, 400
base_array:		#  метка адреса глобальной переменной base_array
	.zero	400	# зануление всех элементов base_array
	.globl	freaky_array
	.align 32
	.type	freaky_array, @object
	.size	freaky_array, 400
freaky_array:	#  метка адреса глобальной переменной freaky_array
	.zero	400	# зануление всех элементов freaky_array
	.globl	base_array_length
	.align 4
	.type	base_array_length, @object
	.size	base_array_length, 4
base_array_length:		#  метка адреса глобальной переменной base_array_length
	.zero	4		# инициализация base_array_length ноликом
	.globl	freaky_array_length
	.align 4
	.type	freaky_array_length, @object
	.size	freaky_array_length, 4
freaky_array_length:	#  метка адреса глобальной переменной freaky_array_length
	.zero	4		# инициализация freaky_array_length ноликом
	.section	.rodata
	.align 8
.LC0:
	.string	"Input array length (0 < length <= %d): "
.LC1:
	.string	"%d"
.LC2:
	.string	"Input %d array values: "
	.text
	.globl	try_input_base_array
	.type	try_input_base_array, @function
try_input_base_array:
	endbr64
	push	rbp
	mov	rbp, rsp
	sub	rsp, 16
	mov	esi, 100
	lea	rax, .LC0[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT
	lea	rax, base_array_length[rip]
	mov	rsi, rax
	lea	rax, .LC1[rip]
	mov	rdi, rax
	mov	eax, 0
	call	__isoc99_scanf@PLT	# получаем снаружи и сохраняем значение base_array_length
	mov	eax, DWORD PTR base_array_length[rip]
	test	eax, eax
	jle	.L2
	mov	eax, DWORD PTR base_array_length[rip]
	cmp	eax, 100
	jle	.L3
.L2:
	mov	eax, 0	# записываем возвращаемый результат в регистр (0 = некорректные данные от пользователя)
	jmp	.L4
.L3:
	mov	eax, DWORD PTR base_array_length[rip]
	mov	esi, eax
	lea	rax, .LC2[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT
	mov	DWORD PTR -4[rbp], 0	# записываем значение 0 для i на стек
	jmp	.L5
.L6:
	mov	eax, DWORD PTR -4[rbp]
	cdqe
	lea	rdx, 0[0+rax*4]
	lea	rax, base_array[rip]
	add	rax, rdx
	mov	rsi, rax
	lea	rax, .LC1[rip]
	mov	rdi, rax
	mov	eax, 0
	call	__isoc99_scanf@PLT		# получаем снаружи и сохраняем значение очередного элемента base_array
	add	DWORD PTR -4[rbp], 1	# увеличиваем значение i на 1
.L5:
	mov	eax, DWORD PTR base_array_length[rip]
	cmp	DWORD PTR -4[rbp], eax
	jl	.L6
	mov	eax, 1	# записываем возвращаемый результат в регистр (1 = base_array успешно заполнен)
.L4:
	leave
	ret	# выходим из функции 
	.size	try_input_base_array, .-try_input_base_array
	.section	.rodata
.LC3:
	.string	" %d"
	.text
	.globl	print_array
	.type	print_array, @function
print_array:
	endbr64
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
	mov	QWORD PTR -24[rbp], rdi	# записываем значение из регистра 1 агрумента rdi для формального параметра array на стек
	mov	DWORD PTR -28[rbp], esi	# записываем значение из регистра 2 аргумента esi для формального параметра length на стек
	mov	DWORD PTR -4[rbp], 0	# записываем значение 0 для i на стек
	jmp	.L8
.L9:
	mov	eax, DWORD PTR -4[rbp]
	cdqe
	lea	rdx, 0[0+rax*4]
	mov	rax, QWORD PTR -24[rbp]
	add	rax, rdx
	mov	eax, DWORD PTR [rax]
	mov	esi, eax
	lea	rax, .LC3[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT
	add	DWORD PTR -4[rbp], 1	# увеличиваем значение i на 1
.L8:
	mov	eax, DWORD PTR -4[rbp]
	cmp	eax, DWORD PTR -28[rbp]
	jl	.L9
	nop
	nop
	leave
	ret
	.size	print_array, .-print_array
	.globl	fill_freaky_array
	.type	fill_freaky_array, @function
fill_freaky_array:
	endbr64
	push	rbp
	mov	rbp, rsp
	mov	DWORD PTR -12[rbp], -1	# записываем значение -1 для first_positive_value_index на стек
	mov	DWORD PTR -8[rbp], 0		# записываем значение 0 для i на стек
	jmp	.L11
.L14:
	mov	eax, DWORD PTR -8[rbp]
	cdqe
	lea	rdx, 0[0+rax*4]
	lea	rax, base_array[rip]
	mov	eax, DWORD PTR [rdx+rax]
	test	eax, eax
	jle	.L12
	mov	eax, DWORD PTR -8[rbp]
	mov	DWORD PTR -12[rbp], eax		# записываем найденный индекс в first_positive_value_index
	jmp	.L13
.L12:
	add	DWORD PTR -8[rbp], 1		# увеличиваем значение i на 1
.L11:
	mov	eax, DWORD PTR base_array_length[rip]
	cmp	DWORD PTR -8[rbp], eax
	jl	.L14
.L13:
	mov	DWORD PTR freaky_array_length[rip], 0	# записываем 0 в freaky_array_length, необязтельное действие в данном контексте программы
	mov	eax, DWORD PTR base_array_length[rip]
	sub	eax, 1
	mov	DWORD PTR -4[rbp], eax	# записываем значение base_array_length - 1 для j на стек
	jmp	.L15
.L18:
	mov	eax, DWORD PTR -4[rbp]
	cmp	eax, DWORD PTR -12[rbp]
	je	.L19
	mov	eax, DWORD PTR freaky_array_length[rip]
	lea	edx, 1[rax]
	mov	DWORD PTR freaky_array_length[rip], edx	# увеличиваем значение freaky_array_length на 1
	mov	edx, DWORD PTR -4[rbp]
	movsx	rdx, edx
	lea	rcx, 0[0+rdx*4]
	lea	rdx, base_array[rip]
	mov	edx, DWORD PTR [rcx+rdx]
	cdqe
	lea	rcx, 0[0+rax*4]
	lea	rax, freaky_array[rip]
	mov	DWORD PTR [rcx+rax], edx	# записываем очередное значение freaky_array
	jmp	.L17
.L19:
	nop
.L17:
	sub	DWORD PTR -4[rbp], 1	# уменьшаем значение j на 1
.L15:
	cmp	DWORD PTR -4[rbp], 0
	jns	.L18
	nop
	nop
	pop	rbp
	ret
	.size	fill_freaky_array, .-fill_freaky_array
	.section	.rodata
.LC4:
	.string	"Incorrect length = %d\n"
.LC5:
	.string	"Freaky array values:"
.LC6:
	.string	"Freaky array is empty"
	.text
	.globl	main
	.type	main, @function
main:
	endbr64
	push	rbp
	mov	rbp, rsp
	mov	eax, 0
	call	try_input_base_array
	test	eax, eax	# проверяем значение возврата try_input_base_array
	jne	.L21
	mov	eax, DWORD PTR base_array_length[rip]
	mov	esi, eax
	lea	rax, .LC4[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT
	mov	eax, 1	# записываем возвращаемый результат в регистр (1 = main отработал не совсем так как ожидалось)
	jmp	.L22
.L21:
	mov	eax, 0
	call	fill_freaky_array
	mov	eax, DWORD PTR freaky_array_length[rip]
	test	eax, eax
	je	.L23
	lea	rax, .LC5[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT
	mov	eax, DWORD PTR freaky_array_length[rip]		#  записываем значение freaky_array_length в регистр 2 агрумента esi
	mov	esi, eax
	lea	rax, freaky_array[rip]
	mov	rdi, rax		#  записываем значение адреса freaky_array в регистр 1 агрумента rdi
	call	print_array	# вызываем print_array
	jmp	.L24
.L23:
	lea	rax, .LC6[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT
.L24:
	mov	edi, 10
	call	putchar@PLT
	mov	eax, 0	# записываем возвращаемый результат в регистр (0 = вызов main завершился успешно)
.L22:
	pop	rbp
	ret	# выходим из функции main
	.size	main, .-main
	.ident	"GCC: (Ubuntu 11.2.0-19ubuntu1) 11.2.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	1f - 0f
	.long	4f - 1f
	.long	5
0:
	.string	"GNU"
1:
	.align 8
	.long	0xc0000002
	.long	3f - 2f
2:
	.long	0x3
3:
	.align 8
4:
