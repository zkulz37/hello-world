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
    G1_tsh_add_m_pk     = 1,
    G1_tsh_mixtyped_pk  = 2,
    G1_item_code        = 3,
    G1_item_name        = 4,
    G1_uom              = 5,
    G1_use_ratio        = 6,
    G1_inst_qty         = 7,
    G1_min_value        = 8,
    G1_max_value        = 9,
    G1_test_no          = 10,
    G1_gel_ratio        = 11,
    G1_tco_item_pk      = 12;
 //---------------------------------------------------------
 function BodyInit()
 {
      OnAddNew('Master');
      FormatGrid();
      txtTypeNo.SetEnable(false);
      txtTypeDesc.SetEnable(false);
      txtBatchNo.SetEnable(false);
      txtEmpID.SetEnable(false);
      txtEmpName.SetEnable(false);
      dtIssDate.SetEnable(false);
     // grdDetail.SetWrapText(true);
     dtFromDate.SetDataText(System.AddDate(dtToDate.GetData(),-7));
     shbo00040.Call("SELECT");
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
        case 'Type_no':
            var fpath = System.RootURL + "/form/sh/ab/shab00070.aspx?type=Tit";
            var object = System.OpenModal( fpath , 750 , 500 , 'resizable:yes;status:yes'); 
            if (object != null)
            {                  
                txtTypePK.text = object[0];
                txtTypeNo.text = object[1];
                txtTypeDesc.text = object[2];
                shbo00040_2.Call('SELECT');
            }
        break;
        case 'Emp':
               var path = System.RootURL + '/form/sh/ab/shab00020.aspx';
               var obj = System.OpenModal( path ,850 , 500,  'resizable:yes;status:yes');
               if ( obj != null )
               {
                    txtEmpPk.text = obj[0];
                    txtEmpID.text = obj[4];
                    txtEmpName.text = obj[5];
               }	
        break; 
        case 'Print':
               var path = System.RootURL + '/form/sh/bo/shbo00180.aspx?batchno=' + txtBatchNo.text + '&inst_dt=' + dtInstDate.value;
               var obj = System.OpenModal( path ,750 , 500,  'resizable:yes;status:yes');
               shbo00040_1.Call('SELECT');
        break;     
    }
}
 //---------------------------------------------------------
 function OnSearch(pos)
 {
    switch(pos)
    {
        case 'List':
            shbo00040.Call("SELECT");
        break;
        case'Master':
            txtMasterPK.text=grdBatch.GetGridData(grdBatch.row,G1_pk);
            flag ='select';
            shbo00040_1.Call("SELECT");
        break;
    }
 }
 //---------------------------------------------------------
 function OnAddNew(pos)
 {
      switch (pos)         
      {		  
        case 'Master':
            shbo00040_1.StatusInsert();
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
            flag ='update';
            txtInsTot.text = grdDetail.GetGridData(grdDetail.rows-1,G1_inst_qty);
            txtMinTot.text = grdDetail.GetGridData(grdDetail.rows-1,G1_min_value);
            txtMaxTot.text = grdDetail.GetGridData(grdDetail.rows-1,G1_max_value);
            shbo00040_1.Call();
        break;
        case 'Detail':
            for(i=1;i<grdDetail.rows-1;i++)
            {
                if(grdDetail.GetGridData(i,G1_pk)=='')
                {
                    grdDetail.SetGridText(i,G1_tsh_add_m_pk,txtMasterPK.text);
                    grdDetail.SetRowStatus(i,'48');
                }
            }
            grdDetail.SetRowStatus(grdDetail.rows-1,'');
            shbo00040_2.Call();
        break;
      }  
 }
//---------------------------------------------------------

 function OnDelete()
 {
    if ( confirm( "Do you want to delete?" ) ) 
    {
        flag ='update';
	    shbo00040_1.StatusDelete();
	    shbo00040_1.Call();
    }
 }
 //---------------------------------------------------------
 function OnReceiveData(obj)
{
    switch(obj.id)
    {
        case 'shbo00040_1':
            if(flag=="update")
            {
                OnSave('Detail'); 
            }
            else
            {
                shbo00040_2.Call("SELECT");
            }  
        break;
        case'shbo00040_2':
            if(flag == 'update')
                shbo00040.Call("SELECT");
                
            grdDetail.Subtotal( 0, 2, -1, '6!7!8!9','###,###,##0.##0');  
            if(grdDetail.rows>1)
            {
                grdDetail.SetGridText(grdDetail.rows-1,G1_inst_qty, txtBatchQty.text);
                inst_tot = grdDetail.GetGridData(grdDetail.rows-1,G1_inst_qty);
                tmpvalue =System.Round((Number(inst_tot) - (Number(inst_tot) *  0.010)),3);
                grdDetail.SetGridText(grdDetail.rows-1, G1_min_value, tmpvalue); 
                tmpvalue  = ((Number(inst_tot) + (Number(inst_tot) *  0.010))).toFixed(3) ;
                grdDetail.SetGridText(grdDetail.rows-1, G1_max_value, tmpvalue); 
            }
        break
    }
}
 
