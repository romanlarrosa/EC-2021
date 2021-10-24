.section .data
# lista:		  .int 0x10000000, 0x10000000, 0x10000000, 0x10000000
#            .int 0x10000000, 0x10000000, 0x10000000, 0x10000000
#            .int 0x10000000, 0x10000000, 0x10000000, 0x10000000
#            .int 0x10000000, 0x10000000, 0x10000000, 0x10000000
# lista:		  .int 0x0fffffff, 0x0fffffff, 0x0fffffff, 0x0fffffff
#            .int 0x0fffffff, 0x0fffffff, 0x0fffffff, 0x0fffffff
#            .int 0x0fffffff, 0x0fffffff, 0x0fffffff, 0x0fffffff
#            .int 0x0fffffff, 0x0fffffff, 0x0fffffff, 0x0fffffff
 lista:		  .int 0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff
            .int 0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff
            .int 0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff
            .int 0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff



longlista:	.int   (.-lista)/4
resultado:	.quad   0
    resto:	.quad		0
  formato: 	.asciz	"media = %ld = 0x%lx hex\nresto = %ld = 0x%lx hex\n"

# opción: 1) no usar printf, 2)3) usar printf/fmt/exit, 4) usar tb main
# 1) as  suma.s -o suma.o
#    ld  suma.o -o suma					1232 B
# 2) as  suma.s -o suma.o				6520 B
#    ld  suma.o -o suma -lc -dynamic-linker /lib64/ld-linux-x86-64.so.2
# 3) gcc suma.s -o suma -no-pie –nostartfiles		6544 B
# 4) gcc suma.s -o suma	-no-pie				8664 B

.section .text
_start: .global _start
# main: .global  main

	call trabajar	# subrutina de usuario
	call imprim_C	# printf()  de libC
	call acabar_L	# exit()   del kernel Linux
#	ret

trabajar:
	mov     $lista, %rbx
	mov  longlista, %ecx
	call media		# == media(&lista, longlista);
	# ret: %eax = media, %edx = resto
	mov  %eax, resultado
  mov  %edx, resto
	ret

media:
  # Suma
	mov  $0, %eax   # retorno y guardado del valor
	mov  $0, %rsi   # contador
  mov  $0, %edx   # registro con acarreos
	mov  $0, %r8d   # suma de los numeros
bucle:
	mov  (%rbx,%rsi,4), %eax # Mover elemento de la lista a %eax
	cltd 						# Extender signo de %eax --> %edx:%eax
	add  	%eax, %r8d
	adc		$0, %edx
	inc   %rsi
	cmp   %rsi,%rcx
	jne    bucle

	mov   %r8d, %eax # Mover la suma al valor de retorno
	cltd 						# Extender signo de %eax --> %edx:%eax

	# Division
	idivl %ecx

	ret

imprim_C:			# requiere libC
	mov   $formato, %rdi
	mov   resultado,%esi
	mov   resultado,%edx
	mov   resto,%ecx
	mov   resto,%r8d
	mov          $0,%eax	# varargin sin xmm
	call  printf		# == printf(formato, res, res);
	ret

acabar_L:
	mov        $60, %rax
	mov  resultado, %rdi
	syscall			# == _exit(resultado)
	ret

acabar_C:			# requiere libC
	mov  resultado, %edi
	call _exit		# ==  exit(resultado)
	ret
