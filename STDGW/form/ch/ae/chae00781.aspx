<!-- #include file="../../../system/lib/form.inc"  -->
 <%  ESysLib.SetUser(Session("APP_DBUSER"))%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Untitled Page</title>
</head>
<script>
var rpt_no = 0;
var v_language = "<%=Session("SESSION_LANG")%>";
function BodyInit()
{
    idGrid.GetGridControl().ScrollTrack=true;
    if (v_language!="ENG")
        System.Translate(document);
    iduser_pk.text = "<%=session("USER_PK")%>";
     txtHr_level.text= "<%=session("HR_LEVEL")%>";
    menu_id.text=System.Menu.GetMenuID();
    <%=ESysLib.SetGridColumnComboFormat( "idGrid" , 3 , "select code,code_nm from vhr_hr_code where id='HR0009' order by code_nm " ) %>;  //từ code gọi code_name 
    idBtnSave.SetEnable(false);
    datCheck_View.Call();
}
function OnDataReceive(obj)
{

    if(obj.id == "datCheck_View")
       {
            if(txtFlag_View.text == 'Y')
            {
                idBtnNew.style.display = "none";
                idBtnSave.style.display = "none";
                idBtnDelete.style.display = "none";
            }		
        
       }
}

function OnSave()
{
    datTax_Detail.Call();   
}
function OnDel()
{
    if(confirm("Do you want to delete?\nBạn đã chắc chắn xóa?"))
        idGrid.DeleteRow();
    idBtnSave.SetEnable(true);
}
function OnSearch()
{
    idBtnSave.SetEnable(false);
    datTax_Detail.Call("SELECT");
}

function OnShowPopup(m)
{     
        var strcom;
        var fpath = System.RootURL + "/form/ch/ae/chae00010_org.aspx?";
        var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:no;status:no;dialogWidth:20;dialogHeight:20;dialogLeft:'+window.event.screenX+';dialogTop:'+window.event.screenY+';edge:sunken;scroll:yes;unadorned:yes;help:no');
		lstOrg_Code.value = obj;
       
}

function OnReport(obj)
{
	
    var url=System.RootURL; //khai báo + khởi tạo URL 
    rpt_no=obj;
	
	

		switch (obj)
		{
		
			case 1: //Summary Report
			{
				
			    //txtReport_tmp.text = "rpt_chae00781_employee_list_summary.aspx";
			    txtReport_tmp.text = "test_summary.aspx";
				break;
			}
			case 2: //Detail Report
			{
				txtReport_tmp.text="rpt_chae00781_employee_list.aspx";
				break;
			}
		    case 3: //Summary Report_Pay Slip
		        {
		            txtReport_tmp.text = "summary_rpt_salary_payslip_test.aspx";
		            break;
		        }
		    case 4: //Detail Report_Pay Slip
		        {
		            txtReport_tmp.text = "rpt_salary_payslip_test.aspx";
		            break;
		        }
		 
		}
		url=url + '/reports/ch/ae/'+txtReport_tmp.text+'?TCO_ORG_PK=' + lstOrg_Code.value + '&THR_WG_PK=' + lstGrp_Code.value + '&NATION=' + lst_nation.value;
		
		

		datTax_Detail.Call();
		window.open(url);    
    
    
    
}
//-----------------------------------------------
</script>
<body>
<gw:data id="datCheck_View" onreceive="OnDataReceive(this)"  > 
        <xml>
            <dso  type="process" procedure="sp_pro_check_view"  > 
                <input>
                    <input bind="iduser_pk" />
                    <input bind="menu_id" />
                </input> 
                <output>
                    <output bind="txtFlag_View" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<gw:data id="datTax_Detail" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid"  parameter="0,1,2,3,4,5,6,7" function="HR_SEL_CHAE00781_NATION" procedure="HR_UPD_CHAE00781_NATION"> 
                <input bind="idGrid" >
                   <input bind="lstOrg_Code" /> 
				   <input bind="lstGrp_Code" />
				   <input bind="lst_nation" />
                </input>
                <output  bind="idGrid" />
            </dso> 
        </xml> 
