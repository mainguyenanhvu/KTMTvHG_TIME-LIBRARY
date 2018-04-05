.data 
	time: .asciiz"04/04/2018"
	time1: .asciiz"28/02/2018"
	time2: .asciiz"29/02/2016"
	Monday: .asciiz"Mon"
	Tuesday: .asciiz"Tue"
	Wednesday: .asciiz"Wed"
	Thursday: .asciiz"Thurs"
	Friday: .asciiz"Fri"
	Saturday: .asciiz"Sat"
	Sunday: .asciiz"Sun"
	newline: .asciiz"\n"
	startAnnounce: .asciiz" 1. Xuat chuoi TIME theo dinh dang DD/MM/YYYY \n 2. Chuyen doi chuoi TIME thanh mot trong cac dinh dang sau: \n     A. MM/DD/YYYY \n     B. Month DD, YYYY \n     C. DD Month, YYYY \n 3. Cho biet ngay vua nhap la ngay thu may trong tuan: \n 4. Kiem tra nam trong chuoi TIME co phai la nam nhuan khong \n 5. Cho biet khoang thoi gian giua chuoi TIME_1 va TIME_2 \n 6. Cho biet 2 nam nhuan gan nhat voi nam trong chuoi time \n"
	charRequestNumber: .space 2
	charRequestAlphabet: .space 2
	stringLuaChon: .asciiz"Lua chon: "
	stringKetQua: .asciiz"Ket qua: "
.text
.globl main
#-----------------------------------------------------------

main: 
	
	#jal GetTime
	#add $a0,$v0,$0
	#li $v0,1 #In kieu int
ChooseRequestNumber:
	#In thong bao va doc ki tu
	la $a0,startAnnounce
	li $v0,4 #In xau ra man hinh
	syscall
	li $v0, 8       #Goi ham nhap 1 ki tu
	la $a0, charRequestNumber        #Tai dia chi de doc
	li $a1, 2       #Chieu dai cua chuoi la 1 byte va 1 null
	syscall         #Luu char tu buffer vao charRequest
	lb $t0,charRequestNumber

	#Kiem tra ki tu nhap vao
	addi $t1,$0,49
	slt $t2,$t0,$t1
	bne $t2,$0,ChooseRequestNumber #Ki tu doc vao <49 (nho hon 1)
	addi $t1,$t1,5 #$t1 la ki tu 54 (so 6)
	slt $t2,$t1,$t0
	bne $t2,$0,ChooseRequestNumber #Ki tu doc vao >54 (lon hon 6)
Choose6:
	bne $t1,$t0,Choose5
	#jal NextLeapYear
	#Luu tru $a0, $v0
	addi $sp,$sp,-8
	sw $a0,0($sp)
	sw $v0,4($sp)
	la $a0,newline
	li $v0,4 #In xau ra man hinh
	syscall
	la $a0,stringLuaChon
	li $v0,4 #In xau ra man hinh
	syscall
	la $a0, charRequestNumber
	li $v0,4    # in ki tu ra nam hinh
	syscall
	la $a0,newline
	li $v0,4 #In xau ra man hinh
	syscall
	la $a0,stringKetQua
	li $v0,4 #In xau ra man hinh
	syscall
	#Tra lai $v0, $a0
	lw $v0,4($sp)
	lw $a0,0($sp)
	addi $sp,$sp,8
	j EndChooseRequestNumber
Choose5:
	addi $t1,$t1,-1
	bne $t1,$t0,Choose4
	#jal Nhap time1
	#jal Nhap time2
	la $a0,time1 #($v0)
	la $a1,time2 #($v1)
	jal GetTime
	#Luu tru $a0, $v0
	addi $sp,$sp,-8
	sw $a0,0($sp)
	sw $v0,4($sp)
	la $a0,newline
	li $v0,4 #In xau ra man hinh
	syscall
	la $a0,stringLuaChon
	li $v0,4 #In xau ra man hinh
	syscall
	la $a0, charRequestNumber
	li $v0,4    # in ki tu ra nam hinh
	syscall
	la $a0,newline
	li $v0,4 #In xau ra man hinh
	syscall
	la $a0,stringKetQua
	li $v0,4 #In xau ra man hinh
	syscall
	#Tra lai $v0, $a0
	lw $v0,4($sp)
	lw $a0,0($sp)
	addi $sp,$sp,8
	#In ket qua
	add $a0,$v0,$0
	li $v0,1 #In kieu int
	syscall
	j EndChooseRequestNumber
