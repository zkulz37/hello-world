<%@ Page Language="C#" %> 

<%@ Import Namespace = "System.Web" %>
<%@ Import Namespace = "System.Web.Security" %>
<%@ Import Namespace = "System.Security.Principal" %>
<%@ Import Namespace = "System.Runtime.InteropServices" %>

<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
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
      
        grdContracts.GetGridControl().FrozenCols = 6;
        SetGridFormat();
        <%=ESysLib.SetGridColumnComboFormat("grdContracts", 16, "select a.CODE,  a.CODE_NM from TCO_ABCODE a, TCO_ABCODEGRP b where TCO_ABCODEGRP_PK=b.pk and b.id='ACCR0140' and a.del_if=0 and b.del_if=0 order by a.CODE ")%>; 
        getCurrBooking();
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
        var ctr = grdContracts.GetGridControl(); 
        ctr.ColFormat(11) = "#,###,###,###,###,###.##";
        ctr.ColFormat(12) = "#,###,###,###,###,###.##";
        ctr.ColFormat(13) = "#,###,###,###,###,###.##";
        
        var ctr = grdTotal.GetGridControl(); 
        ctr.ColFormat(2) = "#,###,###,###,###,###.##";
        ctr.ColFormat(3) = "#,###,###,###,###,###.##";
    }    
    //----------------------------------------------------------------------------
    function OnDataReceive(obj)
    {
        switch(obj.id)
        {
            case 'dat_epac00020_1':
                grdContracts.SetCellFontColor(0,1,grdContracts.rows-1,1,0x666666);
                dat_epac00020_2.Call('SELECT');
            break;
            case 'dat_epac00020_2':
                grdTotal.Subtotal(0,2,0,"3","",true,8,"Total");
            break;
        }        
    }
    //----------------------------------------------------------------------------
    function onSave()
    {
        if (ValidateData())
            dat_epac00020_1.Call('');
    }
    //----------------------------------------------------------------------------
    function ValidateData()
    {
        for(var i=1; i<grdContracts.rows; i++)
        {
            if((grdContracts.GetGridData(i,3)=='-1')&& grdContracts.GetGridData(i,9)=='')
            {   
                alert("You must input close date at row " + grdContracts.GetGridData(i,2));
                return false;
            }
            if((grdContracts.GetGridData(i,3)=='0')&& grdContracts.GetGridData(i,9)!='')
            {   
                alert("You must check close at row " +grdContracts.GetGridData(i,2));
                return false;
            }
        }
        return true;
    }
    //----------------------------------------------------------------------------
    function View()
    {
        if ((grdContracts.row>0) &&(grdContracts.col==1))
        {
            var fpath = System.RootURL + "/form/ep/ac/epac00010.aspx?contract_pk=" + grdContracts.GetGridData(grdContracts.row,0);
            System.OpenModal( fpath ,1000 , 700, 'resizable:yes;status:yes');           
        }
    }
    //-------------------------------------------------------------------
    function onPrint()
    {
        var  url= System.RootURL + "/reports/ep/ac/rptepac00020_inquiry.aspx?" + "company=" + cboCompany.value + "&vendor=" + txtCusPK.text 
                + "&fromdate=" + dtFromDate.value + "&todate=" + dtToDate.value + "&curr=" + cboCurrency.value + "&closeyn=" 
                + cboClosedYN.value + "&status=" +radStatus.value + "&fromdt=" + dtFromDate.text + "&todt=" + dtToDate.text;
	    System.OpenTargetPage( url, "_blank" );        
    }
    //----------------------------------------------------------------------------
    function GetXmlHttpRequest(handler)
    { 
	    var objXmlHttp=null;
    	
	    if (navigator.userAgent.indexOf("Opera")>=0)
	    {
		    alert("Sorry! Ajax doesn't work in Opera"); 
		    return; 
	    }
    	
	    if (navigator.userAgent.indexOf("MSIE")>=0)
	    { 
		    var strName="Msxml2.XMLHTTP";
		    if (navigator.appVersion.indexOf("MSIE 5.5")>=0)
		    {
			    strName="Microsoft.XMLHTTP";
    			
		    } 
		    try
		    { 
			    objXmlHttp=new ActiveXObject(strName);
			    objXmlHttp.onreadystatechange=handler; 
    			
			    return objXmlHttp;
		    } 
		    catch(e)
		    { 
			    alert("Error. Scripting for ActiveX might be disabled");
			    return; 
		    } 
	    } 
    	
	    if (navigator.userAgent.indexOf("Mozilla")>=0)
	    {
		    objXmlHttp=new XMLHttpRequest();
		    objXmlHttp.onload=handler;
		    objXmlHttp.onerror=handler;
    		
		    return objXmlHttp;
	    }
    } 
    
    //-----------------------------------------------
    //ajax function
    function GetRequestState(obj)
    {
     
      if(obj.readyState == 4 && obj.status == 200)
      {
          return true;
      }
      return false;
    }
    //--------------------------------------------------------------
    function getCurrBooking()
    {    
	    var url =  System.RootURL + "/form/ep/ac/AjaxFile.aspx?type=1" ;
	    ajax_test = null;
	   
	    ajax_test = GetXmlHttpRequest(returnCurrBooking);
	    ajax_test.open("GET", url , true);
	    ajax_test.send(null); 
    }
    //---------------------------------------------------------
    function returnCurrBooking()
    {
        if(GetRequestState(ajax_test))
	    {		   
	        strdata = ajax_test.responseText;	 		         
	        lbCurrBooking.SetDataText('/'+strdata);
	    }
    }
</script>
<body>
<!------------------------Get Contract List -------------------------------------->
<gw:data id="dat_epac00020_1"  onreceive="OnDataReceive(this)" > 
    <xml> 
        <dso id="1" type="grid" parameter="0,3,9" function="imex.sp_sel_epac00020_1"   procedure="imex.sp_upd_tim_contr_inquiry "> 
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
<gw:data id="dat_epac00020_2"  onreceive="OnDataReceive(this)" > 
    <xml> 
        <dso id="1" type="grid" parameter="0,3,9" function="imex.sp_sel_tot_contract_inquiry" > 
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
                <td width="6%" align="right"><gw:imgbtn id="btnSearch" img="search" alt="Search" text="Search" onclick="dat_epac00020_1.Call('SELECT');" /></td>
                <td width="2%"><gw:imgbtn id="btnSave" img="save" alt="Save" text="Save" onclick="onSave()" /></td>        
                <td width="2%"><gw:imgbtn id="btnPrint" img="excel" alt="Print" text="Print" onclick="onPrint()" /></td>        
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
                <td width="5%"><gw:label id="lbCurrBooking"  text=""  styles='width:100%;' /></td>
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
                    <gw:radio id="radStatus" value="0" styles="width:100%" onchange ="dat_epac00020_1.Call('SELECT');"> 
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
                <td colspan="16" style='height:10;'></td>
            </tr>
            <tr>
                <td colspan="16">
                    <gw:grid id='grdContracts'
                        header='_Pk| |No|Close Yn|Order Yn|Vendor|Contract No|Contract Date|Exp Date|Close Date|Tr Ccy|Ex Rate|Trans. Amt|Booking Amt|Shipment Date|Price Terms|Pay Meth|Description'
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
                <td colspan="7"></td>
                <td colspan="9">
                    <gw:grid id='grdTotal'
                        header=' |Currency|Trans. Amt|Booking Amt'
                        format='0|0|0|0'
                        aligns='1|1|3|3'
                        defaults='|||'
                        editcol='0|0|0|0'
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
