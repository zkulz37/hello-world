<%@ Page Language="C#" %> 

<%@ Import Namespace = "System.Web" %>
<%@ Import Namespace = "System.Web.Security" %>
<%@ Import Namespace = "System.Security.Principal" %>
<%@ Import Namespace = "System.Runtime.InteropServices" %>

<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Contract Info</title>
</head>
<%  ESysLib.SetUser("comm");%>



<script language="javascript" type="text/javascript">
   function BodyInit()
     {       
        System.Translate(document);  // Translate to language session
        
        var now = new Date(); 
        var lmonth, ldate;
         
        BindingDataList(); 
                
//        ldate=dtFromDate.value;         
//        ldate = ldate.substr(0,4) + ldate.substr(4,2) + '01'           
//        dtFromDate.value=ldate ; 
        txtCtrPKs.text= "<%=Request.QueryString["CtrPKs"] %>"; 
        txtCusPK.text= "<%=Request.QueryString["Vendor"] %>";
       
        grdContracts.GetGridControl().FrozenCols = 6;
        SetGridFormat();
        <%=ESysLib.SetGridColumnComboFormat("grdContracts", 16, "select a.CODE,  a.CODE_NM from TCO_ABCODE a, TCO_ABCODEGRP b where TCO_ABCODEGRP_PK=b.pk and b.id='ACCR0140' and a.del_if=0 and b.del_if=0 order by a.CODE ")%>;        
        dat_epei00010_1_1.Call('SELECT');
     }
     
     function BindingDataList()
     {   
         var data1 = "<%=ESysLib.SetListDataSQL("SELECT pk, PARTNER_NAME FROM TCO_company  where del_if=0")%>|-1|Select All";   
                                   
         cboCompany.SetDataText(data1);    
         cboCompany.value='-1';             
     }
   //---------------------------------------------------------------------------------------
 
    function SetGridFormat()
    {
        var ctr = grdContracts.GetGridControl(); 
        ctr.ColFormat(10) = "#,###,###,###,###,###.##";
        ctr.ColFormat(11) = "#,###,###,###,###,###.##";
        ctr.ColFormat(12) = "#,###,###,###,###,###.##";
    }    
    //----------------------------------------------------------------------------
    function OnDataReceive(obj)
    {
       
    }
//----------------------------------------------------------------------------------------
function onSelect()
{
    var code_data=new Array()
    var ctrl = grdContracts.GetGridControl();
    var index, rowNo
	
    index =0;
    rowNo = 0 ;
	
    if(ctrl.SelectedRows == 0)
    {
        return ;
    }
    rowNo=grdContracts.row;
    for(var col =0; col<grdContracts.cols; col++)
        code_data[col] = grdContracts.GetGridData(rowNo , col);
    
    window.returnValue = code_data; 
    window.close();
}
</script>
<body>
<!------------------------Get Contract List -------------------------------------->
<gw:data id="dat_epei00010_1_1"  onreceive="OnDataReceive(this)" > 
    <xml> 
        <dso id="1" type="grid"  function="imex.sp_sel_imcontract_to_inv" > 
            <input bind="grdContracts">                    
                <input bind="cboCompany" /> 
                <input bind="txtCusPK" />  
                <input bind="txtFromDate" /> 
                <input bind="txtToDate" /> 
                <input bind="txtCtrPKs" />   
                <input bind="txtContractNotmp" />
            </input> 
            <output bind="grdContracts" /> 
        </dso> 
    </xml> 
