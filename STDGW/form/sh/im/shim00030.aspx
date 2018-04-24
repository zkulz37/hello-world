<!-- #include file="../../../system/lib/form.inc"  -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%  ESysLib.SetUser("prod")%>
<head id="Head1" runat="server">
    <title>Max Capacity</title>
</head>

<script>

    var  user_pk    = "<%=Session("EMPLOYEE_PK")%>" ;
    var  user_code  = "<%=Session("USER_ID")%>" ;
    var  user_name  = "<%=Session("USER_NAME")%>" ;       
             

 //---------------------------------------------------------
 function BodyInit()
 {
    BindingDataList();
 }
 //---------------------------------------------------------
 function OnSearch()
 {      
     shim00030.Call("SELECT");
 }
 //---------------------------------------------------------
function OnPopUp()
{ 
    var fpath = System.RootURL + "/form/fp/ab/fpab00120.aspx?partner_type=AR";
    var object = System.OpenModal( fpath , 750 , 500 , 'resizable:yes;status:yes'); 
    if (object != null)
    {                  
        txtCustomerPK.text = object[0];
        txtCustomerID.text   = object[1];
        txtCustomerName.text = object[2];
    }
}
 
//----------------------------------------------------------
function BindingDataList()
 {    
        var data="";
        data = "<%=ESysLib.SetListDataSQL("SELECT pk,PARTNER_NAME from  comm.TCO_COMPANY where del_if=0 order by PARTNER_NAME ")%>";
        lstCompany.SetDataText(data);
     
     var fg=grdDetail.GetGridControl();
        fg.FixedRows  = 1
        fg.MergeCells = 5
       fg.MergeRow(0) = true
       fg.Cell(0, 0, 5, 0, 6) = "Pink Ink/Type"
                
             
 }
//---------------------------------------------------------
function OnDataReceive()
{
    var iNumRecord    =  grdDetail.rows-1 ;
    lblTotalItem.text = iNumRecord  + " item(s)" ;
}
//------------------------------------------------------------------------------
</script>

<body>
    <!------------------------------------------------------------------>
    <gw:data id="shim00030" onreceive="OnDataReceive(this)"> 
        <xml>                                                               
            <dso id="1" type="grid" user="prod" function="prod.sp_sel_shim00030" > 
                <input bind="grdDetail" > 
                    <input bind="txtCustomerPK" /> 
                </input> 
                <output bind="grdDetail" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <table style="width: 100%; height: 100%">
        <tr style="height: 2%">
            <td style="width: 5%" align="right">
                Plant
            </td>
            <td style="width: 30%" align="left" style="white-space: nowrap" colspan="2">
                <gw:list id="lstCompany" styles='width:100%' />
            </td>
            <td style="width: 5%" align="right">
                <b onclick="OnPopUp()" href="#tips" style="color: #0000ff">Customer</b>
            </td>
            <td style="width: 45%; white-space: nowrap" align="right">
                <gw:textbox id="txtCustomerPK" styles="width:30%;display:none" />
                <gw:textbox id="txtCustomerID" styles="width:30%" readonly="true" />
                <gw:textbox id="txtCustomerName" styles="width:70%" readonly="true"/>
            </td>
            <td style="width: 10%;white-space:nowrap" align="center">
                <gw:label id="lblTotalItem" styles='width:100%;color:cc0000;font:9pt' text='item' />
            </td>
            <td style="width: 1%" align="right">
                <gw:imgbtn img="search" alt="Search" id="btnSearch" onclick="OnSearch()" />
            </td>
            <td style="width: 1%" align="right">
                <gw:imgbtn img="excel" alt="Print" id="btnPrint" />
            </td>
        </tr>
        <tr style="height: 98%">
            <td colspan="8">
                <gw:grid id='grdDetail' header='_PK|_ITEM_CODE|Product|Size|Unit Price|Pink Ink/Type|Pink Ink/Type|Print Character|Print Character'
                    format='0|0|0|0|0|0|0|0|0' aligns='0|0|0|0|0|0|0|0|0' check='||||||||' editcol='0|0|0|0|0|0|0|0|0'
                    widths='1000|1000|1000|1000|1000|1000|1000|1000|1000' sorting='T' autosize='T'
                    styles='width:100%; height:460' />
            </td>
        </tr>
    </table>
    <!------------------------------------------->
</body>
<gw:textbox id="txtGroupPK" style="display: none" />
</html>
