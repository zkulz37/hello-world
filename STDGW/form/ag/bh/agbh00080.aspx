<!-- #include file="../../../system/lib/form.inc"  -->
 <% ESysLib.SetUser(Session("APP_DBUSER"))%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Untitled Page</title>
</head>
<script>

var v_language = "<%=Session("SESSION_LANG")%>";
function BodyInit()
{   
   
    if (v_language!="ENG")
        System.Translate(document);	
   txtUser_PK.text= "<%=session("USER_PK")%>";
   txtClientDB.text = "<%=Session("APP_DBUSER")%>";
   datHR_LEVEL.Call("SELECT");
}

function OnDataReceive(obj)
{
    if(obj.id=="datHR_LEVEL2")
    {
        for(var i=1;i<idGrid2.rows;i++)
        {
            idGrid2.SetGridData(i,8,txtUser_PK);
            idGrid2.SetRowStatus(i,0);
        }
		datEapprove_auth.Call("SELECT");
    }
    if(obj.id=="datHR_LEVEL")
	{
		datSalary_security.Call("SELECT");
	}
    if(obj.id=="datSalary_security")
	{
	}
}
function onClick_M()
{
    txtUser_PK.text=idGrid1.GetGridData(event.row,4);
    datHR_LEVEL2.Call("SELECT");
}
function OnSave(n)
{
    if(confirm("Do you want to save?\nBạn muốn save?"))
	{
		if(n==1)
            datHR_LEVEL2.Call();
	    else if(n==4)
            datEapprove_auth.Call();
        else   
            datSalary_security.Call();
	}
        
}
function OnSearch1()
{
    idGrid1.ClearData();
    idGrid2.ClearData();
    datHR_LEVEL.Call("SELECT");
    
}
function OnSearch2()
{
    idGrid2.ClearData();
    datHR_LEVEL2.Call("SELECT");
    
}
function OnSearch3()
{
    idGrid3.ClearData();
    datSalary_security.Call("SELECT");
}
function OnSearch4()
{
    idGrid4.ClearData();
    datEapprove_auth.Call("SELECT");
}
</script>

<body>
<!------------main control---------------------->
<gw:data id="datHR_LEVEL" onreceive="OnDataReceive(this)"  > 
        <xml>
            <dso  type="grid" parameter="0" function="HR_SEL_80020007_HR_LEVEL"> 
                <input bind="idGrid1">
                    <input bind="txtUser_PK" /> 
					<input bind="txtClientDB" /> 
					<input bind="lstTemp1" /> 
					<input bind="txtTemp1" /> 
                </input> 
                <output bind="idGrid1" />
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datHR_LEVEL2" onreceive="OnDataReceive(this)"  > 
        <xml>
            <dso  type="grid" parameter="0,7,8" function="HR_SEL_80020007_HR_LEVEL2" procedure="HR_UPD_80020007_HR_LEVEL2"> 
                <input bind="idGrid2">
                    <input bind="txtUser_PK" /> 
					<input bind="lstOrg_Code" /> 
                </input> 
                <output bind="idGrid2" />
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datSalary_security" onreceive="OnDataReceive(this)"  > 
        <xml>
            <dso  type="grid" parameter="4,5,6,7" function="HR_SEL_80020007_HR_SAL_SEC" procedure="HR_UPD_80020007_HR_SAL_SEC"> 
                <input bind="idGrid3">
                    <input bind="txtUser_PK" /> 
					<input bind="txtClientDB" /> 
					<input bind="lstTemp2" /> 
					<input bind="txtTemp2" /> 
                </input> 
                <output bind="idGrid3" />
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datEapprove_auth" onreceive="OnDataReceive(this)"  > 
	<xml>
		<dso  type="grid" parameter="0,3,4,5,6" function="HR_SEL_80020007_HR_EPP_SEC" procedure="HR_UPD_80020007_HR_EPP_SEC"> 
			<input bind="idGrid4">
				<input bind="txtUser_PK" /> 
				<input bind="lstOrg_Code2" /> 
			</input> 
			<output bind="idGrid4" />
		</dso> 
	</xml> 
</gw:data>
<!--------------------main table--------------------------------->
<table style="width:100%;height:100%" cellpadding="0" cellspacing="0" align="top" border="1" >
	<tr>
	    <td width="50%">
	    <table id="tblMain" style="width:100%;height:100%" border=1 cellpadding="0" cellspacing="0">
				<tr style="width:100%;height:5%">
					<td style="border:0;">
					<table id="tblMain" style="width:100%;height:100%" border=1 cellpadding="0" cellspacing="0">
						<tr style="width:100%;height:5%">
							<td width="13%" style="border:0;" align="right" >Search by</td>
							<td width="13%" style="border:0">
								<gw:list  id="lstTemp1" value="2" styles='width:100%' onchange=""> 
							        <data>LIST|1|Name|2|Emp ID|3|User ID</data> 
								</gw:list>
							</td>
							<td width="13%" align=right style="border:0"> 
								<gw:textbox id="txtTemp1" onenterkey="OnSearch()" styles="width:95%"/>
							</td>
							<td width="10%" style="border:0;" align="left" >
								<gw:imgBtn img="search" id="ibtnSearch1"   alt="search"  onclick="OnSearch1()"/>
							</td>
						</tr>
					</table>
					</td>
				</tr>
				<tr style="width:100%;height:25%">
	                <td  id="tdMaster" style="width:100%">
	                    <gw:grid   
				        id="idGrid1"  
				        header="User ID|Full Name|Emp ID|Department|_PK"   
				        format="0|0|0|0|0"  
				        aligns="0|0|0|0|0"  
				        defaults="||||"  
				        editcol="0|0|0|0|0"  
				        widths="1000|3000|1000|2000|0"  
				        styles="width:100%; height:100% "   
				        sorting="T"   
				        oncellclick     = "onClick_M()"/>
	                </td>
	            </tr>
				<tr style="width:100%;height:5%">
					<td style="border:0;">
					<table id="tblMain" style="width:100%;height:100%" border=1 cellpadding="0" cellspacing="0">
						<tr style="width:100%;height:5%">
							<td width="5%" style="border:0;" align="center" ></td>
							<td width="25%" style="border:0">
								<gw:list  id="lstOrg_Code" value='ALL' maxlen = "100" styles='width:100%'onchange="onChange_org()" >
									<data>
										<%=ESysLib.SetListDataSQL("select a.pk,lpad('.',level*2-1,'.')|| a.org_nm from tco_org a  where a.del_if = 0 and (a.tco_company_pk=nvl('" + session("COMPANY_PK") + "',a.tco_company_pk) or '" + session("HR_LEVEL") + "'='6')  AND NVL(A.END_DATE,TO_CHAR(SYSDATE+1,'YYYYMMDD')) >  TO_CHAR(SYSDATE,'YYYYMMDD') connect by prior a.pk = a.p_pk start with nvl(a.p_pk,0)=0 order siblings by a.org_id")%>|ALL|All Department
									</data>
								</gw:list>
							</td>
							<td width="10%" style="border:0;" align="center" >
								<gw:imgBtn img="search" id="ibtnSearch2"   alt="search"  onclick="OnSearch2()"/>
							</td>
							<td style="border:0;" width="20%" align="center" ><gw:imgBtn id="ibtnSave" alt="Save" img="save" text="Save" onclick="OnSave(1)" /></td>
						</tr>
					</table>
					</td>
				</tr>
				<tr style="width:100%;height:65%">
	                <td id="td2" style="width:100%">
						<gw:grid   
                        id="idGrid2"  
                        header="Select|Department ID|Department Name|Type|Start Date|End Date|Remark|_dept_pk|_emp_pk"   
                        format="3|0|0|0|0|0|0|0|0"  
                        aligns="0|0|0|0|0|0|0|0|0"  
                        defaults="||||||||"  
                        editcol="0|0|0|0|0|0|0|0|0"  
                        widths="1000|1500|3000|1500|1200|1200|1200|1000|0"  
                        styles="width:100%; height:100%"   
                        sorting="T"   
                        param="0,1,2,3,4,5,6,7,8" />
	                </td>
	            </tr>  
	       </table>
	    </td>
	    <td width=50%>
			<gw:tab id="tabMain"  border=1 style="width:100%;height:100%;" onpageactivate="onPageActive()"  >   
				<table name="Salary auth" id="Table1" style="width:100%;height:100%" border=1 cellpadding="0" cellspacing="0">
					<tr style="width:100%;height:5%">
						<td style="border:0;">
						<table id="tblMain" style="width:100%;height:100%" border=1 cellpadding="0" cellspacing="0">
							<tr style="width:100%;height:5%">
								<td width="13%" style="border:0;" align="right" >Search by</td>
								<td width="13%" style="border:0">
									<gw:list  id="lstTemp2" value="2" styles='width:100%' onchange=""> 
										<data>LIST|1|Name|2|Emp ID|3|User ID</data> 
									</gw:list>
								</td>
								<td width="13%" align=right style="border:0"> 
									<gw:textbox id="txtTemp2" onenterkey="OnSearch()" styles="width:95%"/>
								</td>
								<td width="10%" style="border:0;" align="left" >
									<gw:imgBtn img="search" id="ibtnSearch3"   alt="search"  onclick="OnSearch3()"/>
								</td>
								<td style="border:0;" width="20%" align="center" ><gw:imgBtn id="ibtnSave2" alt="Save" img="save" text="Save" onclick="OnSave(2)" /></td>
							</tr>
						</table>
						</td>
					</tr>
					<tr style="width:100%;height:95%">
						<td id="td1" style="width:100%">
							<gw:grid   
							id="idGrid3"  
							header="User ID|Full Name|Emp ID|Department|Salary Control|E-App Self YN|_PK|_THR_EMP_PK"   
							format="0|0|0|0|3|3|0|0"  
							aligns="0|0|0|0|0|0|0|0"  
							defaults="|||||0|0|0"  
							editcol="0|0|0|0|1|1|0|0"  
							widths="1000|2000|1000|3000|1500|1800|0|0"  
							styles="width:100%; height:100% "   
							sorting="T"   
							oncellclick     = ""/>
						</td>
					</tr>
				</table>
				<table name="E-approve auth" id="Table1" style="width:100%;height:100%" border=1 cellpadding="0" cellspacing="0">
					<tr style="width:100%;height:5%">
						<td style="border:0;">
							<table id="tblMain" style="width:100%;height:100%" border=1 cellpadding="0" cellspacing="0">
								<tr style="width:100%;height:5%">
									<td width="5%" style="border:0;" align="center" ></td>
									<td width="25%" style="border:0">
										<gw:list  id="lstOrg_Code2" value='ALL' maxlen = "100" styles='width:100%'onchange="onChange_org()" >
											<data>
												<%=ESysLib.SetListDataSQL("select a.pk,lpad('.',level*2-1,'.')|| a.org_nm from tco_org a  where a.del_if = 0 and (a.tco_company_pk=nvl('" + session("COMPANY_PK") + "',a.tco_company_pk) or '" + session("HR_LEVEL") + "'='6')  AND NVL(A.END_DATE,TO_CHAR(SYSDATE+1,'YYYYMMDD')) >  TO_CHAR(SYSDATE,'YYYYMMDD') connect by prior a.pk = a.p_pk start with nvl(a.p_pk,0)=0 order siblings by a.org_id")%>|ALL|All Department
											</data>
										</gw:list>
									</td>
									<td width="10%" style="border:0;" align="center" >
										<gw:imgBtn img="search" id="ibtnSearch4"   alt="search"  onclick="OnSearch4()"/>
									</td>
									<td style="border:0;" width="20%" align="center" ><gw:imgBtn id="ibtnSave4" alt="Save" img="save" text="Save" onclick="OnSave(4)" /></td>
								</tr>
							</table>
						</td>
					</tr>
					<tr style="width:100%;height:95%">
						<td id="td2" style="width:100%">
						<gw:grid   
                        id="idGrid4"  
                        header="Select|Department ID|Department Name|Remark|_user_pk|_dept_pk|_emp_pk"   
                        format="3|0|0|0|0|0|0"  
                        aligns="0|0|0|0|0|0|0"  
                        defaults="||||||"  
                        editcol="0|0|0|0|0|0|0"  
                        widths="1000|1500|3000|1500|1200|1200|1200"  
                        styles="width:100%; height:100%"   
                        sorting="T"   
                        param="0,3,4,5,6" />
	                </td>
					</tr>
				</table>
			</gw:tab>  
	    </td>
	</tr>
</table>
<gw:textbox id="txtUser_PK" styles="display:none"/>
<gw:textbox id="txtClientDB" text="" style="display: none" />
</body>
</html>

