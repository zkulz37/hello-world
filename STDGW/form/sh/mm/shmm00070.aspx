<!-- #include file="../../../system/lib/form.inc"  -->
<%  ESysLib.SetUser("prod")%>
<head id="Head1">
    <title>Stock OutGoing</title>
</head>

<script>
var  user_pk    = "<%=Session("EMPLOYEE_PK")%>" ;
var  user_code  = "<%=Session("EMP_ID")%>" ;
var  user_name  = "<%=Session("USER_NAME")%>" ; 
var  dept_pk  = "<%=Session("DEPT_PK")%>" ; 
var  dept_id  = "<%=Session("DEPT_CODE")%>" ; 
var  dept_nm  = "<%=Session("DEPT_NAME")%>" ; 
var flag ='';
       
var G1_pk               = 0,           
    G1_tin_takeout_pk   = 1,
    G1_tco_item_pk      = 2,
    G1_item_code        = 3,
    G1_item_name        = 4,
    G1_spec             = 5,
    G1_item_unit        = 6,
    G1_stock_qty        = 7, 
    G1_takeout_qty      = 8,
    G1_lot_no           = 9,
    G1_test_no          = 10,
    G1_blending_no      = 11,   
    G1_description      = 12,
    G1_unit_of_entry    = 13,
    G1_take_out_dt      = 14,
    G1_out_wh_pk        = 15,
    G1_takeout_type     = 16;
 //---------------------------------------------------------

 function BodyInit()
 {
    BindingDataList();
    txtEmpID.SetEnable(false);
    txtEmpName.SetEnable(false);
    txtDeptCode.SetEnable(false);
    txtDeptName.SetEnable(false);
    txtRecDeptID.SetEnable(false);
    txtRecDeptName.SetEnable(false);
    txtCusID.SetEnable(false);
    txtCusName.SetEnable(false);
    txtSeq.SetEnable(false);
    BindingDataList();
    OnAddNew('Master');
    dtFromDate.SetDataText(System.AddDate(dtToDate.GetData(),-7));
    txtDeptName.text='PC';
    txtDeptCode.text='5054';
    txtRecDeptName.text='PC';
    txtRecDeptID.text='5054';
    
 }
 //---------------------------------------------------------
 function OnPopUp(obj)
{
    switch(obj)
    { 
        case 'IssDept':
            var fpath = System.RootURL + "/form/fp/ab/fpab00220.aspx?code_group=LGIV0050";
            var object = System.OpenModal( fpath , 550 , 400 , 'resizable:yes;status:yes'); 
            if (object != null)
            {                  
               txtDeptName.text = object[3]; 
               txtDeptPk.text  = object[1]; 
               txtDeptCode.text  = object[1]; 
            }
        break;
        case 'RecDept':
            var fpath = System.RootURL + "/form/fp/ab/fpab00220.aspx?code_group=LGIV0050";
            var object = System.OpenModal( fpath , 550 , 400 , 'resizable:yes;status:yes'); 
            if (object != null)
            {                  
               txtRecDeptName.text = object[3]; 
               txtRecDeptPk.text  = object[1]; 
               txtRecDeptID.text  = object[1]; 
            }
        break;
        case 'Charger':
               var path = System.RootURL + '/form/sh/ab/shab00020.aspx';
               var obj = System.OpenModal( path ,850 , 500,  'resizable:yes;status:yes');
               if ( obj != null )
               {
                    txtEmpPk.text   = obj[0];
                    txtEmpID.text   = obj[4];
                    txtEmpName.text = obj[5];
               }	
        break;  
         case 'Item':
               var path = System.RootURL + '/form/sh/ab/shab00220.aspx';
               var obj = System.OpenModal( path ,850 , 500,  'resizable:yes;status:yes');
               if ( obj != null )
               {
                    for(var i =0 ;i< obj.length;i++)
                    {
                        var value = new Array();
                        value = obj[i];
                        grdDetail.AddRow();
                        grdDetail.SetGridText(grdDetail.rows-1, G1_tco_item_pk,value[0]);
                        grdDetail.SetGridText(grdDetail.rows-1, G1_item_code,  value[1]);
                        grdDetail.SetGridText(grdDetail.rows-1, G1_item_name,  value[2]);
                        grdDetail.SetGridText(grdDetail.rows-1, G1_spec,       value[3]);
                        grdDetail.SetGridText(grdDetail.rows-1, G1_item_unit,  value[5]);
                        grdDetail.SetGridText(grdDetail.rows-1, G1_unit_of_entry,  value[5]);
                        grdDetail.SetGridText(grdDetail.rows-1, G1_stock_qty,  value[6]);
                        
                        grdDetail.SetGridText(grdDetail.rows-1, G1_lot_no,  value[7]);
                        grdDetail.SetGridText(grdDetail.rows-1, G1_test_no,  value[8]);
                        
                        grdDetail.SetGridText(grdDetail.rows-1, G1_out_wh_pk,  lstWH.value);
                    }
               }	
        break;  
       
        case 'Customer' :
             var path = System.RootURL + "/form/fp/ab/fpab00120.aspx?partner_type=AR";
	         var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
	         if ( object != null )
	         {
	            txtCusPk.text   = object[0];
	            txtCusID.text     = object[1];
                txtCusName.text     = object[2];                
	         }
        break;
        
    }
}
//---------------------------------------------------------
function BindingDataList()
 {
     data = "<%=ESysLib.SetListDataSQL("select v.pk, v.wh_name from inv.tin_warehouse v where del_if =0 and WH_ID in ('MAT-DO','MAT-OS')  order by v.wh_name")%>";
     lstWH.SetDataText(data);
     data= "<%=ESysLib.SetListDataSQL("select code, code_nm from sale.lg_code a, sale.lg_code_group b where a.lg_code_group_pk = b.pk and b.group_id = 'LGIV0040' and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0 and a.CHA_VALUE1='shmm00070' order by a.def_yn desc, ord")%>||Select All";
     lstTOType1.SetDataText(data);
     lstTOType1.value="";
 }
 //---------------------------------------------------------
 function OnAddNew(pos)
 {
      switch (pos)         
      {		  
        case 'Master':
            data_shmm00070_1.StatusInsert();
            txtEmpPk.text = user_pk;
            txtEmpID.text = user_code;
            txtEmpName.text = user_name;
            txtDeptPk.text = dept_pk;
            txtDeptCode.text = dept_id;
            txtDeptName.text = dept_nm;
            grdDetail.ClearData();
            OnChangeType();
        break;              
        case 'Detail' :
            grdDetail.AddRow();
        break;
      }  
 }
 //---------------------------------------------------------
 function OnDelete(obj)
 {
    switch(obj)
    {
        case 'Master':
            if ( confirm( "Do you want to delete?" ) ) 
            {
                flag = 'delete';
               data_shmm00070_1.StatusDelete();
               data_shmm00070_1.Call();
            }
        break;
        case 'Detail':
            if ( confirm( "Do you want to delete?" ) ) 
            {
               grdDetail.DeleteRow();
            }
        break;
    }
 }
 //--------------------------------------------------------
 function OnUnDelete()
{              
     grdDetail.UnDeleteRow();
}
 //---------------------------------------------------------
 function OnSearch(pos)
 {
    switch(pos)
    {
        case 'List':
            data_shmm00070.Call('SELECT');
        break;
        case'Master':
            flag= 'select';
            if(grdList.row>0)
                txtMasterPK.text = grdList.GetGridData(grdList.row,0);
            data_shmm00070_1.Call('SELECT');
        break;
    }
 }
 //---------------------------------------------------------
 function OnSave(pos)
 {
      switch (pos)         
      {		        
        case 'Master' :
            flag= 'save';
            data_shmm00070_1.Call();
        break;
        case 'Detail':
            for(i=1;i<grdDetail.rows;i++)
            {
                grdDetail.SetGridText(i,G1_tin_takeout_pk, txtMasterPK.text);
                grdDetail.SetGridText(i,G1_take_out_dt, dtIssDT.value);
                grdDetail.SetGridText(i,G1_takeout_type, lstTOType.value);
            }
            data_shmm00070_2.Call();
        break;
      }  
 }
//---------------------------------------------------------
function OnDataReceive(obj)
{
    switch(obj.id)
    {
        case 'data_shmm00070_1':
            if(flag=="save")
            {
                OnSave('Detail');
            }
            else
            if(flag=='delete')
            {
                grdDetail.ClearData();
                data_shmm00070.Call('SELECT');
            }
            else
            if(flag=='select')
            {
                data_shmm00070_2.Call('SELECT');
            }
        break;
        case 'data_shbo00010_2':
            if(flag=="save")
            {
                data_shmm00070.Call('SELECT');
            }
        break;
        case 'data_shmm00070_3':
            grdDetail.SetGridText(grdDetail.row,G1_legname, txtRtnValue1.text);
        break;
        case 'data_shmm00070_4':
            grdDetail.SetGridText(event.row,G1_partner_name, txtRtnValue1.text);
            grdDetail.SetGridText(event.row,G1_tco_partner_pk, txtRtnValue2.text);
        break;
    }
}//----------------------------------------------------------------------------------------
function OnChangeType()
{
    var tbDeli  = document.all("tbDilivery");
    var tbCus  = document.all("tbDiffAcc");  
    tbDeli.style.display ="none";
    tbCus.style.display ="none";
    switch(lstTOType.value)
    {
        case '02':
            var tbDeli  = document.all("tbDilivery");
            var tbCus  = document.all("tbDiffAcc");  
            tbDeli.style.display ="";
            tbCus.style.display ="none";
        break;
        case '06':
            var tbDeli  = document.all("tbDilivery");
            var tbCus  = document.all("tbDiffAcc");  
            tbDeli.style.display ="none";
            tbCus.style.display ="";
        break;
    }
    
}
//----------------------------------------------------------
function OnGriddblClick()
{
    col = event.col;
    row = event.row;
    
    if((col==G1_item_unit) || (col==G1_unit_of_entry))
    {
        var fpath = System.RootURL + '/form/fp/ab/fpab00230.aspx';
        var object = System.OpenModal( fpath , 550 , 400 , 'resizable:yes;status:yes'); 
        if (object != null)
        {                  
           grdDetail.SetGridText(row, col,    object[1]);
        }
    }
    if(col==G1_blending_no) 
    {
        var fpath = System.RootURL + "/form/sh/ab/shab00100.aspx?type=Blend";
        var object = System.OpenModal( fpath , 550 , 400 , 'resizable:yes;status:yes'); 
        if (object != null)
        {                  
           grdDetail.SetGridText(row, col,    object[3]);
        }
    }
}
//----------------------------------------------------------
function OnAfterValueChange(obj)
{   
    switch(obj)
    {
        case 'Detail':
            
        break;
        
    }
}
//----------------------------------------------------------
function OnKeyPress(e)
{
    if (e.keyAscii != 13)
        return;
        
    if(event.col == G1_partner_id)
    {
        txtInput.text =grdDetail.GetGridData(event.row, G1_partner_id);
        data_shmm00070_4.Call();
    }
    if(event.col == G1_ledger)
    {
        txtInput.text =grdDetail.GetGridData(event.row, G1_ledger);
        data_shmm00070_3.Call();
    }
}
//----------------------------------------------------------
function AddDigit(value, number)
{
    newstr = value;
    for(i=value.length; i< number; i++)
    {
        newstr = '0' + newstr;
    }
    return newstr;
}
//----------------------------------------------------------
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

</script>

<body>
    <!------------------------------------------------------------------>
    <gw:data id="data_shmm00070"> 
        <xml>                                                               
            <dso id="1" type="grid" user="inv" function="inv.sp_sel_shmm00070" > 
                <input> 
                    <input bind="txtTONo" /> 
                    <input bind="dtFromDate" /> 
                    <input bind="dtToDate" /> 
                    <input bind="lstTOType1" />
                </input> 
                <output bind="grdList" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <gw:data id="data_shmm00070_1" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="control" function="inv.sp_sel_shmm00070_1"  parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15" procedure="inv.sp_upd_shmm00070_1"> 
                <inout> 
                     <inout  bind="txtMasterPK" />
                     <inout  bind="lstCompany" />
                     <inout  bind="dtIssDT" />
                     <inout  bind="txtSeq" />
                     <inout  bind="txtDeptCode" />
                     <inout  bind="txtDeptName" />
                     <inout  bind="lstTOType" />
                     <inout  bind="txtCusPk" />
                     <inout  bind="txtCusID" />
                     <inout  bind="txtCusName" />                     
                     <inout  bind="txtRecDeptID" />
                     <inout  bind="txtRecDeptName" />
                     <inout  bind="txtEmpPk" />
                     <inout  bind="txtEmpID" /> 
                     <inout  bind="txtEmpName" />
                     <inout  bind="lstWH" />
                </inout>
            </dso> 
        </xml> 
    </gw:data>
    <!--------------------------------------------------------------------------->
    <gw:data id="data_shmm00070_2" onreceive="OnDataReceive(this)"> 
        <xml> 
           <dso id="4" type="grid" user="inv" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16" function="inv.sp_sel_shmm00070_2" procedure="inv.sp_upd_shmm00070_2"> 
                <input bind="grdDetail">
                    <input bind="txtMasterPK" />               
                </input> 
                <output bind="grdDetail" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!--------------------------------------------------------------------------------------->
    <table style="width: 100%; height: 100%" border="1">
        <tr style="height: 100%">
            <td style="width: 20" id="left">
                <table style="width: 100%; height: 100%">
                    <tr style="height: 1%">
                        <td style="width: 30%; white-space: nowrap" align="right">
                            <b>Seq</b>
                        </td>
                        <td style="width: 69%" align="right">
                            <gw:textbox id="txtTONo" styles='width:100%' onenterkey="OnSearch('List')" />
                        </td>
                        <td style="width: 1%; white-space: nowrap" align="right">
                            <gw:imgbtn img="search" alt="Search" id="btnSearch1" onclick="OnSearch('List')" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td align="right">
                            <b>Date</b>
                        </td>
                        <td colspan="2">
                            <gw:datebox id="dtFromDate" lang="1" styles="width:100%" onchange="OnSearch('List')" />
                            ~<gw:datebox id="dtToDate" lang="1" styles="width:100%" onchange="OnSearch('List')" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td align="right" style="white-space:nowrap">
                            <b>T/O Type</b>
                        </td>
                        <td colspan="2">
                            <gw:list id="lstTOType1" styles="width:100%;" onchange="OnSearch('List')" value="">
                           </gw:list>
                        </td>
                    </tr>
                    <tr style="height: 98%">
                        <td colspan="3">
                            <gw:grid id='grdList' header='_pk|Date|Seq' format='0|4|0' aligns='0|0|0' defaults='||'
                                editcol='0|0|0' widths='0|2000|500' sorting='T' styles='width:100%; height:100%'
                                oncellclick="OnSearch('Master')" autosize="T" />
                        </td>
                    </tr>
                </table>
            </td>
            <td style="width: 80%" id="right">
                <table style="width: 100%; height: 100%" cellpadding="0" cellspacing="0">
                    <tr style="height: 1%">
                        <td style="width: 100%">
                            <fieldset style="padding: 5">
                                <table style="width: 100%; height: 100%">
                                    <tr>
                                        <td align="right" style="white-space: nowrap">
                                            T/O Type
                                        </td>
                                        <td align="right" style="width: 10%" colspan="2">
                                            <gw:list id="lstTOType" styles="width:100%;" onchange="OnChangeType()">
                                            <data>
                                                <%=ESysLib.SetListDataSQL("select code, code_nm from sale.lg_code a, sale.lg_code_group b where a.lg_code_group_pk = b.pk and b.group_id = 'LGIV0040' and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0 and a.CHA_VALUE1='shmm00070' order by a.def_yn desc, ord")%>||
                                            </data>
                                        </gw:list>
                                        </td>
                                        <td colspan="3">
                                            <table style="width: 100%; height: 100%">
                                                <tr style="height: 1%">
                                                    <td style="width: 96%; color: Red">
                                                    </td>
                                                    <td style="width: 1%" align="right">
                                                        <gw:imgbtn img="search" alt="Search" id="btnSearch" onclick="OnSearch('Cap')" />
                                                    </td>
                                                    <td style="width: 1%" align="right">
                                                        <gw:imgbtn img="new" alt="New" id="btnAddNew" onclick="OnAddNew('Master')" />
                                                    </td>
                                                    <td style="width: 1%" align="right">
                                                        <gw:imgbtn img="delete" alt="Delete" id="btnDelete" onclick="OnDelete('Master')" />
                                                    </td>
                                                    <td style="width: 1%" align="right">
                                                        <gw:imgbtn img="save" alt="Save" id="btnSave" onclick="OnSave('Master')" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr style="height: 1%">
                                        <td style="width: 10%; white-space: nowrap" align="right">
                                            Plant
                                        </td>
                                        <td style="width: 10%" align="right" colspan="2">
                                            <gw:list id="lstCompany" styles='width:100%'>
                                            <data>
											    <%=ESysLib.SetListDataSQL("SELECT pk,PARTNER_NAME from  comm.TCO_COMPANY where del_if=0 order by PARTNER_NAME ")%>||
										    </data>
										</gw:list>
                                        </td>
                                        <td align="right" style="width: 12%">
                                            Issue Date
                                        </td>
                                        <td colspan="2">
                                            <gw:datebox id="dtIssDT" styles='width:100%' lang="1" />
                                            &nbsp;
                                            <gw:textbox id="txtSeq" styles='width:40; color:red' />
                                        </td>
                                    </tr>
                                    <tr style="height: 1%">
                                        <td style="white-space: nowrap" align="right">
                                            <b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp('IssDept')">Issue Dept.</b>
                                        </td>
                                        <td align="right" style="width: 10%">
                                            <gw:textbox id="txtDeptPk" styles='width:100%;display:none' />
                                            <gw:textbox id="txtDeptCode" styles='width:100%' />
                                        </td>
                                        <td align="right" style="width: 22%">
                                            <gw:textbox id="txtDeptName" styles='width:100%' />
                                        </td>
                                        <td align="right" style="white-space: nowrap">
                                            Warehouse
                                        </td>
                                        <td align="right" style="width: 33%" colspan="2">
                                            <gw:list id="lstWH" styles="width:100%;" onchange="OnChangeType()">
                                        </gw:list>
                                        </td>
                                    </tr>
                                    <tr style="height: 1%">
                                        <td align="right" style="white-space: nowrap; color: Red">
                                            <b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp('Charger')">Charger</b>
                                        </td>
                                        <td align="right">
                                            <gw:textbox id="txtEmpPk" styles='width:100%;display:none' />
                                            <gw:textbox id="txtEmpID" styles='width:100%' />
                                        </td>
                                        <td align="right">
                                            <gw:textbox id="txtEmpName" styles='width:100%' />
                                        </td>
                                        <td colspan="3" style="width: 45%">
                                            <table id="tbDilivery" style="width: 100%; height: 100%" border="0">
                                                <tr style="height: 1%">
                                                    <td style="white-space: nowrap; width: 22%" align="right">
                                                        <b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp('Customer')">Customer</b>
                                                    </td>
                                                    <td align="right" style="width: 23%">
                                                        <gw:textbox id="txtCusPk" styles='width:100%;display:none' />
                                                        <gw:textbox id="txtCusID" styles='width:100%' />
                                                    </td>
                                                    <td align="right" style="width: 55%">
                                                        <gw:textbox id="txtCusName" styles='width:100%' />
                                                    </td>
                                                </tr>
                                            </table>
                                            <table id="tbDiffAcc" style="width: 100%; height: 100%" border="0">
                                                <tr style="height: 1%">
                                                    <td style="white-space: nowrap; width: 22%" align="right">
                                                        <b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp('RecDept')">Rec. Dept</b>
                                                    </td>
                                                    <td align="right" style="width: 23%">
                                                        <gw:textbox id="txtRecDeptPk" styles='width:100%;display:none' />
                                                        <gw:textbox id="txtRecDeptID" styles='width:100%' />
                                                    </td>
                                                    <td align="right" style="width: 55%">
                                                        <gw:textbox id="txtRecDeptName" styles='width:100%' />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </fieldset>
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td style="width: 18%" align="right" colspan="5">
                            <table style="width: 100%; height: 100%">
                                <tr style="height: 1%">
                                    <td style="width: 96%; color: Red">
                                    </td>
                                    <td style="width: 1%" align="right">
                                    </td>
                                    <td style="width: 1%" align="right">
                                        <gw:icon img="3" alt="Add Item" text="Add Item" id="btnAddNew1" onclick="OnPopUp('Item')" />
                                    </td>
                                    <td style="width: 1%">
                                        <gw:imgbtn id="btnUnDeleteDTL" img="udelete" alt="UnDelete" onclick="OnUnDelete()" />
                                    </td>
                                    <td style="width: 1%" align="right">
                                        <gw:imgbtn img="delete" alt="Delete" id="btnDelete1" onclick="OnDelete('Detail')" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr style="height: 98%">
                        <td colspan="5">
                            <gw:grid id='grdDetail' header='_pk|_tin_linemattakeout_pk|_tco_item_pk|Item Code|Item Name|Spec|Unit|Stock|T/O Qty|Lot No.|Test No.|Blending No.|Reason|Unit of Entry|_Take_Out_Dt|_out_wh_pk|_takeout_type'
                                format='0|0|0|0|0|0|0|-6|-6|0|0|0|0|0|0|0|0' aligns='0|0|0|0|0|0|1|3|3|0|0|0|0|0|0|0|0'
                                check='||||||||0n-|0|0||||||' editcol='0|0|0|0|0|0|0|0|1|1|1|1|1|0|0|0|0' widths='0|0|0|1200|2000|1500|500|1500|1500|1000|1000|1000|1000|800|0|0|0'
                                sorting='T' acceptnulldate styles='width:100%; height:100%' onafteredit="" oncelldblclick="OnGriddblClick()" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <!------------------------------------------->
</body>
<gw:textbox id="txtMasterPK" styles="width: 100%;display:none" />
<gw:textbox id="txtInput" styles="width: 100%;display:none" />
<gw:textbox id="txtRtnValue1" styles="width: 100%;display:none" />
<gw:textbox id="txtRtnValue2" styles="width: 100%;display:none" />
<img status="expand" id="imgArrow" src="../../../system/images/prev_orange.gif" style="cursor: hand;
    position: absolute; left: 1; top: 0;" onclick="OnToggle()" />
</html> 