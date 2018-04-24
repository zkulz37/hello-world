<%@ Page Language="C#" %>
<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml" >

<%ESysLib.SetUser("comm");%>
<script language="javascript" type="text/javascript">
    var action;
function BodyInit()
{ 
    System.Translate(document);  // Translate to language session
    
    var  ldate;
    ldate=dtDateFrom.value;         
    ldate = ldate.substr(0,4) + ldate.substr(4,2) + '01'           
    dtDateFrom.value=ldate ; 
    
    flag= "<%=Request.QueryString["IsPopup"]%>"; // popup  
    if(flag==1)
    {
        btnPrint.style.display="none";
        btnSave.style.display="none";
    }
        
    var data1 = "<%=ESysLib.SetListDataSQL("SELECT pk, PARTNER_NAME FROM TCO_company  where del_if=0")%>|-1|Select All"; 
    cboCompany.SetDataText(data1);
    cboCompany.value='-1';
}
//--------------------------------------------------------------------------------------
function View()
{
    if(flag==1)
        if(grdDeclInquiry.row>0)
        {
            var code_data=new Array();
            code_data[0] = grdDeclInquiry.GetGridData(grdDeclInquiry.row, 0);
            window.returnValue = code_data; 
	        window.close(); 
        }
}
//--------------------------------------------------------------------------------------
function onSave()
{
    if(ValidateData())
        dat_epgd00050_1.Call('');
}
//--------------------------------------------------------------------------------------
function ValidateData()
{ 
//    5.Close Y/N|6.Close date
    for(i=0; i<grdDeclInquiry.rows; i++)
    { 
        if((grdDeclInquiry.GetGridData(i,5)=='-1')&& (grdDeclInquiry.GetGridData(i,6)==''))
        {
            alert("You must input closed date at row " + i + "!"); 
            return false;
        }
        
        if((grdDeclInquiry.GetGridData(i,5)!='-1')&& (grdDeclInquiry.GetGridData(i,6)!=''))
        {
            alert("You must check closed Y/N at row " + i + "!"); 
            return false;
        }
    }
    return true;
}
//----------------------------------------------------------------------------------------
function onPrint()
{     
    var  url= System.RootURL + "/reports/ep/hl/rpt_ephl00050.aspx?" + "com_pk=" + cboCompany.value + 
            "&dtst=" + dtDateFrom.value + "&dtet=" + dtDateTo.value + "&liquid_no=" + txtLiqNo.text +
            "&closeYN=" + cboClosedYN.value + "&status=" + radStatus.value;
    System.OpenTargetPage( url, "_blank" );           
}
//--------------------------------------------------------------------------------------
function OnDataReceive(obj)
{
    for(i=1; i<grdDeclInquiry.rows;i++)
    {
        grdDeclInquiry.SetGridText(i,1,i);      
    }
}
</script>
<body>
    <!------------------------------------------------------------------>
    <gw:data id="dat_epgd00050_1"  onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso id="1" type="grid" parameter="0,5,6" function="IMEX.sp_sel_tie_liquid_doc"   procedure="IMEX.sp_upd_tie_liquiddoc_close"> 
                <input bind="grdDeclInquiry">                    
                    <input bind="cboCompany" />
                    <input bind="dtDateFrom" /> 
                    <input bind="dtDateTo" /> 
                    <input bind="txtLiqNo" /> 
                    <input bind="cboClosedYN" /> 
                    <input bind="txtStatus" /> 
                </input> 
                <output bind="grdDeclInquiry" /> 
            </dso> 
        </xml> 
    </gw:data> 
<!--------------------------------------------------------------------->
    <form id="form1" runat="server">
        <table width="100%" cellpadding=0 cellspacing=0>
            <tr>
                <td colspan="11">
                      
                </td>               
            </tr>
            <tr>
                <td>Company</td>
                <td ><gw:list id="cboCompany" styles="width:100%;"></gw:list></td>
                <td></td>
                <td></td>
                <td></td>
                <td colspan="3" nowrap >
                    <%--<gw:radio id="radStatus" value="0" styles="width:100%" onchange =""> 
                        <span value="1">Saved </span> 
                        <span value="2">Confirmed</span> 
                        <span value="3">Cancelled</span> 
                        <span value="0">All</span> 
                    </gw:radio>--%>
                </td>
                <td colspan="3" align="right">
                    <table width="100%" cellpadding=0 cellspacing=0>
                        <tr>
                            <td width="97%"></td>
                            <td width="1%"><gw:imgbtn id="btnSave" img="save" alt="Save" text="Save" onclick="onSave()" /></td>
                            <td width="1%"><gw:imgbtn id="btnSearch" img="search" alt="Search" text="Search" onclick="dat_epgd00050_1.Call('SELECT');" /></td>
                            <td width="1%"><gw:imgbtn id="btnPrint" img="excel" alt="Print" text="Print" onclick="onPrint()" /></td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td width="10%" nowrap >Liquidation No.</td>
                <td width="20%"><gw:textbox id="txtLiqNo"  text=""  styles='width:100%;' /></td>                
                <td width="5%"></td>
                <td width="8%" nowrap>Liquidation Date</td>
                <td width="2%"></td>
                <td width="8%"><gw:datebox id="dtDateFrom" lang="1" onchange=""/></td>
                <td width="3%" align="center">~</td>
                <td width="12%"><gw:datebox id="dtDateTo" lang="1" onchange=""/></td>
                <td width="8%" align="right" nowrap >Close Y/N</td>
                <td width="1%"></td>
                <td width="25%"><gw:list id="cboClosedYN" styles="width:50%;" >
                            <data>Data|ALL|Select ALL|Y|Yes|N|No </data>
                        </gw:list></td>
            </tr>
            <tr>
                <td colspan="11" height="10"></td>
            </tr>
            <tr>
                <td colspan="11">
                   <%-- 0._Pk|1.No.|2.Liquidation No.|3.Seq|4.Date|5.Close Y/N|6.Close date|7.Description--%>
                    <gw:grid id='grdDeclInquiry'
                        header='_Pk|No.|Liquidation No.|Seq|Date|Close Y/N|Close date|Description'
                        format='0|0|0|0|4|3|4|0'
                        aligns='0|0|0|0|0|0|0|0'
                        defaults='|||||||'
                        editcol='0|0|0|0|0|1|1|1'
                        widths='0|800|1800|1200|1300|1300|1300|2000'
                        sorting='T'
                        styles='width:100%; height:460'
                        acceptNullDate='true' oncelldblclick="View()"  
                    />
                </td>
            </tr>
        </table>
    </form>
    <gw:textbox id="txtStatus"  text="0"  styles='width:100%;display:none' />
</body>
</html>
