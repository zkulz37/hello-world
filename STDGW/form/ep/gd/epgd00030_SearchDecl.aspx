<%@ Page Language="C#" %> 

<%@ Import Namespace = "System.Web" %>
<%@ Import Namespace = "System.Web.Security" %>
<%@ Import Namespace = "System.Security.Principal" %>
<%@ Import Namespace = "System.Runtime.InteropServices" %>
<!-- #include file="../../../system/lib/form.inc"  -->

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Search Declaration</title>
</head>
 <%ESysLib.SetUser("comm");%>
 
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
//        <%=ESysLib.SetGridColumnComboFormat("grdDeclList", 15, "select a.CODE,  a.CODE_NM from TCO_ABCODE a, TCO_ABCODEGRP b where TCO_ABCODEGRP_PK=b.pk and b.id='ACCR0140' and a.del_if=0 and b.del_if=0 order by a.CODE ")%>; 
//        <%=ESysLib.SetGridColumnComboFormat("grdDeclList", 14, "select a.CODE,  a.CODE_NM from TCO_ABCODE a, TCO_ABCODEGRP b where TCO_ABCODEGRP_PK=b.pk and b.id='ACCR0020' and a.del_if=0 and b.del_if=0 order by a.CODE ")%>; 
        <%=ESysLib.SetGridColumnComboFormat("grdDeclList", 4, "select a.CODE,  a.CODE_NM from TCO_ABCODE a, TCO_ABCODEGRP b where TCO_ABCODEGRP_PK=b.pk and b.id='IEBD0020' and a.del_if=0 and b.del_if=0 order by a.CODE ")%>; 
     }   
              
     function OnSelect()
     {
        var code_data=new Array()
	    var ctrl = grdDeclList.GetGridControl();
	    var index, rowNo
    	
	    index =0;
	    rowNo = 0 ;
    	
	    if(ctrl.SelectedRows == 0)
        {
            return ;
        }
        rowNo=grdDeclList.row;
        code_data[0] = grdDeclList.GetGridData(rowNo , 0);
        
        window.returnValue = code_data; 
	    window.close();
     }
     //---------------------------------------------------------------------------------------------------------
     function BindingDataList()
     {   
         var data1 = "<%=ESysLib.SetListDataSQL("SELECT pk, PARTNER_NAME FROM TCO_company  where del_if=0")%>|-1|Select All";   
         var data2 = "<%=ESysLib.SetListDataSQL("select a.CODE,  a.CODE from TCO_ABCODE a, TCO_ABCODEGRP b where TCO_ABCODEGRP_PK=b.pk and b.id='ACAB0110' and a.del_if=0 and b.del_if=0 order by a.CODE")%>|ALL|Select All";  //currency 
         var data3 = "<%=ESysLib.SetListDataSQL("select a.CODE,  a.CODE from TCO_ABCODE a, TCO_ABCODEGRP b where TCO_ABCODEGRP_PK=b.pk and b.id='IEBD0020' and a.del_if=0 and b.del_if=0 order by a.CODE")%>|ALL|Select All";  
                          
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
    //---------------------------------------------------------------------------------------
    function SetGridFormat()
    {
        var ctr = grdDeclList.GetGridControl(); 
        ctr.ColFormat(10) = "#,###,###,###,###,###";
        ctr.ColFormat(11) = "#,###,###,###,###,###.##";
        ctr.ColFormat(12) = "#,###,###,###,###,###";
        
        var ctr = grdTotal.GetGridControl(); 
        ctr.ColFormat(2) = "#,###,###,###,###,###.##";
        ctr.ColFormat(3) = "#,###,###,###,###,###";
    }    
    //----------------------------------------------------------------------------
    function OnDataReceive(obj)
    {
        switch(obj.id)
        {
            case 'dat_epgd00020_1':
                dat_epgd00020_2.Call('SELECT');
            break;
            case 'dat_epgd00020_2':
                grdTotal.Subtotal(0,2,0,"3","",true,8,"Total");
            break;
        }        
    }
 </script>
 
<body>
    <!------------------------Get Contract List -------------------------------------->
<gw:data id="dat_epgd00020_1"  onreceive="OnDataReceive(this)" > 
    <xml> 
        <dso id="1" type="grid" parameter="0,2,8" function="imex.sp_sel_ex_declaration_inquiry"   procedure="imex.sp_upd_tim_decl_inquiry "> 
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
<gw:data id="dat_epgd00020_2"  onreceive="OnDataReceive(this)" > 
    <xml> 
        <dso id="1" type="grid" parameter="0,3,9" function="imex.sp_sel_ex_tot_decl_inquiry" > 
            <input bind="grdTotal">                    
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
                <td width="8%"><a title="Click here to select Vendor" onclick="openPopup(0)" href="#tips" style="text-decoration : none; color=#0000FF"><b>Vendor Name</b></a></td>
                <td width="1%"></td>
                <td width="10%"><gw:textbox id="txtCusCode"  text=""  styles='width:100%;' /><gw:textbox id="txtCusPK"  text=""  styles='display:none' /></td>
                <td width="30%" colspan="5" ><gw:textbox id="txtCusName"  text=""  styles='width:100%;' /></td>                                              
                <td width="5%" align="right"></td>
                <td width="2%" ></td>        
                <td width="2%"><gw:imgbtn id="btnSearch" img="search" alt="Search" text="Search" onclick="dat_epgd00020_1.Call('SELECT');" /></td>        
            </tr>
            <tr> 
                <td width="10%" nowrap>Register Date</td>
                <td width="8%"><gw:datebox id="dtFromDate" lang="1"  styles='width:100%;' onchange=""/></td>
                <td width="2%" align="center">~</td>
                <td width="17%"><gw:datebox id="dtToDate" lang="1"  styles='width:100%;' onchange=""/></td>
                <td width="2%"></td>
                <td width="10%">Trans Currency</td>
                <td width="1%"></td>
                <td width="15%"><gw:list id="cboCurrency" styles="width:100%;" ></gw:list></td>
                <td width="4%">/VND</td>
                <td width="2%"></td>
                <td width="8%"align="right">Closed Y/N</td>
                <td width="1%"></td>
                <td width="15%"><gw:list id="cboClosedYN" styles="width:100%;" >
                            <data>Data|All|Select All|Y|Yes|N|No </data>
                        </gw:list></td>
                <td></td>
                <td></td>
                <td></td>
            </tr>
            <tr>
                <td>Status</td>
                <td colspan="3">
                    <gw:radio id="radStatus" value="0" styles="width:100%" onchange="dat_epgd00020_1.Call('SELECT');"> 
                        <span value="1">Saved </span> 
                        <span value="2">Confirmed</span> 
                        <span value="3">Cancelled</span>
                        <span value="0">All</span> 
                    </gw:radio>
                </td>
                <td></td>
                <td>Declaration No</td>
                <td></td>
                <td><gw:textbox id="txtDeclNo"  text=""  styles='width:100%;'  /></td>
                <td></td>
                <td></td>
                <td align="right">Declaration Type</td>
                <td></td>
                <td><gw:list id="cboDeclType" styles="width:100%;" ></gw:list></td>
                <td></td>
                <td></td>
                <td></td>
            </tr>
            <tr>
                <td colspan="16" style='height:10;'>&nbsp;</td>
            </tr>
            <tr>
            <!--_Pk|No|Close Y/N|Customer|Decl. Type|Decl. No|Reg. Date|Import Date|Close Date|Trans. Curr|Ex. Rate|Trans. Amt|Booking Amt|Arrival Date|Pay Term|Payment Method|Description'->
                <td colspan="16">
                    <gw:grid id='grdDeclList'
                        header='_Pk|No|Close Y/N|Customer|Decl. Type|Decl. No|Reg. Date|Status|Export Date|Close Date|Trans. Curr|Ex. Rate|Trans. Amt|Booking Amt|Description'
                        format='0|0|3|0|2|0|4|0|4|4|0|0|0|0|0'
                        aligns='0|1|1|0|0|0|1|0|1|1|1|3|3|3|0'
                        defaults='||||||||||||||'
                        editcol='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                        widths='0|600|1200|2500|1500|1500|1200|1200|1200|1200|1500|1500|2000|2000|2000'
                        sorting='T'
                        styles='width:100%; height:300'
                        oncelldblclick="OnSelect()"
                        acceptNullDate='true'
                        styles='width:100%; height:300'
                    />
                </td>
            </tr>
            <tr>
                <td colspan="6"></td>
                <td colspan="10">
                    <gw:grid id='grdTotal'
                        header=' |Currency|Trans. Amt|Booking Amt'
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
