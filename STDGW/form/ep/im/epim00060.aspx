<%@ Page Language="C#" %>

<%@ Import Namespace="System.Web" %>
<%@ Import Namespace="System.Web.Security" %>
<%@ Import Namespace="System.Security.Principal" %>
<%@ Import Namespace="System.Runtime.InteropServices" %>
<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Untitled Page</title>
</head>

<%  
    ESysLib.SetUser(Session("APP_DBUSER"))
    Dim l_user As String
    l_user = ""
%>


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
      
        grdDeclList.GetGridControl().FrozenCols = 6;
        SetGridFormat();
      }
     //---------------------------------------------------------------------------------------------------------
     function BindingDataList()
     {   
         var data1 = "<%=ESysLib.SetListDataSQL("SELECT pk, PARTNER_NAME FROM TCO_company  where del_if=0")%>|-1|Select All";   
         var data2 = "<%=ESysLib.SetListDataSQL("select a.CODE,  a.CODE from TCO_ABCODE a, TCO_ABCODEGRP b where TCO_ABCODEGRP_PK=b.pk and b.id='ACAB0110' and a.del_if=0 and b.del_if=0 order by a.CODE")%>|ALL|Select All";  //currency 
         var data3 = "<%=ESysLib.SetListDataFUNC("SELECT lg_f_logistic_code('IEBS0060') FROM DUAL")%>|ALL|Select All"; 
                          
         cboCompany.SetDataText(data1);    
         cboCompany.value='-1';     
         cboCurrency.SetDataText(data2);
         cboCurrency.value='ALL';
         cboDeclType.SetDataText(data3);
         cboDeclType.value='ALL';
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
        var ctr = grdDeclList.GetGridControl(); 
        ctr.ColFormat(11) = "#,###,###,###,###,###";
        ctr.ColFormat(12) = "#,###,###,###,###,###.##";
        ctr.ColFormat(13) = "#,###,###,###,###,###";
        
       
    }    
    //----------------------------------------------------------------------------
    function OnDataReceive(obj)
    {
            
    }
    //----------------------------------------------------------------------------
    function onSave()
    {
        if (ValidateData())
            dat_epim00060.Call('');
    }
    //----------------------------------------------------------------------------
    function ValidateData()
    {
        for(var i=1; i<grdDeclList.rows; i++)
        {
            if((grdDeclList.GetGridData(i,2)=='-1')&& grdDeclList.GetGridData(i,9)=='')
            {   
                alert("You must input close date at row " + grdDeclList.GetGridData(i,1));
                return false;
            }
            if((grdDeclList.GetGridData(i,2)=='0')&& grdDeclList.GetGridData(i,9)!='')
            {   
                alert("You must check close at row " +grdDeclList.GetGridData(i,1));
                return false;
            }
        }
        return true;
    }
    //----------------------------------------------------------------------------
    function View()
    {
        if (grdDeclList.row>0) 
        {
            var fpath = System.RootURL + "/form/ep/gd/epgd00030.aspx?decl_pk=" + grdDeclList.GetGridData(grdDeclList.row,0);
            System.OpenModal( fpath ,1000 , 620, 'resizable:yes;status:yes');           
        }
    }
    //-------------------------------------------------------------------
    function onPrint()
    {     
        var  url= System.RootURL + "/reports/ep/gd/rpt_epgd00020_DeclInq.aspx?" + "company_pk=" + cboCompany.value + "&vendor_pk=" + txtCusPK.text 
                + "&fromdate=" + dtFromDate.value + "&todate=" + dtToDate.value + "&curr=" + cboCurrency.value + "&status=" +radStatus.value
                + "&close_yn=" + cboClosedYN.value + "&decl_type=" + cboDeclType.value + "&decl_no=" + txtDeclNo.text + "&fromdt=" + dtFromDate.text + "&todt=" + dtToDate.text;
	    System.OpenTargetPage( url, "_blank" );           
    }
</script>

