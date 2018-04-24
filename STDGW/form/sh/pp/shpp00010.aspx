<%@ Page Language="C#" %>

<%@ Import Namespace="System.Web" %>
<%@ Import Namespace="System.Web.Security" %>
<%@ Import Namespace="System.Security.Principal" %>
<%@ Import Namespace="System.Runtime.InteropServices" %>
<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>MATERIAL TAKE IN</title>
</head>
<%ESysLib.SetUser("inv");%>
<script language="javascript" type="text/javascript">

//-----------------------------------------------------

var flag;

var G1_PK    = 0 ;

//---------------------------------------------------------
var G1_pk                   = 0,
    G1_tsh_prodresult_pk    = 1,   
    G1_tsh_batlot_m_pk      = 2, 
    G1_tsa_saleorderd_pk    = 3,   
    G1_tco_buspartner_pk    = 4,
    G1_tco_item_pk          = 5,
    G1_lotno                = 6,
    G1_ref_so_no            = 7,
    G1_item_code            = 8,
    G1_item_name            = 9, 
    G1_noprt_qty            = 10,
    G1_iqty                 = 11,
    G1_mafg_date            = 12,
    G1_partner_id           = 13,
    G1_partner_nm           = 14,
    G1_size_code            = 15,
    G1_cap_col_cd           = 16,
    G1_body_col_cd          = 17,
    G1_print_yn             = 18,
    G1_country_nm           = 19,
    G1_idate                = 20;
//---------------------------------------------------------
var iCodeID = "" ; 
var initFlag = 1;
//-----------------------------------------------------
function BodyInit()
 {
    txtVoucherNo.SetEnable(false);
    txtStaff.SetEnable(false);
    txtStaffID.SetEnable(false);
    //-------------------------
    var now = new Date(); 
    var lmonth, ldate;
    
    ldate=dtFrom.value ;         
    ldate = ldate.substr(0,4) + ldate.substr(4,2) + '01' ;
    dtFrom.value=ldate ;
    //----------------------------
    BindingDataList();    
    //----------------------------
    OnNew();
 }
 //---------------------------------------------------------------------------------------------------
 
 function BindingDataList()
 {  
     var data = "<%=ESysLib.SetListDataSQL("SELECT pk, PARTNER_NAME FROM comm.TCO_company  where del_if=0")%>";   
     
     cboCompany.SetDataText(data);
//     cboCompany.value="<%=Session["COMPANY_PK"]%>"; 
 }
 //---------------------------------------------------------------------------------------------------
function OnNew()
{
    initFlag =0 ;
    data_shpp00010_1.StatusInsert();
    btnSave.SetEnable(true);
    //-------------------------------------------
   // cboCompany.value = "<%=Session["COMPANY_PK"]%>";

    txtStaff.text    = "<%=Session["USER_NAME"]%>";
    txtStaffID.text    = "<%=Session["EMP_ID"]%>";
    txtStaffPK.text  = "<%=Session["EMPLOYEE_PK"]%>";
    //------------------------------------------- 
    grdTakeinItems.ClearData();
    flag="view"; 
}  

//-------------------------------------------------------------------------------------
function OnSearch(pos)
{
    switch (pos)
    {
        case 'grdVouchers':
            data_shpp00010.Call("SELECT");
        break;
    
        case 'data_shpp00010_1':
            {
                if ( grdVouchers.row > 0 )
                {
                    txtMasterPK.text = grdVouchers.GetGridData( grdVouchers.row, G1_PK );
                }
                flag = 'view' ;
                data_shpp00010_1.Call("SELECT");
            }                               
        break;
        
        case 'grdTakeinItems':            
            data_shpp00010_2.Call("SELECT");
        break;
    }
}
//-------------------------------------------------------------------------------------
function OnDataReceive(obj)
{
    switch(obj.id)
    {
        case "data_shpp00010_1": 
        
            //-------------------        
            if ( flag == "save" )
            {
                                                  
               //---------------------   
               OnSave('data_shpp00010_2');                
            }
            else
            {                
                if ( txtMasterClose.text == 'Y' )
                {
                    btnSave.SetEnable(false);
                }    
                else
                {
                    btnSave.SetEnable(true);
                }
                //---------------------------- 
                OnSearch('grdTakeinItems');
            } 
            
            //txtMasterClose.text == 'Y'?lblStatus.text='Closed':lblStatus.text='Open' ;    
                
        break;

        case "data_shpp00010_2":
            if ( flag != 'view' ) 
            {
                OnSearch('grdVouchers');
                flag='view';
                
            }
        break;
         
   }            
}

