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
	
	# Huan's data section . [newline] duplicated
	promptDay: .asciiz "Nhap ngay DAY: "
	promptMonth: .asciiz "Nhap thang MONTH: "
	promptYear: .asciiz "Nhap nam YEAR: "
	slash: .asciiz "/"
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

#-------------------------------- Huan's Function Section ----------------------------------------------

#----------------------- Test Main ----------------------------#
#main:
#	# main prolog
#	
#	addi $sp, $sp, -4
#	sw $ra, 0($sp) # push in $ra
#	addi $sp, $sp, -4
#	sw $fp, 0($sp) # push in $fp
#	addi $sp, $sp, -12 # reserved for TIME as STRING
#	addi $sp, $sp, -4 # reserved for DAY as INT
#	addi $sp, $sp, -4 # reserved for MONTH as INT
#	addi $sp, $sp, -4 # reserved for YEAR as INT
#	add $fp, $sp, $zero # $fp = $sp
#	
#	# main body
#	add $a0, $zero, $fp # $a0 points to [YEAR, MONTH, DAY]
#	addi $a1, $fp, 12 # $a1 stores address of TIME STRING
#	jal nhap
#	add $a0, $zero, $fp # $a0 points to [YEAR, MONTH, DAY]
#	jal xuat
#
#	addi $a0, $fp, 12 # $a1 stores address of TIME STRING
#	addi $v0, $zero, 4
#	syscall
#
#	# main epilog
#	addi $sp, $fp, 24 # pop local variables
#	lw $fp, 0($sp) # pop $fp
#	addi $sp, $sp, 4
#	lw $ra, 0($sp) # pop $ra
#	addi $sp, $sp, 4
#	addi $v0, $zero, 10
#	syscall
#----------------------- End Test Main ----------------------------#

# ----------------------------------------------------------------------
# FUNCTION: nhap - Input [YEAR, MONTH, DAY] as INT
# PARAM: $a0 - address of array [YEAR, MONTH, DAY] as INT
# RETURN: nothing
# ----------------------------------------------------------------------
nhap:
	# nhap prolog
	addi $sp, $sp, -4
	sw $ra, 0($sp) # push in $ra
	addi $sp, $sp, -4
	sw $fp, 0($sp) # push in $fp
	addi $sp, $sp, -24 # reserved for character buffer
	add $fp, $sp, $zero # $fp = $sp

	# nhap body
	add $t0, $a0, $zero # save $a0 to $t0 as it will be altered
	readLoop:
		# read DAY
		addi $v0, $zero, 4 # print prompt
		la $a0, promptDay
		syscall
		add $a0, $fp, $zero
		addi $a1, $zero, 3
		addi $v0, $zero, 8 # read string
		syscall
		addi $v0, $zero, 4 # print newline
		la $a0, newline
		syscall
		# read MONTH
		addi $v0, $zero, 4 # print prompt
		la $a0, promptMonth
		syscall
		addi $a0, $fp, 8
		addi $a1, $zero, 3
		addi $v0, $zero, 8 # read string
		syscall
		addi $v0, $zero, 4 # print newline
		la $a0, newline
		syscall
		# read YEAR
		addi $v0, $zero, 4 # print prompt
		la $a0, promptYear
		syscall
		addi $a0, $fp, 16
		addi $a1, $zero, 5
		addi $v0, $zero, 8 # read string
		syscall
		addi $v0, $zero, 4 # print newline
		la $a0, newline
		syscall
		# check DAY, MONTH, YEAR
		addi $sp, $sp, -4 # push in $t0
		sw $t0, 0($sp)
		add $a0, $fp, $zero # pass in parameter
		jal check
		lw $t0, 0($sp) # pop $t0
		addi $sp, $sp, 4
		beq $v0, $zero, readLoop
	
	# convert DAY, MONTH, YEAR to Int
		# convert DAY
		addi $sp, $sp, -4 # push in $t0
		sw $t0, 0($sp)
		add $a0, $fp, $zero # pass in parameter
		jal convertToInt
		lw $t0, 0($sp) # pop $t0
		sw $v0, 8($t0)
		addi $sp, $sp, 4
		# convert MONTH
		addi $sp, $sp, -4 # push in $t0
		sw $t0, 0($sp)
		addi $a0, $fp, 8 # pass in parameter
		jal convertToInt
		lw $t0, 0($sp) # pop $t0
		sw $v0, 4($t0)
		addi $sp, $sp, 4
		# convert to YEAR
		addi $sp, $sp, -4 # push in $t0
		sw $t0, 0($sp)
		addi $a0, $fp, 16 # pass in parameter
		jal convertToInt
		lw $t0, 0($sp) # pop $t0
		sw $v0, 0($t0)
		addi $sp, $sp, 4
	
	# nhap epilog
	addi $sp, $sp, 24 # pop character buffer
	lw $fp, 0($sp) # pop $fp
	addi $sp, $sp, 4
	lw $ra, 0($sp) # pop $ra
	addi $sp, $sp, 4
	jr $ra # return to caller

