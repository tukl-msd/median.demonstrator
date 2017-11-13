// ==============================================================
// RTL generated by Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC
// Version: 2017.2
// Copyright (C) 1986-2017 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

module Color (
        ap_clk,
        ap_rst,
        ap_start,
        ap_done,
        ap_continue,
        ap_idle,
        ap_ready,
        stream_out_TREADY,
        stream_out_TDATA,
        stream_out_TVALID,
        stream_out_TUSER,
        stream_out_TLAST,
        MdnStream_V_data_V_dout,
        MdnStream_V_data_V_empty_n,
        MdnStream_V_data_V_read,
        MdnStream_V_user_V_dout,
        MdnStream_V_user_V_empty_n,
        MdnStream_V_user_V_read,
        MdnStream_V_last_V_dout,
        MdnStream_V_last_V_empty_n,
        MdnStream_V_last_V_read
);

parameter    ap_ST_fsm_pp0_stage0 = 1'd1;

input   ap_clk;
input   ap_rst;
input   ap_start;
output   ap_done;
input   ap_continue;
output   ap_idle;
output   ap_ready;
input   stream_out_TREADY;
output  [23:0] stream_out_TDATA;
output   stream_out_TVALID;
output  [0:0] stream_out_TUSER;
output  [0:0] stream_out_TLAST;
input  [7:0] MdnStream_V_data_V_dout;
input   MdnStream_V_data_V_empty_n;
output   MdnStream_V_data_V_read;
input  [0:0] MdnStream_V_user_V_dout;
input   MdnStream_V_user_V_empty_n;
output   MdnStream_V_user_V_read;
input  [0:0] MdnStream_V_last_V_dout;
input   MdnStream_V_last_V_empty_n;
output   MdnStream_V_last_V_read;

reg ap_done;
reg ap_idle;
reg ap_ready;

reg    ap_done_reg;
(* fsm_encoding = "none" *) reg   [0:0] ap_CS_fsm;
wire    ap_CS_fsm_pp0_stage0;
wire    ap_enable_reg_pp0_iter0;
reg    ap_enable_reg_pp0_iter1;
reg    ap_enable_reg_pp0_iter2;
reg    ap_idle_pp0;
reg    ap_block_state1_pp0_stage0_iter0;
wire    ap_block_state2_pp0_stage0_iter1;
wire    stream_out_V_data_V_1_ack_in;
reg   [0:0] empty_n_3_reg_87;
reg    ap_block_state2_io;
wire    stream_out_V_user_V_1_ack_in;
wire    stream_out_V_last_V_1_ack_in;
reg    ap_block_state3_pp0_stage0_iter2;
reg   [0:0] ap_reg_pp0_iter1_empty_n_3_reg_87;
reg    ap_block_state3_io;
reg    ap_block_pp0_stage0_flag00011001;
reg   [23:0] stream_out_V_data_V_1_data_out;
reg    stream_out_V_data_V_1_vld_in;
wire    stream_out_V_data_V_1_vld_out;
wire    stream_out_V_data_V_1_ack_out;
reg   [23:0] stream_out_V_data_V_1_payload_A;
reg   [23:0] stream_out_V_data_V_1_payload_B;
reg    stream_out_V_data_V_1_sel_rd;
reg    stream_out_V_data_V_1_sel_wr;
wire    stream_out_V_data_V_1_sel;
wire    stream_out_V_data_V_1_load_A;
wire    stream_out_V_data_V_1_load_B;
reg   [1:0] stream_out_V_data_V_1_state;
wire    stream_out_V_data_V_1_state_cmp_full;
reg   [0:0] stream_out_V_user_V_1_data_out;
reg    stream_out_V_user_V_1_vld_in;
wire    stream_out_V_user_V_1_vld_out;
wire    stream_out_V_user_V_1_ack_out;
reg   [0:0] stream_out_V_user_V_1_payload_A;
reg   [0:0] stream_out_V_user_V_1_payload_B;
reg    stream_out_V_user_V_1_sel_rd;
reg    stream_out_V_user_V_1_sel_wr;
wire    stream_out_V_user_V_1_sel;
wire    stream_out_V_user_V_1_load_A;
wire    stream_out_V_user_V_1_load_B;
reg   [1:0] stream_out_V_user_V_1_state;
wire    stream_out_V_user_V_1_state_cmp_full;
reg   [0:0] stream_out_V_last_V_1_data_out;
reg    stream_out_V_last_V_1_vld_in;
wire    stream_out_V_last_V_1_vld_out;
wire    stream_out_V_last_V_1_ack_out;
reg   [0:0] stream_out_V_last_V_1_payload_A;
reg   [0:0] stream_out_V_last_V_1_payload_B;
reg    stream_out_V_last_V_1_sel_rd;
reg    stream_out_V_last_V_1_sel_wr;
wire    stream_out_V_last_V_1_sel;
wire    stream_out_V_last_V_1_load_A;
wire    stream_out_V_last_V_1_load_B;
reg   [1:0] stream_out_V_last_V_1_state;
wire    stream_out_V_last_V_1_state_cmp_full;
reg    stream_out_TDATA_blk_n;
wire    ap_block_pp0_stage0_flag00000000;
reg   [7:0] tmp_data_V_reg_91;
reg   [0:0] tmp_user_V_reg_98;
reg   [0:0] tmp_last_V_reg_103;
wire   [23:0] tmp_data_V_1_fu_79_p4;
reg    ap_block_pp0_stage0_flag00011011;
reg    MdnStream_V_data_V0_update;
wire   [0:0] empty_n_nbread_fu_40_p4_0;
reg    ap_block_pp0_stage0_flag00001001;
reg   [0:0] ap_NS_fsm;
reg    ap_idle_pp0_0to1;
reg    ap_reset_idle_pp0;
wire    ap_enable_pp0;

