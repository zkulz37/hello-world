<!-- #include file="../../../system/lib/form.inc"  -->
<html>
<head id="Head1" runat="server">
    <title>Dipping Complete</title>
</head>
<%  ESysLib.SetUser("comm")%>

<script>


//===============================================================

function BodyInit()
{
    emp_pk  = "<%=Session("EMPLOYEE_PK")%>" ;
    user_id = "<%=Session("EMP_ID")%>" ;
    user_name = "<%=Session("USER_NAME")%>" ;
    //------------------
	BindingDataList();
	dtFromDate.SetDataText(System.AddDate(dtToDate.GetData(),-7));
}
//===============================================================

function BindingDataList()
{ 
    /*Item*/
    dtInstructed.SetEnable(false);
    txtIssueNo.SetEnable(false);
    txtIssueSeq.SetEnable(false);
    txtItemCD.SetEnable(false);
    txtItemNM.SetEnable(false);
    txtCColor.SetEnable(false);
    txtBColor.SetEnable(false);
    
    txtBinType.SetEnable(false);
    txtPrinting.SetEnable(false);
    lstSize.SetEnable(false);
    txtCBinNo.SetEnable(false);
    txtBBinNo.SetEnable(false);
    
    txtCusID.SetEnable(false);
    txtCusNm.SetEnable(false);    
    txtLicensen.SetEnable(false);
    txtBlending.SetEnable(false);
    txtEstimate.SetEnable(false);
    
    txtWeiPerCapsule.SetEnable(false);
    txtQtyPerKg.SetEnable(false);
    /*Inst. Q'ty*/
    txtTotalGel.SetEnable(false);
    txtTotalADD.SetEnable(false);
    txtTotalTrim.SetEnable(false);
    txtTotalColP.SetEnable(false);
    txtTotalColor.SetEnable(false);
    /*Dip. Completion*/
    txtCGel.SetEnable(false);
    txtBGel.SetEnable(false);
    txtCTrim.SetEnable(false);
    txtBTrim.SetEnable(false);
    txtTotalQty.SetEnable(false);
    txtDipQty.SetEnable(false);
    txtDipWei.SetEnable(false);
    txtScrap.SetEnable(false);
    txtCAdd.SetEnable(false);
    
    txtDrum.SetEnable(false);
    txtBAdd.SetEnable(false);
    txtTank.SetEnable(false);
    txtCColP.SetEnable(false);
    txtYeild.SetEnable(false);
    
    txtBColP.SetEnable(false);
    txtCColorants.SetEnable(false);
    txtBColorants.SetEnable(false);    
    
    lstMachine.SetEnable(false); 
    
    var data = "";
     data = "<%=ESysLib.SetListDataFUNC("SELECT COMM.f_logistic_code('LGMF0010') FROM DUAL" )%>";    
     lstMachine.SetDataText(data); 
     lstMachineS.SetDataText(data);  
     data = "<%=ESysLib.SetListDataSQL("select   code, code ||' - '||code_nm from sale.lg_code a, sale.lg_code_group b where a.lg_code_group_pk = b.pk and b.group_id = 'LGMF0020' and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0 order by a.def_yn desc, ord")%>"
     lstSize.SetDataText(data);
}
  //---------------------------------------------------------
 function OnToggle()
 {
    var left  = document.all("left");    
    var right = document.all("right");   
    var imgArrow = document.all("imgArrow");   
    
    if(imgArrow.status == "expand")
    {
        left.style.display="none";       
        imgArrow.status = "collapse";
        right.style.width="100%";
        imgArrow.src = "../../../system/images/next_orange.gif";
    }
    else
    {
        left.style.display="";
        imgArrow.status = "expand";
        right.style.width="75%";
        imgArrow.src = "../../../system/images/prev_orange.gif";
    }
 }
//===============================================================

function OnSearch(obj)
{
    if(obj=='LOT')
    {
        sel_shpr00040.Call('SELECT');
    }else if(obj=='DIP')
    {
        txtMasterPK.text = grdSearch.GetGridData(grdSearch.row,0)
        data_shpr00040_2.Call('SELECT')
    }
    
}

