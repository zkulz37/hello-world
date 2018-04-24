<!-- #include file="../../../system/lib/form.inc"  -->
 <% ESysLib.SetUser(Session("APP_DBUSER"))%>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Untitled Page</title>
</head>
<script>
var binit=true;
var user;
//'Work Group|Detail Regulation|Emp ID|Full Name|_Social No|Condition|Average Salary|Social Date|Days|Progressive|Amount
//|From Date|To Date|Remark|_PK|Payment|Payment Date|Modidy by hand'
var g_workgroup = 0;
    g_detail_regulation = 1;
    g_emp_id = 2;
    g_full_name =3;
    g_social_no = 4;
    g_condition =5 ;
    g_average_sal = 6;
    g_social_dt = 7;
    g_days = 8;
    g_progressive = 9;
    g_amount = 10;
    g_from_dt = 11;
    g_to_dt = 12;
    g_remark =13;
    g_pk = 14;
    g_payment = 15;
    g_payment_dt = 16;
    g_by_hand = 17;
    g_ins_month = 18;
	var g_select =0;

var v_language = "<%=Session("SESSION_LANG")%>";
function BodyInit()
{
   grdRegulation.GetGridControl().FrozenCols =4;
   grdRegulation.GetGridControl().ScrollTrack=true;
   iduser_pk.text = "<%=session("USER_PK")%>";
   txtHr_level.text= "<%=session("HR_LEVEL")%>";
   user="<%=session("USER_ID")%>";
   menu_id.text=System.Menu.GetMenuID();
   var data = "<%=ESysLib.SetGridColumnDataSQL(" select 'Y','Yes' from dual union all select 'N','No' from dual " ) %> ";       
    grdRegulation.SetComboFormat(g_payment,data);

    ChangeColorItem(lstOrg.GetControl());

   datCheck_View.Call();

   
   
}


//-----------------------------------------------
 function ChangeColorItem(lstctl) 
 {
        var slevel1, slevel2, slevel3,slevel4;
        for (var i = 0; i < lstctl.options.length; i++)
        {
            slevel1 = lstctl.options.item(i).text.substr(0, 1);
            slevel2 = lstctl.options.item(i).text.substr(0, 3);
            slevel3 = lstctl.options.item(i).text.substr(0, 5);
            slevel4 = lstctl.options.item(i).text.substr(0, 7);
            if (slevel4 != ".......")
            {
                if(slevel3==".....")
                {
                    lstctl.options.item(i).style.color = "0066CC";
                }
                else  
                {
                    if (slevel2 == "...")
                    {
                        lstctl.options.item(i).style.color = "FF4500";
                    }
                    else
                    {
                        if (slevel1 == ".")
                            lstctl.options.item(i).style.color = "FF00FF";  //FF3333
                    }
                }                
            }
        }
    }

//-----------------------------------------------
function OnChangeMonth()
{
    datGetSickPeriod.Call();
}
//-----------------------------------------------
function InitButton(obj)
{
    ibtnSave.SetEnable(obj);
}

//--------------------------
function OnSearch()
{
    datRegulation.Call("SELECT");
}
//---------------------------
function OnSave()
{
    if (confirm("Do you want to save? \n Bạn có muốn lưu không?"))
    {
        datRegulation.Call();
    }
}

function OnChangeReg()
{
    datGetDetailRegulation.Call();
}
//------------------------------------------------
function OnDataReceive(obj)
{
   if(obj.id == "datCheck_View")
   {
        if(txtFlag_View.text == 'Y')
        {
            ibtnDelete.style.display = "none";
            ibtnSave.style.display = "none";
        }
        
        if((Trim(iduser_pk.text)!="")&&(txtHr_level.text=="1")) //QUYEN BI GIOI HAN 
        {
            datUser_info.Call();     	    
        }
        else
        {
            datOrg_Company.Call();
        }
   }
   else if (obj.id=="datUser_info")
   {
        onChange_org(2,lstOrg);
   }
   else if(obj.id == "datOrg_Company")
   {
        OnChangeMonth();
   }
   else if (obj.id=="datRegulation")
   {
        lblRecord.text=grdRegulation.rows-1 + " rec(s)";
   }
   else if (obj.id=="datGetSickPeriod")
    {
        switch (String(txtresult.text))
        {
            case "0":
            {
                lblCloseYN.text='Status: Not Register';
                InitButton(false);
                break;
            }
            
            case "2":
            {
                lblCloseYN.text='Status: Close';
                InitButton(false);
                break;
            }
            default:
            {
                lblCloseYN.text='Status: Open';
                InitButton(true);
                break;
            }
            
        }
        
    }
    else if (obj.id=="datGetDetailRegulation")
    {
        lstDetail_Reg_Type.value='ALL';
    }
    else if (obj.id=="datFind_Report")
    {
        
        var url=System.RootURL+ '/reports/ch/di/' + txtReport_tmp.text + '?p_mon=' + dtMonth.value +'&p_reg_type=' + lstRegulation_Type.value + '&p_org=' + lstOrg.value + "&emp_pk_list=" + emp_pk_list;
        window.open(url);
	}
    else if(obj.id =="datWorkGroup_info")
    {
        if(flag_tab =="1")
        {
		    lstWG.SetDataText(txtwg_tmp.text + "|ALL|Select All");
		    lstWG.value="ALL";
        }
        else if(flag_tab =="2")
        {
            lstWG.SetDataText(txtwg_tmp.text + "|ALL|Select All");
		    lstWG.value="ALL";
           
        }
        datOrg_Company.Call();
    }
}

function OnReport()
{    
	 
	emp_pk_list="";

		for (var i=1;i<=grdRegulation.rows-1;i++)
		{
			if (grdRegulation.GetGridData(i,g_select)=="-1")
			{
				emp_pk_list = emp_pk_list + grdRegulation.GetGridData(i,15) + ",";
			}   
		}

		if (emp_pk_list == "")
			alert("Please choose employees to print");
		else
		{
		emp_pk_list=emp_pk_list.substr(0,emp_pk_list.length-1);
		//alert(emp_pk_list);
        txtReport_tmp.text="rpt_C70a_HD.aspx";        
        datFind_Report.Call();
		}
    	
    
}

function OnShowPopup(n)
{
    var fpath = System.RootURL + "/form/ch/ae/chae00010_org.aspx?";
    var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:yes;status:no;dialogWidth:20;dialogHeight:30;dialogLeft:10;dialogTop:240;edge:sunken;scroll:yes;unadorned:yes;help:no');
    if (obj!=null)
    {
        if(n==1)
            lstOrg.value=obj;
        
    }    
}
function OnDelete()
{
    if(confirm("Do you want to delete?\nBạn có muốn xóa?"))
    {
        grdRegulation.DeleteRow();
    }
}
function onChange_org(tab,obj)
{
	flag_tab=tab;
	txtorg_tmp.text=obj.value;
	datWorkGroup_info.Call();
	//datOrg_Company.Call();
}
function OnSetDate()
{
    
    var check= false;      
    if(confirm("Do you want to set report date?"))
    {          
        for (var i=1;i<=grdRegulation.rows-1;i++)
        {
            if (grdRegulation.GetGridData(i,0)=="-1")
            {
                grdRegulation.SetGridText(i, 17, idSetDate.value); // Set Report Date                     
                check = true;
            }   
        }
        if(!check)
        {
            alert("Please choose employee to set payment date.\nBạn phải chọn nhân viên để set ngày thanh toán.");
            return;
        }
    }
}
function OnSetGrid(obj_checkbox,obj_grd,obj_col)
{
	var tmp;
    if( obj_checkbox.GetData()=='T')
		tmp=-1;
	else
		tmp=0;
    var ctrl = obj_grd.GetGridControl();
    
    if (ctrl.SelectedRows>0)
    {
	    for ( var i =  0 ; i < ctrl.SelectedRows ; i++ )
		{
			var row = ctrl.SelectedRow(i);
			if ( row > 0 )
			{		
				obj_grd.SetGridText(row,obj_col,tmp);
			}
		}
	}
	else
	{
	    for ( var i =  1 ; i < ctrl.rows ; i++ )
			obj_grd.SetGridText(i,obj_col,tmp);
	}
}

</script>
<body >
<!------------main control---------------------->
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
<gw:data id="datWorkGroup_info" onreceive="OnDataReceive(this)"  > 
        <xml>
            <dso  type="list" procedure="hr_sp_sel_wg_role"  > 
                <input>
                    <input bind="txtorg_tmp" />
                </input> 
                <output>
                    <output bind="txtwg_tmp" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<!-----------------Get ID company theo Organization ------------------------>
<gw:data id="datOrg_Company" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="HR_sp_pro_get_company" > 
                <input>
                    <input bind="lstOrg" /> 
                </input> 
                <output>
                    <output bind="txtCompany_PK" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<!-------------------data control----------------------->
<gw:data id="datGetSickPeriod" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr_sp_pro_sick_get_from_to" > 
                <input>
                    <input bind="txtCompany_PK" /> 
                    <input bind="dtMonth" /> 
                </input> 
                <output>
                    <output bind="txtfromdt" />
                    <output bind="txttodt" />
                    <output bind="txtresult" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<gw:data id="datFind_Report" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr_sp_pro_find_report_2" > 
                <input>
                    <input bind="txtReport_tmp" /> 
                    <input bind="lstOrg" />
                </input> 
                <output>
                    <output bind="txtReport_tmp" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<!-------------------data control----------------------->
<gw:data id="datUser_info" onreceive="OnDataReceive(this)"  > 
        <xml>
            <dso  type="list" procedure="hr_sp_sel_user_role2"  > 
                <input>
                    <input bind="iduser_pk" />
                </input> 
                <output>
                    <output bind="lstOrg" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<!-------------------data control----------------------->
<gw:data id="datGetDetailRegulation" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="list" procedure="HR_PRO_10040006" > 
                <input>
                    <input bind="lstRegulation_Type" /> 
                </input> 
                <output>
                    <output bind="lstDetail_Reg_Type" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<!----------------------------------------------------------->
<gw:data id="datRegulation" onreceive="OnDataReceive(this)"  > 
        <xml> 
           <dso  type="grid"  function="HR_SEL_10040006" parameter="5,6,14,15,16,17,18,19" procedure="HR_UPD_10040006"> 
                <input bind="grdRegulation">
                    <input bind="lstOrg" /> 
                    <input bind="lstWG" /> 
                    <input bind="lstTemp" /> 
                    <input bind="txtTemp" /> 
                    <input bind="dtMonth" /> 
                    <input bind="lstRegulation_Type" /> 
                    <input bind="lstDetail_Reg_Type" />					
					<input bind="dtFromReport" />			
					<input bind="dtToReport" />			
                </input> 
                <output bind="grdRegulation"/>
            </dso> 
        </xml> 
</gw:data>

