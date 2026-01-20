# AXI-Stream Data Path Implementation

## 📌 Project Overview

This project is a **SystemVerilog RTL implementation of an AXI-Stream based data path**, demonstrating **packet generation, buffering, and consumption** using standard **AXI-Stream ready/valid handshaking**.

The design models a **realistic streaming pipeline**, commonly used in:

* DSP pipelines
* Video / image processing
* Network packet processing
* DMA and accelerator interfaces

This is a **non-dummy, protocol-focused project** suitable for **RTL / SoC / VLSI internships**.

---

## 🧠 Key Features

* Fully synthesizable **SystemVerilog RTL**
* AXI-Stream compliant ready/valid protocol
* Modular streaming pipeline
* FIFO-based backpressure handling
* Packet-level streaming support
* Clean separation of source, buffer, and sink

---

## 🏗️ AXI-Stream Architecture (High-Level)

### Streaming Pipeline

```text
AXI-Stream Packet Generator
        ↓
     AXI-Stream FIFO
        ↓
     AXI-Stream Sink
```

### Modules Description

* **Packet Generator**

  * Generates AXI-Stream packets
  * Drives `TVALID`, `TDATA`, `TLAST`

* **AXI-Stream FIFO**

  * Buffers streaming data
  * Handles backpressure using `TREADY`
  * Prevents data loss

* **AXI-Stream Sink**

  * Consumes stream data
  * Validates packet boundaries

* **Top Module**

  * Integrates generator, FIFO, and sink

---

## 📂 Repository Structure (Actual Implementation)

```text
src/
├── axis_packet_generator.sv   # AXI-Stream source
├── axis_fifo.sv               # AXI-Stream FIFO buffer
├── axis_sink.sv               # AXI-Stream sink
└── axis_top.sv                # Top-level integration

testbench/
└── axis_top_tb.sv             # Testbench (if present)
```

---

## 🔌 AXI-Stream Signals Used

| Signal | Purpose                 |
| ------ | ----------------------- |
| TVALID | Indicates valid data    |
| TREADY | Backpressure control    |
| TDATA  | Stream data payload     |
| TLAST  | End-of-packet indicator |

---

## ⚙️ Design Highlights

* Proper **ready/valid handshake**
* Backpressure-aware FIFO design
* Clean packet boundary handling using `TLAST`
* No combinational loops
* No latch inference
* Fully synthesizable RTL

---

## 🚀 Deployment & Simulation Guide

### 🧰 Prerequisites

**Simulator**

* Xilinx Vivado (recommended)
* Questa / ModelSim
* Synopsys VCS

**OS**

* Linux or Windows

**Knowledge**

* SystemVerilog
* AXI-Stream protocol basics

---

### 📥 Step 1: Clone the Repository

```bash
git clone https://github.com/Srinu-bhimavarapu/AXI_STREAM.git
cd AXI_STREAM
```

---

### 📁 Step 2: File Organization

Ensure directories remain unchanged:

```text
src/
testbench/
```

This structure reflects **industry-style RTL organization**.

---

### ▶️ Step 3: Run Simulation (Vivado)

#### GUI Method

1. Open **Vivado**
2. Create a new **RTL Project**
3. Add all files from `src/`
4. Add testbench files from `testbench/`
5. Set `axis_top` as the top module
6. Run **Behavioral Simulation**

#### Tcl Flow (Preferred)

```tcl
read_verilog src/*.sv
read_verilog testbench/*.sv
set_property top axis_top [current_fileset]
launch_simulation
```

---

## 🧪 Step 4: Testbench Functionality

The testbench validates:

* Packet generation by AXI-Stream source
* FIFO buffering under backpressure
* Correct propagation of `TVALID / TREADY`
* Proper `TLAST` signaling at packet boundaries
* End-to-end data integrity

---

## 🔍 Step 5: Waveform Verification

Verify correct behavior of:

* `TVALID && TREADY` handshakes
* FIFO full / empty behavior
* Continuous data flow under backpressure
* Correct assertion of `TLAST`

**Key Signals**

* `TVALID`
* `TREADY`
* `TDATA`
* `TLAST`

---

## 🏗️ Step 6: Synthesis Check (Optional)

* Run RTL synthesis
* Ensure:

  * No latches
  * Clean elaboration
  * Synthesizable streaming logic

---

## 🧪 Verification Status

* Directed SystemVerilog testbench
* Functional AXI-Stream validation
* Waveform-based protocol checking

---

## 🎯 Learning Outcomes

* Strong understanding of AXI-Stream protocol
* Streaming data pipeline design
* FIFO-based backpressure handling
* Packet-based data flow control
* RTL debugging using waveforms

---

## 📌 Future Enhancements

* Parameterized data widths
* Multiple stream sources and sinks
* AXI-Stream to AXI4 bridge
* Throughput and latency measurement
* UVM-based AXI-Stream verification

---

## 👤 Author

**Srinu Bhimavarapu**
Electronics & Communication Engineering
Focus Areas: RTL Design, AXI Protocols, SoC Architecture

---

## ⭐ Recruiter Note

✔ Hand-written RTL
✔ Protocol-correct AXI-Stream design
✔ Modular streaming architecture
✔ Simulation-validated data path

This project demonstrates **strong streaming protocol fundamentals**, which are essential for **SoC, accelerator, and high-performance RTL roles**.