//===============================================================

function OnNew()
{    
    data_shpr00040_2.StatusInsert(); 
}
//===============================================================

function OnDelete()
{
    if(confirm('Are you sure to delete this record!'))
    {
        data_shpr00040_2.StatusDelete();
        data_shpr00040_2.Call()
    }
}
//===============================================================
function OnPopUp()
{
    var fpath = System.RootURL + "/form/sh/ab/shab00110.aspx?DippingVN="+rdStatus.value;
    var object = System.OpenModal( fpath , 650 , 500 , 'resizable:yes;status:yes'); 
    if (object != null)
    {
        txtLotNo.text = object[0];        
        CheckLotNo()
    }
 }           

//===============================================================

function OnSave()
{  
           if(txtLotNo.text=="")
            {   
                alert("Please LotNo first!");
                return false;
            }
           if(dtCompDT.value=="")
            {   
                alert("Please Select Comp Date!");
                return false;
            }
            if(txtCRemain.text<=0)
            {
                alert("Remain Sol Cap must be larger than zero!");
                return false;
            }
            if(txtBRemain.text<=0)
            {
                alert("Remain Sol Body must be larger than zero!");
                return false;
            }
          data_shpr00040_2.Call();  
   
}

//===============================================================
function OnDataReceive(obj)
{
    switch (obj.id)
    {
        case 'pro_shpr00040':
            if(txtMasterPK.text == '-1')
            {
                alert('Invalid Lot No! Please, Check Lot No!')
            }else if (txtMasterPK.text == '0')
            {   
                var v_lotno = txtLotNo.text;
                OnNew()
                txtLotNo.text = v_lotno;
                data_shpr00040.Call('SELECT')              
            }else
            {
                data_shpr00040_2.Call('SELECT')
            }
        break;
        
    }    
}
//====================================================================================
function CalculScrap()
{
    var scrap=Number(txtTotalQty.text)-Number(txtDipWei.text)-Number(txtCRemain.text)-Number(txtBRemain.text);
    txtScrap.text=scrap;
    
}

//===============================================================
function CheckLotNo()
{
    if(txtLotNo.text!="")
    {
        pro_shpr00040.Call();
    }else
    {
        alert("Please Input LotNo!")
    }
    
}
</script>

