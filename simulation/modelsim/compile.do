transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/Seth\ Mueller/Documents/riscv-processor/src +incdir+C:/Users/Seth\ Mueller/Documents/riscv-processor {C:/Users/Seth Mueller/Documents/riscv-processor/src/utils.v}
vlog -vlog01compat -work work +incdir+C:/Users/Seth\ Mueller/Documents/riscv-processor/src/interfaces +incdir+C:/Users/Seth\ Mueller/Documents/riscv-processor {C:/Users/Seth Mueller/Documents/riscv-processor/src/interfaces/memory_mapped_io.v}
vlog -vlog01compat -work work +incdir+C:/Users/Seth\ Mueller/Documents/riscv-processor/src/interfaces +incdir+C:/Users/Seth\ Mueller/Documents/riscv-processor {C:/Users/Seth Mueller/Documents/riscv-processor/src/interfaces/flash.v}
vlog -vlog01compat -work work +incdir+C:/Users/Seth\ Mueller/Documents/riscv-processor/src/interfaces +incdir+C:/Users/Seth\ Mueller/Documents/riscv-processor {C:/Users/Seth Mueller/Documents/riscv-processor/src/interfaces/sram.v}
vlog -vlog01compat -work work +incdir+C:/Users/Seth\ Mueller/Documents/riscv-processor/src/interfaces +incdir+C:/Users/Seth\ Mueller/Documents/riscv-processor {C:/Users/Seth Mueller/Documents/riscv-processor/src/interfaces/vga.v}
vlog -vlog01compat -work work +incdir+C:/Users/Seth\ Mueller/Documents/riscv-processor/src/interfaces +incdir+C:/Users/Seth\ Mueller/Documents/riscv-processor {C:/Users/Seth Mueller/Documents/riscv-processor/src/interfaces/memory.v}
vlog -vlog01compat -work work +incdir+C:/Users/Seth\ Mueller/Documents/riscv-processor/src +incdir+C:/Users/Seth\ Mueller/Documents/riscv-processor {C:/Users/Seth Mueller/Documents/riscv-processor/src/riscv.v}
vlog -vlog01compat -work work +incdir+C:/Users/Seth\ Mueller/Documents/riscv-processor/src/interfaces +incdir+C:/Users/Seth\ Mueller/Documents/riscv-processor {C:/Users/Seth Mueller/Documents/riscv-processor/src/interfaces/ps2.v}
vlog -vlog01compat -work work +incdir+C:/Users/Seth\ Mueller/Documents/riscv-processor/src/pipeline +incdir+C:/Users/Seth\ Mueller/Documents/riscv-processor {C:/Users/Seth Mueller/Documents/riscv-processor/src/pipeline/processorstate.v}
vlog -vlog01compat -work work +incdir+C:/Users/Seth\ Mueller/Documents/riscv-processor/src/pipeline +incdir+C:/Users/Seth\ Mueller/Documents/riscv-processor {C:/Users/Seth Mueller/Documents/riscv-processor/src/pipeline/regbank.v}
vlog -vlog01compat -work work +incdir+C:/Users/Seth\ Mueller/Documents/riscv-processor/src/pipeline +incdir+C:/Users/Seth\ Mueller/Documents/riscv-processor {C:/Users/Seth Mueller/Documents/riscv-processor/src/pipeline/fetch.v}
vlog -vlog01compat -work work +incdir+C:/Users/Seth\ Mueller/Documents/riscv-processor/src/pipeline +incdir+C:/Users/Seth\ Mueller/Documents/riscv-processor {C:/Users/Seth Mueller/Documents/riscv-processor/src/pipeline/decoder.v}
vlog -vlog01compat -work work +incdir+C:/Users/Seth\ Mueller/Documents/riscv-processor/src/pipeline +incdir+C:/Users/Seth\ Mueller/Documents/riscv-processor {C:/Users/Seth Mueller/Documents/riscv-processor/src/pipeline/execute.v}
vlog -vlog01compat -work work +incdir+C:/Users/Seth\ Mueller/Documents/riscv-processor/src/pipeline +incdir+C:/Users/Seth\ Mueller/Documents/riscv-processor {C:/Users/Seth Mueller/Documents/riscv-processor/src/pipeline/memoryaccess.v}
vlog -vlog01compat -work work +incdir+C:/Users/Seth\ Mueller/Documents/riscv-processor/src/pipeline +incdir+C:/Users/Seth\ Mueller/Documents/riscv-processor {C:/Users/Seth Mueller/Documents/riscv-processor/src/pipeline/writeback.v}