Choose4:
	addi $t1,$t1,-1
	bne $t1,$t0,Choose3
	#jal LeapYear
	#Luu tru $a0, $v0
	addi $sp,$sp,-8
	sw $a0,0($sp)
	sw $v0,4($sp)
	la $a0,newline
	li $v0,4 #In xau ra man hinh
	syscall
	la $a0,stringLuaChon
	li $v0,4 #In xau ra man hinh
	syscall
	la $a0, charRequestNumber
	li $v0,4    # in ki tu ra nam hinh
	syscall
	la $a0,newline
	li $v0,4 #In xau ra man hinh
	syscall
	la $a0,stringKetQua
	li $v0,4 #In xau ra man hinh
	syscall
	#Tra lai $v0, $a0
	lw $v0,4($sp)
	lw $a0,0($sp)
	addi $sp,$sp,8
	j EndChooseRequestNumber
Choose3:
	addi $t1,$t1,-1
	bne $t1,$t0,Choose2
	la $a0,time
	jal Weekday
	#Luu tru $a0, $v0
	addi $sp,$sp,-8
	sw $a0,0($sp)
	sw $v0,4($sp)
	la $a0,newline
	li $v0,4 #In xau ra man hinh
	syscall
	la $a0,stringLuaChon
	li $v0,4 #In xau ra man hinh
	syscall
	la $a0, charRequestNumber
	li $v0,4    # in ki tu ra nam hinh
	syscall
	la $a0,newline
	li $v0,4 #In xau ra man hinh
	syscall
	la $a0,stringKetQua
	li $v0,4 #In xau ra man hinh
	syscall
	#Tra lai $v0, $a0
	lw $v0,4($sp)
	lw $a0,0($sp)
	addi $sp,$sp,8
	#In ket qua la xau thu trong tuan
	add $a0,$v0,$0
	li $v0,4 #In xau ra man hinh
	syscall
	j EndChooseRequestNumber
Choose2:
	addi $t1,$t1,-1
	bne $t1,$t0,Choose1
	ChooseRequestAlphabet:
		li $v0, 8       #Goi ham nhap 1 ki tu
		la $a0, charRequestAlphabet        #Tai dia chi de doc
		li $a1, 2       #Chieu dai cua chuoi la 1 byte va 1 null
		syscall         #Luu char tu buffer vao charRequest
		lb $t0,charRequestAlphabet

		#Kiem tra ki tu nhap vao
		addi $t1,$0,65 #Ki tu "A"
		slt $t2,$t0,$t1
		bne $t2,$0,ChooseRequestAlphabet #Ki tu doc vao <65 (nho hon "A")
		addi $t1,$t1,2 #$t1 la ki tu 67 ("C")
		slt $t2,$t1,$t0
		bne $t2,$0,ChooseRequestAlphabet #Ki tu doc vao >67 (lon hon "C")
	EndChooseRequestAlphabet:
	add $a1,$0,$t0
	la $a0,time
	#jal Convert
	#Luu tru $a0, $v0
	addi $sp,$sp,-8
	sw $a0,0($sp)
	sw $v0,4($sp)
	la $a0,newline
	li $v0,4 #In xau ra man hinh
	syscall
	la $a0,stringLuaChon
	li $v0,4 #In xau ra man hinh
	syscall
	la $a0, charRequestNumber
	li $v0,4    # in ki tu ra nam hinh
	syscall
	la $a0, charRequestAlphabet
	li $v0,4    # in ki tu ra nam hinh
	syscall
	la $a0,newline
	li $v0,4 #In xau ra man hinh
	syscall
	la $a0,stringKetQua
	li $v0,4 #In xau ra man hinh
	syscall
	#Tra lai $v0, $a0
	lw $v0,4($sp)
	lw $a0,0($sp)
	addi $sp,$sp,8
	j EndChooseRequestNumber