# [!!! NOTE !!!]: This is a function for TESTING PURPOSE ONLY
# ----------------------------------------------------------------------
# FUNCTION: xuat - Output DAY/MONTH/YEAR
# PARAM: $a0 - address of array [YEAR, MONTH, DAY] as INT
# RETURN: nothing
# ----------------------------------------------------------------------
xuat:
	# xuat prolog
	addi $sp, $sp, -4
	sw $ra, 0($sp) # push in $ra
	addi $sp, $sp, -4
	sw $fp, 0($sp) # push in $fp
	add $fp, $sp, $zero # $fp = $sp

	# xuat body
	add $t0, $a0, $zero # save $a0 to $t0 as it will be altered
		# print DAY
		addi $v0, $zero, 1
		lw $a0, 8($t0)
		syscall
		# add slash
		addi $v0, $zero, 4
		la $a0, slash
		syscall
		# print MONTH
		addi $v0, $zero, 1
		lw $a0, 4($t0)
		syscall
		# add slash
		addi $v0, $zero, 4
		la $a0, slash
		syscall
		# print YEAR
		addi $v0, $zero, 1
		lw $a0, 0($t0)
		syscall

	# xuat epilog
	lw $fp, 0($sp) # pop $fp
	addi $sp, $sp, 4
	lw $ra, 0($sp) # pop $ra
	addi $sp, $sp, 4
	jr $ra # return to caller

