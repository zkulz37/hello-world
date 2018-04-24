<%@ Page Language="C#" %> 

<%@ Import Namespace = "System.Web" %>
<%@ Import Namespace = "System.Web.Security" %>
<%@ Import Namespace = "System.Security.Principal" %>
<%@ Import Namespace = "System.Runtime.InteropServices" %>

<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Search Contract</title>
</head>
<%  ESysLib.SetUser("comm");%>

<script language="javascript" type="text/javascript">
    var G1_tex_contr_mst_pk = 0,  
        G1_view             = 1,  
        G1_rownum           = 2, 
        G1_close_yn         = 3,  
        G1_order_yn         = 4,  
        G1_partner_name     = 5,  
        G1_contr_no         = 6,  
        G1_contr_date       = 7,  
        G1_exp_date         = 8,  
        G1_close_date       = 9,  
        G1_tr_ccy           = 10,  
        G1_ex_rate          = 11,  
        G1_tot_amt          = 12,  
        G1_booking_amt      = 13,  
        G1_shipment_date    = 14, 
        G1_trade_terms      = 15,  
        G1_pay_meth         = 16,  
        G1_description      = 17;
        
   function BodyInit()
     {       
        System.Translate(document);  // Translate to language session
        
        var now = new Date(); 
        var lmonth, ldate;         
        
        BindingDataList(); 
                
        ldate=dtFromDate.value;         
        ldate = ldate.substr(0,4) + ldate.substr(4,2) + '01'           
        dtFromDate.value=ldate ; 
      
        grdContracts.GetGridControl().FrozenCols = G1_contr_no;
        SetGridFormat();
        
     }
     
 function BindingDataList()
 {   
     var data1 = "<%=ESysLib.SetListDataSQL("SELECT pk, PARTNER_NAME FROM TCO_company  where del_if=0")%>|-1|Select All";   
     var data2 = "<%=ESysLib.SetListDataSQL("select a.CODE,  a.CODE from TCO_ABCODE a, TCO_ABCODEGRP b where TCO_ABCODEGRP_PK=b.pk and b.id='ACAB0110' and a.del_if=0 and b.del_if=0 order by a.CODE")%>|ALL|Select All";  //currency 
                      
     cboCompany.SetDataText(data1);    
     cboCompany.value='-1';     
     cboCurrency.SetDataText(data2);
     cboCurrency.value='ALL';
         
     var data = "<%=ESysLib.SetGridColumnDataSQL("select a.CODE,  a.CODE_NM from TCO_ABCODE a, TCO_ABCODEGRP b where TCO_ABCODEGRP_PK=b.pk and b.id='ACCR0140' and a.del_if=0 and b.del_if=0 order by a.CODE " ) %> "; 
     grdContracts.SetComboFormat(G1_pay_meth,data);
 }
   //---------------------------------------------------------------------------------------
    function openPopup(index)
    {
         var fpath = '';
	    switch(index)
	    {	        
	         
           case 0:// Customer 
	            var fpath = System.RootURL + "/form/fp/ab/fpab00120.aspx?partner_type=AR"; //customs
                aValue = System.OpenModal( fpath , 900 , 500, 'resizable:yes;status:yes');
	            if ( aValue != null )
	            {          
	                txtCusName.SetDataText(aValue[2]); 
	                txtCusCode.SetDataText(aValue[1]);  
	                txtCusPK.SetDataText(aValue[0]);  
	            }	
	        break;  
	    }
    }   
    //----------------------------------------------------------------------------
    function SetGridFormat()
    {
        var ctr = grdContracts.GetGridControl(); 
        ctr.ColFormat(G1_ex_rate) = "#,###,###,###,###,###.##";
        ctr.ColFormat(G1_tot_amt) = "#,###,###,###,###,###.##";
        ctr.ColFormat(G1_booking_amt) = "#,###,###,###,###,###.##";
        
        var ctr = grdTotal.GetGridControl(); 
        ctr.ColFormat(2) = "#,###,###,###,###,###.##";
        ctr.ColFormat(3) = "#,###,###,###,###,###.##";
    }    
    //----------------------------------------------------------------------------
    function OnDataReceive(obj)
    {
        switch(obj.id)
        {
            case 'dat_epac00030_1':
                grdContracts.SetCellFontColor(0,1,grdContracts.rows-1,1,0x666666);
                dat_epac00030_2.Call('SELECT');
            break;
        }        
    }
    //----------------------------------------------------------------------------
    function View()
    {
        if (grdContracts.row>0) 
        {
            var code_data=new Array();
            code_data[0] = grdContracts.GetGridData(grdContracts.row, 0);
            window.returnValue = code_data; 
	        window.close();         
        }
    }
    
</script>
<body>
<!------------------------Get Contract List -------------------------------------->
<gw:data id="dat_epac00030_1"  onreceive="OnDataReceive(this)" > 
    <xml> 
        <dso id="1" type="grid" parameter="0,3,9" function="imex.sp_sel_epac00040_1"  > 
            <input bind="grdContracts">                    
                <input bind="cboCompany" /> 
                <input bind="txtCusPK" />  
                <input bind="dtFromDate" />
                <input bind="dtToDate" /> 
                <input bind="cboCurrency" />   
                <input bind="txtContractNo" /> 
                <input bind="cboClosedYN" />   
                <input bind="radStatus" /> 
            </input> 
            <output bind="grdContracts" /> 
        </dso> 
    </xml> 