</gw:data>

    <table style="width:100%;height:100%" cellpadding="0" cellspacing="0" align="top" border="1" >
	    <tr style="height:5%;border:1">	
			<td width="9%" style="border:0;" align="right" >
                          <a title="Click here to show Organization" onclick="OnShowPopup(1)" href="#tips" >Oganization</a></td>
			<td width="20%" colspan=2 style="border:0;" align="left" >
                         <gw:list  id="lstOrg_Code" value='ALL' maxlen = "100" styles='width:100%'onchange="onChange_org()" > 
                            <data>
                                <%=ESysLib.SetListDataSQL("select a.pk,lpad('.',level*2-1,'.')|| a.org_nm from tco_org a  where a.del_if = 0 and (a.tco_company_pk=nvl('" + session("COMPANY_PK") + "',a.tco_company_pk) or '" + session("HR_LEVEL") + "'='6')  AND NVL(A.END_DATE,TO_CHAR(SYSDATE+1,'YYYYMMDD')) >  TO_CHAR(SYSDATE,'YYYYMMDD') connect by prior a.pk = a.p_pk start with nvl(a.p_pk,0)=0 order siblings by a.org_id")%>|ALL|Select All
                            </data>
                        </gw:list>
                        </td>
			<td width="11%" style="border:0;" align="right" >Work Group</td>
            <td width="20%" colspan=2 style="border:0;" align="left" >
						<gw:list  id="lstGrp_Code" value='ALL' maxlen = "100" styles='width:100%' >
                            <data>
								<%=ESysLib.SetListDataSQL("select a.PK,a.WORKGROUP_NM from thr_work_group a where a.del_if=0 order by a.WORKGROUP_NM")%>|ALL|Select All  
							</data>
							</gw:list>
                        </td>
		    <td width="11%" style="border:0;" align="right">Nation</td>
		    <td width="20%" colspan=2 style="border:0;" align="left" >
						<gw:list  id="lst_nation"  styles='width:100%' >
                            <data>
								<%=ESysLib.SetListDataSQL("select a.CODE,a.CODE_NM from vhr_hr_code a where a.id = 'HR0009' ORDER BY a.CODE")%>|ALL|Select All
							</data>
						</gw:list></td>
		    
		     <td align=right style="width:31%;border:1" ></td>
			 <td width="3%" style="border:1;" align="right" ><gw:imgBtn img="search" id="ibtnSearch"   alt="Search"  onclick="OnSearch()"/></td>
		    <td align=right style="width:3%;border:1" ><gw:imgBtn img="delete" id="idBtnDelete"  alt="Delete" onclick="OnDel()" /></td>
		    <td align=right style="width:3%;border:1" ><gw:imgBtn  img="save" id="idBtnSave" alt="Save" onclick="OnSave()" /></td>
			<td width="3%" style="border:0" align="right">
                         <gw:imgBtn img="excel" id="idBtnReport1"    alt="Summary Report"  onclick="OnReport(1)"/>
                        </td>
                        <td width="6%" style="border:0" align="right">
                         <gw:imgBtn img="excel" id="idBtnReport2"    alt="Detail Report"  onclick="OnReport(2)"/>
                        </td>
            <td width="3%" style="border:0" align="right">
                         <gw:imgBtn img="excel" id="idBtnReport3"    alt="Summary Report_Pay Slip"  onclick="OnReport(3)"/>
                        </td>
            <td width="3%" style="border:0" align="right">
                         <gw:imgBtn img="excel" id="idBtnReport4"    alt="Detail Report_Pay Slip"  onclick="OnReport(4)"/>
                        </td>
        </tr>	
		<tr style="height:95%">
			<td colspan=13  id="master" width="100%">
				<gw:grid
					id="idGrid"
					header="EMP_ID|FULL_NAME|SEX|NATION|TEL|_PK|JOIN_DT|BIRTH_DT"
					format="0|1|1|0|0|0|4|4"
					aligns="1|1|1|1|1|1|1|1"
					defaults="|||||||"
					editcol="0|0|0|0|0|0|0|0"
					widths="1500|3000|500|1500|3000|2000|3000|3000"
					styles="width:100%;height:100%"
					sorting="T"
					onafteredit=""
					oncellclick = ""
					acceptNullDate="T"
					oncelldblclick = ""/>
			</td>
		</tr>	
	</table>
<gw:textbox id="txtpk" styles="display:none"/>
    <gw:textbox id="txtfrom" styles="display:none"/>
    <gw:textbox id="txtto" styles="display:none"/>
    <gw:textbox id="txtflag" styles="display:none"/>
    <gw:textbox id="txtresult" styles="display:none"/>
    <gw:textbox id="menu_id" text="" styles="display:none"  />
<gw:textbox id="txtFlag_View" text="" styles="display:none"  />
<gw:textbox id="iduser_pk" styles="display:none"/>
<gw:textbox id="txtHr_level" styles="display:none"/>
<gw:textbox id="txtReport_tmp" styles="display:none"/>
</body>
</html>