//---------------------------------------------------------
function FormatGrid()
 {
      var trl ;
     
      trl = grdDetail.GetGridControl();
      	
      trl.ColFormat(G1_use_ratio )     = "###,###,###,###,##0.##0";
      trl.ColFormat(G1_inst_qty )      = "###,###,###,###,##0.##0";
      trl.ColFormat(G1_min_value )     = "###,###,###,###,##0.##0";
      trl.ColFormat(G1_max_value )     = "###,###,###,###,##0.##0";
      
 }
//---------------------------------------------------------
function CalculateInst()
{
    var inst_qty =0, matno = '', min_value=0, max_value =0, use_ratio=0;
    var gel_qty = Number(txtBatchQty.text);
    for(i =1;i<grdDetail.rows -1; i++)
    {

        matno       = grdDetail.GetGridData(i, G1_item_code);
        use_ratio   = grdDetail.GetGridData(i, G1_use_ratio);

        if  (matno == 'M000012' )
        {
           inst_qty = ((((Number(gel_qty) * Number(use_ratio) / 100) / 0.980) * 1000) / 1000).toFixed(3);
        }
        else
        {
           inst_qty = Math.ceil((Number(gel_qty) * Number(use_ratio) / 100)    * 1000) / 1000;
        }
//      
        min_value  = System.Round((Number(inst_qty) - (Number(inst_qty) *  0.010)),3);
        max_value  = ((Number(inst_qty) + (Number(inst_qty) *  0.010))).toFixed(3) ;
      
        grdDetail.SetGridText(i, G1_inst_qty,  inst_qty); 
        grdDetail.SetGridText(i, G1_min_value, min_value); 
        grdDetail.SetGridText(i, G1_max_value, max_value);
    }
    grdDetail.Subtotal( 0, 2, -1, '6!7!8!9','###,###,##0.##0');  
    if(grdDetail.rows >1)
    {
        grdDetail.SetGridText(grdDetail.rows-1,G1_inst_qty, txtBatchQty.text);
        inst_tot = grdDetail.GetGridData(grdDetail.rows-1,G1_inst_qty).replace(',','');
        tmpvalue =System.Round((Number(inst_tot) - (Number(inst_tot) *  0.010)),3);
        grdDetail.SetGridText(grdDetail.rows-1, G1_min_value, tmpvalue); 
        tmpvalue  = ((Number(inst_tot) + (Number(inst_tot) *  0.010))).toFixed(3) ;
        grdDetail.SetGridText(grdDetail.rows-1, G1_max_value, tmpvalue); 
        tmpvalue =System.Round((Number(inst_tot) + (Number(inst_tot) *  0.010)),3);
        grdDetail.SetGridText(grdDetail.rows-1, G1_max_value, tmpvalue);
    }
} 
//------------------------------------------------------------------------------
function OnChangeData()
{
    var inst_qty =0, matno = '', min_value=0, max_value =0, gel_ratio=0;
    var i =event.row;
    if(i >0 && i <grdDetail.rows-1)
    {
        matno       = grdDetail.GetGridData(i, G1_item_code);
        inst_qty   = grdDetail.GetGridData(i, G1_inst_qty);

        min_value  = System.Round((Number(inst_qty) - (Number(inst_qty) *  0.010)),3);
        max_value  = ((Number(inst_qty) + (Number(inst_qty) *  0.010))).toFixed(3) ;
      
        grdDetail.SetGridText(i, G1_min_value, min_value); 
        grdDetail.SetGridText(i, G1_max_value, max_value);
    }
    grdDetail.Subtotal( 0, 2, -1, '6!7!8!9','###,###,##0.##0');
    if(grdDetail.rows >1)
    {
        grdDetail.SetGridText(grdDetail.rows-1,G1_inst_qty, txtBatchQty.text);
        inst_tot = grdDetail.GetGridData(grdDetail.rows-1,G1_inst_qty).replace(',','');
        tmpvalue =System.Round((Number(inst_tot) - (Number(inst_tot) *  0.010)),3);
        grdDetail.SetGridText(grdDetail.rows-1, G1_min_value, tmpvalue);
        tmpvalue  = ((Number(inst_tot) + (Number(inst_tot) *  0.010))).toFixed(3) ;
        grdDetail.SetGridText(grdDetail.rows-1, G1_max_value, tmpvalue); 
        tmpvalue =System.Round((Number(inst_tot) + (Number(inst_tot) *  0.010)),3);
        grdDetail.SetGridText(grdDetail.rows-1, G1_max_value, tmpvalue);
    }
}
</script>