Choose1:
	#jal 
	addi $sp,$sp,-8
	sw $a0,0($sp)
	sw $v0,4($sp)
	la $a0,newline
	li $v0,4 #In xau ra man hinh
	syscall
	la $a0,stringLuaChon
	li $v0,4 #In xau ra man hinh
	syscall
	la $a0, charRequestNumber
	li $v0,4    # in ki tu ra nam hinh
	syscall
	la $a0,newline
	li $v0,4 #In xau ra man hinh
	syscall
	la $a0,stringKetQua
	li $v0,4 #In xau ra man hinh
	syscall
	#Tra lai $v0, $a0
	lw $v0,4($sp)
	lw $a0,0($sp)
	addi $sp,$sp,8
EndChooseRequestNumber:
	j EndOfFile
#-----------------------------------------------------------

#-----------------------------------------------------------
#Gia su là bién time da duoc truyen vào thanh ghi $a0
#$a0: Luu tham so truyen vào tu bien time
#$v0: Luu ket qua tra ve 
#$t0: Luu so 10
#$t1: Luu kí tu duoc trích ra tu $a0
#$t2: Dem vong lap
#$t3: Luu ket qua tra ve($t3=$t3$t0 + $t1)
Day:

#Luu $ra
addi $sp,$sp,-4 
sw $ra,0($sp) 

#Luu $t0
addi $sp,$sp,-4 
sw $t0,0($sp)

#Luu $t1
addi $sp,$sp,-4 
sw $t1,0($sp)

#Luu $a0
addi $sp,$sp,-4 
sw $a0,0($sp)

#Luu $t2
addi $sp,$sp,-4 
sw $t2,0($sp)

#Luu $t3
addi $sp,$sp,-4 
sw $t3,0($sp)

add $t3,$0,$0 #Gán $t3 = 0
addi $t0,$0,10 #Gán $t0=10
addi $t2,$0,2 #So kí tu trích ra 

LoopExtractDay:
	addi $t2,$t2,-1 #Giam buoc lap
	lb $t1,($a0) #Lay ki tu trong xâu
	addi $t1,$t1,-48 # kí tu -'0' ra int
	addi $a0,$a0,1 #Doi vi trí tro vào kí tu
	mult $t3,$t0 #Nhan $t3 va $t0
	mflo $t3 #Chuyen $LO vao $t3
	add $t3,$t3,$t1 ##$t3= $t3 + $t1
	#Kiem tra dieu kien thoát: $t2=0
	beq $t2,$0,EndLoopED
	j LoopExtractDay
EndLoopED:

#Gán giá tri cho $v0
add $v0,$t3,$0
#Tra lai giá tri cho $t3
lw $t3,0($sp)
addi $sp,$sp,4
#Tra lai giá tri cho $t2
lw $t2,0($sp)
addi $sp,$sp,4 
#Tra lai giá tri cho $a0
lw $a0,0($sp)
addi $sp,$sp,4 
#Tra lai giá tri cho $t1
lw $t1,0($sp)
addi $sp,$sp,4 
#Tra lai giá tri cho $t0
lw $t0,0($sp)
addi $sp,$sp,4 
#Tra lai giá tri cho $ra
lw $ra,0($sp) 
addi $sp,$sp,4 

jr $ra #Tro lai hàm truoc dó
EndDay:
#-----------------------------------------------------------

