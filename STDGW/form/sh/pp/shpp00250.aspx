<%@ Page Language="C#" %>

<%@ Import Namespace="System.Web" %>
<%@ Import Namespace="System.Web.Security" %>
<%@ Import Namespace="System.Security.Principal" %>
<%@ Import Namespace="System.Runtime.InteropServices" %>
<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Period-End Closing Display</title>
</head>
<% ESysLib.SetUser("comm");%>

<script language="javascript" type="text/javascript">
 
 function BodyInit()
 {
    BindingDataList();
 }
//---------------------------------------------------------------------------------------------------
 function BindingDataList()
 {  
        var data="";
        data = "<%=ESysLib.SetListDataSQL("SELECT pk,PARTNER_NAME from  comm.TCO_COMPANY where del_if=0 order by PARTNER_NAME ")%>";
        cboCompany.SetDataText(data);
 }
//------------------------------------------------------------------------------------
function onAddRow()
 {
  
 }
 //---------------------------------------------------------------------------------------
 function onSave()
 {    
      shpp00250.Call();
 }
 //---------------------------------------------------------------------------------------
 function onValidate()
 {
    
 }
 //---------------------------------------------------------------------------------------
 function OnChangeDT()
 {
    if(grdDetail.rows>0)
    {
        for(var i=1;i<grdDetail.rows;i++)
      {
        grdDetail.SetGridText(i,10,dtChangeDT.value);
      }
    }   
 }
 //---------------------------------------------------------------------------------------
 function OnDataReceive(obj)
 {
   
 }
 //---------------------------------------------------------------------------------------
 function onSearch()
 {
    if(txtProdCode.text=="")
    {
        alert("Please input Product Code");
    }
    else
    {
        shpp00250.Call("SELECT");
    }
    
 }
</script>

<body>
    <!------------------------------------------------------------------>
    <gw:data id="shpp00250"  onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso id="1" type="grid"  function="prod.sp_sel_shpp00250 " parameter="0,1,2,3,4,5,6,7,8,9,10,11" procedure="prod.sp_upd_shpp00250"> 
                <input bind="grdDetail">    
                    <input bind="txtProdCode" />                 
                    <input bind="txtProdName" /> 
                    <input bind="txtSizeCode" />
                    <input bind="txtSizeName" />
                    <input bind="txtColorCodeCap" />
                    <input bind="txtColorCodeBody" />
                    <input bind="txtLotNo" />
                </input> 
                <output bind="grdDetail" /> 
            </dso> 
        </xml> 
</gw:data>
    <!------------------------------------------------------------------>
    <form id="form1" runat="server">
        <div>
            <table style="height:100%">
                <tr style="height:5%">
                    <td width="5%">
                        Company</td>
                    <td width="15%">
                        <gw:list id="cboCompany" styles="width:100%;"></gw:list>
                    </td>
                    <td width="5%" align="right" style="white-space: nowrap">
                        Change Date</td>
                    <td width="15%">
                        <gw:datebox id="dtChangeDT" lang="1" onchange="OnChangeDT()" />
                    </td>
                    <td width="5%">
                        Prod.Code</td>
                    <td width="20%" style="white-space: nowrap">
                        <gw:textbox id="txtProdCode" style="width: 30%" />
                        <gw:textbox id="txtProdName" style="width: 70%" />
                    </td>
                    <td width="2%">
                        <gw:imgbtn id="btnSearch" img="search" alt="Search" text="Search" onclick="onSearch()" />
                    </td>
                    <td width="2%">
                        <gw:imgbtn id="btnSave" img="save" alt="Save" text="Save" onclick="onSave()" />
                    </td>
                </tr>
                <tr style="height:5%">
                    <td width="5%">
                        Size</td>
                    <td style="white-space: nowrap" width="15%">
                        <gw:textbox id="txtSizeCode" style="width: 30%" />
                        <gw:textbox id="txtSizeName" style="width: 70%" />
                    </td>
                    <td width="5%" style="white-space: nowrap">
                        Color Code</td>
                    <td style="white-space: nowrap">
                        <gw:textbox id="txtColorCodeCap" style="width: 50%" />
                        <gw:textbox id="txtColorCodeBody" style="width: 50%" />
                    </td>
                    <td>
                        Lot No</td>
                    <td>
                        <gw:textbox id="txtLotNo" style="width: 100%" />
                    </td>
                </tr>
               <tr style="height:90%">
                    <td colspan="8">
                        <gw:grid id='grdDetail' header='_PK|_Item_pk|Prod.Code|Prod.Name |Cust.Name|Lot no|P.Stock|P.Add.Q`ty|NP.Stock|NP.Add.Q`ty|_Change_DT|_tco_buspartner_pk'
                            format='0|0|0|0|0|0|-0|-0|-0|-0|4|0' aligns='0|0|0|0|0|0|0|0|0|0|0|0' check='||||||n|n|n|n||'
                            editcol='1|1|1|1|1|1|1|1|1|1|1|0' widths='1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|0'
                            sorting='T' autosize='T' styles='width:100%; height:100%' />
                    </td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>