</gw:data> 
<!-------------------------------------------------------------------------------->
    <form id="form1" runat="server">
        <table cellpadding=0 cellspacing=0 width="100%" border=0>
            <tr>
                <td width="10%">Company</td>
                <td width="20%"><gw:list id="cboCompany" styles="width:100%;"></gw:list></td>
                <td width="2%"></td>
                <td width="10%">Contract Date</td>
                <td width="8%"><gw:datebox id="dtFromDate" lang="1" nullaccept  styles='width:100%;' onchange="txtFromDate.text=this.value"/></td>
                <td width="2%" align="center">~</td>
                <td width="17%"><gw:datebox id="dtToDate" lang="1" nullaccept styles='width:100%;' onchange="dtToDate.text=this.value"/></td>
                <td width="2%"></td>
                <td>Contract No</td>
                <td></td>
                <td width="10%"><gw:textbox id="txtContractNo"  text=""  styles='width:100%;' onchange="txtContractNotmp.text='%'+this.text+'%'" /></td>
                <td width="6%" align="right"></td>
                <td width="2%"><gw:imgbtn id="btnSearch" img="search" alt="Search" text="Search" onclick="dat_epei00010_1_1.Call('SELECT');" /></td>        
                <td width="2%"><gw:imgbtn id="btnSelect" img="select" alt="Select" text="Select" onclick="onSelect()" /></td>        
            </tr>
            <tr>
                <td colspan="14" style='height:10;'></td>
            </tr>
            <tr>
                <td colspan="14">
                <%--'0._Pk|1.Contract No|2.Contract Date|3.Exp Date|4.Tr Ccy|5.Ex Rate|6.Tot Amt|7.Item Orgin
                |8.Shipment Date|9.Trade Terms|10.Pay Meth|11.Pay Ccy|12.Pay Term|13.Discount|14.Transport By
                |15.Pay Ex Rate|16.Trade Loc|17.Description|18.Bank_Account|19.Vendor Code|20.Vendor Name
                |21._Ship_Id|22._Ship_Name|23._Paid_Id|24._Paid_Name|25._Country_Nm|26._Plc_Loading
                |27._Plc_Discharge|28._Tco_Buspartner_Pk4|29._Bank|30._Tco_Buspartner_Pk|31._Plc_Discharge
                |32_Plc_Loading|33._Ship_Opt|34._Pay_Opt|35._Ship_Add|36._Paid_Add|37._Tco_Buspartner_Pk1
                |38._Tco_Buspartner_Pk2'--%>
                    <gw:grid id='grdContracts'
                        header='_Pk|Contract No|Contract Date|Exp Date|Tr Ccy|Ex Rate|Tot Amt|Item Orgin|Shipment Date|Trade Terms|Pay Meth|Pay Ccy|Pay Term|Discount|Transport By|Pay Ex Rate|Trade Loc|Description|Bank_Account|Vendor Code|Vendor Name|_Ship_Id|_Ship_Name|_Paid_Id|_Paid_Name|_Country_Nm|_Plc_Loading|_Plc_Discharge|_Tco_Buspartner_Pk4|_Bank|_Tco_Buspartner_Pk|_Plc_Discharge|_Plc_Loading|_Ship_Opt|_Pay_Opt|_Ship_Add|_Paid_Add|_Tco_Buspartner_Pk1|_Tco_Buspartner_Pk2'
                        format='0|0|4|4|0|0|0|0|4|0|2|2|2|0|2|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                        aligns='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                        defaults='||||||||||||||||||||||||||||||||||||||'
                        editcol='0|0|0|0|0|3|3|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                        widths='0|1000|1515|1245|1000|1305|1000|1620|1680|1605|1650|1305|1530|1065|1800|1980|1890|2055|2000|2000|2000|2000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000'
                        sorting='T'
                        oncelldblclick='onSelect()'
                        styles='width:100%; height:460'
                        />
                </td>
            </tr>
        </table>    
    </form>
    <gw:textbox id="txtCusPK" styles="display:none" />
    <gw:textbox id="txtCtrPKs" styles="display:none" />
    <gw:textbox id="txtContractNotmp"  text='%%' styles="display:none" />
    <gw:textbox id="txtFromDate" text='19000101' styles="display:none" />
    <gw:textbox id="txtToDate" text='30000101' styles="display:none" />
</body>
</html>