</gw:data> 
<!------------------------Total -------------------------------------->
<gw:data id="dat_epac00030_2"  onreceive="OnDataReceive(this)" > 
    <xml> 
        <dso id="1" type="grid" parameter="0,3,9" function="imex.sp_sel_tot_ex_contract_inquiry" > 
            <input bind="grdTotal">                    
                <input bind="cboCompany" /> 
                <input bind="txtCusPK" />  
                <input bind="dtFromDate" />
                <input bind="dtToDate" /> 
                <input bind="cboCurrency" />   
                <input bind="txtContractNo" /> 
                <input bind="cboClosedYN" />   
                <input bind="radStatus" /> 
            </input> 
            <output bind="grdTotal" /> 
        </dso> 
    </xml> 
</gw:data> 
<!-------------------------------------------------------------------------------->
    <form id="form1" runat="server">
        <table cellpadding=0 cellspacing=0 width="100%" border=0>
            <tr>
                <td width="10%">Company</td>
                <td colspan="3"><gw:list id="cboCompany" styles="width:100%;"></gw:list></td>
                <td width="2%"></td>
                <td width="10%"><a title="Click here to select Vendor" onclick="openPopup(0)" href="#tips" style="text-decoration : none; color=#0000FF"><b>Vendor Name</b></a></td>
                <td width="1%"></td>
                <td width="10%"><gw:textbox id="txtCusCode"  text=""  styles='width:100%;' /><gw:textbox id="txtCusPK"  text=""  styles='display:none' /></td>
                <td width="30%" colspan="5" ><gw:textbox id="txtCusName"  text=""  styles='width:100%;' /></td>                              
                <td width="6%" align="right"></td>
                <td width="2%"></td>        
                <td width="2%"><gw:imgbtn id="btnSearch" img="search" alt="Search" text="Search" onclick="dat_epac00030_1.Call('SELECT');" /></td>        
            </tr>
            <tr> 
                <td width="10%">Contract Date</td>
                <td width="8%"><gw:datebox id="dtFromDate" lang="1"  styles='width:100%;' onchange=""/></td>
                <td width="2%" align="center">~</td>
                <td width="17%"><gw:datebox id="dtToDate" lang="1"  styles='width:100%;' onchange=""/></td>
                <td width="2%"></td>
                <td width="10%">Trans Currency</td>
                <td width="1%"></td>
                <td width="13%"><gw:list id="cboCurrency" styles="width:100%;" ></gw:list></td>
                <td width="5%">/VND</td>
                <td width="2%"></td>
                <td width="6%" align="right">Closed Y/N</td>
                <td width="1%"></td>
                <td width="13%"><gw:list id="cboClosedYN" styles="width:100%;" >
                        <data>Data|All|Select All|Y|Yes|N|No </data>
                    </gw:list>
                </td>
                <td></td>
                <td></td>
                <td></td>
            </tr>
            <tr>
                <td>Status</td>
                <td colspan="3">
                    <gw:radio id="radStatus" value="0" styles="width:100%" onchange ="dat_epac00030_1.Call('SELECT');"> 
                        <span value="1">Saved </span> 
                        <span value="2">Confirmed</span> 
                        <span value="3">Cancelled</span> 
                        <span value="0">All</span> 
                    </gw:radio>
                </td>
                <td></td>
                <td>Contract No</td>
                <td></td>
                <td><gw:textbox id="txtContractNo"  text=""  styles='width:100%;'  /></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
            </tr>
            <tr>
                <td colspan="16">&nbsp;</td>
            </tr>
            <tr>
                <td colspan="16">
                    <gw:grid id='grdContracts'
                        header='_Pk|_|No|Close Yn|Order Yn|Vendor|Contract No|Contract Date|Exp Date|Close Date|Tr Ccy|Ex Rate|Trans. Amt|Booking Amt|Shipment Date|Price Terms|Pay Meth|Description'
                        format='0|0|0|3|3|0|0|4|4|4|0|0|0|0|4|0|0|0'
                        aligns='0|1|1|0|0|0|0|1|1|1|1|3|3|3|1|1|1|0'
                        defaults='|||||||||||||||||'
                        editcol='0|0|0|1|0|0|0|0|0|1|0|0|0|0|0|0|0|0'
                        widths='0|600|600|1200|1200|3500|1500|1300|1200|1200|1000|1400|1400|1400|1400|1400|1400|1000'
                        sorting='T'
                        oncelldblclick="View()"
                        acceptNullDate='true'
                        styles='width:100%; height:300'
                    />
                </td>
            </tr>
            <tr>
                <td colspan="6"></td>
                <td colspan="10">
                    <gw:grid id='grdTotal'
                        header=' |  |Trans. Amt|Booking Amt'
                        format='0|0|0|0'
                        aligns='1|1|3|3'
                        defaults='|||'
                        editcol='1|1|1|1'
                        widths='1000|1000|2000|2000'
                        sorting='T'
                        styles='width:100%; height:110'
                    />
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