//--------------------------------------------------------------------------------------------------
function OnPopUp(pos)
{
    switch(pos)
    {
        case 'Charger':
            var path = System.RootURL + '/form/sh/ab/shab00020.aspx';
            var obj = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');

            if ( obj != null )
            {
                txtStaff.text    = obj[5];
                txtStaffID.text    = obj[4];
                txtStaffPK.text  = obj[0];
            }
        break; 
        
        case 'Supplier' :
             var path = System.RootURL + "/form/fp/ab/fpab00120.aspx?partner_type=AP";
	         var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
	         if ( object != null )
	         {
	            txtSupplierPK.text   = object[0];
	            txtSupplierID.text     = object[1];
                txtSupplier.text     = object[2];                
	         }
        break;
        
        case 'Dept': // PL
            var fpath = System.RootURL + "/form/sh/ab/shab00150.aspx";
            var object = System.OpenModal( fpath , 550 , 400 , 'resizable:yes;status:yes'); 
            if (object != null)
            {                  
               txtDeptName.text = object[2]; 
               txtDeptPK.text  = object[0]; 
               txtDeptCode.text  = object[1]; 
            }
        break;    

        case 'POItem':
             var path = System.RootURL + '/form/sh/pp/shpp00011.aspx';
             var object = System.OpenModal( path ,900 , 600 ,  'resizable:yes;status:yes');
             if ( object != null )
             {
                var arrTemp
                for( var i=0; i < object.length; i++)	  
                {	
                    arrTemp = object[i];
                      
                    grdTakeinItems.AddRow();                            
                    grdTakeinItems.SetGridText( grdTakeinItems.rows-1, G1_tsh_batlot_m_pk,      arrTemp[0]);     	                                               
                    grdTakeinItems.SetGridText( grdTakeinItems.rows-1, G1_tsa_saleorderd_pk,    arrTemp[2]);
                    grdTakeinItems.SetGridText( grdTakeinItems.rows-1, G1_tco_buspartner_pk,    arrTemp[15]);
                    grdTakeinItems.SetGridText( grdTakeinItems.rows-1, G1_tco_item_pk,          arrTemp[4]);
                    grdTakeinItems.SetGridText( grdTakeinItems.rows-1, G1_lotno,                arrTemp[1]);  
                    grdTakeinItems.SetGridText( grdTakeinItems.rows-1, G1_ref_so_no,            arrTemp[3]);   
                    grdTakeinItems.SetGridText( grdTakeinItems.rows-1, G1_item_code,            arrTemp[5]);   
                    grdTakeinItems.SetGridText( grdTakeinItems.rows-1, G1_item_name,            arrTemp[6]);  
                    if ( arrTemp[10]=='Y')
                        grdTakeinItems.SetGridText( grdTakeinItems.rows-1, G1_iqty,             arrTemp[14]);
                    else    
                        grdTakeinItems.SetGridText( grdTakeinItems.rows-1, G1_noprt_qty,        arrTemp[14]);
                        
                    grdTakeinItems.SetGridText( grdTakeinItems.rows-1, G1_partner_id,           arrTemp[16]);
                    grdTakeinItems.SetGridText( grdTakeinItems.rows-1, G1_partner_nm,           arrTemp[17]);
                    grdTakeinItems.SetGridText( grdTakeinItems.rows-1, G1_size_code,            arrTemp[7]);
                    grdTakeinItems.SetGridText( grdTakeinItems.rows-1, G1_cap_col_cd ,          arrTemp[8]);
                    grdTakeinItems.SetGridText( grdTakeinItems.rows-1, G1_body_col_cd ,         arrTemp[9]);
                    grdTakeinItems.SetGridText( grdTakeinItems.rows-1, G1_print_yn ,            arrTemp[10]);
                    grdTakeinItems.SetGridText( grdTakeinItems.rows-1, G1_country_nm ,          arrTemp[18]);  
                    grdTakeinItems.SetGridText( grdTakeinItems.rows-1, G1_mafg_date ,           arrTemp[19]);  
                }		            
             }        
        break;  
        case 'TIType':
             var path = System.RootURL + "/form/fp/ab/fpab00220.aspx?code_group=LGPO2001";
	         var object = System.OpenModal( path ,800 ,600 ,'resizable:yes;status:yes');
	         
	         if ( object != null )
	         {	        	                   
	            if ( object[0] == 1 )
	            {
	                txtLGGroupCodeID.text = 'LGPO2001';
	                rtnLGCode             = object[1];
	                
                    data_fpab00220_2.Call("SELECT");                                
	            }
	            else
	            {
	                lstTIType.value = object[1];      
	            }    	                
	         }                
        break;                                               
    }	       
}
//-------------------------------------------------------------------------------------
function OnSave(pos)
{    
    switch(pos)
    { 
        case 'data_shpp00010_1':
            if( Validate() )
            {
                data_shpp00010_1.Call();
                flag='save';
            }            
        break;
        case 'data_shpp00010_2':   
            for (var i = 1; i<grdTakeinItems.rows; i++)   
           {
                if ( grdTakeinItems.GetGridData( i, G1_pk) == '' )
                {
                    grdTakeinItems.SetGridText(i, G1_tsh_prodresult_pk,  txtMasterPK.GetData());
                }  
                grdTakeinItems.SetGridText(i, G1_idate,  dtVoucherDate.value);
           } 
                 
            data_shpp00010_2.Call();
        break;
    }
}
//------------------------------------------------------------------------------------------------
 function OnDelete(index)
 {        
    switch (index)
    {
        case 'Voucher':// delete master
            if(confirm('Do you want to delete this Voucher?'))
            {
                flag='delete';
                data_shpp00010_1.StatusDelete();
                data_shpp00010_1.Call();
            }   
        break;

        case 'GridItem':
            if(confirm('Do you want to delete this Item?'))
            {
                if ( grdTakeinItems.GetGridData( grdTakeinItems.row,  G1_pk ) == '' )
                {
                    grdTakeinItems.RemoveRow();
                }
                else
                {   
                    grdTakeinItems.DeleteRow();
                }    
            }            
        break;            
    }     
}
 //------------------------------------------------------------------------------------- 
 
