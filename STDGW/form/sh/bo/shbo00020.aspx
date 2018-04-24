<!-- #include file="../../../system/lib/form.inc"  -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%  ESysLib.SetUser("prod")%>
<head id="Head1" runat="server">
    <title>Additive Solution Preparation Instruction and Record</title>
</head>
<script>
var  user_pk    = "<%=Session("EMPLOYEE_PK")%>" ;
var  user_code  = "<%=Session("EMP_ID")%>" ;
var  user_name  = "<%=Session("USER_NAME")%>" ; 
    
var G1_pk               = 0,   
    G1_tsh_wei_m_pk     = 1,
    G1_tsh_mixtyped_pk  = 2, 
    G1_Blend_type       = 3,
    G1_Test_No          = 4,
    G1_Use_Ratio        = 5,
    G1_Inst_Qty         = 6,
    G1_Min_Value        = 7,
    G1_Max_Value        = 8,
    G1_tank_no          = 9;
 //---------------------------------------------------------
 function BodyInit()
 {
      OnAddNew('Master');
      FormatGrid();
      txtABatchNo.SetEnable(false);
      txtTrGU.SetEnable(false);
      txtTrGUNM.SetEnable(false);
      txtBlendingNo.SetEnable(false);
      txtTypeNo.SetEnable(false);
      txtTypeDesc.SetEnable(false);
      txtBatchNo.SetEnable(false);
      txtEmpID.SetEnable(false);
      txtEmpName.SetEnable(false);
      dtIssDate.SetEnable(false);
     // grdDetail.SetWrapText(true);
     dtFromDate.SetDataText(System.AddDate(dtToDate.GetData(),-7));
     BindingDataList();
     shbo00020.Call("SELECT");
 }
 //---------------------------------------------------------
 function BindingDataList()
 { 
        var data ="#01;01 - Gelatin(Type A)|#02;02 - Gelatin(Type B)"; 
        grdDetail.SetComboFormat(3,data);   
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
 //---------------------------------------------------------
 function OnPopUp(obj)
{
    switch(obj)
    { 
        case 'Additive':
            var fpath = System.RootURL + "/form/sh/ab/shab00090.aspx";
            var object = System.OpenModal( fpath , 750 , 400 , 'resizable:yes;status:yes'); 
            if (object != null)
            {                  
                txtABatchPK.text = object[0];
                txtABatchNo.text = object[2];
                txtTrGU.text     = object[4];
                txtTrGUNM.text   = object[5];
            }
        break;
        case 'Blending':
            var fpath = System.RootURL + "/form/sh/ab/shab00100.aspx?type=Blend";
            var object = System.OpenModal( fpath , 550 , 400 , 'resizable:yes;status:yes'); 
            if (object != null)
            {                  
                txtTypePK.text     = object[0];
                txtTypeNo.text     = object[1];
                txtTypeDesc.text   = object[2];
                txtBlendingNo.text = object[3];
                shbo00020_2.Call('SELECT');
            }
        break;
        case 'Emp':
               var path = System.RootURL + '/form/sh/ab/shab00020.aspx';
               var obj = System.OpenModal( path ,850 , 500,  'resizable:yes;status:yes');
               if ( obj != null )
               {
                    txtEmpPk.text   = obj[0];
                    txtEmpID.text   = obj[4];
                    txtEmpName.text = obj[5];
               }	
        break;  
        case 'Print':
               var path = System.RootURL + '/form/sh/bo/shbo00160.aspx?batchno=' + txtBatchNo.text + '&inst_dt=' + dtInstDate.value + '&tankno=' + txtMTankNo.text;
               var obj = System.OpenModal( path ,750 , 500,  'resizable:yes;status:yes');
               shbo00020_1.Call('SELECT');
        break;  
    }
}
 //---------------------------------------------------------
 function OnSearch(pos)
 {
    switch(pos)
    {
        case 'List':
            shbo00020.Call("SELECT");
        break;
        case'Master':
            txtMasterPK.text=grdBatch.GetGridData(grdBatch.row,G1_pk);
            flag ='select';
            shbo00020_1.Call("SELECT");
        break;
    }
 }
 //---------------------------------------------------------
 function OnAddNew(pos)
 {
      switch (pos)         
      {		  
        case 'Master':
            shbo00020_1.StatusInsert();
            txtEmpPk.text = user_pk;
            txtEmpID.text = user_code;
            txtEmpName.text =user_name;
            grdDetail.ClearData();
        break;              
        case 'grdDetail' :
            
        break;
      }  
 }
//---------------------------------------------------------
var flag="";
//---------------------------------------------------------

 function OnSave(pos)
 {
      switch (pos)         
      {		        
        case 'Master' :
            if(!OnValidateData())
            {
                return ;
            }
                
            flag ='update';            
            txtInsTot.text = grdDetail.GetGridData(grdDetail.rows-1,G1_Inst_Qty).replace(',','');;
            txtMinTot.text = grdDetail.GetGridData(grdDetail.rows-1,G1_Min_Value).replace(',','');;
            txtMaxTot.text = grdDetail.GetGridData(grdDetail.rows-1,G1_Max_Value).replace(',','');;
            shbo00020_1.Call();
        break;
        case 'Detail':
            
            for(i=1;i<grdDetail.rows-1;i++)
            {
                grdDetail.SetGridText(i,G1_tank_no,txtMTankNo.text);
                if(grdDetail.GetGridData(i,G1_pk)=='')
                {
                    grdDetail.SetGridText(i,G1_tsh_wei_m_pk,txtMasterPK.text);
                    grdDetail.SetRowStatus(i,'48');
                }
            }
            grdDetail.SetRowStatus(grdDetail.rows-1,0);
            shbo00020_2.Call();
        break;
      }  
 }
//----------------------------------------------------------
function OnValidateData()
{
    if(txtMTankNo.text =='')
    {
        alert("Please input M/tank!!!");
        return false;
    }
    if(Number(txtMTankNo.text) ==0)
    {
        alert("M/tank must be a number and from 1!!!");
        return false;
    }
    return true;
}
//----------------------------------------------------------
 function OnDelete()
 {
    if ( confirm( "Do you want to delete?" ) ) 
    {
        flag ='update';
	    shbo00020_1.StatusDelete();
	    shbo00020_1.Call();
    }
 }
 //---------------------------------------------------------
 function OnReceiveData(obj)
{
    switch(obj.id)
    {
        case 'shbo00020_1':
            if(flag=="update")
            {
                OnSave('Detail'); 
            }
            else
            {
                shbo00020_2.Call("SELECT");
            }   
        break;
        case'shbo00020_2':
            if(flag == 'update')
                shbo00020.Call("SELECT");
                
            grdDetail.Subtotal( 0, 2, -1, '5!6!7!8','###,###,##0.##0');  
        break;
        case 'shbo00020_3':
            CalculateInst();
        break;
    }
}
 
//---------------------------------------------------------
function FormatGrid()
 {
 }
//---------------------------------------------------------
function OnChangeGelQty()
{
    shbo00020_3.Call();
}
//---------------------------------------------------------
function CalculateInst()
{
    var inst_qty =0, use_ratio = 0, min_value=0, max_value =0, v_inst_nugye=0, v_ratio_nugye=0, per_hap=0;
    var batch_qty = Number(txtBatchQty.text);
    for(i =1;i<grdDetail.rows -1; i++)
    {
        use_ratio   = grdDetail.GetGridData(i, G1_Use_Ratio);
        
        inst_qty      = Math.ceil(((Number(batch_qty) - Number(v_inst_nugye)) * Number(use_ratio) / (100 - Number(v_ratio_nugye))) * 1000) / 1000;  
        v_inst_nugye  = Number(v_inst_nugye)  + Number(inst_qty); 
        v_ratio_nugye = Number(v_ratio_nugye) + Number(use_ratio); 
        min_value     = System.Round((Number(inst_qty) - (Number(inst_qty) *  0.010)),3);
        max_value     = ((Number(inst_qty,0) + (Number(inst_qty,0) *  0.010))).toFixed(3) ;
        
        grdDetail.SetGridText(i, G1_Inst_Qty,  inst_qty); 
        grdDetail.SetGridText(i, G1_Min_Value, min_value); 
        grdDetail.SetGridText(i, G1_Max_Value, max_value);
    }
    
    grdDetail.Subtotal( 0, 2, -1, '5!6!7!8','###,###,##0.##0');  
    if(grdDetail.rows >1)
    {
        inst_tot = Number(grdDetail.GetGridData(grdDetail.rows-1,G1_Inst_Qty).replace(',','') );
        tmpvalue =System.Round((Number(inst_tot) - (Number(inst_tot) *  0.010)),3);
        grdDetail.SetGridText(grdDetail.rows-1, G1_Min_Value, tmpvalue); 
    }  
} 

//------------------------------------------------------------------------------
function OnChangeData()
{
    var inst_qty =0, matno = '', min_value=0, max_value =0, gel_ratio=0;
    var i =event.row;
    if(i >0 && i <grdDetail.rows-1)
    {
        inst_qty   = grdDetail.GetGridData(i, G1_Inst_Qty);

        min_value  = System.Round((Number(inst_qty) - (Number(inst_qty) *  0.010)),3);
        max_value  = ((Number(inst_qty) + (Number(inst_qty) *  0.010))).toFixed(3) ;
      
        grdDetail.SetGridText(i, G1_Min_Value, min_value); 
        grdDetail.SetGridText(i, G1_Max_Value, max_value);
    }
    grdDetail.Subtotal( 0, 2, -1, '5!6!7!8','###,###,##0.##0');
    if(grdDetail.rows >1)
    {
        inst_tot = grdDetail.GetGridData(grdDetail.rows-1,G1_Inst_Qty).replace(',','');
        tmpvalue =System.Round((Number(inst_tot) - (Number(inst_tot) *  0.010)),3);
        grdDetail.SetGridText(grdDetail.rows-1, G1_Min_Value, tmpvalue); 
    }  
}
//------------------------------------------------------------------------------
</script>

<body>
    <!------------------------------------------------------------------>
    <gw:data id="shbo00020"> 
        <xml>                                                               
            <dso id="1" type="grid" user="prod" function="prod.sp_sel_shbo00020" > 
                <input> 
                    <input bind="txtBatch" /> 
                    <input bind="dtFromDate" /> 
                    <input bind="dtToDate" /> 
                </input> 
                <output bind="grdBatch" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <gw:data id="shbo00020_1" onreceive="OnReceiveData(this)"> 
        <xml>                                                               
            <dso id="2" type="control" user="prod" function="prod.sp_sel_shbo00020_1" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19" procedure="PROD.sp_upd_shbo00020_1" > 
                <inout > 
                    <inout bind="txtMasterPK" />
                    <inout bind="dtInstDate" />
                    <inout bind="txtABatchPK" />
                    <inout bind="txtABatchNo" />
                    <inout bind="txtMTankNo" />
                    <inout bind="txtTrGU" />
                    <inout bind="txtTrGUNM" />
                    <inout bind="txtBatchNo" />
                    <inout bind="dtIssDate" />
                    <inout bind="txtBatchQty" />
                    <inout bind="txtEmpPk" />
                    <inout bind="txtEmpID" />
                    <inout bind="txtEmpName" />
                    <inout bind="txtTypePK" />
                    <inout bind="txtTypeNo" />
                    <inout bind="txtTypeDesc" />
                    <inout bind="txtBlendingNo" />
                    <inout bind="txtInsTot" />
                    <inout bind="txtMinTot" />
                    <inout bind="txtMaxTot" />
                </inout> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <gw:data id="shbo00020_2" onreceive="OnReceiveData(this)"> 
        <xml>                                                               
            <dso id="3" type="grid" user="prod" function="prod.sp_sel_shbo00020_2" parameter="0,1,2,3,4,5,6,7,8,9" procedure="prod.sp_upd_shbo00020_2"> 
                <input bind="grdDetail"> 
                    <input bind="txtMasterPK" />
                    <input bind="txtTypePK" />
                </input> 
                <output bind="grdDetail" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <table style="width: 100%; height: 100%" border="1">
        <tr style="height: 100%">
            <td style="width: 25%" id="left">
                <table style="width: 100%; height: 100%" >
                    <tr style="height: 1%">
                        <td style="width: 30%;white-space:nowrap" align="right">
                            <b>Batch No.</b>
                        </td>
                        <td style="width: 69%" align="right">
                            <gw:textbox id="txtBatch" styles='width:100%' onenterkey="OnSearch('List')" />
                        </td>
                        <td style="width: 1%" align="right">
                            <gw:imgbtn img="search" alt="Search" id="btnSearch" onclick="OnSearch('List')" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td align="right" >
                            <b>Date</b>
                        </td>
                        <td  colspan=2>
                            <gw:datebox id="dtFromDate" lang="1" styles="width:100%" onchange="OnSearch('List')"/>
                            ~<gw:datebox id="dtToDate" lang="1" styles="width:100%" onchange="OnSearch('List')"/>
                        </td>
                    </tr>
                    <tr style="height: 98%">
                        <td colspan="3">
                            <gw:grid id='grdBatch'
                                header='_pk|Date|Batch No|Batch Desc'
                                format='0|4|0|0' aligns='0|0|0|0' defaults='|||' editcol='0|0|0|0'
                                widths='0|1200|1500|2000' sorting='T' styles='width:100%; height:100%'
                                oncellclick="OnSearch('Master')" autosize="T" />
                        </td>
                    </tr>
                </table>
            </td>
            <td style="width: 75%" id="right" >
                <table style="width: 100%; height: 100%">
                    <tr style="height: 1%">
                        <td style="width: 18%" align="right" colspan=5>
                            <table style="width: 100%; height: 100%">
                                <tr style="height: 1%">
                                    <td style="width: 96%">
                                    </td>
                                    <td style="width: 1%" align="right">
                                        <gw:icon id="btnCal" img="3" text="Calculate" onclick="CalculateInst()" />
                                    </td>
                                    <td style="width: 1%" align="right">
                                        <gw:imgbtn img="new" alt="New" id="btnAddNew" onclick="OnAddNew('Master')" />
                                    </td>
                                    <td style="width: 1%" align="right">
                                        <gw:imgbtn img="delete" alt="Delete" id="btnDelete" onclick="OnDelete()" />
                                    </td>
                                    <td style="width: 1%" align="right">
                                        <gw:imgbtn img="save" alt="Save" id="btnSave" onclick="OnSave('Master')" />
                                    </td>
                                    <td style="width: 1%" align="right">
                                        <gw:imgbtn img="printer" alt="Save" id="btnPrint" onclick="OnPopUp('Print')" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td style="width: 20%;white-space:nowrap" align="right">
                            Instructed Date
                        </td>
                        <td style="width: 12%" align="right" >
                            <gw:datebox id="dtInstDate" lang="<%=Application("Lang")%>" mode="01" />
                        </td>
                        <td style="width: 35%;white-space:nowrap" align="right"> 
                            <b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp('Additive')">Additive Sol. Batch No.</b>
                        </td>
                        <td style="width: 12%" align="right">
                            <gw:textbox id="txtABatchPK" styles='width:100%;display:none' />
                            <gw:textbox id="txtABatchNo" styles='width:100%' />
                        </td>
                        <td  align="right" style="width: 21%">
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td style="white-space:nowrap" align="right">
                            M/Tank No.
                        </td>
                        <td  align="right" >
                            <gw:textbox id="txtMTankNo" styles='width:100%'  />
                        </td>
                        <td style="white-space:nowrap" align="right">
                            Tr./Op
                        </td>
                        <td  align="right">
                            <gw:textbox id="txtTrGU" styles='width:100%'/>
                        </td>
                        <td style="white-space:nowrap" align="right">
                            <gw:textbox id="txtTrGUNM" styles='width:100%'/>
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td style="white-space:nowrap" align="right">
                            Melting Batch No.
                        </td>
                        <td  align="right" >
                            <gw:textbox id="txtBatchNo" styles='width:100%' />
                        </td>
                        <td style="white-space:nowrap" align="right">
                            Issued Date
                        </td>
                        <td  align="right">
                            <gw:datebox id="dtIssDate" nullaccept lang="<%=Application("Lang")%>" mode="01" />
                        </td>
                        <td style="white-space:nowrap" align="right">
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td align="right">
                            Total Gelatin Q'ty(Kg)
                        </td>
                        <td  align="right" >
                            <gw:textbox id="txtBatchQty" styles='width:100%' type="number" format="#,###,###,###,###.##0R" onenterkey="CalculateInst()" onblur="CalculateInst()"/>
                        </td>
                        <td align="right">
                            <b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp('Emp')">Issued by</b>
                        </td>
                        <td  align="right">
                            <gw:textbox id="txtEmpPk" styles='width:100%;display:none' />
                            <gw:textbox id="txtEmpID" styles='width:100%' />
                        </td>
                        <td align="right">
                            <gw:textbox id="txtEmpName" styles='width:100%' />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td align="right">
                            <b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp('Blending')">Blending Type No.</b>
                        </td>
                        <td  align="right" >
                            <gw:textbox id="txtTypePK" styles='width:100%;display:none' />
                            <gw:textbox id="txtTypeNo" styles='width:100%' />
                        </td>
                        <td align="right">
                            <gw:textbox id="txtTypeDesc" styles='width:100%' />
                        </td>
                        <td align="right">
                            Blending No.
                        </td>
                        <td align="right">
                            <gw:textbox id="txtBlendingNo" styles='width:100%;color:blue' />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td  align="right" colspan=5>
                        </td>
                    </tr>
                    <tr style="height: 93%">
                        <td colspan="5">
                            <gw:grid id='grdDetail' 
                                header='_pk|_tsh_wei_m_pk|_tsh_mixtyped_pk|Blend Type|Test No|Blend Ratio|Inst Qty(Kg)|Min Value|Max Value|_tank_no'
                                format='0|0|0|2|0|-3|-3|-3|-3|0' aligns='0|0|0|0|0|3|3|3|3|0' defaults='|||||||||'
                                editcol='0|0|0|0|0|0|1|0|0|0' widths='0|0|0|2800|1300|1300|1500|1000|1000|0'
                                sorting='T' styles='width:100%; height:100%' editcolcolor ="T" onafteredit="OnChangeData()"/>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <!------------------------------------------->
</body>
 <img status="expand" id="imgArrow" src="../../../system/images/prev_orange.gif" style="cursor: hand;
        position: absolute; left: 1; top: 0;" onclick="OnToggle()" />
<gw:textbox id="txtMasterPK" styles="width: 100%;display:none" />
<gw:textbox id="txtInsTot" styles="width: 100%;display:none" />
<gw:textbox id="txtMinTot" styles="width: 100%;display:none" />
<gw:textbox id="txtMaxTot" styles="width: 100%;display:none" />
<gw:textbox id="txtChargerPK" styles="width: 100%;display:none" />
</html>