<body>
     <gw:data id="sel_shpr00040" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="grid" function="prod.sp_sel_shpr00040" > 
                <input>
                    <input bind="txtSLotno" />   
                    <input bind="dtFromDate" />  
                    <input bind="dtToDate" />    
                    <input bind="lstMachineS" />                    
                </input> 
                 <output bind="grdSearch" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <gw:data id="pro_shpr00040" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="process" procedure="prod.sp_pro_shpr00040" > 
                <input>
                    <input bind="txtLotNo" />                     
                </input> 
                <output> 
                    <output bind="txtMasterPK" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <gw:data id="data_shpr00040" onreceive="OnDataReceive(this)"> 
        <xml>                                                               
            <dso id="1" type="control" user="prod" function="PROD.sp_sel_shpr00040_1"> 
                <inout>    
                    <inout bind="txtLotNo" /> 
                 
                    <inout bind="lstMachine" />                    
                    <inout bind="rdStatus" />  
                    <inout bind="dtInstructed" />  
                    <inout bind="txtIssueNo" />  
                    <inout bind="txtIssueSeq" />  
                    
                    <inout bind="txtItemCD" />                    
                    <inout bind="txtItemNM" />  
                    <inout bind="txtCColor" />  
                    <inout bind="txtBColor" />  
                    <inout bind="txtBinType" /> 
                    
                    <inout bind="txtPrinting" />                    
                    <inout bind="lstSize" />  
                    <inout bind="txtCBinNo" />  
                    <inout bind="txtBBinNo" />  
                    <inout bind="txtCusID" /> 
                    
                    <inout bind="txtCusNm" />                    
                    <inout bind="txtLicensen" />  
                    <inout bind="txtBlending" />  
                    <inout bind="txtEstimate" />  
                    <inout bind="txtWeiPerCapsule" />
                     
                    <inout bind="txtQtyPerKg" />  
                    <inout bind="dtCompDT" />
                    <inout bind="txtTotalQty" />
                    <inout bind="txtCGel" />
                    
                    <inout bind="txtBGel" />  
                    <inout bind="txtCTrim" />
                    <inout bind="txtBTrim" />
                    <inout bind="txtCColP" />
                    <inout bind="txtBColP" />
                    
                    <inout bind="txtCAdd" />  
                    <inout bind="txtBAdd" />
                    <inout bind="txtCColorants" />
                    <inout bind="txtBColorants" />
                    <inout bind="txtDipQty" />
                    
                    <inout bind="txtDipWei" />  
                    <inout bind="txtScrap" />
                    <inout bind="txtDrum" />
                    <inout bind="txtTank" />
                    <inout bind="txtYeild" />
                    
                    <inout bind="txtTotalGel" />  
                    <inout bind="txtTotalTrim" />
                    <inout bind="txtTotalColor" />
                    <inout bind="txtTotalColP" />
                    <inout bind="txtTotalADD" />                          
                 </inout> 
            </dso> 
        </xml> 
    </gw:data> 
    
     <!------------------------------------------------------------------>
    <gw:data id="data_shpr00040_2" onreceive="OnDataReceive(this)"> 
        <xml>                                                               
            <dso id="1" type="control" user="prod" function="PROD.sp_sel_shpr00040_2" parameter="0,1,2,3,21,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40, 46,47" procedure="PROD.sp_upd_shpr00040_2" > 
                <inout> 
                
                    <inout bind="txtMasterPK" />                      
                    <inout bind="txtLotNo" /> 
                    
                 
                    <inout bind="lstMachine" />                    
                    <inout bind="rdStatus" />  
                    <inout bind="dtInstructed" />  
                    <inout bind="txtIssueNo" />  
                    <inout bind="txtIssueSeq" />  
                    
                    <inout bind="txtItemCD" />                    
                    <inout bind="txtItemNM" />  
                    <inout bind="txtCColor" />  
                    <inout bind="txtBColor" />  
                    <inout bind="txtBinType" /> 
                    
                    <inout bind="txtPrinting" />                    
                    <inout bind="lstSize" />  
                    <inout bind="txtCBinNo" />  
                    <inout bind="txtBBinNo" />  
                    <inout bind="txtCusID" /> 
                    
                    <inout bind="txtCusNm" />                    
                    <inout bind="txtLicensen" />  
                    <inout bind="txtBlending" />  
                    <inout bind="txtEstimate" />  
                    <inout bind="txtWeiPerCapsule" />
                     
                    <inout bind="txtQtyPerKg" />  
                    <inout bind="dtCompDT" />
                    <inout bind="txtTotalQty" />
                    <inout bind="txtCGel" />
                    
                    <inout bind="txtBGel" />  
                    <inout bind="txtCTrim" />
                    <inout bind="txtBTrim" />
                    <inout bind="txtCColP" />
                    <inout bind="txtBColP" />
                    
                    <inout bind="txtCAdd" />  
                    <inout bind="txtBAdd" />
                    <inout bind="txtCColorants" />
                    <inout bind="txtBColorants" />
                    <inout bind="txtDipQty" />
                    
                    <inout bind="txtDipWei" />  
                    <inout bind="txtScrap" />
                    <inout bind="txtDrum" />
                    <inout bind="txtTank" />
                    <inout bind="txtYeild" />
                    
                    <inout bind="txtTotalGel" />  
                    <inout bind="txtTotalTrim" />
                    <inout bind="txtTotalColor" />
                    <inout bind="txtTotalColP" />
                    <inout bind="txtTotalADD" />      
                    
                    <inout bind="txtCRemain" />
                    <inout bind="txtBRemain" /> 
                                        
                 </inout> 
            </dso> 
        </xml> 
    </gw:data> 
    
    <!--------------------------------------------------------------------------------------->
    <table style="height: 100%; width: 100%" border="1">
        <tr style="height: 100%">          
            <td style="width: 10%" id="left">
                <table style="width: 100%; height: 100%">
                    <tr style="height: 1%">
                        <td style="width: 40%" align="right">
                            <b>Machine No</b>
                        </td>
                        <td style="width: 59%" align="right">
                            <gw:list id="lstMachineS" styles='width:100%' onchange="OnSearch('LOT')" />
                        </td>
                        <td style="width: 1%" align="right">
                            <gw:imgbtn img="search" alt="Search" id="btnSearch" onclick="OnSearch('LOT')" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td style="width: 40%" align="right">
                            <b>Lot No</b>
                        </td>
                        <td style="width: 59%" align="right">
                            <gw:textbox id="txtSLotno" styles='width:100%' onenterkey="OnSearch('LOT')" />
                        </td>
                       
                    </tr>
                    <tr style="height: 1%">
                        <td align="right" rowspan="2" >
                            <b>Comp. Date</b>
                        </td>
                        <td  colspan=2>
                            <gw:datebox id="dtFromDate" lang="1" styles="width:100%"   onenterkey="OnSearch('LOT')" />                           
                        </td>
                    </tr>
                    <tr style="height: 1%">                       
                        <td  colspan=2>
                           <gw:datebox id="dtToDate" lang="1" styles="width:100%"  onenterkey="OnSearch('LOT')"  />
                        </td>
                    </tr>
                    <tr style="height: 98%">
                        <td colspan="3">
                            <gw:grid id='grdSearch'
                                header='_pk|Machine|Lot No|Comp DT'
                                format='0|0|0|4' aligns='0|0|0|0' defaults='|||' editcol='0|0|0|0'
                                widths='0|100|1200|1500' sorting='T' styles='width:100%; height:100%'
                                oncellclick="OnSearch('DIP')" autosize="T" />
                        </td>
                    </tr>
                </table>
            </td>
            <td style="width:90%" id="right">
                    <table style="width:100%; height:100%" border=1>
                            <tr style="height:2%">
                                <td colspan="2">
                                    <table style="width: 100%; height: 100%">
                                        <tr style="height: 1%">
                                            <td style="width: 96%">
                                            </td>
                                            <td style="width: 1%" align="right">
                                                <gw:imgbtn img="new" alt="New" id="btnAddNew" onclick="OnNew()" />
                                            </td>
                                            <td style="width: 1%" align="right">
                                                <gw:imgbtn img="delete" alt="Delete" id="btnDelete" onclick="OnDelete()" />
                                            </td>
                                            <td style="width: 1%" align="right">
                                                <gw:imgbtn img="save" alt="Save" id="btnSave" onclick="OnSave()" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                           <tr style="height:25%" >
                            <td style="width:40%">
                                    <table style="width:100%; height:100%">
                                        <tr>
                                             <td style="background-color:#99ccff; color:White; font-size:13 " > <b>Header</b></td>
                                        </tr>
                                        <tr>
                                            <td style="width:30%; border:solid 1  #99ccff" align="right"> <b>Machine</b></td>
                                            <td style="width:70%" >  <gw:list id="lstMachine" styles='width:100%' /> </td>
                                        </tr>
                                        <tr>
                                            <td style="width:30%; border:solid 1  #99ccff" align="right"> <b>Completion</b></td>
                                            <td style="width:70%" >  <gw:radio id="rdStatus" value="Y" styles="width:100%">                    
			                                                            <span value="Y" id="rdYes">YES</span>                       
			                                                            <span value="N" id="rdNo">NO</span>                   			                                
        			                         </gw:radio> </td>
                                        </tr>
                                        <tr>
                                            <td style="width:20%; border:solid 1  #99ccff" align="right"> <b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp()">Lot. No </b></td>
                                            <td style="width:80%" > <gw:textbox id="txtLotNo" styles='width:100%' onenterkey="CheckLotNo()" csstype="mandatory" /> </td>
                                        </tr>
                                    </table>
                             </td>
                             <td style="width:60%">
                                    <table style="width:100%; height:99%">
                                         <tr>
                                             <td style="background-color:#99ccff; color:White; font-size:13 "  colspan="2"> <b>Inst. Q'ty</b></td>
                                        </tr>
                                         <tr>
                                            <td style="width:20%; border:solid 1  #99ccff" align="right" > <b>Gelatin</b></td>
                                            <td style="width:28% " > <gw:textbox id="txtTotalGel" styles='width:100%' type="number"  format="###,###,###,###.##0" /> </td>
                                            <td style="width:2%" >Kg</td> 
                                           <td style="width:20%; border:solid 1  #99ccff" align="right" > <b>Additive</b></td>
                                            <td style="width:28% " > <gw:textbox id="txtTotalADD" styles='width:100%' type="number"  format="###,###,###,###.##0" /> </td>
                                            <td style="width:2%" >g</td>                                      
                                        </tr>
                                         <tr>
                                            <td style="width:20%; border:solid 1  #99ccff" align="right" > <b>Trimming</b></td>
                                            <td style="width:28% " > <gw:textbox id="txtTotalTrim" styles='width:100%' type="number"  format="###,###,###,###.##0" /> </td>
                                            <td style="width:2%" >Kg</td> 
                                           <td style="width:20%; border:solid 1  #99ccff" align="right" > <b>Colorant Pack</b></td>
                                            <td style="width:28% " > <gw:textbox id="txtTotalColP" styles='width:100%' type="number"  format="###,###,###,###.##0" /> </td>
                                            <td style="width:2%" >g</td>                                      
                                        </tr>
                                         <tr>
                                            <td style="width:20%; border:solid 1  #99ccff" align="right" > <b>Colorants</b></td>
                                            <td style="width:28% " > <gw:textbox id="txtTotalColor" styles='width:100%' type="number"  format="###,###,###,###.##0" /> </td>
                                            <td style="width:2%" >g</td> 
                                                                               
                                        </tr>
                                    </table>
                             </td>
                        </tr>
                         <tr style="height:73%" >
                            <td style="width:40%">
                                     <table style="width:100%; height:100%">
                                        <tr>
                                            <td style="background-color:#99ccff; color:White; font-size:13" align="left"> <b>Item</b></td>
                                        </tr>
                                        <tr>
                                            <td style="width:30%;border:solid 1  #99ccff" align="right"> <b>Inst. DT</b></td>
                                            <td style="width:70%" colspan="3" > <gw:datebox id="dtInstructed" lang="1" styles="width:50%" />   </td>
                                        </tr>
                                        <tr>
                                            <td style="width:30%;border:solid 1  #99ccff" align="right"> <b>Issue No</b></td>
                                            <td style="width:25%"><gw:textbox id="txtIssueNo" styles='width:100%' /> </td>
                                            <td style="width:45%" colspan="2" > <gw:textbox id="txtIssueSeq" styles='width:100%' /> </td>
                                          </tr>
                                       <tr>
                                            <td style="width:30%;border:solid 1  #99ccff" align="right"> <b>Product</b></td>
                                            <td style="width:25%"><gw:textbox id="txtItemCD" styles='width:100%' /> </td>
                                            <td style="width:45%" colspan="2" > <gw:textbox id="txtItemNM" styles='width:100%' /> </td>
                                       </tr>
                                       <tr>
                                            <td style="width:30%;border:solid 1  #99ccff" align="right"> <b>Color/Pin Type</b></td>
                                            <td style="width:25%"><gw:textbox id="txtCColor" styles='width:100%' /> </td>
                                            <td style="width:20%"><gw:textbox id="txtBColor" styles='width:100%' /> </td>
                                            <td style="width:25%" > <gw:textbox id="txtBinType" styles='width:100%' /> </td>
                                       </tr>
                                       <tr>
                                            <td style="width:30%;border:solid 1  #99ccff" align="right"> <b>Printing/Size</b></td>
                                            <td style="width:25%"><gw:textbox id="txtPrinting" styles='width:100%' /> </td>
                                            <td style="width:45%" colspan="2"><gw:list id="lstSize" styles='width:100%' /> </td>                                            
                                       </tr>
                                        <tr>
                                            <td style="width:30%;border:solid 1  #99ccff" align="right"> <b>Pin No(C/B)</b></td>
                                            <td style="width:25%"><gw:textbox id="txtCBinNo" styles='width:100%' /> </td>
                                            <td style="width:45%" colspan="2"><gw:textbox id="txtBBinNo" styles='width:100%' /></td>                                            
                                       </tr>
                                        <tr>
                                            <td style="width:30%;border:solid 1  #99ccff" align="right"> <b>Customer</b></td>
                                            <td style="width:25%"><gw:textbox id="txtCusID" styles='width:100%' /> </td>
                                            <td style="width:45%" colspan="2"><gw:textbox id="txtCusNm" styles='width:100%' /></td>                                            
                                       </tr>
                                       <tr>
                                            <td style="width:30%;border:solid 1  #99ccff" align="right"> <b>License No</b></td>
                                            <td style="width:70%" colspan="3"><gw:textbox id="txtLicensen" styles='width:100%' /> </td>                                                                                   
                                       </tr>
                                      <tr>
                                            <td style="width:30%;border:solid 1  #99ccff" align="right"> <b>Blending No</b></td>
                                            <td style="width:70%" colspan="3"><gw:textbox id="txtBlending" styles='width:100%' /> </td>                                                                                   
                                       </tr> 
                                       <tr>
                                            <td style="width:30%;border:solid 1  #99ccff" align="right"> <b>Estimated Q'ty</b></td>
                                            <td style="width:70%" colspan="3"><gw:textbox id="txtEstimate" styles='width:85%' type="number" format="###,###,###,###" /> </td>                                                                                   
                                       </tr>
                                       <tr>
                                            <td style="width:30%;border:solid 1  #99ccff" align="right"> <b>Wt/Capsule</b></td>
                                            <td style="width:70%" colspan="3"><gw:textbox id="txtWeiPerCapsule" styles='width:85%' type="number" format="###,###,###.##0" />mg</td>                                                                                                                           
                                       </tr>
                                        <tr>
                                            <td style="width:30%;border:solid 1  #99ccff; white-space:nowrap" align="right"> <b>Prod Q'ty/KG</b></td>
                                            <td style="width:70%" colspan="3"><gw:textbox id="txtQtyPerKg" styles='width:85%' type="number"  format="###,###,###,###" />Ea </td>                                                                                   
                                            
                                       </tr>
                                       
                                    </table>
                             </td>
                             <td style="width:70%">
                                    <table style="width:100%; height:100% "  cellpadding=0>
                                         <tr>
                                            <td style="background-color:#99ccff; color:White; font-size:13" colspan="3" align="left"> <b>Dip. Completion</b></td>
                                        </tr>
                                        <tr>
                                            <td style="width:20%; border:solid 1  #99ccff" align="right" colspan=2 > <b>Comp Date</b></td>
                                            <td style="width:80%"  colspan="6"> <gw:datebox id="dtCompDT" lang="1" styles="width:50%" csstype="mandatory" nullaccept/> </td>
                                        </tr>
                                        <tr>
                                            <td style="width:20%; border:solid 1  #99ccff" align="right" colspan='2'> <b>Total Q'ty(KG)</b></td>
                                            <td style="width:28% " > <gw:textbox id="txtTotalQty"  styles='width:100%' type="number"  format="###,###,###,###.#####0" /> </td>
                                            <td style="width:2%" >Kg</td> 
                                            <td style="width:15%;border:solid 1  #99ccff; border-right:none" align="right" rowspan="2" > <b>Remain -Sol</b></td>
                                            <td style="width:5%;border:solid 1  #99ccff; border-left:none;border-bottom:none" align="right"  > <b>C</b></td>
                                            <td style="width:28%;border:solid 1  #99ccff; border-right:none " >  <gw:textbox id="txtCRemain" styles='width:100%' type="number"  format="###,###,###.#0"  csstype="mandatory" onblur="CalculScrap()" onenterkey="CalculScrap()"/> </td>     
                                            <td style="width:2%"></td>                                       
                                        </tr>
                                        <tr >
                                           <td rowspan="2" style="width:15%;border:solid 1  #99ccff; border-right:none " align="right"  > <b>Gelatin</b></td>
                                            <td style="width:5%;border:solid 1  #99ccff; border-left:none;border-bottom:none" align="right"  > <b>C</b></td>
                                            <td style="width:28%" >  <gw:textbox id="txtCGel" styles='width:100%' type="number"  format="###,###,###.##0" /> </td>     
                                            <td style="width:2%">Kg</td> 
                                            <td style="width:5%; border:solid 1  #99ccff; border-left:none ; border-top:none" align="right"  > <b>B</b></td>
                                            <td style="width:28%;border:solid 1  #99ccff; border-right:none " >   <gw:textbox id="txtBRemain" styles='width:100%' type="number"  format="###,###,###.#0" csstype="mandatory" onblur="CalculScrap()" onenterkey="CalculScrap()" /> </td>     
                                            <td style="width:2%" ></td>   
                                        </tr>
                                        <tr>
                                             <td style="width:5%; border:solid 1  #99ccff; border-left:none ; border-top:none" align="right"  > <b>B</b></td>
                                            <td style="width:28%  " >   <gw:textbox id="txtBGel" styles='width:100%' type="number"  format="###,###,###.##0" /> </td>     
                                            <td style="width:2%" >Kg</td>    
                                            <td style="width:20%;border:solid 1  #99ccff" align="right" colspan='2'> <b>Dip. Q'ty</b></td>
                                            <td style="width:28% " > <gw:textbox id="txtDipQty" styles='width:100%' type="number"  format="###,###,###,###" /> </td>
                                            <td style="width:2%" >Ea</td> 
                                        </tr>
                                        <tr>
                                             <td style="width:15%;border:solid 1  #99ccff; border-right:none" align="right" rowspan="2" > <b>Trimming</b></td>
                                            <td style="width:5%;border:solid 1  #99ccff; border-left:none;border-bottom:none" align="right"  > <b>C</b></td>
                                            <td style="width:28% " >  <gw:textbox id="txtCTrim" styles='width:100%' type="number"  format="###,###,###.##0" /> </td>     
                                            <td style="width:2%">Kg</td>   
                                            <td style="width:20%;border:solid 1  #99ccff" align="right" colspan='2'> <b>Dip. Wt</b></td>
                                            <td style="width:28% " > <gw:textbox id="txtDipWei" styles='width:100%' type="number"  format="###,###,###,###.#####0" /> </td>
                                            <td style="width:2%" >Kg</td> 
                                            
                                        </tr>
                                        <tr>
                                            <td style="width:5%; border:solid 1  #99ccff; border-left:none ; border-top:none" align="right"  > <b>B</b></td>
                                            <td style="width:28% " >   <gw:textbox id="txtBTrim" styles='width:100%' type="number"  format="###,###,###.##0" /> </td>     
                                            <td style="width:2%" >Kg</td>   
                                            <td style="width:20%;border:solid 1  #99ccff" align="right" colspan='2'> <b>Scrap</b></td>
                                            <td style="width:28% " > <gw:textbox id="txtScrap" styles='width:100%' type="number"  format="###,###,###,###.#####0R" /> </td>
                                            <td style="width:2%" >Kg</td> 
                                        </tr>
                                        <tr>
                                            <td style="width:15%;border:solid 1  #99ccff; border-right:none " align="right" rowspan="2" > <b>Additive</b></td>
                                            <td style="width:5%;border:solid 1  #99ccff; border-left:none;border-bottom:none" align="right"  > <b>C</b></td>
                                            <td style="width:28% " >  <gw:textbox id="txtCAdd" styles='width:100%' type="number"  format="###,###,###.##0" /> </td>     
                                            <td style="width:2%">g</td>    
                                            <td style="width:20%;border:solid 1  #99ccff" align="right" colspan='2'> <b>Drums</b></td>
                                            <td style="width:28% " > <gw:textbox id="txtDrum" styles='width:100%' type="number"  format="###,###,###,##0" /> </td>
                                            <td style="width:2%" >Ea</td>                                             
                                        </tr>
                                        <tr>
                                           <td style="width:5%; border:solid 1  #99ccff; border-left:none ; border-top:none " align="right"  > <b>B</b></td>
                                            <td style="width:28% " >   <gw:textbox id="txtBAdd" styles='width:100%' type="number"  format="###,###,###.##0" /> </td>     
                                            <td style="width:2%" >g</td> 
                                            <td style="width:20%;border:solid 1  #99ccff" align="right" colspan='2'> <b>TANKs</b></td>
                                            <td style="width:28% " > <gw:textbox id="txtTank" styles='width:100%' type="number"  format="###,###,###,###" /> </td>
                                            <td style="width:2%" >Ea</td> 
                                        </tr>
                                        <tr>
                                            <td style="width:15%;border:solid 1  #99ccff; border-right:none " align="right" rowspan="2" > <b>Colorant Pack</b></td>
                                            <td style="width:5%;border:solid 1  #99ccff; border-left:none;border-bottom:none" align="right"  > <b>C</b></td>
                                            <td style="width:28% " >  <gw:textbox id="txtCColP" styles='width:100%' type="number"  format="###,###,###.##0" /> </td>     
                                            <td style="width:2%">g</td>   
                                            <td style="width:20%;border:solid 1  #99ccff" align="right" colspan='2'> <b>Dip. Yeild</b></td>
                                            <td style="width:28% " > <gw:textbox id="txtYeild" styles='width:100%' type="number"  format="###,###,###.#0R" /> </td>
                                            <td style="width:2%" >%</td> 
                                            
                                        </tr>                                       
                                        <tr>
                                            <td style="width:5%; border:solid 1  #99ccff; border-left:none ; border-top:none" align="right"  > <b>B</b></td>
                                            <td style="width:28% " >   <gw:textbox id="txtBColP" styles='width:100%' type="number"  format="###,###,###.##0" /> </td>     
                                            <td style="width:2%" >g</td>   
                                                                                        
                                        </tr>
                                        <tr>
                                            <td style="width:15%;border:solid 1  #99ccff; border-right:none " align="right" rowspan="2" > <b>Colorants</b></td>
                                            <td style="width:5%;border:solid 1  #99ccff; border-left:none;border-bottom:none" align="right"  > <b>C</b></td>
                                            <td style="width:28% " >  <gw:textbox id="txtCColorants" styles='width:100%' type="number"  format="###,###,###.##0" /> </td>     
                                            <td style="width:2%">g</td>  
                                           
                                        </tr>
                                        <tr>
                                            <td style="width:5%; border:solid 1  #99ccff; border-left:none ; border-top:none" align="right"  > <b>B</b></td>
                                            <td style="width:28% " >   <gw:textbox id="txtBColorants" styles='width:100%' type="number"  format="###,###,###.##0" /> </td>     
                                            <td style="width:2%" >g</td>   
                                            
                                            
                                        </tr>
                                    </table>
                             </td>
                        </tr>
                    </table>
            </td>
        </tr>
    </table>
    
   
</body>
<img status="expand" id="imgArrow" src="../../../system/images/prev_orange.gif" style="cursor: hand;
        position: absolute; left: 1; top: 0;" onclick="OnToggle()" />
        
 <gw:textbox id="txtMasterPK" styles='width:100%;display:none'  />
 
<gw:datebox id="dtnow" style="display:none" lang="1" />
<gw:textbox id="txtStartDT" styles="display:none" />
<gw:textbox id="txtStartTime" styles="display:none" />
<gw:textbox id="txtEndDT" styles="display:none" />
<gw:textbox id="txtEndTime" styles="display:none" />
<gw:textbox id="txtRtnValue" styles="display:none" />
<!--------------------------------------------------------------------------------------->
</html> 