<body>
    <!------------------------------------------------------------------>
    <gw:data id="shbo00040"> 
        <xml>                                                               
            <dso id="1" type="grid" user="prod" function="prod.sp_sel_shbo00040" > 
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
    <gw:data id="shbo00040_1" onreceive="OnReceiveData(this)"> 
        <xml>                                                               
            <dso id="2" type="control" user="prod" function="prod.sp_sel_shbo00040_1" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14" procedure="PROD.sp_upd_shbo00040_1" > 
                <inout > 
                    <inout bind="txtMasterPK" />
                    <input bind="dtInstDate" />
                    <input bind="txtBatchQty" />
                    <input bind="txtBatchNo" />
                    <input bind="txtBatchDesc" />
                    <input bind="dtIssDate" />
                    <input bind="txtTypePK" />
                    <input bind="txtTypeNo" />
                    <input bind="txtTypeDesc" />
                    <input bind="txtEmpPk" />
                    <input bind="txtEmpID" />
                    <input bind="txtEmpName" />
                    <input bind="txtInsTot" />
                    <input bind="txtMinTot" />
                    <input bind="txtMaxTot" />
                </inout> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <gw:data id="shbo00040_2" onreceive="OnReceiveData(this)"> 
        <xml>                                                               
            <dso id="3" type="grid" user="prod" function="prod.sp_sel_shbo00040_2" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12" procedure="prod.sp_upd_shbo00040_2"> 
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
        <tr>
            <td style="width: 25%" id="left">
                <table style="width: 100%; height: 100%">
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
                            <gw:datebox id="dtFromDate" lang="1" styles="width:100%" onchange="OnSearch('List')" />
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
                        <td style="width: 18%" align="right" colspan=6>
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
                        <td style="width: 15%;white-space:nowrap" align="right">
                            Instructed Date
                        </td>
                        <td style="width: 13%" align="right" >
                            <gw:datebox id="dtInstDate" lang="<%=Application("Lang")%>" mode="01" />
                        </td>
                        <td style="width: 28%;white-space:nowrap" align="right">
                        </td>
                        <td style="width: 14%" align="right">
                        </td>
                        <td  style="width: 10%"align="right" >
                        </td>
                        <td  style="width: 20%"align="right" >
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td style="white-space:nowrap" align="right">
                            Batch Q'ty
                        </td>
                        <td align="right" >
                            <gw:textbox id="txtBatchQty" styles='width:100%' type="number" format="#,###,###,###,###" onblur="CalculateInst()" onenterkey="CalculateInst()"/>
                        </td>
                        <td style="white-space:nowrap" align="right">
                        </td>
                        <td  align="right">
                        </td>
                        <td style="white-space:nowrap" align="right">
                        </td>
                        <td  align="right">
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td align="right">
                            Batch No.
                        </td>
                        <td  align="right" >
                            <gw:textbox id="txtBatchNo" styles='width:100%' />
                        </td>
                        <td align="right" >
                            <gw:textbox id="txtBatchDesc" styles='width:100%' />
                        </td>
                        <td style="white-space:nowrap" align="right">
                            Issued Date
                        </td>
                        <td align="right">
                            <gw:datebox id="dtIssDate" nullaccept lang="<%=Application("Lang")%>" mode="01" />
                        </td>
                        <td  align="right">
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td align="right">
                            <b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp('Type_no')">Type No.</b>
                        </td>
                        <td  align="right" >
                            <gw:textbox id="txtTypeNo" styles='width:100%' />
                        </td>
                        <td align="right" >
                            <gw:textbox id="txtTypeDesc" styles='width:100%' />
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
                        <td  align="right" colspan=6>
                        </td>
                    </tr>
                    <tr style="height: 98%">
                        <td colspan="6">
                            <gw:grid id='grdDetail' 
                                header='_pk|_tsh_add_m_pk|_tsh_mixtyped_pk|Mat Code|Mat Name|Unit|Mixing Ratio(%)|Inst. Qty.(Kg)|Min|Max|Test No|_gel_ratio|_tco_item_pk'
                                format='0|0|0|0|0|0|0|0|0|0|0|0|0' aligns='0|0|0|0|0|1|3|3|3|3|0|0|0' defaults='||||||||||||'
                                editcol='0|0|0|0|0|0|0|1|0|0|0|0|0' widths='0|0|0|1500|2400|600|1500|1300|900|900|1200|0|0'
                                sorting='T'styles='width:100%; height:100%' editcolcolor ="T" onafteredit="OnChangeData()"  />
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
<gw:textbox id="txtTypePK" styles="width: 100%;display:none" />
<gw:textbox id="txtChargerPK" styles="width: 100%;display:none" />
<gw:textbox id="txtInsTot" styles="width: 100%;display:none" />
<gw:textbox id="txtMinTot" styles="width: 100%;display:none" />
<gw:textbox id="txtMaxTot" styles="width: 100%;display:none" />
</html>