// power-on initialization
initial begin
#0 ap_done_reg = 1'b0;
#0 ap_CS_fsm = 1'd1;
#0 ap_enable_reg_pp0_iter1 = 1'b0;
#0 ap_enable_reg_pp0_iter2 = 1'b0;
#0 stream_out_V_data_V_1_sel_rd = 1'b0;
#0 stream_out_V_data_V_1_sel_wr = 1'b0;
#0 stream_out_V_data_V_1_state = 2'd0;
#0 stream_out_V_user_V_1_sel_rd = 1'b0;
#0 stream_out_V_user_V_1_sel_wr = 1'b0;
#0 stream_out_V_user_V_1_state = 2'd0;
#0 stream_out_V_last_V_1_sel_rd = 1'b0;
#0 stream_out_V_last_V_1_sel_wr = 1'b0;
#0 stream_out_V_last_V_1_state = 2'd0;
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_CS_fsm <= ap_ST_fsm_pp0_stage0;
    end else begin
        ap_CS_fsm <= ap_NS_fsm;
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_done_reg <= 1'b0;
    end else begin
        if ((1'b1 == ap_continue)) begin
            ap_done_reg <= 1'b0;
        end else if (((1'b1 == ap_enable_reg_pp0_iter2) & (ap_block_pp0_stage0_flag00011001 == 1'b0))) begin
            ap_done_reg <= 1'b1;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter1 <= 1'b0;
    end else begin
        if (((1'b1 == ap_CS_fsm_pp0_stage0) & (ap_block_pp0_stage0_flag00011011 == 1'b0))) begin
            ap_enable_reg_pp0_iter1 <= ap_start;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter2 <= 1'b0;
    end else begin
        if ((ap_block_pp0_stage0_flag00011011 == 1'b0)) begin
            ap_enable_reg_pp0_iter2 <= ap_enable_reg_pp0_iter1;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        stream_out_V_data_V_1_sel_rd <= 1'b0;
    end else begin
        if (((1'b1 == stream_out_V_data_V_1_ack_out) & (1'b1 == stream_out_V_data_V_1_vld_out))) begin
            stream_out_V_data_V_1_sel_rd <= ~stream_out_V_data_V_1_sel_rd;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        stream_out_V_data_V_1_sel_wr <= 1'b0;
    end else begin
        if (((1'b1 == stream_out_V_data_V_1_vld_in) & (1'b1 == stream_out_V_data_V_1_ack_in))) begin
            stream_out_V_data_V_1_sel_wr <= ~stream_out_V_data_V_1_sel_wr;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        stream_out_V_data_V_1_state <= 2'd0;
    end else begin
        if ((((1'b0 == stream_out_V_data_V_1_vld_in) & (1'b1 == stream_out_V_data_V_1_ack_out) & (stream_out_V_data_V_1_state == 2'd3)) | ((1'b0 == stream_out_V_data_V_1_vld_in) & (stream_out_V_data_V_1_state == 2'd2)))) begin
            stream_out_V_data_V_1_state <= 2'd2;
        end else if ((((1'b1 == stream_out_V_data_V_1_vld_in) & (1'b0 == stream_out_V_data_V_1_ack_out) & (stream_out_V_data_V_1_state == 2'd3)) | ((1'b0 == stream_out_V_data_V_1_ack_out) & (stream_out_V_data_V_1_state == 2'd1)))) begin
            stream_out_V_data_V_1_state <= 2'd1;
        end else if ((((1'b1 == stream_out_V_data_V_1_vld_in) & (stream_out_V_data_V_1_state == 2'd2)) | ((1'b1 == stream_out_V_data_V_1_ack_out) & (stream_out_V_data_V_1_state == 2'd1)) | ((stream_out_V_data_V_1_state == 2'd3) & ~((1'b1 == stream_out_V_data_V_1_vld_in) & (1'b0 == stream_out_V_data_V_1_ack_out)) & ~((1'b0 == stream_out_V_data_V_1_vld_in) & (1'b1 == stream_out_V_data_V_1_ack_out))))) begin
            stream_out_V_data_V_1_state <= 2'd3;
        end else begin
            stream_out_V_data_V_1_state <= 2'd2;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        stream_out_V_last_V_1_sel_rd <= 1'b0;
    end else begin
        if (((1'b1 == stream_out_V_last_V_1_ack_out) & (1'b1 == stream_out_V_last_V_1_vld_out))) begin
            stream_out_V_last_V_1_sel_rd <= ~stream_out_V_last_V_1_sel_rd;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        stream_out_V_last_V_1_sel_wr <= 1'b0;
    end else begin
        if (((1'b1 == stream_out_V_last_V_1_vld_in) & (1'b1 == stream_out_V_last_V_1_ack_in))) begin
            stream_out_V_last_V_1_sel_wr <= ~stream_out_V_last_V_1_sel_wr;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        stream_out_V_last_V_1_state <= 2'd0;
    end else begin
        if ((((1'b0 == stream_out_V_last_V_1_vld_in) & (1'b1 == stream_out_V_last_V_1_ack_out) & (2'd3 == stream_out_V_last_V_1_state)) | ((1'b0 == stream_out_V_last_V_1_vld_in) & (2'd2 == stream_out_V_last_V_1_state)))) begin
            stream_out_V_last_V_1_state <= 2'd2;
        end else if ((((1'b1 == stream_out_V_last_V_1_vld_in) & (1'b0 == stream_out_V_last_V_1_ack_out) & (2'd3 == stream_out_V_last_V_1_state)) | ((1'b0 == stream_out_V_last_V_1_ack_out) & (2'd1 == stream_out_V_last_V_1_state)))) begin
            stream_out_V_last_V_1_state <= 2'd1;
        end else if ((((1'b1 == stream_out_V_last_V_1_vld_in) & (2'd2 == stream_out_V_last_V_1_state)) | ((1'b1 == stream_out_V_last_V_1_ack_out) & (2'd1 == stream_out_V_last_V_1_state)) | ((2'd3 == stream_out_V_last_V_1_state) & ~((1'b1 == stream_out_V_last_V_1_vld_in) & (1'b0 == stream_out_V_last_V_1_ack_out)) & ~((1'b0 == stream_out_V_last_V_1_vld_in) & (1'b1 == stream_out_V_last_V_1_ack_out))))) begin
            stream_out_V_last_V_1_state <= 2'd3;
        end else begin
            stream_out_V_last_V_1_state <= 2'd2;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        stream_out_V_user_V_1_sel_rd <= 1'b0;
    end else begin
        if (((1'b1 == stream_out_V_user_V_1_ack_out) & (1'b1 == stream_out_V_user_V_1_vld_out))) begin
            stream_out_V_user_V_1_sel_rd <= ~stream_out_V_user_V_1_sel_rd;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        stream_out_V_user_V_1_sel_wr <= 1'b0;
    end else begin
        if (((1'b1 == stream_out_V_user_V_1_vld_in) & (1'b1 == stream_out_V_user_V_1_ack_in))) begin
            stream_out_V_user_V_1_sel_wr <= ~stream_out_V_user_V_1_sel_wr;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        stream_out_V_user_V_1_state <= 2'd0;
    end else begin
        if ((((1'b0 == stream_out_V_user_V_1_vld_in) & (1'b1 == stream_out_V_user_V_1_ack_out) & (2'd3 == stream_out_V_user_V_1_state)) | ((1'b0 == stream_out_V_user_V_1_vld_in) & (2'd2 == stream_out_V_user_V_1_state)))) begin
            stream_out_V_user_V_1_state <= 2'd2;
        end else if ((((1'b1 == stream_out_V_user_V_1_vld_in) & (1'b0 == stream_out_V_user_V_1_ack_out) & (2'd3 == stream_out_V_user_V_1_state)) | ((1'b0 == stream_out_V_user_V_1_ack_out) & (2'd1 == stream_out_V_user_V_1_state)))) begin
            stream_out_V_user_V_1_state <= 2'd1;
        end else if ((((1'b1 == stream_out_V_user_V_1_vld_in) & (2'd2 == stream_out_V_user_V_1_state)) | ((1'b1 == stream_out_V_user_V_1_ack_out) & (2'd1 == stream_out_V_user_V_1_state)) | ((2'd3 == stream_out_V_user_V_1_state) & ~((1'b1 == stream_out_V_user_V_1_vld_in) & (1'b0 == stream_out_V_user_V_1_ack_out)) & ~((1'b0 == stream_out_V_user_V_1_vld_in) & (1'b1 == stream_out_V_user_V_1_ack_out))))) begin
            stream_out_V_user_V_1_state <= 2'd3;
        end else begin
            stream_out_V_user_V_1_state <= 2'd2;
        end
    end
end

always @ (posedge ap_clk) begin
    if (((1'b1 == ap_CS_fsm_pp0_stage0) & (ap_block_pp0_stage0_flag00011001 == 1'b0))) begin
        ap_reg_pp0_iter1_empty_n_3_reg_87 <= empty_n_3_reg_87;
        empty_n_3_reg_87 <= empty_n_nbread_fu_40_p4_0;
        tmp_data_V_reg_91 <= MdnStream_V_data_V_dout;
        tmp_last_V_reg_103 <= MdnStream_V_last_V_dout;
        tmp_user_V_reg_98 <= MdnStream_V_user_V_dout;
    end
end

always @ (posedge ap_clk) begin
    if ((1'b1 == stream_out_V_data_V_1_load_A)) begin
        stream_out_V_data_V_1_payload_A <= tmp_data_V_1_fu_79_p4;
    end
end

always @ (posedge ap_clk) begin
    if ((1'b1 == stream_out_V_data_V_1_load_B)) begin
        stream_out_V_data_V_1_payload_B <= tmp_data_V_1_fu_79_p4;
    end
end

always @ (posedge ap_clk) begin
    if ((1'b1 == stream_out_V_last_V_1_load_A)) begin
        stream_out_V_last_V_1_payload_A <= tmp_last_V_reg_103;
    end
end

always @ (posedge ap_clk) begin
    if ((1'b1 == stream_out_V_last_V_1_load_B)) begin
        stream_out_V_last_V_1_payload_B <= tmp_last_V_reg_103;
    end
end

always @ (posedge ap_clk) begin
    if ((1'b1 == stream_out_V_user_V_1_load_A)) begin
        stream_out_V_user_V_1_payload_A <= tmp_user_V_reg_98;
    end
end

always @ (posedge ap_clk) begin
    if ((1'b1 == stream_out_V_user_V_1_load_B)) begin
        stream_out_V_user_V_1_payload_B <= tmp_user_V_reg_98;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_pp0_stage0) & (1'b1 == ap_start) & (ap_block_pp0_stage0_flag00011001 == 1'b0) & (1'b1 == (MdnStream_V_data_V_empty_n & MdnStream_V_user_V_empty_n & MdnStream_V_last_V_empty_n)))) begin
        MdnStream_V_data_V0_update = 1'b1;
    end else begin
        MdnStream_V_data_V0_update = 1'b0;
    end
end

always @ (*) begin
    if (((1'b1 == ap_enable_reg_pp0_iter2) & (ap_block_pp0_stage0_flag00011001 == 1'b0))) begin
        ap_done = 1'b1;
    end else begin
        ap_done = ap_done_reg;
    end
end

always @ (*) begin
    if (((1'b0 == ap_start) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b1 == ap_idle_pp0))) begin
        ap_idle = 1'b1;
    end else begin
        ap_idle = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_enable_reg_pp0_iter0) & (1'b0 == ap_enable_reg_pp0_iter1) & (1'b0 == ap_enable_reg_pp0_iter2))) begin
        ap_idle_pp0 = 1'b1;
    end else begin
        ap_idle_pp0 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_enable_reg_pp0_iter0) & (1'b0 == ap_enable_reg_pp0_iter1))) begin
        ap_idle_pp0_0to1 = 1'b1;
    end else begin
        ap_idle_pp0_0to1 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_pp0_stage0) & (1'b1 == ap_start) & (ap_block_pp0_stage0_flag00011001 == 1'b0))) begin
        ap_ready = 1'b1;
    end else begin
        ap_ready = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_start) & (1'b1 == ap_idle_pp0_0to1))) begin
        ap_reset_idle_pp0 = 1'b1;
    end else begin
        ap_reset_idle_pp0 = 1'b0;
    end
end

always @ (*) begin
    if ((((1'b1 == ap_CS_fsm_pp0_stage0) & (empty_n_3_reg_87 == 1'd1) & (1'b1 == ap_enable_reg_pp0_iter1) & (ap_block_pp0_stage0_flag00000000 == 1'b0)) | ((1'd1 == ap_reg_pp0_iter1_empty_n_3_reg_87) & (1'b1 == ap_enable_reg_pp0_iter2) & (ap_block_pp0_stage0_flag00000000 == 1'b0)))) begin
        stream_out_TDATA_blk_n = stream_out_V_data_V_1_state[1'd1];
    end else begin
        stream_out_TDATA_blk_n = 1'b1;
    end
end

always @ (*) begin
    if ((1'b1 == stream_out_V_data_V_1_sel)) begin
        stream_out_V_data_V_1_data_out = stream_out_V_data_V_1_payload_B;
    end else begin
        stream_out_V_data_V_1_data_out = stream_out_V_data_V_1_payload_A;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_pp0_stage0) & (empty_n_3_reg_87 == 1'd1) & (1'b1 == ap_enable_reg_pp0_iter1) & (ap_block_pp0_stage0_flag00011001 == 1'b0))) begin
        stream_out_V_data_V_1_vld_in = 1'b1;
    end else begin
        stream_out_V_data_V_1_vld_in = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == stream_out_V_last_V_1_sel)) begin
        stream_out_V_last_V_1_data_out = stream_out_V_last_V_1_payload_B;
    end else begin
        stream_out_V_last_V_1_data_out = stream_out_V_last_V_1_payload_A;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_pp0_stage0) & (empty_n_3_reg_87 == 1'd1) & (1'b1 == ap_enable_reg_pp0_iter1) & (ap_block_pp0_stage0_flag00011001 == 1'b0))) begin
        stream_out_V_last_V_1_vld_in = 1'b1;
    end else begin
        stream_out_V_last_V_1_vld_in = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == stream_out_V_user_V_1_sel)) begin
        stream_out_V_user_V_1_data_out = stream_out_V_user_V_1_payload_B;
    end else begin
        stream_out_V_user_V_1_data_out = stream_out_V_user_V_1_payload_A;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_pp0_stage0) & (empty_n_3_reg_87 == 1'd1) & (1'b1 == ap_enable_reg_pp0_iter1) & (ap_block_pp0_stage0_flag00011001 == 1'b0))) begin
        stream_out_V_user_V_1_vld_in = 1'b1;
    end else begin
        stream_out_V_user_V_1_vld_in = 1'b0;
    end
end

always @ (*) begin
    case (ap_CS_fsm)
        ap_ST_fsm_pp0_stage0 : begin
            ap_NS_fsm = ap_ST_fsm_pp0_stage0;
        end
        default : begin
            ap_NS_fsm = 'bx;
        end
    endcase
end

assign MdnStream_V_data_V_read = MdnStream_V_data_V0_update;

assign MdnStream_V_last_V_read = MdnStream_V_data_V0_update;

assign MdnStream_V_user_V_read = MdnStream_V_data_V0_update;

assign ap_CS_fsm_pp0_stage0 = ap_CS_fsm[32'd0];

assign ap_block_pp0_stage0_flag00000000 = ~(1'b1 == 1'b1);

always @ (*) begin
    ap_block_pp0_stage0_flag00001001 = ((ap_done_reg == 1'b1) | ((1'b1 == ap_start) & ((1'b0 == ap_start) | (ap_done_reg == 1'b1))) | (((1'b0 == stream_out_V_data_V_1_ack_in) | (1'b0 == stream_out_V_user_V_1_ack_in) | (1'b0 == stream_out_V_last_V_1_ack_in)) & (1'b1 == ap_enable_reg_pp0_iter2)));
end

always @ (*) begin
    ap_block_pp0_stage0_flag00011001 = ((ap_done_reg == 1'b1) | ((1'b1 == ap_start) & ((1'b0 == ap_start) | (ap_done_reg == 1'b1))) | ((1'b1 == ap_block_state2_io) & (1'b1 == ap_enable_reg_pp0_iter1)) | (((1'b0 == stream_out_V_data_V_1_ack_in) | (1'b0 == stream_out_V_user_V_1_ack_in) | (1'b0 == stream_out_V_last_V_1_ack_in) | (1'b1 == ap_block_state3_io)) & (1'b1 == ap_enable_reg_pp0_iter2)));
end

always @ (*) begin
    ap_block_pp0_stage0_flag00011011 = ((ap_done_reg == 1'b1) | ((1'b1 == ap_start) & ((1'b0 == ap_start) | (ap_done_reg == 1'b1))) | ((1'b1 == ap_block_state2_io) & (1'b1 == ap_enable_reg_pp0_iter1)) | (((1'b0 == stream_out_V_data_V_1_ack_in) | (1'b0 == stream_out_V_user_V_1_ack_in) | (1'b0 == stream_out_V_last_V_1_ack_in) | (1'b1 == ap_block_state3_io)) & (1'b1 == ap_enable_reg_pp0_iter2)));
end

always @ (*) begin
    ap_block_state1_pp0_stage0_iter0 = ((1'b0 == ap_start) | (ap_done_reg == 1'b1));
end

always @ (*) begin
    ap_block_state2_io = ((1'b0 == stream_out_V_data_V_1_ack_in) & (empty_n_3_reg_87 == 1'd1));
end

assign ap_block_state2_pp0_stage0_iter1 = ~(1'b1 == 1'b1);

always @ (*) begin
    ap_block_state3_io = ((1'b0 == stream_out_V_data_V_1_ack_in) & (1'd1 == ap_reg_pp0_iter1_empty_n_3_reg_87));
end

always @ (*) begin
    ap_block_state3_pp0_stage0_iter2 = ((1'b0 == stream_out_V_data_V_1_ack_in) | (1'b0 == stream_out_V_user_V_1_ack_in) | (1'b0 == stream_out_V_last_V_1_ack_in));
end

assign ap_enable_pp0 = (ap_idle_pp0 ^ 1'b1);

assign ap_enable_reg_pp0_iter0 = ap_start;

assign empty_n_nbread_fu_40_p4_0 = (MdnStream_V_data_V_empty_n & MdnStream_V_user_V_empty_n & MdnStream_V_last_V_empty_n);

assign stream_out_TDATA = stream_out_V_data_V_1_data_out;

assign stream_out_TLAST = stream_out_V_last_V_1_data_out;

assign stream_out_TUSER = stream_out_V_user_V_1_data_out;

assign stream_out_TVALID = stream_out_V_last_V_1_state[1'd0];

assign stream_out_V_data_V_1_ack_in = stream_out_V_data_V_1_state[1'd1];

assign stream_out_V_data_V_1_ack_out = stream_out_TREADY;

assign stream_out_V_data_V_1_load_A = (stream_out_V_data_V_1_state_cmp_full & ~stream_out_V_data_V_1_sel_wr);

assign stream_out_V_data_V_1_load_B = (stream_out_V_data_V_1_sel_wr & stream_out_V_data_V_1_state_cmp_full);

assign stream_out_V_data_V_1_sel = stream_out_V_data_V_1_sel_rd;

assign stream_out_V_data_V_1_state_cmp_full = ((stream_out_V_data_V_1_state != 2'd1) ? 1'b1 : 1'b0);

assign stream_out_V_data_V_1_vld_out = stream_out_V_data_V_1_state[1'd0];

assign stream_out_V_last_V_1_ack_in = stream_out_V_last_V_1_state[1'd1];

assign stream_out_V_last_V_1_ack_out = stream_out_TREADY;

assign stream_out_V_last_V_1_load_A = (stream_out_V_last_V_1_state_cmp_full & ~stream_out_V_last_V_1_sel_wr);

assign stream_out_V_last_V_1_load_B = (stream_out_V_last_V_1_sel_wr & stream_out_V_last_V_1_state_cmp_full);

assign stream_out_V_last_V_1_sel = stream_out_V_last_V_1_sel_rd;

assign stream_out_V_last_V_1_state_cmp_full = ((stream_out_V_last_V_1_state != 2'd1) ? 1'b1 : 1'b0);

assign stream_out_V_last_V_1_vld_out = stream_out_V_last_V_1_state[1'd0];

assign stream_out_V_user_V_1_ack_in = stream_out_V_user_V_1_state[1'd1];

assign stream_out_V_user_V_1_ack_out = stream_out_TREADY;

assign stream_out_V_user_V_1_load_A = (stream_out_V_user_V_1_state_cmp_full & ~stream_out_V_user_V_1_sel_wr);

assign stream_out_V_user_V_1_load_B = (stream_out_V_user_V_1_sel_wr & stream_out_V_user_V_1_state_cmp_full);

assign stream_out_V_user_V_1_sel = stream_out_V_user_V_1_sel_rd;

assign stream_out_V_user_V_1_state_cmp_full = ((stream_out_V_user_V_1_state != 2'd1) ? 1'b1 : 1'b0);

assign stream_out_V_user_V_1_vld_out = stream_out_V_user_V_1_state[1'd0];

assign tmp_data_V_1_fu_79_p4 = {{{tmp_data_V_reg_91}, {tmp_data_V_reg_91}}, {tmp_data_V_reg_91}};

endmodule //Color