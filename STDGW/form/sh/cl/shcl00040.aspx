<%@ Page Language="C#" %>

<%@ Import Namespace="System.Web" %>
<%@ Import Namespace="System.Web.Security" %>
<%@ Import Namespace="System.Security.Principal" %>
<%@ Import Namespace="System.Runtime.InteropServices" %>
<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>genuwin</title>
</head>
<% ESysLib.SetUser("INV");%>

<script language="javascript" type="text/javascript">
 
 function BodyInit()
 {
    //<%=ESysLib.SetGridColumnComboFormat("grdMonthly", 7, "select 'O', 'Opened' from dual union select 'C', 'Closed' from dual")%>; 
    BindingDataList();
    onSearch();
 }
//---------------------------------------------------------------------------------------------------
 function BindingDataList()
 {  
       var data1 = "<%=ESysLib.SetListDataSQL("SELECT pk, PARTNER_NAME FROM comm.TCO_company  where del_if=0")%>";   
     cboCompany.SetDataText(data1);    
 }
//------------------------------------------------------------------------------------
function onAddRow()
 {
    
 }
 //---------------------------------------------------------------------------------------
 function onOpen()
 {
   
 }
 //---------------------------------------------------------------------------------------
  function onClose()
 {
    
 }
 //---------------------------------------------------------------------------------------
 function onCheckValidate(pos)
 {
               
 }
 //--------------------------------------------------------------------------------------
 function OnDataReceive(obj)
 {
    lblRecord.text = grdTest.rows -1 + " record(s)"
 }
 
 function onSearch()
 {
    dat_shcl00040_1.Call("SELECT");
 }
</script>

<body>
    <!------------------------------------------------------------------>
    <gw:data id="dat_shcl00040_1" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid" parameter="0,1,2,3,4" function="inv.sp_sel_shcl00040"> 
           <input >    
                <input bind="cboCompany"/>   
                <input bind="dtYear" />        
                <input bind="txtMatlCode"/> 
                <input bind="txtDescription"/> 
                <input bind="txtSpec"/>              
                </input> 
                <output bind="grdTest" /> 
            </dso> 
        </xml> 
</gw:data>
    <!------------------------------------------------------------------>
    <form id="form1" runat="server">
        <div>
            <table>
                <tr>
                    <table width="100%" border="0">
                        <td style="width: 8%; white-space: nowrap" align="right">
                            Company
                        </td>
                        <td style="width: 21%">
                            <gw:list id="cboCompany" styles="width:100%"></gw:list>
                        </td>
                        <td style="width: 11%; white-space: nowrap" align="right">
                            Closing Period</td>
                        <td style="width: 20%">
                            <gw:datebox id="dtYear" lang="1" onchange="onSearch()" type='month'/>
                        </td>
                        <td style="width: 41%">
                            <td>
                                <gw:imgbtn id="btnSearch" img="search" alt="Search" text="Search" onclick="onSearch()" />
                            </td>
                        </td>
                    </table>
                </tr>
                <tr>
                    <table style="width: 100%" border="0">
                        <td style="width: 8%; white-space: nowrap" align="right">
                            Matl Code
                        </td>
                        <td style="width: 20%">
                            <gw:textbox id="txtMatlCode"  styles="width: 100%" />
                        </td>
                        <td style="width: 11%; white-space: nowrap" align="right">
                            Description
                        </td>
                        <td style="width: 20%">
                            <gw:textbox id="txtDescription"  styles="width: 100%" />
                        </td>
                        <td style="width: 5%; white-space: nowrap" align="right">
                            Spec
                        </td>
                        <td style="width: 20%">
                            <gw:textbox id="txtSpec"  styles="width: 100%" />
                        </td>
                        <td style="width: 16%">
                             <gw:label id="lblRecord"  styles="width: 100%; color:blue" />
                        </td>
                    </table>
                </tr>
                <tr>
                    <td colspan="10">
                        &nbsp;</td>
                </tr>
                <tr>
                    <td colspan="10">
                        <gw:grid id='grdTest' header='Matl Code|Description|Spec|Beginning Quantity|Receipt Quantity|Consumption Quantity|Ending Quantity'
                            format='0|0|0|-5|-5|-5|-5' aligns='0|0|0|0|0|0|0' check='||||||' editcol='0|0|0|0|0|0|0'
                            widths='1000|1000|1000|1000|1000|1000|1000' sorting='T' autosize='T' styles='width:100%; height:460' />
                    </td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>
