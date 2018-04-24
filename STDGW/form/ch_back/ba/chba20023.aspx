<!-- #include file="../../../system/lib/form.inc"  -->
 <% ESysLib.SetUser(Session("APP_DBUSER"))%>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Terminal Info</title>
</head>
<script>      

function BodyInit()
{
    grid.GetGridControl().FrozenCols = 4;
    grid.GetGridControl().ScrollTrack = true;
    ChangeColorItem(lstOrg.GetControl());


}

//-----------------------------------------------
function ChangeColorItem(lstctl) {
    var slevel1, slevel2, slevel3, slevel4;
    for (var i = 0; i < lstctl.options.length; i++) {
        slevel1 = lstctl.options.item(i).text.substr(0, 1);
        slevel2 = lstctl.options.item(i).text.substr(0, 3);
        slevel3 = lstctl.options.item(i).text.substr(0, 5);
        slevel4 = lstctl.options.item(i).text.substr(0, 7);
        if (slevel4 != ".......") {
            if (slevel3 == ".....") {
                lstctl.options.item(i).style.color = "0066CC";
            }
            else {
                if (slevel2 == "...") {
                    lstctl.options.item(i).style.color = "FF4500";
                }
                else {
                    if (slevel1 == ".")
                        lstctl.options.item(i).style.color = "FF00FF";  //FF3333
                }
            }
        }
    }
}

//---------------------------------------------------------------------------
function OnDataReceive(obj) 
{
    if (obj.id == "datTerminal_Info") {
        lblRecord.text = grid.rows - 1 + " record(s).";
        
    }

}
//----------------------------------------------------
function OnSearch() {
    datTerminal_Info.Call("SELECT");
}
//------------------------------------------------
function OnReport() {
    var url = System.RootURL;
    url = url + '/reports/ch/ba/rpt_terminal_info.aspx?l_org_pk=' + lstOrg.value + '&l_group=' + lstWGroup.value + '&l_nation=' + lstNation.value
        + '&l_search_by=' + lstTemp.value + '&l_search_temp=' + txtTemp.text + '&l_date=' + dtDate.value + '&l_emp_type=' + lstEmpType.value+ '&l_thr_ws_pk=' + lstWShift.value; 
    window.open(url); 
}


function OnShowPopup()
{
    var strcom;
    var fpath = System.RootURL + "/form/ch/ae/chae00010_org.aspx?";
    var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:no;status:no;dialogWidth:25;dialogHeight:25;dialogLeft:10;dialogTop:240;edge:sunken;scroll:yes;unadorned:yes;help:no');
    if (obj!=null)
    {
        lstOrg.value=obj;
    }
    
}

</script>
<body >
<!-------------------data control----------------------->
<gw:data id="datTerminal_Info" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid"  function="HR_sel_terminal_data" > 
                <input bind="grid" >
                    <input bind="lstOrg" />
                    <input bind="lstWGroup" />
                    <input bind="lstNation" />
                    <input bind="lstTemp" />
                    <input bind="txtTemp" />
                    <input bind="dtDate" />
                    <input bind="lstEmpType"/>
                    <input bind="lstWShift"/>
                    
                </input>
                <output  bind="grid" />
                
            </dso> 
        </xml> 