#-----------------------------------------------------------
#Gia su là bién time da duoc truyen vào thanh ghi $a0
#$a0: Luu tham so truyen vào tu bien time
#$v0: Luu ket qua tra ve 
#$t0: Luu so 10
#$t1: Luu kí tu duoc trích ra tu $a0
#$t2: Dem vong lap
#$t3: Luu ket qua tra ve($t3=$t3$t0 + $t1)
Month:

#Luu $ra
addi $sp,$sp,-4 
sw $ra,0($sp) 

#Luu $t0
addi $sp,$sp,-4 
sw $t0,0($sp)

#Luu $t1
addi $sp,$sp,-4 
sw $t1,0($sp)

#Luu $a0
addi $sp,$sp,-4 
sw $a0,0($sp)

#Luu $t2
addi $sp,$sp,-4 
sw $t2,0($sp)

#Luu $t3
addi $sp,$sp,-4 
sw $t3,0($sp)

add $t3,$0,$0 #Gán $t3 = 0
addi $t0,$0,10 #Gán $t0=10
addi $t2,$0,2 #So kí tu trích ra 
addi $a0,$a0,3 #Bo qua ngay va dau '/'

LoopExtractMonth:
	addi $t2,$t2,-1 #Giam buoc lap
	lb $t1,($a0) #Lay ki tu trong xâu
	addi $t1,$t1,-48 # kí tu -'0' ra int
	addi $a0,$a0,1 #Doi vi trí tro vào kí tu
	mult $t3,$t0 #Nhan $t3 va $t0
	mflo $t3 #Chuyen $LO vao $t3
	add $t3,$t3,$t1 ##$t3= $t3 + $t1
	#Kiem tra dieu kien thoát: $t2=0
	beq $t2,$0,EndLoopEMonth
	j LoopExtractMonth
EndLoopEMonth:

#Gán giá tri cho $v0
add $v0,$t3,$0
#Tra lai giá tri cho $t3
lw $t3,0($sp)
addi $sp,$sp,4
#Tra lai giá tri cho $t2
lw $t2,0($sp)
addi $sp,$sp,4 
#Tra lai giá tri cho $a0
lw $a0,0($sp)
addi $sp,$sp,4 
#Tra lai giá tri cho $t1
lw $t1,0($sp)
addi $sp,$sp,4 
#Tra lai giá tri cho $t0
lw $t0,0($sp)
addi $sp,$sp,4 
#Tra lai giá tri cho $ra
lw $ra,0($sp) 
addi $sp,$sp,4 

jr $ra #Tro lai hàm truoc dó
EndMonth:
#-----------------------------------------------------------

#-----------------------------------------------------------
#Gia su là bién time da duoc truyen vào thanh ghi $a0
#$a0: Luu tham so truyen vào tu bien time
#$v0: Luu ket qua tra ve 
#$t0: Luu so 10
#$t1: Luu kí tu duoc trích ra tu $a0
#$t2: Dem vong lap
#$t3: Luu ket qua tra ve($t3=$t3$t0 + $t1)
Year:

#Luu $ra
addi $sp,$sp,-4 
sw $ra,0($sp) 

#Luu $t0
addi $sp,$sp,-4 
sw $t0,0($sp)

#Luu $t1
addi $sp,$sp,-4 
sw $t1,0($sp)

#Luu $a0
addi $sp,$sp,-4 
sw $a0,0($sp)

#Luu $t2
addi $sp,$sp,-4 
sw $t2,0($sp)

#Luu $t3
addi $sp,$sp,-4 
sw $t3,0($sp)

add $t3,$0,$0 #Gán $t3 = 0
addi $t0,$0,10 #Gán $t0=10
addi $t2,$0,4 #So kí tu trích ra 
addi $a0,$a0,6 #Bo qua ngay va dau '/'