# ----------------------------------------------------------------------
# FUNCTION: check - Validate user input
# PARAM: $a0 - address of array [YEAR, MONTH, DAY] as STRING
# RETURN: $v0 - [0 - FALSE] [1 - TRUE]
# ----------------------------------------------------------------------
check:
	# check prolog
	addi $sp, $sp, -4
	sw $ra, 0($sp) # push in $ra
	addi $sp, $sp, -4
	sw $fp, 0($sp) # push in $fp
	addi $sp, $sp, -4 # DAY
	addi $sp, $sp, -4 # MONTH
	addi $sp, $sp, -4 # YEAR
	add $fp, $sp, $zero # $fp = $sp

	# check body
	add $t0, $zero, $a0 # save $a0 to $t0 as it will be altered
	# check for numbers
		# check DAY
		addi $sp, $sp, -4 # push $t0
		sw $t0, 0($sp)
		add $a0, $t0, $zero
		jal checkNumber
		lw $t0, 0($sp) # pop $t0
		addi $sp, $sp, 4
		beq $v0, $zero, checkFailure
		# check MONTH
		addi $sp, $sp, -4 # push $t0
		sw $t0, 0($sp)
		addi $a0, $t0, 8
		jal checkNumber
		lw $t0, 0($sp) # pop $t0
		addi $sp, $sp, 4
		beq $v0, $zero, checkFailure
		# check YEAR
		addi $sp, $sp, -4 # push $t0
		sw $t0, 0($sp)
		addi $a0, $t0, 16
		jal checkNumber
		lw $t0, 0($sp) # pop $t0
		addi $sp, $sp, 4
		beq $v0, $zero, checkFailure
		
	# convert DAY, MONTH, YEAR to Int
		# convert DAY
		addi $sp, $sp, -4 # push $t0
		sw $t0, 0($sp)
		add $a0, $t0, $zero # pass in parameter
		jal convertToInt
		sw $v0, 8($fp)
		lw $t0, 0($sp) # pop $t0
		addi $sp, $sp, 4
		# convert MONTH
		addi $sp, $sp, -4 # push $t0
		sw $t0, 0($sp)
		addi $a0, $t0, 8 # pass in parameter
		jal convertToInt
		sw $v0, 4($fp)
		lw $t0, 0($sp) # pop $t0
		addi $sp, $sp, 4
		# convert to YEAR
		addi $sp, $sp, -4 # push $t0
		sw $t0, 0($sp)
		addi $a0, $t0, 16 # pass in parameter
		jal convertToInt
		sw $v0, 0($fp)
		lw $t0, 0($sp) # pop $t0
		addi $sp, $sp, 4
	# check MONTH value
	lw $t0, 4($fp) # load MONTH value
	slti $t1, $t0, 13
	beq $t1, $zero, checkFailure
	slt $t1, $zero, $t0
	beq $t1, $zero, checkFailure
	
	# check DAY value
	lw $a0, 4($fp) # load MONTH value to parameter $a0
	lw $a1, 0($fp) # load YEAR value to parameter $a1
	jal dayInMonth
	lw $t0, 8($fp) # load DAY value
	slt $t1, $zero, $t0
	beq $t1, $zero, checkFailure
	slt $t1, $v0, $t0
	bne $t1, $zero, checkFailure
	
	addi $v0, $zero, 1
	j checkEnd
	checkFailure:
	add $v0, $zero, $zero
	
	# check epilog
	checkEnd:
	addi $sp, $sp, 12 # pop local variables
	lw $fp, 0($sp) # pop $fp
	addi $sp, $sp, 4
	lw $ra, 0($sp) # pop $ra
	addi $sp, $sp, 4
	jr $ra # return to caller

# ----------------------------------------------------------------------
# FUNCTION: convertToInt - Convert VALID STRING to INT
# PARAM: $a0 - address of STRING
# RETURN: $v0 - INT result
# ----------------------------------------------------------------------
convertToInt:
	# convertToInt prolog
	addi $sp, $sp, -4
	sw $ra, 0($sp) # push in $ra
	addi $sp, $sp, -4
	sw $fp, 0($sp) # push in $fp
	add $fp, $sp, $zero # $fp = $sp

	# convertToInt body
	add $t0, $zero, $zero
	addi $t1, $zero, 10
	convertLoop:
		lb $t2, 0($a0)
		beq $t2, $zero, endConvertLoop
		beq $t2, $t1, endConvertLoop
		addi $t2, $t2, -48
		mult $t0, $t1
		mflo $t0
		add $t0, $t0, $t2
		addi $a0, $a0, 1
		j convertLoop
	endConvertLoop:
	add $v0, $zero, $t0

	# convertToInt epilog
	lw $fp, 0($sp) # pop $fp
	addi $sp, $sp, 4
	lw $ra, 0($sp) # pop $ra
	addi $sp, $sp, 4
	jr $ra # return to caller