</gw:data>

   <table width="100%" cellpadding="0" cellspacing="0" border=1 style="width:100%;height:100%;">
        <tr style="width:100%;height:0%" valign="top" >
            			<td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td>
						<td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td>
						<td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td>
						<td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td>
						<td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td>
						<td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td>
						<td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td>
						<td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td>
						<td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td>
						<td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td>
					</tr>	
					<tr style="border:0;width:100%;height:5%" valign="center" >
                        <td colspan=5 width="10%" align="right" style="border:0;"><a title="Click here to show Organization" onclick="OnShowPopup()" href="#tips" >Organization</a>                  
                        </td>
                        <td colspan=10 width="20%"  align="left" style="border:0;">
                         <gw:list  id="lstOrg" value='ALL' styles='width:100%' onchange="" >
                            <data>
                                <%=ESysLib.SetListDataSQL("select a.pk,lpad('.',level*2-1,'.')|| a.org_nm from tco_org a  where a.del_if = 0 and (a.tco_company_pk=nvl('" + Session("COMPANY_PK") + "',a.tco_company_pk) or '" + Session("HR_LEVEL") + "'='6')  AND NVL(A.END_DATE,TO_CHAR(SYSDATE+1,'YYYYMMDD')) >  TO_CHAR(SYSDATE,'YYYYMMDD') connect by prior a.pk = a.p_pk start with nvl(a.p_pk,0)=0 order siblings by a.org_id")%>|ALL|Select All
                            </data>
                        </gw:list>
                        </td>
                        <td colspan=5 width="8%" align="right" style="border:0;" >W-Group</td>
                        <td colspan=8 width="16%"  align="left" style="border:0;" >
                            <gw:list  id="lstWGroup" value='ALL' maxlen = "100" styles="width:100%" >
                                <data><%=Esyslib.SetListDataSQL("SELECT pk,workgroup_NM FROM Thr_work_Group WHERE DEL_IF = 0 order by workgroup_id" )%>|ALL|Select All</data></gw:list>
                        </td>
                        <td colspan="8" style="border:0;" align="right">Work Date </td>
				        <td colspan="10" style="border:0;"><gw:datebox id="dtDate" styles="width:100%" lang="<%=Session("Lang")%>" /></td>
				        <td colspan=2 width="4%" style="border:0;" align="left"><gw:imgBtn img="search" id="idBtnSearch" alt="Search" styles='width:100%' onclick="OnSearch()" /></td>
						<td colspan=2 width="4%" style="border:0;" align="right"><gw:imgBtn img="excel" id="idBtnReport" alt="Report" styles='width:100%' onclick="OnReport()" /></td>
                    </tr>					
                    <tr style="border:0;width:100%;height:5%" valign="center" >
                        <td colspan=5 width="10%" align="right" style="border:0;">Nation</td>
                        <td colspan=10 width="20%"  align="left" style="border:0;">
                         <gw:list  id="lstNation" value='ALL' styles='width:100%' onchange="" >
                            <data>
                                <%=Esyslib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0009' order by code_nm" )%>|ALL|Select All
                            </data>
                        </gw:list>
                        </td>
                        <td colspan=5 width="8%" align="right" style="border:0;" >Search by</td>
                        <td colspan=4 width="16%"  align="left" style="border:0;" >
                            <gw:list  id="lstTemp" value='2' maxlen = "100" styles="width:100%" >
                                <data>LIST|1|Name|2|Emp ID|3|Card ID</data></gw:list>
                        </td>
                        <td colspan=4 width="13%" align=right style="border:0"> 
					        <gw:textbox id="txtTemp" onenterkey   ="OnSearch()" styles="width:95%"/>
				        </td>
                        <td colspan="8" style="border:0;" align="right">Employee Type </td>
				        <td colspan="5" style="border:0;">
                            <gw:list  id="lstEmpType" value='ALL' maxlen = "100" styles='width:100%' >
                                <data><%= ESysLib.SetListDataSQL("select  V.CHAR_4 , V.CODE_NM, max(V.NUM_1)  from vhr_hr_code v where v.id='HR0180' and V.CHAR_1='HR0017' group by V.CODE_NM, V.CHAR_4   union all select CODE, CODE_NM, NUM_1  from vhr_hr_code  where id='HR0017' order by 3")%>|ALL|Select All</data>
                            </gw:list></td>
				        <td colspan=6 width="13%" align=right style="border:0"> 
					        <gw:label id="lblRecord"  text="0 record(s)." maxlen = "100" styles="color:red;width:100%;font-weight: bold;font-size:13" />
				        </td>
                    </tr>	
                    <tr style="border:0;width:100%;height:5%" valign="center" >
                        <td colspan=5 width="10%" align="right" style="border:0;">W-Shift</td>
                        <td colspan=23 width="20%"  align="left" style="border:0;">
                         <gw:list  id="lstWShift" value='ALL' styles='width:100%' onchange="" >
                            <data>
                                <%=Esyslib.SetListDataSQL("select s.pk,s.shift||'-'||s.remark from thr_work_shift s where s.del_if=0 and s.use_yn='Y'" )%>|ALL|Select All
                            </data>
                        </gw:list>
                        </td>
                        <td colspan=22 width="10%" align="right" style="border:0;">&nbsp;</td>
                    </tr>	
					<tr style="border:1;width:100%;height:90%" valign="top">
                        <td colspan=50 style="width:100%;height:100%;"> 
                            <table width="100%" id="tblMaster" style="height:100%" border=1 cellpadding="0" cellspacing="0">
                                <tr style="border:1;width:100%;height:80%" valign="top">
                                      
									  <td id="td_chart2" width=0%  align=center>
									  
									  <gw:grid   
                                        id="grid"  
                                        header="Organization|Work Group|Employee ID|Full Name|W/S|_Work Date|Time 1|Time 2|Time 3|Time 4|Time 5|Time 6|Time 7|Time 8|Time 9|Time 10|Time 11|Time 12|Time 13|Time 14|Time 15|Time 16|Time 17|Time 18|Time 19|Time 20"
                                        format="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
                                        aligns="0|0|0|0|0|0|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1"
                                        defaults="||||||||||||||||||||||||||"
                                        editcol="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
                                        widths="1500|1000|1000|2500|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000"
                                        styles="width:100%; height:100%" 
								        acceptNullDate="T"
										autosize="true"
                                        sorting="T"    
										oncellclick="" 
										onafteredit=""
                                        /> 
										
									  </td>
                                 </tr>
								 
								 
                             </table>
                             
                        </td>
                    </tr>
				</table>
          
	

</body>
<gw:textbox id="txtDeptData" styles="display:none"/>
<gw:textbox id="txtUpperDept" styles="display:none"/>
<gw:textbox id="txtUpperDept_1" styles="display:none"/>
<gw:textbox id="txtGroupData" styles="display:none"/>
<gw:textbox id="iduser_pk" styles="display:none"/>
<gw:textbox id="txtReport_tmp" styles="display:none"/>
<gw:textbox id="txtHr_level" styles="display:none"/>
<gw:textbox id="txtEmp_PK" styles="display:none"/>
<gw:textbox id="txtTimes" styles="display:none"/>
<gw:textbox id="txtCompany_pk" text="" styles="display:none"  />
<gw:textbox id="menu_id" text="" styles="display:none"  />
<gw:textbox id="txtvalue" text="-1" styles="display:none"  />
<gw:textbox id="txtcol" text="-1" styles="display:none"  />
<gw:textbox id="txtmonth" text="-1" styles="display:none"  />
<gw:textbox id="txtFlag_View" text="" styles="display:none"  /> 
</html>
