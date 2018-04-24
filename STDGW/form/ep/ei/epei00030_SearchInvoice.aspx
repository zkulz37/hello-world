<%@ Page Language="C#"%>

<%@ Import Namespace = "System.Web" %>
<%@ Import Namespace = "System.Web.Security" %>
<%@ Import Namespace = "System.Security.Principal" %>
<%@ Import Namespace = "System.Runtime.InteropServices" %>

<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Search Invoice</title>
</head>
<%  ESysLib.SetUser("comm");%>

<script language="javascript" type="text/javascript">
   function BodyInit()
     {    
        System.Translate(document);  // Translate to language session
           
        var now = new Date(); 
        var lmonth, ldate;
         
        BindingDataList(); 
                
        ldate=dtFromDate.value;         
        ldate = ldate.substr(0,4) + ldate.substr(4,2) + '01'           
        dtFromDate.value=ldate ;
      
        grdInvoices.GetGridControl().FrozenCols = 6;
        SetGridFormat();
        <%=ESysLib.SetGridColumnComboFormat("grdInvoices", 16, "select a.CODE,  a.CODE_NM from TCO_ABCODE a, TCO_ABCODEGRP b where TCO_ABCODEGRP_PK=b.pk and b.id='ACCR0140' and a.del_if=0 and b.del_if=0 order by a.CODE ")%>; 
        <%=ESysLib.SetGridColumnComboFormat("grdInvoices", 15, "select a.CODE,  a.CODE_NM from TCO_ABCODE a, TCO_ABCODEGRP b where TCO_ABCODEGRP_PK=b.pk and b.id='ACCR0020' and a.del_if=0 and b.del_if=0 order by a.CODE ")%>; 
     }
     
     function BindingDataList()
     {   
         var data1 = "<%=ESysLib.SetListDataSQL("SELECT pk, PARTNER_NAME FROM TCO_company  where del_if=0")%>|-1|Select All";   
         var data2 = "<%=ESysLib.SetListDataSQL("select a.CODE,  a.CODE from TCO_ABCODE a, TCO_ABCODEGRP b where TCO_ABCODEGRP_PK=b.pk and b.id='ACAB0110' and a.del_if=0 and b.del_if=0 order by a.CODE")%>|ALL|Select All";  //currency 
                          
         cboCompany.SetDataText(data1);    
         cboCompany.value='-1';     
         cboCurrency.SetDataText(data2);
         cboCurrency.value='ALL';
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
        var ctr = grdInvoices.GetGridControl(); 
        ctr.ColFormat(11) = "#,###,###,###,###,###";
        ctr.ColFormat(12) = "#,###,###,###,###,###.##";
        ctr.ColFormat(13) = "#,###,###,###,###,###";
        
        var ctr = grdTotal.GetGridControl(); 
        ctr.ColFormat(2) = "#,###,###,###,###,###.##";
        ctr.ColFormat(3) = "#,###,###,###,###,###";
    }    
    //----------------------------------------------------------------------------
    function OnDataReceive(obj)
    {
        switch(obj.id)
        {
            case 'dat_epei00030_1':
                dat_epei00030_2.Call('SELECT');
            break;
            case 'dat_epei00030_2':
                grdTotal.Subtotal(0,2,0,"3","",true,8,"Total");
            break;
        }        
    }   
    //----------------------------------------------------------------------------
    function View()
    {
        if (grdInvoices.row>0) 
        {
             var code_data=new Array();
            code_data[0] = grdInvoices.GetGridData(grdInvoices.row, 1);
            window.returnValue = code_data; 
	        window.close();            
        }
    }
    
</script>
<body>
<!------------------------Get Contract List -------------------------------------->
<gw:data id="dat_epei00030_1"  onreceive="OnDataReceive(this)" > 
    <xml> 
        <dso id="1" type="grid" parameter="0,3,9" function="imex.sp_sel_ex_invoice_inquiry"   procedure="imex.sp_upd_tex_contr_inquiry "> 
            <input bind="grdInvoices">                    
                <input bind="cboCompany" /> 
                <input bind="txtCusPK" />  
                <input bind="dtFromDate" />
                <input bind="dtToDate" /> 
                <input bind="cboCurrency" />   
                <input bind="txtContractNo" /> 
                <input bind="txtOrderNo" /> 
                <input bind="txtInvNo" />   
                <input bind="radStatus" /> 
            </input> 
            <output bind="grdInvoices" /> 
        </dso> 
    </xml> 