# ----------------------------------------------------------------------
# FUNCTION: checkNumber - Check if a STRING can be converted to INT or not
# PARAM: $a0 - address of STRING
# RETURN: $v0 - [0 - FALSE] [1 - TRUE]
# ----------------------------------------------------------------------
checkNumber:
	# checkNumber prolog
	addi $sp, $sp, -4 # push in $ra
	sw $ra, 0($sp)
	addi $sp, $sp, -4 # push in $fp
	sw $fp, 0($sp)
	add $fp, $sp, $zero # $fp = $sp

	# checkNumber body
	add $t0, $a0, $zero
	addi $t1, $zero, 48
	addi $t2, $zero, 57
	addi $t3, $zero, 10
	addi $v0, $zero, 1
	checkNumberLoop:
		lb $t4, 0($a0)
		beq $t4, $zero, checkNumberEnd
		beq $t4, $t3, checkNumberEnd
		slt $t5, $t4, $t1
		bne $t5, $zero, checkNumberFailure
		slt $t5, $t2, $t4
		bne $t5, $zero, checkNumberFailure
		addi $a0, $a0, 1
		j checkNumberLoop
	checkNumberFailure:
	add $v0, $zero, $zero

	# checkNumber epilog
	checkNumberEnd:
	lw $fp, 0($sp) # pop $fp
	addi $sp, $sp, 4
	lw $ra, 0($sp) # pop $ra
	addi $sp, $sp, 4
	jr $ra

# ----------------------------------------------------------------------
# FUNCTION: dayInMonth - Calculate number of days in a specific MONTH & YEAR
# PARAM: $a0 - MONTH as INT, $a1 - YEAR as INT
# RETURN: $v0 - Number of days in that MONTH & YEAR
# ----------------------------------------------------------------------
dayInMonth:
	# dayInMonth prolog
	addi $sp, $sp, -4 # push in $ra
	sw $ra, 0($sp)
	addi $sp, $sp, -4 # push in $fp
	sw $fp, 0($sp)
	add $fp, $sp, $zero # $fp = $sp

	# dayInMonth body
	add $t0, $zero, $zero
	addi $t1, $zero, 400
	addi $t2, $zero, 4
	addi $t3, $zero, 100
	div $a1, $t1 # if YEAR % 400 == 0, then it's a LEAP YEAR
	mfhi $t4
	beq $t4, $zero, DIM_isLYear
	div $a1, $t2 # else if YEAR % 4 == 0
	mfhi $t4
	div $a1, $t3 # and YEAR % 100 != 0, then it's a LEAP YEAR
	mfhi $t5
	bne $t4, $zero, DIM_notLYear
	beq $t5, $zero, DIM_notLYear
	DIM_isLYear:
	addi $t0, $zero, 1
	DIM_notLYear:
	j calDIM

	calDIM:
	addi $a0, $a0, -1
	beq $a0, $zero, DIM_31 # January
	addi $a0, $a0, -1
	beq $a0, $zero, DIM_28 # February
	addi $a0, $a0, -1
	beq $a0, $zero, DIM_31 # March
	addi $a0, $a0, -1
	beq $a0, $zero, DIM_30 # April
	addi $a0, $a0, -1
	beq $a0, $zero, DIM_31 # May
	addi $a0, $a0, -1
	beq $a0, $zero, DIM_30 # June
	addi $a0, $a0, -1
	beq $a0, $zero, DIM_31 # July
	addi $a0, $a0, -1
	beq $a0, $zero, DIM_31 # August
	addi $a0, $a0, -1
	beq $a0, $zero, DIM_30 # September
	addi $a0, $a0, -1
	beq $a0, $zero, DIM_31 # October
	addi $a0, $a0, -1
	beq $a0, $zero, DIM_30 # November
	addi $a0, $a0, -1
	beq $a0, $zero, DIM_31 # December

	DIM_30:
	addi $v0, $zero, 30
	j DIM_End
	DIM_31:
	addi $v0, $zero, 31
	j DIM_End
	DIM_28:
	addi $v0, $t0, 28
	
	# dayInMonth epilog
	DIM_End:
	lw $fp, 0($sp) # pop $fp
	addi $sp, $sp, 4
	lw $ra, 0($sp) # pop $ra
	addi $sp, $sp, 4
	jr $ra

EndOfFile:
