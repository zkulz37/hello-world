<!-- #include file="../../../system/lib/form.inc"  -->

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script>
<%  ESysLib.SetUser(Session("APP_DBUSER"))%>
var v_language = "<%=Session("SESSION_LANG")%>";
var lang= "<%=Session("Lang")%>";

var  user_pk   = "<%=Session("EMPLOYEE_PK")%>"  ;
var  user_name = "<%=Session("USER_NAME")%>"  ;
var  user_id = "<%=Session("USER_ID")%>"  ; 
var  dept_pk = "<%=Session("ORG_PK")%>"  ; 
var  emp_id = "<%=Session("EMP_ID")%>"  ; 

function BodyInit()
{
    BindingDataList(); 
    //txtEmpPK.text = emp_id;
    txtEmpIDSearch.text = emp_id;
    dso_chkr00120_check_role.Call();
}

function BindingDataList()
{
    idGridDomestic.GetGridControl().ColFormat(5)= "###,###,###,###,###"; 
    idGridDomestic.GetGridControl().ColFormat(6)= "###,###,###,###,###"; 
	
	idGridOversea.GetGridControl().ColFormat(5)= "###,###,###,###,###"; 
    idGridOversea.GetGridControl().ColFormat(6)= "###,###,###,###,###"; 
//    data = "<%=ESysLib.SetListDataSQL("SELECT CODE,CODE_NM FROM VHR_HR_CODE WHERE ID='HR0173' ORDER BY CODE_NM")%>|ALL|Select All";
//    lstTypeProgram.SetDataText(data);
//    lstTypeProgram.value = 'ALL';

//    data = "<%=ESysLib.SetListDataSQL("SELECT CODE,CODE_NM FROM VHR_HR_CODE WHERE ID='HR0010' and code in(173, 159, 166,167,164,165,55,162,163,177) ORDER BY CODE")%> |ALL|Select All";
//    lstJobClass.SetDataText(data);
//    lstJobClass.value = 'ALL';

//    data = "<%=ESysLib.SetListDataSQL("SELECT CODE,CODE_NM FROM VHR_HR_CODE WHERE ID='HR0008' and code in (40, 51, 55, 54) ORDER BY CODE")%> |ALL|Select All";
//    lstJobTitle.SetDataText(data);
//    lstJobTitle.value = 'ALL';
//    
//    data = "<%=ESysLib.SetListDataSQL("SELECT CODE,CODE_NM FROM VHR_HR_CODE WHERE ID='HR0078' ORDER BY CODE_NM")%> |ALL|Select All";
//    lstCategory.SetDataText(data);
//    lstCategory.value = 'ALL';

//    <%=ESysLib.SetGridColumnComboFormat( "idGridDomestic" , 1 , "SELECT CODE, CODE_NM FROM VHR_HR_CODE WHERE ID='HR0173' ORDER BY CODE_NM") %>;
//    <%=ESysLib.SetGridColumnComboFormat( "idGridDomestic" , 2 , "SELECT CODE, CODE_NM FROM VHR_HR_CODE WHERE ID='HR0010' and code in(173, 159, 166,167,164,165,55,162,163,177) ORDER BY CODE") %>;
//    <%=ESysLib.SetGridColumnComboFormat( "idGridDomestic" , 3 , "SELECT null, null from dual UNION ALL SELECT CODE, CODE_NM FROM VHR_HR_CODE WHERE ID='HR0008' and code in (40, 51, 55, 54)") %>;
//    <%=ESysLib.SetGridColumnComboFormat( "idGridDomestic" , 4 , "SELECT CODE, CODE_NM FROM VHR_HR_CODE WHERE ID='HR0078' ORDER BY CODE_NM") %>;
//    <%=ESysLib.SetGridColumnComboFormat( "idGridDomestic" , 5 , "SELECT CODE, CODE_NM FROM VHR_HR_CODE WHERE ID='HR0168' ORDER BY CODE") %>;
}

function OnDataReceive(obj)
{ 
    switch  (obj.id)
    {
        case 'dso_chkr00120_check_role':
            if (txtCount.text == '')
                document.getElementById('idSearch').style.display="none";
            
            dso_chkr00120.Call('SELECT');
        break;
        case 'dso_chkr00120':
            dso_chkr00120_1.Call('SELECT');
        break;
        case 'dso_chkr00120_1':
            idGridDomestic.Subtotal(1, 2, -1, '5-6');            
            idGridDomestic.GetGridControl().AutoSize(0, idGridDomestic.cols-1);
            dso_chkr00120_4.Call('SELECT');
        break;
        case 'dso_chkr00120_2':
            //dso_chkr00120_3.Call('SELECT');
        break;
		case 'dso_chkr00120_4':
            idGridOversea.Subtotal(1, 2, -1, '5-6');            
            idGridOversea.GetGridControl().AutoSize(0, idGridOversea.cols-1);
            dso_chkr00120_2.Call('SELECT');
        break;
		
    }
}

function OnShowPopup()
{
    var fpath = System.RootURL + "/form/ch/ae/chae00010_search_emp.aspx" ;
    var obj  = System.OpenModal(  fpath , 900 ,600, 'resizable:yes;status:yes;');
	if (obj!=null)
	{
	    txtEmpIDSearch.text=obj[1];
	    OnSearchData();
	}   
}

function OnSearchData()
{
    dso_chkr00120.Call('SELECT');
}

function OnPrint()
{
    if (txtEmpIDSearch.text != '')
    {
        var url = System.RootURL + '/reports/ch/kr/chkr00120.aspx?p_emp_pk=' + txtEmpPK.text + '&p_emp_id=' + txtEmpIDSearch.text;
        window.open(url);
    }
}

</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Mapping Course</title>
</head>
<body>

<gw:data id="dso_chkr00120_check_role" onreceive="OnDataReceive(this)"> 
    <xml> 
        <dso type="process" procedure="HR_CHKR10200006_check_role"> 
            <input> 
            	 <input bind="txtEmpIDSearch" />
            </input>
            <output>
                 <output bind="txtCount"/>
           </output> 
        </dso> 
    </xml> 
</gw:data>

<gw:data id="dso_chkr00120" onreceive="OnDataReceive(this)"> 
    <xml> 
        <dso id="3" type="control" function="HR_CHKR10200006_sel_120">
            <input>
                <inout bind="txtEmpIDSearch" />
                <inout bind="txtDept" />
                <inout bind="txtName" />
                <inout bind="txtTeam" />
                <inout bind="txtDOB" />
                <inout bind="txtJobTitle" />
                <inout bind="txtStatus" />
                <inout bind="txtJobClass" />
                <inout bind="txtTel" />
                <inout bind="txtJoinDate" />
                <inout bind="txtAddr" />
                <inout bind="txtJobGrade" />
                <inout bind="txtEmpPK" />
            </input>
        </dso>
    </xml>
</gw:data>
<gw:data id="dso_chkr00120_1" onreceive="OnDataReceive(this)"> 
	<xml> 
		<dso id="1" type="grid"  function="HR_CHKR10200006_sel_120_1">
			<input> 
				<input bind="txtEmpPK" />
			</input> 
			<output bind="idGridDomestic" /> 
		</dso> 
	</xml> 
</gw:data> 
<gw:data id="dso_chkr00120_4" onreceive="OnDataReceive(this)"> 
	<xml> 
		<dso id="1" type="grid"  function="HR_CHKR10200006_sel_120_4">
			<input> 
				<input bind="txtEmpPK" />
			</input> 
			<output bind="idGridOversea" /> 
		</dso> 
	</xml> 
</gw:data> 
<gw:data id="dso_chkr00120_2" onreceive="OnDataReceive(this)"> 
	<xml> 
		<dso id="1" type="grid"  function="HR_CHKR10200006_sel_120_2">
			<input> 
				<input bind="txtEmpPK" />
			</input> 
			<output bind="idGridDomesticDTL1" /> 
		</dso> 
	</xml> 
</gw:data> 
<gw:data id="dso_chkr00120_3" onreceive="OnDataReceive(this)"> 
	<xml> 
		<dso id="1" type="grid"  function="HR_CHKR10200006_sel_120">
			<input> 
				<input bind="txtEmpPK" />
			</input> 
			<output bind="idGridDomesticDTL2" /> 
		</dso> 
	</xml> 
</gw:data> 
<form id="form1" runat="server">
<table border=0 cellpadding=0 cellspacing=0 style="width:100%;height:100%">                                                                                                                                                                                             
    <tr>
        <td style="width:100%;height:2%">  
           <table border=0 width=100% cellpadding=0 cellspacing=0>
               <tr id="idSearch">
                    <td style="width:100%;height:1%"><fieldset style="padding: 5"><legend>Search</legend>
                        <table border=0 width=100% cellpadding=0 cellspacing=0>
                            <tr>
                                <td align = "center" width="10%"><a title="Click here to choose" onclick="OnShowPopup()" href="#tips" >Emp ID&nbsp;&nbsp;&nbsp;</a></td>
	                            <td align = "left" width="80%">
                                    <gw:textbox id="txtEmpIDSearch" styles="width:100%" onenterkey="OnSearchData()"/>
                                </td>
                                <td width="8%"></td>
                                <td width="1%"><gw:imgBtn id="btnSearch" img="search" alt="Search" onclick="OnSearchData()" /></td>	
                                <td width="1%"><gw:imgBtn id="btnPrint" img="excel" alt="Print" onclick="OnPrint()" /></td>	
                            </tr>
                        </table>
                    </fieldset>
                    </td>
				</tr>
               <tr>
                    <td style="width:100%;height:99%">
						<fieldset style="padding: 5">
						<legend>PERSONAL TRAINING RECORD</legend>
                        <table border=0 width=100% cellpadding=0 cellspacing=0>
                            <tr>
	                            <td align = "right" width="10%">Department&nbsp;&nbsp;&nbsp;</td>
	                            <td align = "left" width="40%">
                                    <gw:textbox id="txtDept" styles="width:100%" readonly  />
                                </td>
	                            <td align = "right" width="10%">Name&nbsp;&nbsp;&nbsp;</td>
	                            <td align = "left" width="40%">
                                    <gw:textbox id="txtName" styles="width:100%" readonly  />
                                </td>
                            </tr>
                            <tr>
	                            <td align = "right" width="10%">Team/Section&nbsp;&nbsp;&nbsp;</td>
	                            <td align = "left" width="40%">
                                    <gw:textbox id="txtTeam" styles="width:100%" readonly  />
                                </td>
	                            <td align = "right" width="10%">DOB&nbsp;&nbsp;&nbsp;</td>
	                            <td align = "left" width="40%">
                                    <gw:textbox id="txtDOB" styles="width:100%" readonly  />
                                </td>
                            </tr>
                            <tr>
	                            <td align = "right" width="10%">Job Position&nbsp;&nbsp;&nbsp;</td>
	                            <td align = "left" width="40%">
                                    <gw:textbox id="txtJobTitle" styles="width:100%" readonly  />
                                </td>
	                            <td align = "right" width="10%">Telephone&nbsp;&nbsp;&nbsp;</td>
	                            <td align = "left" width="40%">
                                    <gw:textbox id="txtTel" styles="width:100%" readonly  />
                                </td>
                            </tr>
                            <tr>
	                            <td align = "right" width="10%">Job Title&nbsp;&nbsp;&nbsp;</td>
	                            <td align = "left" width="40%">
                                    <gw:textbox id="txtJobClass" styles="width:100%" readonly  />
                                </td>
	                            <td align = "right" width="10%">Permanent Address&nbsp;&nbsp;&nbsp;</td>
	                            <td align = "left" width="40%">
                                    <gw:textbox id="txtAddr" styles="width:100%" readonly  />
                                </td>
                            </tr>
                            <tr>
	                            <td align = "right" width="10%">Join Date&nbsp;&nbsp;&nbsp;</td>
	                            <td align = "left" width="40%">
                                    <gw:textbox id="txtJoinDate" styles="width:100%" readonly  />
                                </td>
	                            <td align = "right" width="10%">Status&nbsp;&nbsp;&nbsp;</td>
	                            <td align = "left" width="40%">
                                    <gw:textbox id="txtStatus" styles="width:100%" readonly  />
                                </td>
                            </tr>
                            
                            <tr>
	                            <td align = "right" width="10%">Job Grade&nbsp;&nbsp;&nbsp;</td>
	                            <td align = "left" width="40%">
	                                <gw:textbox id="txtJobGrade" styles="width:100%" readonly  /> 
                                </td>
	                            <td align = "right" width="10%">&nbsp;&nbsp;&nbsp;</td>
	                            <td align = "left" width="40%"> &nbsp;
                                </td>
                            </tr>
                        </table>
						</fieldset>
					</td>
               </tr>
           </table>        
        </td>
    </tr>
    <tr>
        <td id="td_Master" style="width:100%;height:35%">  
            <table border=1 style="width:100%;height:100%" cellpadding=0 cellspacing=0>
                <tr>
                    <td align="left" style="height:1%">Domestic training</td>
                </tr>
                <tr>
                    <td style="height:99%">
                        <gw:grid   
                        id="idGridDomestic" 
                        header="Category|Train Type|Course Name|From|To|Complete Hour|Cost|Institution|Score|Rank"
                        format="0|0|0|0|0|0|0|0|0|0"
                        aligns="0|0|0|0|0|3|3|0|0|0"
                        defaults="|||||||||"
                        editcol="0|0|0|0|0|0|0|0|0|0"
                        widths="0|0|0|0|0|0|0|0|0|0"
                        styles="width:100%; height:100%"   
                        acceptNullDate="T"
                        autosize="true"
                        debug="false"
                        sorting="T"/>
                    </td>
                </tr>
            </table>
        </td>
    </tr>   
	<tr>
        <td id="td_Master" style="width:100%;height:35%">  
            <table border=1 style="width:100%;height:100%" cellpadding=0 cellspacing=0>
                <tr>
                    <td align="left" style="height:1%">Overseas training</td>
                </tr>
                <tr>
                    <td style="height:99%">
                        <gw:grid   
                        id="idGridOversea" 
                        header="Category|Train Type|Course Name|From|To|Complete Hour|Cost|Institution|Score|Rank"
                        format="0|0|0|0|0|0|0|0|0|0"
                        aligns="0|0|0|0|0|3|3|0|0|0"
                        defaults="|||||||||"
                        editcol="0|0|0|0|0|0|0|0|0|0"
                        widths="0|0|0|0|0|0|0|0|0|0"
                        styles="width:100%; height:100%"   
                        acceptNullDate="T"
                        autosize="true"
                        debug="false"
                        sorting="T"/>
                    </td>
                </tr>
            </table>
        </td>
    </tr>    
    <tr>
        <td id="td1" style="width:100%;height:28%">    
            <table border=1 style="width:100%;height:100%" cellpadding=0 cellspacing=0>
                <tr>
                    <td align="left" style="width:100%;height:1%">Reference: Essential Training Program</td>
                    <td align="left" style="width:0%;height:1%; display:none">Encouraging training program</td>
                </tr>
                <tr>
                    <td style="width:100%;height:99%">       
                          <gw:grid   
                            id="idGridDomesticDTL1" 
                            header="Category|Train Type"
                            format="0|0"
                            aligns="0|0"
                            defaults="|"
                            editcol="0|0"
                            widths="0|0"
                            styles="width:100%; height:100%"   
                            acceptNullDate="T"
                            autosize="false"
                            debug="false"
                            sorting="T"/>
                    </td>
                    <td style="width:0%;height:99%; display:none">  
                          <gw:grid   
                            id="idGridDomesticDTL2" 
                            header="Category|Train Type"
                            format="0|0"
                            aligns="0|0"
                            defaults="|"
                            editcol="0|0"
                            widths="0|0"
                            styles="width:100%; height:100%"   
                            acceptNullDate="T"
                            autosize="false"
                            debug="false"
                            sorting="T"/>
                    </td>
                </tr>
            </table>
        </td>
    </tr>

</table>   
</form>
</body>
</html>

<gw:textbox id="txtEmpPK" styles="display:none" />
<gw:textbox id="txtCount" styles="display:none" />