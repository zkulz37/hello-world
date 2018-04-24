<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml" >
<head >
    <title>Project Inquiry</title>
</head>
<%ESysLib.SetUser("acnt")%>
<script>
function BodyInit()
{
        System.Translate(document);
        BindingDataList(); 
}   
function BindingDataList()
{
        var ls_Company    = "<%=ESysLib.SetListDataSQL("SELECT PK, PARTNER_NAME FROM TCO_COMPANY WHERE DEL_IF=0")%>";
        lstCompany.SetDataText(ls_Company);
        lstCompany.value = "<%=session("company_pk") %>";  
        ls_Status = "<%=ESysLib.SetListDataFUNC("SELECT acnt.SF_A_GET_COMMONCODE('ACBG0010') FROM DUAL")%>";
        lstProject_Status.SetDataText(ls_Status); 
}    
function OnPopUp(obj)
{
        switch(obj)
        {
              
                case 'Customer':
                            var path = System.RootURL + '/form/gf/co/ffbp00031.aspx';
		                    var object = System.OpenModal( path ,800 , 600 , 'resizable:yes;status:yes');
		                    if ( object != null )
		                    {
		                        if (object[0] != 0)
                                {
                                        txtCustomer_Cd.SetDataText(object[1]);//customer id
                                        txtCustomer_Nm.SetDataText(object[2]);//customer name
                                        txtCustomer_Pk.SetDataText(object[0]);//customer name
      	                        }
      	                    }
                break;
                case 'PM':
                             var path = System.RootURL + '/form/ch/ae/chae00010_search_emp.aspx';
                            var obj = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
                            if ( obj != null )
                            {
                                txtPM_Pk.text   = obj[0];
				                txtPM_Cd.text   = obj[1];
				                txtPM_Nm.text = obj[2];
                            }
                break;
                case 'PC':
                             var path = System.RootURL + '/form/ch/ae/chae00010_search_emp.aspx';
                            var obj = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
                            if ( obj != null )
                            {
                                txtPC_Pk.text   = obj[0];
				                txtPC_Cd.text   = obj[1];
				                txtPC_Nm.text = obj[2];
                            }
                break;
				case 'Project':
                            var fpath = System.RootURL + "/form/kp/bp/kpbp00020_popup_Project.aspx";
                            var aValue = System.OpenModal( fpath , 700 , 600 , 'resizable:yes;status:yes;toolbar=no;location:no;directories:no;menubar:no;scrollbars:no;'); 
                            if(aValue != null)
                            {
                                    txtProject_Pk.text = aValue[0];
                                    txtProject_Cd.text = aValue[1];
                                    txtProject_Nm.text = aValue[2];  
                            } 
                break;
				case 'Exegroup':
					var path = System.RootURL + '/form/gf/os/gfos00070_popup_1.aspx?code=TPS0012';
					
					var obj = System.OpenModal( path ,850 , 600 ,  'resizable:yes;status:yes');
		 
					if ( obj != null )
					{
					   txtExecution_Division_Cd.text =obj[1];
					   txtExecution_Division_Nm.text =obj[2];
					}
				break;

        } 
}  
function OnSearch()
{
        dso_search.Call("SELECT");
}
</script>
<body>
 <gw:data id="dso_search" >
        <xml>
            <dso type="grid" function="ec111.sp_sel_kpbp00030" >
                <input bind="Grid_Detail">
                        <input bind="lstCompany"/>
                        <input bind="txtProject_Pk"/>
                        <input bind="txtCustomer_Pk"/>
                        <input bind="dtContractDt_Fr"/>
                        <input bind="dtContractDt_To"/>
                        <input bind="txtPM_Pk"/>
                        <input bind="txtPC_Pk"/>
                        <input bind="txtExecution_Division_Cd"/>
						<input bind="txtExecution_Division_Nm"/> 
                        <input bind="lstProject_Status"/>       
                </input>
                <output bind="Grid_Detail"/>
            </dso>
        </xml>
    </gw:data>
  <table style="width:100%;height:100%" cellpadding="0" cellspacing="0">
              <tr style="height:10%">
                            <td>
                                        <fieldset style="padding:0">
                                                    <table width="100%" cellpadding="0" cellspacing="0">
                                                                <tr>
                                                                            <td align="right" width="15%">Company&nbsp;</td>
                                                                            <td width="35%"><gw:list id="lstCompany"   styles='width:100%'></gw:list></td> 
                                                                            <td align="right" width="15%"><a title="Click here to show Project" href="#" style="text-decoration : none" onclick="OnPopUp('Project')">Project&nbsp;</a></td>
																			<td width="45%">
																					<table cellpadding="0" cellspacing="0" width="100%">
																							<tr>
																										<td width="40%"><gw:textbox id="txtProject_Cd" readonly="true" styles='width:100%' /></td>
																										<td width="60%"><gw:textbox id="txtProject_Nm" readonly="true" styles='width:100%' /></td> 
																										<td width=""><gw:textbox id="txtProject_Pk" styles='width:100%;display:none' /></td>  
																										<td ><gw:imgbtn id="btve2" img="reset" alt="Reset"  onclick="txtProject_Cd.text='';txtProject_Nm.text='';txtProject_Pk.text='';" /></td> 
																							</tr>
																					</table>
																			</td>  
                                                                           <td ><gw:imgbtn id="btve" img="search" alt="Search"  onclick="OnSearch()" /></td>   
                                                                </tr>
                                                                <tr>
                                                                            <td align="right" ><a title="Click here to show Customer" href="#" style="text-decoration:none" onclick="OnPopUp('Customer')">Customer&nbsp;</a></td> 
                                                                            <td >
                                                                                        <table cellpadding="0" cellspacing="0" width="100%">
                                                                                                <tr>
                                                                                                        <td width="40%"><gw:textbox id="txtCustomer_Cd" readonly="true" styles='width:100%' /></td>
                                                                                                        <td width="60%"><gw:textbox id="txtCustomer_Nm" readonly="true" styles='width:100%' /></td> 
                                                                                                        <td><gw:textbox id="txtCustomer_Pk" styles='width:100%;display:none' /></td>  
                                                                                                        <td ><gw:imgbtn id="btjv2" img="reset" alt="Reset"  onclick="txtCustomer_Cd.text='';txtCustomer_Nm.text='';txtCustomer_Pk.text='';" /></td>
                                                                                                        
                                                                                                </tr>
                                                                                        </table> 
                                                                            </td> 
                                                                            <td align="right">Main Contract Date&nbsp;</td> 
                                                                            <td>
                                                                                        <table cellpadding="0" cellspacing="0" width="">
                                                                                                <tr>
                                                                                                            <td width=""><gw:datebox id="dtContractDt_Fr" lang="1"  styles="width:100%" /></td> 
                                                                                                            <td align="center" width="">~</td> 
                                                                                                            <td width=""><gw:datebox id="dtContractDt_To" lang="1" styles="width:100%" /></td>  
                                                                                                </tr>
                                                                                        </table> 
                                                                            </td> 
                                                                </tr> 
                                                                <tr>
                                                                                <td align="right"><a title="Click here to show PM" href="#" style="text-decoration:none" onclick="OnPopUp('PM')">PM&nbsp;</a></td>
                                                                                <td>
                                                                                        <table cellpadding="0" cellspacing="0" width="100%">
                                                                                                <tr>
                                                                                                            <td width="40%"><gw:textbox id="txtPM_Cd" styles='width:100%' /></td> 
                                                                                                            <td width="60%"><gw:textbox id="txtPM_Nm" styles='width:100%' /></td>  
                                                                                                            <td ><gw:textbox id="txtPM_Pk" styles='width:100%;display:none' /></td>    
                                                                                                            <td ><gw:imgbtn id="btjhv2" img="reset" alt="Reset"  onclick="txtPM_Cd.text='';txtPM_Nm.text='';txtPM_Pk.text='';" /></td>
                                                                                                </tr>
                                                                                        </table> 
                                                                            </td> 
                                                                            <td align="right" width="20%"><a title="Click here to show PC" href="#" style="text-decoration:none" onclick="OnPopUp('PC')">PC&nbsp;</a></td>  
                                                                            <td>
                                                                                        <table cellpadding="0" cellspacing="0" width="100%">
                                                                                                <tr>
                                                                                                            <td width="40%"><gw:textbox id="txtPC_Cd" styles='width:100%' /></td>  
                                                                                                            <td width="60%"><gw:textbox id="txtPC_Nm" styles='width:100%' /></td>  
                                                                                                            <td ><gw:textbox id="txtPC_Pk" styles='width:100%;display:none' /></td>    
                                                                                                            <td ><gw:imgbtn id="btjhvhg2" img="reset" alt="Reset"  onclick="txtPC_Cd.text='';txtPC_Nm.text='';txtPC_Pk.text='';" /></td>
                                                                                                </tr>
                                                                                        </table> 
                                                                            </td>  
                                                                </tr> 
                                                                <tr>
                                                                            <td align="right"><a title="Click here to show Execution Group" href="#" style="text-decoration:none" onclick="OnPopUp('Exegroup')">Execution Group&nbsp;</a></td>
                                                                             <td>
                                                                                        <table cellpadding="0" cellspacing="0" width="100%">
                                                                                                <tr>
                                                                                                            <td width="40%"><gw:textbox id="txtExecution_Division_Cd" styles='width:100%' /></td>  
                                                                                                            <td width="60%"><gw:textbox id="txtExecution_Division_Nm" styles='width:100%' /></td>  
                                                                                                            <td ><gw:textbox id="txtExecution_Division_Pk" styles='width:100%;display:none' /></td>    
                                                                                                            <td ><gw:imgbtn id="btjhvh2" img="reset" alt="Reset"  onclick="txtExecution_Division_Cd.text='';txtExecution_Division_Nm.text='';txtExecution_Division_Pk.text='';" /></td>
                                                                                                </tr>
                                                                                        </table> 
                                                                            </td>  
                                                                            
                                                                            <td align="right" >Project Status&nbsp;</td> 
                                                                            <td ><gw:list id="lstProject_Status"   styles='width:100%' onchange="OnSearch()"></gw:list></td>  
                                                                </tr> 
                                                    </table>
                                        </fieldset>
                            </td>
              </tr>
              <tr style="height:90%">
                            <td>
                                        <gw:grid   
                                        id="Grid_Detail"  
                                        header="No|Code|Project Name|Representative Customer|Starting Date|End Date|Dept|PM|PC"   
                                        format  ="0|0|0|0|4|4|0|0|0"  
                                         aligns  ="1|0|0|0|1|1|0|0|0"  
                                        defaults="||||||||"  
                                        editcol ="0|0|0|0|0|0|0|0|0"  
                                        widths  ="500|1500|2500|2500|1300|1300|2500|2500|2500"  
                                        styles="width:100%; height:100%"   
                                        sorting="T"   
                                         /> 
                            </td>
              </tr>  
  </table>
</body>
</html>