</gw:data> 
<!------------------------Total -------------------------------------->
<gw:data id="dat_epei00030_2"  onreceive="OnDataReceive(this)" > 
    <xml> 
        <dso id="1" type="grid" parameter="0,3,9" function="imex.sp_sel_tot_ex_invoice_inquiry" > 
            <input bind="grdTotal">                    
                <input bind="cboCompany" /> 
                <input bind="txtCusPK" />  
                <input bind="dtFromDate" />
                <input bind="dtToDate" /> 
                <input bind="cboCurrency" />   
                <input bind="txtContractNo" /> 
                <input bind="txtOrderNo" /> 
                <input bind="txtInvNo" />   
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
                <td width="8%">Company</td>
                <td colspan="3"><gw:list id="cboCompany" styles="width:100%;"></gw:list></td> 
                <td width="2%"></td>             
                <td nowrap width="8%"><a title="Click here to select Vendor" onclick="openPopup(0)" href="#tips" style="text-decoration : none; color=#0000FF"><b>Vendor Name</b></a></td>
                <td width="1%"></td> 
                <td width="15%"><gw:textbox id="txtCusCode"  text=""  styles='width:100%;' /><gw:textbox id="txtCusPK"  text=""  styles='display:none' /></td>
                <td width="30%" colspan="5" ><gw:textbox id="txtCusName"  text=""  styles='width:100%;' /></td>                                              
                <td width="2%"></td>
                <td width="6%" align="right"><gw:imgbtn id="btnSearch" img="search" alt="Search" text="Search" onclick="dat_epei00030_1.Call('SELECT');" /></td>        
                <td width="2%"><gw:imgbtn id="btnPrint" img="excel" alt="Print" text="Print" onclick="onPrint()" /></td>        
            </tr>
            <tr> 
                <td width="8%">Invoice Date</td>
                <td width="8%"><gw:datebox id="dtFromDate" lang="1"  styles='width:100%;' onchange=""/></td>
                <td width="2%" align="center">~</td>
                <td width="17%"><gw:datebox id="dtToDate" lang="1"  styles='width:100%;' onchange=""/></td>
                <td width="2%"></td> 
                <td nowrap width="8%">Trans Currency</td>
                <td width="1%"></td> 
                <td width="15%"><gw:list id="cboCurrency" styles="width:100%;" ></gw:list></td>
                <td width="4%">/VND</td>
                <td width="2%"></td> 
                <td nowrap width="6%">Order No</td>
                <td width="1%"></td> 
                <td  width="20%"><gw:textbox id="txtOrderNo"  text=""  styles='width:100%;' /></td>  
                <td></td>                       
                <td></td>
            </tr>
            <tr>
                <td>Status</td>
                <td colspan="3">
                    <gw:radio id="radStatus" value="1" styles="width:100%" onchange="dat_epei00030_1.Call('SELECT');"> 
                        <span value="1">Saved </span> 
                        <span value="2">Approved</span> 
                        <span value="3">Cancelled</span> 
                    </gw:radio>
                </td>
                <td></td>
                <td>Contract No</td>
                <td width="1%"></td> 
                <td><gw:textbox id="txtContractNo"  text=""  styles='width:100%;'  /></td>
                <td></td>
                <td></td>
                <td nowrap>Invoice No</td>
                <td width="1%"></td> 
                <td ><gw:textbox id="txtInvNo"  text=""  styles='width:100%;'  /></td>               
                <td></td>                       
                <td></td>
            </tr>
            <tr>
                <td colspan="16" style='height:10;'>&nbsp;</td>
            </tr>
            <tr>
                <td colspan="16">
                    <gw:grid id='grdInvoices'
                        header='No|_Pk|Contr No|Contr Date|Close Yn|Order No|Order Date|Close Yn|Invoice No|Invoice Date|Trans. Curr|Ex Rate|Trans. Amt|Booking Amt|Ship Date|Pay Term|Pay Method'
                        format='0|0|0|4|3|0|4|3|0|4|0|0|0|0|4|0|0'
                        aligns='1|0|0|1|0|0|1|0|0|1|1|3|3|3|1|0|0'
                        defaults='||||||||||||||||'
                        editcol='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                        widths='600|0|1410|1305|1000|1260|1245|1000|1560|1485|1000|1000|1470|1560|1305|1455|1000'
                        sorting='T'
                        styles='width:100%; height:300'
                        oncelldblclick="View()"
                        acceptNullDate='true'
                        styles='width:100%; height:300'
                    />
                </td>
            </tr>
            <tr>
                <td colspan="7"></td>
                <td colspan="9">
                    <gw:grid id='grdTotal'
                        header=' |  |Trans. Amt|Booking Amt'
                        format='0|0|0|0'
                        aligns='1|1|3|3'
                        defaults='|||'
                        editcol='1|1|1|1'
                        widths='1000|1000|1600|1600'
                        sorting='T'
                        styles='width:100%; height:110'
                    />
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