function OnUnDelete()
{              
     grdTakeinItems.UnDeleteRow();
}

//-------------------------------------------------------------------------------------
function Validate()
{   
    //---------------
    if(dtVoucherDate.value>dtToDay.value)
    {
        alert("Voucher Date cannot larger current day ");
        return false;
    }
    for( var i = 1; i < grdTakeinItems.rows; i++)
    {
        if ( ( Number(grdTakeinItems.GetGridData(i,G1_noprt_qty))+ Number(grdTakeinItems.GetGridData(i,G1_iqty)) )== 0)
        {
            alert("Input take in Qty. at " + i + ",pls!")
            return false;
        }
    }
    return true;
}
//---------------------------------------------------------------------------------------------------
function OnPrint() 
{
          var fpath = System.RootURL + "/form/sh/mm/shmm00060.aspx";
          var object = System.OpenModal( fpath , 750 , 500 , 'resizable:yes;status:yes'); 
}
//----------------------------------------------------------------------------------------
</script>

<body>
    <!-----------------------grdVouchers---------------------------------------->
    <gw:data id="data_shpp00010" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="2" type="grid" parameter="0,1" function="prod.sp_sel_shpp00010" > 
                <input> 
                    <input bind="txtNoSearch" /> 
                    <input bind="dtFrom" /> 
                    <input bind="dtTo" /> 
                </input> 
                <output bind="grdVouchers" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------------->
    <gw:data id="data_shpp00010_1" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="control" parameter="0,1,2,3,4,5,6,7,8" function="prod.sp_sel_shpp00010_1"  procedure="prod.sp_upd_shpp00010_1"> 
                <inout>             
                     <inout  bind="txtMasterPK" />
                     <inout  bind="cboCompany" />
                     <inout  bind="dtVoucherDate" />  
                     <inout  bind="txtVoucherNo" /> 
                     <inout  bind="lstTIType" />                            
                     <inout  bind="txtStaffPK" />
                     <inout  bind="txtStaffID" />
                     <inout  bind="txtStaff" />
                     <inout  bind="txtRemark" />               
                </inout>
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <gw:data id="data_shpp00010_2" onreceive="OnDataReceive(this)"> 
        <xml>                                   
            <dso id="3" type="grid" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,16,17,18,20" function="prod.sp_sel_shpp00010_2"   procedure="prod.sp_upd_shpp00010_2"> 
                <input bind="grdTakeinItems">                    
                    <input bind="txtMasterPK" /> 
                </input> 
                <output bind="grdTakeinItems" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <gw:data id="data_fpab00220_2" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="list" procedure="prod.sp_sel_fpab00220_2" > 
                <input> 
                    <input bind="txtLGGroupCodeID" />
                </input>
	           <output>
	                <output bind="lstTIType" /> 
	           </output>
            </dso> 
        </xml> 
    </gw:data>
    <!-------------------------------------------------------------------->
    <table style="width: 100%; height: 100%" border="1">
        <tr>
            <td id="left" style="width: 25%">
                <table style="width: 100%; height: 100%">
                    <tr style="height: 2%">
                        <td style="width: 20%" align="right">
                            No.
                        </td>
                        <td style="width: 79%">
                            <gw:textbox id="txtNoSearch" styles="width: 100%" onenterkey="OnSearch('grdVouchers')" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="btnSearch" img="search" alt="Search" text="Search" onclick="OnSearch('grdVouchers')" />
                        </td>
                    </tr>
                    <tr style="height: 2%">
                        <td style="width: 20%" align="right">
                            Date</td>
                        <td colspan="2" style="white-space: nowrap">
                            <gw:datebox id="dtFrom" lang="1" />
                            ~
                            <gw:datebox id="dtTo" lang="1" />
                        </td>
                    </tr>
                    <tr style="height: 96%">
                        <td colspan="3">
                            <gw:grid id="grdVouchers" header="_PK|Date|Voucher No" format="0|0|0" aligns="0|1|0"
                                defaults="||" editcol="0|0|0" widths="0|1200|1200" styles="width:100%; height:100%"
                                sorting="T" param="0,1,2" oncellclick="OnSearch('data_shpp00010_1')" />
                        </td>
                    </tr>
                </table>
            </td>
            <td id="right" style="width: 75%">
                <table style="width: 100%; height: 100%">
                    <tr style="height: 1%">
                        <td align="right" style="width: 10%">
                            Company
                        </td>
                        <td style="width: 25%">
                            <gw:list id="cboCompany" styles="width:100%;" />
                        </td>
                        <td align="right" style="width: 10%">
                            <a title="Click here to select Requester" onclick="OnPopUp('Charger')" href="#tips"
                                style="text-decoration: none; color:#0000ff"><b>Charger</b></a>
                        </td>
                        <td style="width: 35%" colspan= "2">
                            <gw:textbox id="txtStaffID" styles="width:29%" />
                            <gw:textbox id="txtStaff" styles="width:70%" />
                            <gw:textbox id="txtStaffPK" styles="display:none" />
                        </td>
                        <td style="width: 16%">
                        </td>
                        <td style="width: 1%; " align="right">
                            <gw:imgbtn id="btnPrint" img="excel" alt="Print" styles="display:none" text="Print" onclick="OnPrint()" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="btnNew" img="new" alt="New" text="New" onclick="OnNew()" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="btnDelete" img="delete" alt="Delete" text="Delete" onclick="OnDelete('Voucher')" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="btnSave" img="save" alt="Save" text="Save" onclick="OnSave('data_shpp00010_1')" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td align="right"  style="white-space: nowrap">
                            Voucher Date
                        </td>
                        <td >
                            <gw:datebox id="dtVoucherDate" lang="1" />
                        </td>
                        <td align="right" style=" white-space: nowrap">
                            Voucher No
                        </td>
                        <td style="width: 25%">
                            <gw:textbox id="txtVoucherNo" csstype="mandatory" styles="width:100%;" />
                        </td>
                        <td align="right" >
                            Movement Type
                        </td>
                        <td colspan="5">
                            <gw:list id="lstTIType" styles="width:100%;" onchange="OnChangeType()">
                                <data>
                                    <%=ESysLib.SetListDataFUNC("SELECT COMM.f_logistic_code('LGMF0110') FROM DUAL")%>||
                                </data>
                            </gw:list>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" style="width: 10%; white-space: nowrap">
                            Remark
                        </td>
                        <td colspan="9" >
                            <gw:textbox id="txtRemark" styles="width:100%;" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td style="width: 10%" align="right">
                            
                        </td>
                        <td >
                        </td>
                        <td >
                        </td>
                        <td align="right">
                        </td>
                        <td align="center">
                        </td>
                        <td align="right">
                        </td>
                        
                        <td align="right">
                            <gw:imgbtn id="btnGetPOItem" img="popup" alt="Get item from Instruction" text="Get Item from Instruction"
                                onclick="OnPopUp('POItem')" />
                        </td> 
                        <td>
                            <gw:imgbtn id="btnDeleteItem" img="delete" alt="Delete" text="Delete" onclick="OnDelete('GridItem')" />
                        </td>
                        <td>
                            <gw:imgbtn id="btnUnDelete" img="udelete" alt="Undelete" text="Undelete" onclick="OnUnDelete()" />
                        </td>
                    </tr>
                    <tr style="height: 97%">
                        <td colspan="10">
                            <gw:grid id='grdTakeinItems' 
				                header='_pk|_tsh_prodresult_pk|_tsh_batlot_m_pk|_tsa_saleorderd_pk|_tco_buspartner_pk|_tco_item_pk|Lotno|S/O No|Item Code|Item Name|Unprinted Qty|Printed qty|MFG Date|Customer ID|Customer NM|Size|Cap Col|Body Col|Print Y/N|Country NM|_Idate'
                                format='0|0|0|0|0|0|0|0|0|0|-0|-0|4|0|0|0|0|0|0|0|0'
                                aligns='0|0|0|0|0|0|0|0|0|0|3|3|1|0|0|0|0|0|0|0|0'
                                check='||||||||||n|n|||||||||0'
                                editcol='0|0|0|0|0|0|0|0|0|0|1|1|1|0|0|0|0|0|0|0|0'
                                widths='0|0|0|0|0|0|1500|1200|1200|2000|1300|1000|1200|1200|1500|800|800|800|800|1000|0'
                                sorting='T' onafteredit="" styles="width:100%; height:100%" oncelldblclick="" autosize='T' />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</body>
<!------------------------------------------------------------------------------>
<gw:textbox id="txtMasterPK" styles="display:none;" />
<!------------------------------------------->
<gw:textbox id="txtComCodeID" styles='width:100%;display:none' />
<gw:textbox id="txtCodeTemp" styles='width:100%;display:none' />
<!------------------------------------------------------------------------------>
<gw:textbox id="txtMasterClose" styles="width:100%; display:none" />
<gw:textbox id="txtLGGroupCodeID" styles='display:none;width:100%' text="LGPO2001" />
<gw:datebox id="dtToDay" lang="1" style='display:none' />
<!---------------------------------------------------------------------------------->
</html>