LoopExtractYear:
	addi $t2,$t2,-1 #Giam buoc lap
	lb $t1,($a0) #Lay ki tu trong xâu
	addi $t1,$t1,-48 # kí tu -'0' ra int
	addi $a0,$a0,1 #Doi vi trí tro vào kí tu
	mult $t3,$t0 #Nhan $t3 va $t0
	mflo $t3 #Chuyen $LO vao $t3
	add $t3,$t3,$t1 ##$t3= $t3 + $t1
	#Kiem tra dieu kien thoát: $t2=0
	beq $t2,$0,EndLoopEYear
	j LoopExtractYear
EndLoopEYear:

#Gán giá tri cho $v0
add $v0,$t3,$0
#Tra lai giá tri cho $t3
lw $t3,0($sp)
addi $sp,$sp,4
#Tra lai giá tri cho $t2
lw $t2,0($sp)
addi $sp,$sp,4 
#Tra lai giá tri cho $a0
lw $a0,0($sp)
addi $sp,$sp,4 
#Tra lai giá tri cho $t1
lw $t1,0($sp)
addi $sp,$sp,4 
#Tra lai giá tri cho $t0
lw $t0,0($sp)
addi $sp,$sp,4 
#Tra lai giá tri cho $ra
lw $ra,0($sp) 
addi $sp,$sp,4 

jr $ra #Tro lai hàm truoc dó
EndYear:
#-----------------------------------------------------------

#------------------------------------------------------------
#$a0: Luu bien time
#$t0: Luu ngay
#$t1: Luu thang
#$t2: Luu nam: 2 chu cuoi va luu the ki: 2 so dau + 1
Weekday:
#Luu $ra
addi $sp,$sp,-4 
sw $ra,0($sp) 

#Luu $t0
addi $sp,$sp,-4 
sw $t0,0($sp)

#Luu $t1
addi $sp,$sp,-4 
sw $t1,0($sp)

#Luu $a0
addi $sp,$sp,-4 
sw $a0,0($sp)

#Luu $t2
addi $sp,$sp,-4 
sw $t2,0($sp)

#Luu $t3
addi $sp,$sp,-4 
sw $t3,0($sp)

	jal Day
	add $t0,$v0,$0 

	jal Month
	add $t1,$v0,$0
	
	jal Year
	add $t2,$v0,$0

	add $v0,$t0,$t1
	addi $t3,$0,100
	div $t2,$t3
	mfhi $t3 #Year div 100 + 1= The ki
	addi $t3,$t3,1
	add $v0,$v0,$t3
	
	mflo $t3 #Year mod 100
	add $v0,$v0,$t3

	addi $t2,$0,4
	div $t3,$t2
	mflo $t2  #Year div 4
	add $v0,$v0,$t2
	addi $t2,$0,7
	div $v0,$t2 
	mfhi $v0 #mod 7

SwitchCaseOfWeekday:	
	bne $v0,$0,Mon
	la $v0,Sunday
	j EndSwitchCaseOfWeekday
Mon:
	addi $v0,$v0,-1
	bne $v0,$0,Tue
	la $v0,Monday
	j EndSwitchCaseOfWeekday
Tue:
	addi $v0,$v0,-1
	bne $v0,$0,Web
	la $v0,Tuesday
	j EndSwitchCaseOfWeekday	
Web:
	addi $v0,$v0,-1
	bne $v0,$0,Thurs
	la $v0,Wednesday
	j EndSwitchCaseOfWeekday
Thurs:
	addi $v0,$v0,-1
	bne $v0,$0,Fri
	la $v0,Thursday
	j EndSwitchCaseOfWeekday
Fri:
	addi $v0,$v0,-1
	bne $v0,$0,Sat
	la $v0,Friday
	j EndSwitchCaseOfWeekday
Sat:
	la $v0,Saturday
EndSwitchCaseOfWeekday:
	
#Tra lai giá tri cho $t3
lw $t3,0($sp)
addi $sp,$sp,4
#Tra lai giá tri cho $t2
lw $t2,0($sp)
addi $sp,$sp,4 
#Tra lai giá tri cho $a0
lw $a0,0($sp)
addi $sp,$sp,4 
#Tra lai giá tri cho $t1
lw $t1,0($sp)
addi $sp,$sp,4 
#Tra lai giá tri cho $t0
lw $t0,0($sp)
addi $sp,$sp,4 
#Tra lai giá tri cho $ra
lw $ra,0($sp) 
addi $sp,$sp,4 

