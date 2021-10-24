.section .text
.global _start
_start:
	mov $0, %al
	sete %al
	ret

