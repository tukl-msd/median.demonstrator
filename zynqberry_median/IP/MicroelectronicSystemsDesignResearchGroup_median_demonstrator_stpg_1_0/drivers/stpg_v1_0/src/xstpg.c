// ==============================================================
// File generated by Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC
// Version: 2017.2
// Copyright (C) 1986-2017 Xilinx, Inc. All Rights Reserved.
// 
// ==============================================================

/***************************** Include Files *********************************/
#include "xstpg.h"

/************************** Function Implementation *************************/
#ifndef __linux__
int XStpg_CfgInitialize(XStpg *InstancePtr, XStpg_Config *ConfigPtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(ConfigPtr != NULL);

    InstancePtr->Axilites_BaseAddress = ConfigPtr->Axilites_BaseAddress;
    InstancePtr->IsReady = XIL_COMPONENT_IS_READY;

    return XST_SUCCESS;
}
#endif

void XStpg_Start(XStpg *InstancePtr) {
    u32 Data;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XStpg_ReadReg(InstancePtr->Axilites_BaseAddress, XSTPG_AXILITES_ADDR_AP_CTRL) & 0x80;
    XStpg_WriteReg(InstancePtr->Axilites_BaseAddress, XSTPG_AXILITES_ADDR_AP_CTRL, Data | 0x01);
}

u32 XStpg_IsDone(XStpg *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XStpg_ReadReg(InstancePtr->Axilites_BaseAddress, XSTPG_AXILITES_ADDR_AP_CTRL);
    return (Data >> 1) & 0x1;
}

u32 XStpg_IsIdle(XStpg *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XStpg_ReadReg(InstancePtr->Axilites_BaseAddress, XSTPG_AXILITES_ADDR_AP_CTRL);
    return (Data >> 2) & 0x1;
}

u32 XStpg_IsReady(XStpg *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XStpg_ReadReg(InstancePtr->Axilites_BaseAddress, XSTPG_AXILITES_ADDR_AP_CTRL);
    // check ap_start to see if the pcore is ready for next input
    return !(Data & 0x1);
}

void XStpg_EnableAutoRestart(XStpg *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XStpg_WriteReg(InstancePtr->Axilites_BaseAddress, XSTPG_AXILITES_ADDR_AP_CTRL, 0x80);
}

void XStpg_DisableAutoRestart(XStpg *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XStpg_WriteReg(InstancePtr->Axilites_BaseAddress, XSTPG_AXILITES_ADDR_AP_CTRL, 0);
}

void XStpg_Set_width_V(XStpg *InstancePtr, u32 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XStpg_WriteReg(InstancePtr->Axilites_BaseAddress, XSTPG_AXILITES_ADDR_WIDTH_V_DATA, Data);
}

u32 XStpg_Get_width_V(XStpg *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XStpg_ReadReg(InstancePtr->Axilites_BaseAddress, XSTPG_AXILITES_ADDR_WIDTH_V_DATA);
    return Data;
}

void XStpg_Set_height_V(XStpg *InstancePtr, u32 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XStpg_WriteReg(InstancePtr->Axilites_BaseAddress, XSTPG_AXILITES_ADDR_HEIGHT_V_DATA, Data);
}

u32 XStpg_Get_height_V(XStpg *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XStpg_ReadReg(InstancePtr->Axilites_BaseAddress, XSTPG_AXILITES_ADDR_HEIGHT_V_DATA);
    return Data;
}

void XStpg_InterruptGlobalEnable(XStpg *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XStpg_WriteReg(InstancePtr->Axilites_BaseAddress, XSTPG_AXILITES_ADDR_GIE, 1);
}

void XStpg_InterruptGlobalDisable(XStpg *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XStpg_WriteReg(InstancePtr->Axilites_BaseAddress, XSTPG_AXILITES_ADDR_GIE, 0);
}

void XStpg_InterruptEnable(XStpg *InstancePtr, u32 Mask) {
    u32 Register;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Register =  XStpg_ReadReg(InstancePtr->Axilites_BaseAddress, XSTPG_AXILITES_ADDR_IER);
    XStpg_WriteReg(InstancePtr->Axilites_BaseAddress, XSTPG_AXILITES_ADDR_IER, Register | Mask);
}

void XStpg_InterruptDisable(XStpg *InstancePtr, u32 Mask) {
    u32 Register;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Register =  XStpg_ReadReg(InstancePtr->Axilites_BaseAddress, XSTPG_AXILITES_ADDR_IER);
    XStpg_WriteReg(InstancePtr->Axilites_BaseAddress, XSTPG_AXILITES_ADDR_IER, Register & (~Mask));
}

void XStpg_InterruptClear(XStpg *InstancePtr, u32 Mask) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XStpg_WriteReg(InstancePtr->Axilites_BaseAddress, XSTPG_AXILITES_ADDR_ISR, Mask);
}

u32 XStpg_InterruptGetEnabled(XStpg *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XStpg_ReadReg(InstancePtr->Axilites_BaseAddress, XSTPG_AXILITES_ADDR_IER);
}

u32 XStpg_InterruptGetStatus(XStpg *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XStpg_ReadReg(InstancePtr->Axilites_BaseAddress, XSTPG_AXILITES_ADDR_ISR);
}