jr $ra #Tro lai hàm truoc dó
EndWeekday:
#------------------------------------------------------------------

#------------------------------------------------------------------
#$a0: Luu time1 
#$a1: Luu time2
GetTime:
#Luu $ra
addi $sp,$sp,-4 
sw $ra,0($sp) 

#Luu $t0
addi $sp,$sp,-4 
sw $t0,0($sp)

#Luu $t1
addi $sp,$sp,-4 
sw $t1,0($sp)

#Luu $t2
addi $sp,$sp,-4 
sw $t2,0($sp)

#Luu $t3
addi $sp,$sp,-4 
sw $t3,0($sp)

#Luu $a0
addi $sp,$sp,-4 
sw $a0,0($sp)

#Luu $a1
addi $sp,$sp,-4 
sw $a1,0($sp)
	#Tach year o $a0
	jal Year
	add $t0,$v0,$0
	
	#Tach year o $a1
	add $t3,$a0,$0
	add $a0,$a1,$0
	jal Year
	add $t1,$v0,$0
	add $a0,$t3,$0
	
	# $t2 = Year(time1) - Year(time2)
	sub $t2,$t0,$t1
	beq $t2,$0,EndIfGetTime #$t2=0 thi thoai khoi if
	slt $t3,$t2,$0
	beq $t3,$0,BaseOnMonth #If $t2 > 0 ($t3=0) thi chuyen den xet theo thang.
	sub $t2,$0,$t2 #Doi dau $t2
	
	#Hoan doi a0, a1
	lw $a0,0($sp)
	lw $a1,4($sp)

	BaseOnMonth:
	#Tach thang o $a0
	jal Month
	add $t0,$v0,$0
	
	#Tach Month o $a1
	add $t3,$a0,$0
	add $a0,$a1,$0
	jal Month
	add $t1,$v0,$0
	add $a0,$t3,$0
	
	# $t3 = Month(time1) - Month(time2)
	sub $t3,$t0,$t1
	beq $t3,$0,BaseOnDay #$t3 = 0 thi so sanh den ngay
	slt $t3,$t3,$0
	beq $t3,$0,EndIfGetTime #$t3 > 0 thi thoat khoi if
	addi $t2,$t2,-1
	j EndIfGetTime
	BaseOnDay:
	#Tach Day o $a0
	jal Day
	add $t0,$v0,$0
	
	#Tach Day o $a1
	add $t3,$a0,$0
	add $a0,$a1,$0
	jal Day
	add $t1,$v0,$0
	add $a0,$t3,$0
	
	# $t3 = Day(time1) - Day(time2)
	sub $t3,$t0,$t1
	slt $t3,$t3,$0
	beq $t3,$0,EndIfGetTime #If $t3 >= 0 thi thoat
	addi $t2,$t2,-1
EndIfGetTime:
add $v0,$t2,$0

#Tra lai giá tri cho $a1
lw $a1,0($sp)
addi $sp,$sp,4  
#Tra lai giá tri cho $a0
lw $a0,0($sp)
addi $sp,$sp,4
#Tra lai giá tri cho $t3
lw $t3,0($sp)
addi $sp,$sp,4
#Tra lai giá tri cho $t2
lw $t2,0($sp)
addi $sp,$sp,4 
#Tra lai giá tri cho $t1
lw $t1,0($sp)
addi $sp,$sp,4 
#Tra lai giá tri cho $t0
lw $t0,0($sp)
addi $sp,$sp,4 
#Tra lai giá tri cho $ra
lw $ra,0($sp) 
addi $sp,$sp,4 

jr $ra #Tro lai hàm truoc dó
EndGetTime:
#-----------------------------------------------------------


EndOfFile:
