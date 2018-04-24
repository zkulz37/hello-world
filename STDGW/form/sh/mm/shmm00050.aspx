<!-- #include file="../../../system/lib/form.inc"  -->

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Material Return From Line</title>
</head>
<%ESysLib.SetUser("prod")%>

<script>

var G1_pk               = 0,
    G1_seqno            = 1,
    G1_tco_item_pk      = 2,
    G1_item_code        = 3,
    G1_item_name        = 4,
    G1_item_uom         = 5,
    G1_return_qty       = 6,
    G1_tin_return_pk    = 7,
    G1_lotno            = 8,
    G1_test_no          = 9,
    G1_tin_warehouse_pk = 10,
    G1_wh_name          = 11,
    G1_return_date      = 12,
    G1_description      = 13,
    G1_tin_mattakeind_pk = 14,
    G1_rout_pk          = 15;

var user_name = "<%=Session("USER_NAME")%>"   ;
var emp_id = "<%=Session("EMP_ID")%>"   ;
var user_pk   = "<%=Session("EMPLOYEE_PK")%>" ;
var comp_pk   = "<%=Session("COMPANY_PK") %>" ;
var action='';
//====================================================================================
function BodyInit()
{
   
    txtChargerName.SetEnable(false);
    txtChargerID.SetEnable(false);
    txtDeptID.SetEnable(false);
    txtDeptName.SetEnable(false);
    txtSupplierID.SetEnable(false);     
    txtSupplierName.SetEnable(false);
    
    BindingDataList();
    OnNew();
 }
//====================================================================================

function BindingDataList()
{
    var data="";
    data = "<%=ESysLib.SetListDataSQL("SELECT pk,PARTNER_NAME from  comm.TCO_COMPANY where del_if=0 order by PARTNER_NAME ")%>";
    lstCompany.SetDataText(data);        
   
}
//====================================================================================
function CheckInput()
{   
    var col, row
    
    col = event.col
    row = event.row  
    
    if ( col == G1_return_qty )
    {
        var dQuantiy ;
        
        dQuantiy =  grdDetail.GetGridData(row,col) ;
        
        if (Number(dQuantiy))
        {   
            if (dQuantiy >0)
            {
                grdDetail.SetGridText( row, col, parseFloat(dQuantiy+"").toFixed(2));
            }
            else
            {
                alert(" Value must greater than zero !!");
                grdDetail.SetGridText( row, col, "");
            }
        }
        else
        {
            grdDetail.SetGridText(row,col,"") ;
        }     
    }
    //----------------------
}

//====================================================================================

function OnToggle()
{
    var left = document.all("left"); 
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
        right.style.width="80%";
        imgArrow.src = "../../../system/images/prev_orange.gif";
    }
}
//====================================================================================
 
function OnSearch(pos)
{
    switch (pos) 
    {
        case 'grdSearch' :
            data_shmm00050.Call("SELECT");
        break;
        
        case 'data_shmm00050_1' :
            if ( grdSearch.row > 0 )
            {              
                flag ='';
                txtMasterPK.text = grdSearch.GetGridData( grdSearch.row, 0);
                data_shmm00050_1.Call("SELECT");                         
            }  
        break;
        
        case 'data_shmm00050_2' :           
             data_shmm00050_2.Call("SELECT"); 
        break;        
    }
}
//====================================================================================
var flag ;

function OnNew()
{   
    data_shmm00050_1.StatusInsert();
    //-------------------------------------------
    txtChargerName.SetDataText(user_name);
    txtChargerID.text = "<%=Session("EMP_ID")%>" ;
    txtChargerPK.SetDataText(user_pk);
    
    txtDeptID.text = '5054';
    txtDeptName.text = 'PC';
    //------------------------------------------- 
    grdDetail.ClearData();
    lbRecord1.text=grdDetail.rows-1 +" "+ " record(s)" ;
    flag="view";  
    
}
//====================================================================================

function OnSave(pos)
{   
    switch(pos)
    { 
        case 'data_shmm00050_1':           
            data_shmm00050_1.Call();
            flag='save';            
        break;
        
        case 'data_shmm00050_2':        
            data_shmm00050_2.Call();
        break;
    }
    
}
//====================================================================================

function OnDataReceive(obj)
{
    switch (obj.id)
    {
        case "data_shmm00050_1":   

            if ( flag == 'save')
            {
                for(var i = 1 ; i < grdDetail.rows; i++)
                {
                    grdDetail.SetGridText( i, G1_tin_return_pk, txtMasterPK.text);
                }
                OnSave('data_shmm00050_2'); 
            }
            else if (flag=='delete')
            {
                OnSearch('grdSearch');
            }
            else
            {
                //---------------------------- 
                OnSearch('data_shmm00050_2'); 
            }
            
                          
        break;
        
        case "data_shmm00050_2":
            lbRecord1.text=grdDetail.rows-1 +" "+ " record(s)" ;
            flag = 'view';
              
        break;        
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
//====================================================================================
 
function OnPopUp(obj)
{
    switch(obj)
    {                          
        case 'Charger':
            fpath = System.RootURL + "/form/sh/ab/shab00020.aspx";
            oValue = System.OpenModal( fpath , 900 , 600 , 'resizable:yes;status:yes');
            
            if ( oValue != null )
            {
                txtChargerPK.SetDataText(oValue[0]);
                txtChargerID.SetDataText(oValue[3]);
                txtChargerName.SetDataText(oValue[5]);
            }
        break;
        
        case 'FreeItem':
            if(txtSupplierPK.text!="")
            {
                 var path = System.RootURL + '/form/sh/mm/shmm00051.aspx';
                 var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes', this);
                 if ( object != null )
                 {
                    var arrTemp
                    
                    for( var i=0; i < object.length; i++)	  
                    {	
                        arrTemp = object[i];
                            
                        grdDetail.AddRow();                            
                        
                        grdDetail.SetGridText( grdDetail.rows-1, G1_tin_return_pk, txtMasterPK.text); //master_pk	    	                                               
                        	    
                        grdDetail.SetGridText( grdDetail.rows-1, G1_seqno, AddDigit(String(grdDetail.rows-1),3));
                        grdDetail.SetGridText( grdDetail.rows-1, G1_tco_item_pk, arrTemp[8]);
                        grdDetail.SetGridText( grdDetail.rows-1, G1_item_code,   arrTemp[9]);
                        grdDetail.SetGridText( grdDetail.rows-1, G1_item_name,   arrTemp[10]);
                        grdDetail.SetGridText( grdDetail.rows-1, G1_item_uom,    arrTemp[11]);
                        grdDetail.SetGridText( grdDetail.rows-1, G1_lotno,      arrTemp[15]);
                        grdDetail.SetGridText( grdDetail.rows-1, G1_test_no,    arrTemp[16]);
                        grdDetail.SetGridText( grdDetail.rows-1, G1_tin_mattakeind_pk,    arrTemp[0]);
                        grdDetail.SetGridText( grdDetail.rows-1, G1_rout_pk,    arrTemp[18]);
                        grdDetail.SetGridText( grdDetail.rows-1, G1_tin_warehouse_pk,   arrTemp[6]);
                        grdDetail.SetGridText( grdDetail.rows-1, G1_wh_name,   arrTemp[7]);
                        grdDetail.SetGridText( grdDetail.rows-1, G1_return_date,   dtdvoucherDate.value);	 
                    }		            
                 } 
             }
             else
             {
                alert("Please select Supplier frist");
             }       
        break;   
        case 'Supplier' :
            if(grdDetail.rows>1)
            {
                alert("Cannot change Supplier when you already have some item");
            }
            else
            {
                var path = System.RootURL + "/form/fp/ab/fpab00120.aspx?partner_type=AP";
	            var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
	            if ( object != null )
	            {
	                txtSupplierPK.text   = object[0];
                    txtSupplierID.text   = object[1];      
                    txtSupplierName.text = object[2];                
	            }
            }           
        break;    
        
       case 'Dept': // PL
            var fpath = System.RootURL + "/form/sh/ab/shab00150.aspx";
            var object = System.OpenModal( fpath , 550 , 400 , 'resizable:yes;status:yes'); 
            if (object != null)
            {                  
               txtDeptName.text = object[2]; 
               txtDeptPK.text  = object[0]; 
               txtDeptID.text  = object[1]; 
            }
        break;        
    }
}
//====================================================================================

function onDeleteDTL()
{
    if ( grdDetail.GetGridData( grdDetail.row, 0) == '' )
    {
        grdDetail.RemoveRow();
    }
    else
    {    
        grdDetail.DeleteRow();
    }    
}
//====================================================================================

function onUnDeleteDTL()
{
    grdDetail.UnDeleteRow();
}
//====================================================================================

function onDeleteMST()
{
    if ( confirm("Are you sure delete ?"))
    {
        flag = 'delete';
        data_shmm00050_1.StatusDelete();      
        data_shmm00050_1.Call();
    }
}
//====================================================================================
function OnCellDoubleClick(obj)
{
    var event_row = event.row ;
    var event_col = event.col ;
    
    if ( event_col == G1_item_uom )
    {
         var path = System.RootURL + '/form/fp/ab/fpab00230.aspx';
         var obj = System.OpenModal( path ,800 , 600, 'resizable:yes;status:yes');
         if ( obj != null )
         {
             grdDetail.SetGridText(event_row, G1_item_uom, obj[2] ); //tpr_warehouse_pk
                                       
         }	                
    }
}
//====================================================================================

</script>

<body>
    <!------------------------------------------------------------------->
    <gw:data id="data_shmm00050" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid" function="INV.sp_sel_shmm00050" > 
                <input> 
                    <input bind="txtVoucherSearch" />
                    <input bind="dtFrom" />
                    <input bind="dtTo" />
                </input> 
                <output bind="grdSearch" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------->
    <gw:data id="data_shmm00050_1" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="control" parameter="0,1,2,3,4,5,6,7,8,9,10,11" function="inv.sp_sel_shmm00050_1"  procedure="inv.sp_upd_shmm00050_1"> 
                <inout>
                    <inout  bind="txtMasterPK" />
                    <inout  bind="txtSeq" />
                    <inout  bind="txtDes" />
                    <inout  bind="dtdvoucherDate" /> 
                    <inout  bind="txtSupplierPK" />
                    <inout  bind="txtSupplierID" />
                    <inout  bind="txtSupplierName" />
                    <inout  bind="txtChargerPK" />  
                    <inout  bind="txtChargerID" />                                       
                    <inout  bind="txtChargerName" /> 
                    <inout  bind="txtDeptID" /> 
                    <inout  bind="txtDeptName" />                                 
                </inout>
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------->
    <gw:data id="data_shmm00050_2" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="3" type="grid" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15" function="inv.sp_sel_shmm00050_2" procedure="inv.sp_upd_shmm00050_2"> 
                <input> 
                    <input bind="txtMasterPK" />                
                </input> 
                <output bind="grdDetail" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------->
    <table style="width: 100%; height: 100%" border="1">
        <tr>
            <td id="left" style="width: 20%">
                <table style="width: 100%; height: 100%">
                    <tr style="height: 1%">
                        <td style="width: 10%" align="right">
                            Date</td>
                        <td style="width: 50%; white-space: nowrap">
                            <gw:datebox id="dtFrom" lang="1" />
                            ~<gw:datebox id="dtTo" lang="1" />
                        </td>                        
                    </tr>
                    <tr style="height: 1%">
                        <td style="width: 10%; white-space: nowrap" align="right">
                            Seq No</td>
                        <td >
                            <gw:textbox id="txtVoucherSearch" styles="width:100%" onenterkey="OnSearch('grdSearch')" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn img="search" alt="Search" onclick="OnSearch('grdSearch')" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3">
                            <gw:grid id="grdSearch" header="_PK|Voucher Date|Voucher No" format="0|4|0" aligns="1|0|0"
                                defaults="||" editcol="0|0|0" widths="0|1500|0" styles="width:100%; height:100%"
                                sorting="T" oncellclick="OnSearch('data_shmm00050_1')" param="0,1,2" />
                        </td>
                    </tr>
                </table>
            </td>
            <td id="right" style="width: 80%">
                <table style="width: 100%; height: 100%" border="0">
                    <tr style="height: 1%">
                        <td style="width: 10%" align="right">
                            Company</td>
                        <td style="width: 40%">
                            <gw:list id="lstCompany" styles="width:100%" />
                        </td>
                        <td style="width: 10%" align="right">
                            Date</td>
                        <td style="width: 15%">
                            <gw:datebox id="dtdvoucherDate" lang="1" mode="01" />
                        </td>
                        <td style="width: 20%">
                            <gw:textbox id="txtSeq" styles="width:70%" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="ibtnNewMST" img="new" alt="New" text="New" onclick="OnNew()" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="ibtnDeleteMST" img="delete" alt="Delete" text="Delete" onclick="onDeleteMST()" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="ibtnSaveMST" img="save" alt="Save" text="Save" onclick="OnSave('data_shmm00050_1')" />
                        </td>
                    </tr>
                   
                    <tr>
                        <td style="width: 10%; white-space: nowrap" align="right">
                             <a title="PL" onclick="OnPopUp('Dept')" style="color: #0000ff; cursor: hand"><b>Dept</b></a>
                        </td>
                        <td style="width: 40%">
                            <gw:textbox id="txtDeptID" styles='width:30%' />
                            <gw:textbox id="txtDeptName" styles='width:69%' />
                        </td>
                         <td style="width: 10%" align="right">
                            <b style="color: Blue; cursor: hand" onclick="OnPopUp('Charger')">Charger</b>
                        </td>
                        <td style="width: 40%" colspan="5">
                             <gw:textbox id="txtChargerPK" styles='width:100%; display:none' />
                            <gw:textbox id="txtChargerID" styles='width:30%' />
                            <gw:textbox id="txtChargerName" styles='width:69%' />
                        </td>
                        
                    </tr>
                     <tr style="height: 1%">
                        
                        <td style="width: 10%" align="right">
                            <a title="Click here to select Requester" onclick="OnPopUp('Supplier')" href="#tips"
                                style="text-decoration: none; color=#0000ff"><b>Supplier</b></a>
                        </td>
                        <td style="width: 40%">
                             <gw:textbox id="txtSupplierPK" styles='width:100%; display:none' />
                            <gw:textbox id="txtSupplierID" styles='width:30%' />
                            <gw:textbox id="txtSupplierName" styles='width:69%' />
                        </td>
                        
                        <td style="width: 10%" align="right">
                            Remark
                        </td>
                        <td colspan="5">
                            <gw:textbox id="txtDes" styles="width:100%" />
                        </td>                       
                      
                    </tr>
                    <tr style="height: 1%">
                        <td style="width: 97%" colspan="5" align="right">
                            <gw:label id="lbRecord1" styles='width:100%;color:cc0000;font:9pt'>record(s)</gw:label>
                       </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="ibtnNewDTL" img="popup" alt="Get Item" text="New" onclick="OnPopUp('FreeItem')" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="ibtnDeleteDTL" img="delete" alt="Delete" text="Delete" onclick="onDeleteDTL()" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="ibtnUnDelete" img="udelete" alt="Save" text="Save" onclick="onUnDeleteDTL()" />
                        </td>
                    </tr>
                    <tr style="height: 97%">
                        <td colspan="8">
                            <gw:grid id='grdDetail' 
                                header='_pk|Seq|_tco_item_pk|Item Code|Item Name|Unit|Rtn. Qty|_tin_vendor_mat_return_pk|Lot No|Test No|_tin_warehouse_pk|WH Name|Rtn. Date|Description|_tin_mattakeind|_rout_pk'
                                format='0|0|0|0|0|0|-6|0|0|0|0|0|4|0|0|0' aligns='0|1|0|0|0|1|3|0|0|0|0|0|0|0|0|0'
                                check='||||||0n|||||||||' editcol='0|0|0|0|0|0|1|0|1|1|0|0|1|1|0|0'
                                widths='0|800|0|1500|2000|800|1500|0|1000|1000|0|1000|1200|1000|0|0'
                                sorting='T' styles='width:100%; height:100%'
                                oncelldblclick="OnCellDoubleClick(this)" onafteredit="CheckInput()"/>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <!------------------------------------------------------------------->
    <gw:textbox id="txtMasterPK" styles="display:none"></gw:textbox>
    <gw:textbox id="txtWarehouse_pk" styles="display:none"></gw:textbox>
    <!------------------------------------------------------------------->
    <img status="expand" id="imgArrow" src="../../../system/images/prev_orange.gif" style="cursor: hand;
        position: absolute; left: 1; top: 0;" onclick="OnToggle()" />
    <!------------------------------------------------------------------->
</body>
</html>