<!-------------------data control----------------------->
   <table  id="management" width="100%" cellpadding="0" cellspacing="0" border=1 style="width:100%;height:100%;">
        <tr style="width:100%;height:100%" valign="top">
            <td>
               <table width="100%" id="tblexp" style="height:100%" border=1 cellpadding="0" cellspacing="0">
                    <tr style="border:1;width:100%;height:5%" valign="center" >
                        <td colspan = 2 width="10%" align="right" style="border:0;"><a title="Click here to show Organization" onclick="OnShowPopup(1)" href="#tips" >Organization</a></td>
                        <td width="14%" align="left" style="border:0;">
                         <gw:list  id="lstOrg"  maxlen = "100" styles='width:100%'onchange="onChange_org(1,lstOrg)" >
                            <data>
                                <%=ESysLib.SetListDataSQL("select a.pk,lpad('.',level*2-1,'.')|| a.org_nm from tco_org a  where a.del_if = 0 and a.tco_company_pk=nvl('" + session("COMPANY_PK") + "',a.tco_company_pk)  AND NVL(A.END_DATE,TO_CHAR(SYSDATE+1,'YYYYMMDD')) >  TO_CHAR(SYSDATE,'YYYYMMDD') connect by prior a.pk = a.p_pk start with nvl(a.p_pk,0)=0 order siblings by a.org_id")%>
                            </data>
                        </gw:list>
                        </td>
                        <td width="7%" align="right" style="border:0;">Work-Group</td>
                        <td width="13%"  align="left" style="border:0;">
                         <gw:list  id="lstWG" value='ALL' maxlen = "100" styles='width:100%' >
                            <data><%=Esyslib.SetListDataSQL("SELECT pk,workgroup_NM FROM Thr_work_Group WHERE DEL_IF = 0 order by workgroup_id" )%>|ALL|Select All</data></gw:list>
                        </td>
                        <td  width="10%"  align="right" valign="middle" style="border:0;">Search by</td>
					    <td   width="7%" style="border:0;">
					        <gw:list  id="lstTemp" value="2" styles='width:100%' onchange=""> 
							        <data>LIST|1|Name|2|Emp ID</data> 
					        </gw:list>
				        </td>
                        <td width="8%" align=center style="border:0" colspan=2> 
					        <gw:textbox id="txtTemp" onenterkey   ="OnSearch()" styles='width:100%'/></td>
							<td  width="6%" align=right style="border:0"><b>Payment DT</b></td>
						<td width="6%" align=left style="border:0"> 
							<gw:datebox id="dtFromReport" lang="<%=Session("Lang")%>" nullaccept onchange=" " type=date></gw:datebox> 
						</td>
						<td width="6%" align=right style="border:0">
						  <gw:datebox id="dtToReport" lang="<%=Session("Lang")%>" nullaccept onchange=" " type=date></gw:datebox>
						</td>
				        <td width="5%" style="border:0;" align="right" >
                            <gw:imgBtn img="search" id="ibtnSearch"   alt="Search"  onclick="OnSearch()"/>
                        </td>
				        <td width="4%" style="border:0;" align="right" >
                            <gw:imgBtn img="save" id="ibtnSave"    alt="Save"  onclick="OnSave()"/>
                         </td>
                        <td width="3%" style="border:0" align="right">
                            <gw:imgBtn img="delete" id="ibtnDelete"    alt="Delete"  onclick="OnDelete()"/>
                        </td>
                        <td width="2%" style="border:0" align="right">
                        </td>
                        <td width="2%" style="border:0" align="right">
                        <gw:imgBtn img="excel" id="ibtnReport2"    alt="Report Summary"  onclick="OnReport()"/></td>
                        
                    </tr>
                    <tr style="border:1;width:100%;height:5%" valign="center" >
					<td style="border:0;align="center"><gw:checkbox id="chkCheckReport" value="F" onclick="OnSetGrid(chkCheckReport,grdRegulation,g_select)" ></gw:checkbox ></td>
                        <td  align="right" style="border:0;">Month            
                        </td>
                        <td  align="left" style="border:0;">
                        <gw:datebox id="dtMonth" type="month" styles='width:100%' onchange="OnChangeMonth()"  lang="<%=Session("Lang")%>"/>
                         
                        </td>
                        <td align="right" style="border:0;">Regulation Type</td>
                        <td align="left" style="border:0;">
                            <gw:list  id="lstRegulation_Type" value='ALL' maxlen = "100" styles='width:100%' onchange="OnChangeReg()" >
                            <data>
                                <%=ESysLib.SetListDataSQL("select code,code_nm from vhr_hr_code where id='HR0054'")%>|ALL|Select All
                            </data>
                            </gw:list>
                        </td>
                        <td   align="right" valign="middle" style="border:0;">Detail Reg Type</td>
					    <td   style="border:0;" colspan=3>
					         <gw:list  id="lstDetail_Reg_Type" value='ALL' maxlen = "100" styles='width:100%'onchange="" >
                            <data>
                                <%=ESysLib.SetListDataSQL("select code,code_nm from vhr_hr_code where id='HR0055'")%>|ALL|Select All
                            </data>
                            </gw:list>
				        </td>
						<td align="right" width ="6%" style="border:0;"><font color="FF3399"> Set Pay dt
						</td>
						<td style="width:4%;border:1"><gw:datebox id="idSetDate" lang="<%=Session("Lang")%>" type=date nullaccept></gw:datebox>
						</td>
						<td style="width:3%;border:1" align="left"> <gw:imgBtn id="ibtnSet" alt="Set Payment Date" img="Set" text="Set Grid" onclick="OnSetDate()" />
						</td>
				        <td colspan=2 style="border:0" align="right">
				        <gw:label id="lblCloseYN"  text="" maxlen = "100" styles="color:blue;width:100%;font-weight: bold;font-size:11" /></td>
                        <td colspan=2 style="border:0" align="right">
                        <gw:label id="lblRecord"  text="0 rec(s)" maxlen = "100" styles="color:red;width:100%;font-weight: bold;font-size:12" /></td>
                    </tr>
                    <tr style="border:1;width:100%;height:85%" valign="top">
                        <td colspan=17  style="width:100%;height:100%;"> 
                              <gw:grid id='grdRegulation'
                                header='Select|Work Group|Detail Regulation|Emp ID|Full Name|_Social No|Condition|Average Salary|Social Date|Days|Progressive|Amount|From Date|To Date|Remark|_PK|Payment|Payment Date|By Hand|_INS_MONTH'
                                format='3|0|0|0|0|0|0|1|0|0|0|1|4|4|0|0|2|4|2|0'
                                aligns='0|0|0|1|0|0|0|0|1|1|1|0|1|1|0|0|1|1|1|1'
                                defaults='|||||||||||||||||||'
                                editcol='1|0|0|0|0|1|1|1|0|0|0|0|0|0|1|0|1|1|1|0'
                                widths='0|1530|2000|1000|2530|1515|2005|1330|1030|1000|1295|1130|1320|1275|1000|0|1000|1500|1500|0'
                                sorting='T'
                                styles='width:100%; height:100%'
                                acceptnulldate
                                />
                        </td>
                    </tr>
               </table> 
            </td>
        </tr>
    </table>
    
</body>
<gw:textbox id="txtresult" styles="display:none"/>
<gw:textbox id="txtfromdt" styles="display:none"/>
<gw:textbox id="txttodt" styles="display:none"/>
<gw:textbox id="txtDeptData" styles="display:none"/>
<gw:textbox id="iduser_pk" styles="display:none"/>
<gw:textbox id="txtHr_level" styles="display:none"/>  
<gw:textbox id="txtUpperDept" styles="display:none"/>
<gw:textbox id="txtReport_tmp" styles="display:none">
</gw:textbox>
<gw:textbox id="txtCompany_PK" styles="display:none"/>
<gw:textbox id="txtorg_tmp" styles="display:none"/>
<gw:textbox id="txtwg_tmp" styles="display:none"/> 
<gw:textbox id="menu_id" text="" styles="display:none"  />
<gw:textbox id="txtFlag_View" text="" styles="display:none"  />
</html>
