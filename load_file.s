# a0 - ����� ��������, � ������� �������� ��� �����; a1 - text_size
load_file:
    mv t0 a0
    mv t4 a1
    open_from_reg(t0, READ_ONLY)
    li		t1 -1			# �������� �� ���������� ��������
    beq		a0 t1 er_name_read	# ������ �������� �����
    mv   	t0 a0       	# ���������� ����������� �����
    ###############################################################
    # ��������� ���������� ����� ������ ��� ��� ������ � ����
    allocate_from_reg(t4)		# ��������� �������� � a0
    mv 		t3, a0			# ���������� ������ ���� � ��������
    mv 		t5, a0			# ���������� ����������� ������ ���� � ��������
    #li		t4, TEXT_SIZE	# ���������� ��������� ��� ���������
    mv		t6, zero		# ��������� ��������� ����� ������������ ������
    ###############################################################
read_loop:
    # ������ ���������� �� ��������� �����
    ###read(s0, strbuf, TEXT_SIZE)
    read_addr_all_reg(t0, t5, t4) # ������ ��� ������ ����� �� ��������
    # �������� �� ���������� ������
    beq		a0 t1 er_read	# ������ ������
    mv   	t2 a0       	# ���������� ����� ������
    add 	t6, t6, t2		# ������ ������ ������������� �� ����������� ������
    # ��� ����� ������������ ������ �������, ��� ������ ������,
    # ���������� ��������� �������.
    bne		t2 t4 end_loop
    # ����� ��������� ����� � ���������
    allocate_from_reg(t4)		# ��������� ����� �� �����, �� ���� ����� ��...
    add		t5 t5 t2		# ����� ��� ������ ��������� �� ������ ������
    b read_loop				# ��������� ��������� ������ ������ �� �����
end_loop:
    ###############################################################
    # �������� �����
    close(t0)
    #li   a7, 57       # ��������� ����� �������� �����
    #mv   a0, s0       # ���������� �����
    #ecall             # �������� �����
    ###############################################################
    # ��������� ���� � ����� ����������� ������
    ###la	t0 strbuf	 # ����� ������ ������
    mv	a0 t3		# ����� ������ � ����
    add a0 a0 t6	# ����� ���������� ������������ �������
    addi a0 a0 1	# ����� ��� ����
    sb	zero (a0)	# ������ ���� � ����� ������
    ###############################################################
    # ����� ������ �� �������
    ###la 	a0 strbuf
    mv	a0	t3	# ����� ������ ������ �� ����
    mv a1 t6 # �����
    ret

er_name_read:
    # ��������� �� ��������� ����� �����
    la		a0 er_name_mes
    li		a7 4
    ecall
    # � ���������� ���������
    exit
er_read:
    # ��������� �� ��������� ������
    la		a0 er_read_mes
    li		a7 4
    ecall
    # � ���������� ���������
    exit