<body>
    <!------------------------Get Contract List -------------------------------------->
    <gw:data id="dat_epim00060" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid" parameter="0,2,9" function="<%=l_user%>lg_sel_epim00060" > 
                <input bind="grdDeclList">                    
                    <input bind="cboCompany" /> 
                    <input bind="txtCusPK" />  
                    <input bind="dtFromDate" />
                    <input bind="dtToDate" /> 
                    <input bind="cboCurrency" />   
                    <input bind="txtDeclNo" /> 
                    <input bind="cboDeclType" /> 
                    <input bind="cboClosedYN" />   
                    <input bind="radStatus" />  
                </input> 
                <output bind="grdDeclList" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------Total -------------------------------------->
    <!-------------------------------------------------------------------------------->
    <form id="form1" runat="server">
        <table cellpadding="0" cellspacing="0" border="0" style="height: 100%; width: 100%">
            <tr style="height: 1%">
                <td width="10%">
                    Company</td>
                <td colspan="3">
                    <gw:list id="cboCompany" styles="width:100%;"></gw:list>
                </td>
                <td width="2%">
                </td>
                <td width="8%" style="white-space: nowrap">
                    <a title="Click here to select Vendor" onclick="openPopup(0)" href="#tips" style="text-decoration: none;
                        color:#0000ff"><b>Vendor Name</b></a></td>
                <td width="1%">
                </td>
                <td width="10%">
                    <gw:textbox id="txtCusCode" text="" styles='width:100%;' />
                    <gw:textbox id="txtCusPK" text="" styles='display:none' />
                </td>
                <td width="30%" colspan="5">
                    <gw:textbox id="txtCusName" text="" styles='width:100%;' />
                </td>
                <td width="2%">
                    <gw:imgbtn id="btnSearch" img="search" alt="Search" text="Search" onclick="dat_epim00060.Call('SELECT');" />
                </td>
                <td width="2%">
                    <gw:imgbtn id="btnPrint" img="excel" alt="Print" text="Print" onclick="onPrint()" />
                </td>
            </tr>
            <tr style="height: 1%">
                <td width="10%" nowrap>
                    Register Date</td>
                <td width="8%">
                    <gw:datebox id="dtFromDate" lang="1" styles='width:100%;' onchange="" />
                </td>
                <td width="2%" align="center">
                    ~</td>
                <td width="17%">
                    <gw:datebox id="dtToDate" lang="1" styles='width:100%;' onchange="" />
                </td>
                <td width="2%">
                </td>
                <td width="10%" style="white-space: nowrap">
                    Trans Currency</td>
                <td width="1%">
                </td>
                <td width="15%">
                    <gw:list id="cboCurrency" styles="width:100%;"></gw:list>
                </td>
                <td width="4%">
                    /VND</td>
                <td width="2%">
                </td>
                <td width="8%" align="right">
                    Closed Y/N</td>
                <td width="1%">
                </td>
                <td width="15%">
                    <gw:list id="cboClosedYN" styles="width:100%;">
                            <data>Data|All|Select All|Y|Yes|N|No </data>
                        </gw:list>
                </td>
                <td>
                </td>
                <td>
                </td>
                <td>
                </td>
            </tr>
            <tr style="height: 1%">
                <td>
                    Status</td>
                <td colspan="3" style="white-space: nowrap">
                    <gw:radio id="radStatus" value="0" styles="width:100%" onchange="dat_epim00060.Call('SELECT');"> 
                        <span value="1">Saved </span> 
                        <span value="2">Confirmed</span> 
                        <span value="3">Cancelled</span>
                        <span value="0">All</span> 
                    </gw:radio>
                </td>
                <td>
                </td>
                <td style="white-space: nowrap">
                    Declaration No</td>
                <td>
                </td>
                <td>
                    <gw:textbox id="txtDeclNo" text="" styles='width:100%;' />
                </td>
                <td>
                </td>
                <td>
                </td>
                <td align="right" style="white-space: nowrap">
                    Declaration Type</td>
                <td>
                </td>
                <td>
                    <gw:list id="cboDeclType" styles="width:100%;"></gw:list>
                </td>
                <td>
                </td>
                <td>
                </td>
                <td>
                </td>
            </tr>
            <tr style="height: 95%">
                <td colspan="16">
                    <gw:grid id='grdDeclList' header='_PK|No|Close Y/N|Customer|Decl.Type|Decl No|Decl Date|Status|License Exp Date|Close Date|Trans Curr|Ex Rate|Remark'
                        format='0|0|3|0|0|0|4|0|4|4|0|-2|0' aligns='0|0|0|0|0|0|0|0|0|0|0|0|0' check='||||||||||||'
                        editcol='0|0|0|0|0|0|0|0|0|0|0|0|0' widths='1000|500|1200|1500|1000|2200|1200|1200|1200|1200|1000|1200|1000'
                        sorting='T' styles='width:100%; height:100%' />
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
