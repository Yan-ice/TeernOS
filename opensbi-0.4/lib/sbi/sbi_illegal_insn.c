/*
 * SPDX-License-Identifier: BSD-2-Clause
 *
 * Copyright (c) 2019 Western Digital Corporation or its affiliates.
 *
 * Authors:
 *   Anup Patel <anup.patel@wdc.com>
 */

#include <sbi/riscv_asm.h>
#include <sbi/riscv_encoding.h>
#include <sbi/riscv_unpriv.h>
#include <sbi/sbi_bits.h>
#include <sbi/sbi_emulate_csr.h>
#include <sbi/sbi_error.h>
#include <sbi/sbi_illegal_insn.h>
#include <sbi/sbi_trap.h>
#include <sbi/sbi_console.h>

typedef int (*illegal_insn_func)(ulong insn, u32 hartid, ulong mcause,
				 struct sbi_trap_regs *regs,
				 struct sbi_scratch *scratch);

static int truly_illegal_insn(ulong insn, u32 hartid, ulong mcause,
			      struct sbi_trap_regs *regs,
			      struct sbi_scratch *scratch)
{
	return sbi_trap_redirect(regs, scratch, regs->mepc, mcause, insn);
}

static int system_opcode_insn(ulong insn, u32 hartid, ulong mcause,
			      struct sbi_trap_regs *regs,
			      struct sbi_scratch *scratch)
{
	int do_write, rs1_num = (insn >> 15) & 0x1f;
	ulong rs1_val = GET_RS1(insn, regs);
	int csr_num   = (u32)insn >> 20;
	ulong csr_val, new_csr_val;

	if (sbi_emulate_csr_read(csr_num, hartid, regs->mstatus, scratch,
				 &csr_val))
		return truly_illegal_insn(insn, hartid, mcause, regs, scratch);

	do_write = rs1_num;
	switch (GET_RM(insn)) {
	case 1:
		new_csr_val = rs1_val;
		do_write    = 1;
		break;
	case 2:
		new_csr_val = csr_val | rs1_val;
		break;
	case 3:
		new_csr_val = csr_val & ~rs1_val;
		break;
	case 5:
		new_csr_val = rs1_num;
		do_write    = 1;
		break;
	case 6:
		new_csr_val = csr_val | rs1_num;
		break;
	case 7:
		new_csr_val = csr_val & ~rs1_num;
		break;
	default:
		return truly_illegal_insn(insn, hartid, mcause, regs, scratch);
	};

	if (do_write && sbi_emulate_csr_write(csr_num, hartid, regs->mstatus,
					      scratch, new_csr_val))
		return truly_illegal_insn(insn, hartid, mcause, regs, scratch);

	SET_RD(insn, regs, csr_val);

	regs->mepc += 4;

	return 0;
}

static illegal_insn_func illegal_insn_table[32] = {
	truly_illegal_insn, /* 0 */
	truly_illegal_insn, /* 1 */
	truly_illegal_insn, /* 2 */
	truly_illegal_insn, /* 3 */
	truly_illegal_insn, /* 4 */
	truly_illegal_insn, /* 5 */
	truly_illegal_insn, /* 6 */
	truly_illegal_insn, /* 7 */
	truly_illegal_insn, /* 8 */
	truly_illegal_insn, /* 9 */
	truly_illegal_insn, /* 10 */
	truly_illegal_insn, /* 11 */
	truly_illegal_insn, /* 12 */
	truly_illegal_insn, /* 13 */
	truly_illegal_insn, /* 14 */
	truly_illegal_insn, /* 15 */
	truly_illegal_insn, /* 16 */
	truly_illegal_insn, /* 17 */
	truly_illegal_insn, /* 18 */
	truly_illegal_insn, /* 19 */
	truly_illegal_insn, /* 20 */
	truly_illegal_insn, /* 21 */
	truly_illegal_insn, /* 22 */
	truly_illegal_insn, /* 23 */
	truly_illegal_insn, /* 24 */
	truly_illegal_insn, /* 25 */
	truly_illegal_insn, /* 26 */
	truly_illegal_insn, /* 27 */
	system_opcode_insn, /* 28 */
	truly_illegal_insn, /* 29 */
	truly_illegal_insn, /* 30 */
	truly_illegal_insn  /* 31 */
};

int sbi_illegal_insn_handler(u32 hartid, ulong mcause,
			     struct sbi_trap_regs *regs,
			     struct sbi_scratch *scratch)
{
	ulong insn = csr_read(mbadaddr);
	//sbi_printf("[SBI_satp] illegal instruction handled %lx\n", insn);
	// Yan_ice: handler for satp change.
	{
		ulong epc = regs->mepc;
		ulong csr = insn >> 20;
		ulong fn = (insn >> 12) & 0b111;
		ulong src = (insn >> 15) & 0b11111;
		ulong dst = (insn >> 7) & 0b11111;
		ulong opcode = insn & 0b1111111;

		if (csr == 0x180 && opcode == 0x73) {
			sbi_printf("[SBI_satp] handled.\n");
				
			regs->mepc += 4;
			if (fn != 1){
				sbi_printf("[SBI_satp] only csrrw for operating satp are supported!\n");
				return -1;
			}
			if((epc > 0x80200000 && epc < 0x80800000) || epc>0xffffffffffffd000){
				ulong write_val = ((ulong*)regs)[src];
				if(dst != 0){
					((ulong*)regs)[dst] = csr_read(CSR_SATP);
				}
				if(src != 0){
					csr_write(CSR_SATP,write_val);
				}
				sbi_printf("[SBI_satp] satp operate success: %lx\n", csr_read(CSR_SATP));
				return 0;
			}else{
				sbi_printf("[SBI_satp] permission denied for mepc = %lx.\n",epc);
				return 0;
			}
		}
	}
	
	
	if (unlikely((insn & 3) != 3)) {
		if (insn == 0)
			insn = get_insn(regs->mepc, NULL);
		if ((insn & 3) != 3)
			return truly_illegal_insn(insn, hartid, mcause, regs,
						  scratch);
	}

	return illegal_insn_table[(insn & 0x7c) >> 2](insn, hartid, mcause,
						      regs, scratch);
}
