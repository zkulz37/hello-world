<!-- #include file="../../../system/lib/form.inc"  -->
 <%  ESysLib.SetUser(Session("APP_DBUSER"))%>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Untitled Page</title>
</head>
<script>
var strcodereturn;
var user;
var v_language = "<%=Session("SESSION_LANG")%>";


    var v_emp_pk = 0;
    var v_dept = 1;
    var v_group = 2;
    var v_emp_id = 3;
    var v_full_name = 4;
    var v_regulation_kind = 5;
    var v_remark = 6;
    var v_times = 7;
    var v_reg_type = 8;
    var v_test_weeks = 9;
    var v_test_date = 10;
    var v_from_date = 11;
    var v_to_date = 12;
    var v_create = 13;
    var v_register_times = 14;
    var v_pk = 15;
    var v_Regdt = 16;


var flag_tab=1;
var check_init=0;
function BodyInit()
{
    grdRegulation_Old.GetGridControl().ScrollTrack=true;    

    grdRegulation.GetGridControl().ScrollTrack=true;
    grdRegulation.GetGridControl().FrozenCols =6;

    grdRegulation1.GetGridControl().ScrollTrack=true;
    grdRegulation1.GetGridControl().FrozenCols =6;
    
    if (v_language!="ENG")
        System.Translate(document);
    iduser_pk.text = "<%=session("USER_PK")%>";
    txtHr_level.text= "<%=session("HR_LEVEL")%>";
    user= "<%=session("USER_ID")%>";
    BindingDataList();    
   ibtnUnDelete.SetEnable(false);
   ibtnDelete.SetEnable(false);
   ibtnSave.SetEnable(false);
   menu_id.text=System.Menu.GetMenuID();
   ChangeColorItem(lstOrg.GetControl());
   ChangeColorItem(lstOrg1.GetControl());
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

//-------------------------------
function OnShowPopup(n)
{
    var strcom;
    var fpath = System.RootURL + "/form/ch/ae/chae00010_org.aspx?";
    var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:no;status:no;dialogWidth:20;dialogHeight:20;dialogLeft:10;dialogTop:240;edge:sunken;scroll:no;unadorned:yes;help:no');
    if (obj!=null)
    {
        if(n==1)
		{
            lstOrg.value=obj;
			onChange_org(1,lstOrg);
		}	
        else  
		{
            lstOrg1.value=obj;   
			onChange_org(2,lstOrg1);
		}	
        
    }
    
}
//----------------------------------------------------
function BindingDataList()
{      
    var t1 = "<%=ESysLib.SetGridColumnDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0029' order by code_nm")%>";
    grdRegulation.SetComboFormat(v_regulation_kind,t1);

    t1 = "<%=ESysLib.SetGridColumnDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0119' union all select null,null from dual order by 1")%>";
    grdRegulation.SetComboFormat(v_reg_type,t1);
}
//----------------------------------------------------
function ChoseList_box(obj_list,value)
{
    obj_list.SetDataText(value)    ;
    obj=obj_list.GetControl()
	if (obj.options.length ==2)
		obj.options.selectedIndex=0;
	else
		obj.options.selectedIndex=obj.options.length-1;
}
//----------------------------------------------
function OnDataReceive(obj)
{
   if(obj.id == "datCheck_View")
   {
        if(txtFlag_View.text == 'Y')
        {
            ibtnSave.style.display = "none";
            ibtnDelete.style.display = "none";
            ibtnUnDelete.style.display = "none";
        }
        if((Trim(iduser_pk.text)!="")&&(txtHr_level.text=="1")) //QUYEN BI GIOI HAN 
	    {
            datUser_info.Call();     	    
	    }
        check_init =1;
   }
   else if (obj.id=="datRegulation")
   {
       lblRecord.text=grdRegulation.rows-1 + " record(s)";
       OnShowOld();
       if (grdRegulation.rows>1)
       {
           ibtnUnDelete.SetEnable(false);
           ibtnDelete.SetEnable(true);
           ibtnSave.SetEnable(true);
       }
       else
       {
           ibtnUnDelete.SetEnable(false);
           ibtnDelete.SetEnable(false);
           ibtnSave.SetEnable(false);
       }   
   }
   else if (obj.id=="datRegulation_His")
   {
       lblRecord1.text=grdRegulation1.rows-1 + " record(s)";
       
   }
   else if (obj.id=="datUser_info")
   {
        lstOrg.SetDataText(txtdept_temp.text);            
        lstOrg1.SetDataText(txtdept_temp.text);
        txtDept.text=lstOrg.value;

        ChangeColorItem(lstOrg.GetControl());
        ChangeColorItem(lstOrg1.GetControl());

		onChange_org(0,lstOrg);
       
   }
   else if (obj.id=="datWorkGroup_info")
   {
		switch (flag_tab) 
		{
			case 0:
			{
				lstWG.SetDataText(txtwg_tmp.text + "|ALL|Select All");
                lstWG.value ="ALL";
				lstWG1.SetDataText(txtwg_tmp.text + "|ALL|Select All");
                lstWG1.value ="ALL";
				break;
			}
			case 1:
			{
				lstWG.SetDataText(txtwg_tmp.text + "|ALL|Select All");
                lstWG.value ="ALL";
				break;
			}	
			case 2:
			{
				lstWG1.SetDataText(txtwg_tmp.text + "|ALL|Select All");
                lstWG1.value ="ALL";
				break;
			}
		}
		check_init=1;
		
   }
}

//----------------------------------------------------
function OnSearch(datobj)
{
	if(check_init==1)
		datobj.Call("SELECT");
}


//-----------------------------------------------
function OnReport(typeobj)
{
	if(check_init==1)
	{
		if (typeobj==1)
		{
			if (dtBeginDate.value !="" & dtBeginDate.value!="")
			{
				var url =System.RootURL + '/reports/ch/ae/rpt_wt_allowance.aspx?p_user=' + user + '&p_wg=' + lstWG.value + '&p_search_by=' + lstTemp.value + '&p_search_temp=' + txtTemp.text + '&p_tco_org_pk=' + lstOrg.value + '&p_kind=' + lstRegulation.value + '&p_from_regdate=' +  dtBeginDate.value +'&p_to_regdate=' + dtEndDate.value + '&p_from_regdate_text=' +  dtBeginDate.text +'&p_to_regdate_text=' + dtEndDate.text + '&p_status=' + lstStatus.value + '&p_typeobj=' + typeobj;
				window.open(url); 
			}   
			else
				alert("Please input period of allowance date!");
		}
		else
		{
			var url =System.RootURL + '/reports/ch/ae/rpt_wt_allowance.aspx?p_user=' + user + '&p_wg=' + lstWG1.value + '&p_search_by=' + lstTemp1.value + '&p_search_temp=' + txtTemp1.text + '&p_tco_org_pk=' + lstOrg1.value + '&p_kind=' + lstRegulation1.value + '&p_from_regdate=' +  dtBeginDate1.value +'&p_to_regdate=' + dtEndDate1.value + '&p_from_regdate_text=' +  dtBeginDate1.text +'&p_to_regdate_text=' + dtEndDate1.text + '&p_status=' + lstStatus1.value + '&p_typeobj=' + typeobj;
				window.open(url); 
		}
	}	
}
//-----------------------------------------------
function OnSave()
{
    
    if (CheckUpdate())
        if ( confirm("Do you want to save?"))
            datRegulation.Call();
}
//-------------------------------------------------
function CheckUpdate()
{
    var v_mod=false;
    for (var i=1;i<=grdRegulation.rows-1;i++)
    {
        var sregkind=grdRegulation.GetGridData(i,v_regulation_kind);
        var sremark=grdRegulation.GetGridData(i,v_remark);
		var sregtype=grdRegulation.GetGridData(i,v_reg_type);
        var stest_date=grdRegulation.GetGridData(i,v_test_date);
        var stest_weeks=grdRegulation.GetGridData(i,v_test_weeks);
        var sfromdate=grdRegulation.GetGridData(i,v_from_date);
        var stodate=grdRegulation.GetGridData(i,v_to_date);
        var screate=grdRegulation.GetGridData(i,v_create);
        var spk=grdRegulation.GetGridData(i,v_pk);
        if (grdRegulation.GetRowStatus(i)==16  || grdRegulation.GetRowStatus(i)==64)
        {
            v_mod=true;
            if (sregkind=="" && sremark=="" && sregtype=="" && stest_date=="" && stest_weeks=="" && sfromdate=="" && stodate=="" && (screate=="0" || screate=="") && spk=="")
            {
                
                grdRegulation.SetRowStatus(i,0);
                return false;
            }
            else
            {    
                if (sregkind=="") //regulation kind
                { 
                    alert("You have to input regulation kind at row " + i );
                    return false;
                }
                if (sregtype=="" && sregkind!="04")//regulation type
                {
                    alert("You must input regulation type at row " + i );
                    return false;
                }
                if ((stest_date=="" && stest_weeks=="" ) || (stest_date=="" && stest_weeks!="" &&  sregkind=="02")) //khong nhap ngay kham thai
                {
                    if (sfromdate=="" ) //from date
                    {
                        alert("You have to input From Date at row " + i );
                        return false;
                    }
                    if (stodate=="") //to date
                    {
                        alert("You have to input To Date at row " + i );
                        return false;
                    }
                }
                else //nhap ngay kham thai
                {
                    if (stest_date=="") //khong nhap ngay kham thai
                    {
                        alert("You have to input Test Date at row " + i );
                        return false;
                    }
                    else if (stest_weeks=="" && sregkind=="01") //khong nhap ngay kham thai
                    {
                        alert("You have to input Test Weeks at row " + i );
                        return false;
                    }
                }
                /*if (sfromdate>stodate)
                {
                    alert("To Date have to larger than From Date at row " + i );
                    return false;
                }
    			*/
                if (spk=="" && screate=="0")
                    grdRegulation.SetGridText(i,v_create,"-1");
            }
        }
    }
    return v_mod;
}
//------------------------------------------
function OnDelete()
{
    if(confirm("Do you want to delete?"))
    {
       grdRegulation.DeleteRow();
       ibtnDelete.SetEnable(false);
       ibtnUnDelete.SetEnable(true);
    }
}
//-----------------------------------------
function OnUnDelete()
{
    if (confirm("Do you want to undelete?"))
    {
        grdRegulation.UnDeleteRow();
        ibtnDelete.SetEnable(true);
        ibtnUnDelete.SetEnable(false);
    }
}
//------------------------------------------
function CheckButton()
{
    var ctrl 	= grdRegulation.GetGridControl();
    var rownum 	= ctrl.Row;
    var rownums 	= ctrl.Rows;
    
    if(rownum > 0 && rownums>1)
    {
        if(grdRegulation.GetRowStatus(rownum) >= 64)
        {
            ibtnDelete.SetEnable(false);
            ibtnUnDelete.SetEnable(true);
        }
        else
        {
            ibtnDelete.SetEnable(true);
            ibtnUnDelete.SetEnable(false);
        }
    }

    if (ctrl.col == v_create) {
        if (grdRegulation.GetGridData(ctrl.row, v_create) == "-1")
        {
            grdRegulation.SetGridText(ctrl.row, v_regulation_kind, "");
            grdRegulation.SetGridText(ctrl.row, v_remark, "");
            grdRegulation.SetGridText(ctrl.row, v_test_weeks, "");
            grdRegulation.SetGridText(ctrl.row, v_test_date, "");
            grdRegulation.SetGridText(ctrl.row, v_from_date, "");
            grdRegulation.SetGridText(ctrl.row, v_to_date, "");
            grdRegulation.SetGridText(ctrl.row, v_Regdt, "");
        }
    }
}
//------------------------------------------
function OnShowOld()
{
    if (imgMaster.status=="expand")
    {
        var irow=grdRegulation.row;
        if (irow>=1)
        {
            txtEmp_PK.text=grdRegulation.GetGridData(irow,v_emp_pk);
            txtReg_PK.text=grdRegulation.GetGridData(irow,v_pk);
            datRegulation_Old.Call("SELECT");
        }
        else
        {
            grdRegulation_Old.ClearData();
        }
    }
}
//------------------------------------------

function OnToggle()
{
        if(imgMaster.status == "expand")
        {
            imgMaster.status = "collapse";
			tblDetail.style.display="none";
			tblDetail.style.height="0%";
			tblMaster.style.height="90%";
            imgMaster.src = "../../../system/images/iconmaximize.gif";
			imgMaster.alt="Show old regulation";
			
        }
        else
        {
            imgMaster.status = "expand";
            tblDetail.style.display="";
            tblDetail.style.height="30%";
            tblMaster.style.height="60%";
            imgMaster.src = "../../../system/images/close_popup.gif";
			imgMaster.alt="Close old regulation";
			OnShowOld();
			
        }
  
}

function onChange_org(tab,obj)
{
	flag_tab=tab;
	txtorg_tmp.text=obj.value;
	datWorkGroup_info.Call();
	
}
</script>
<body >
<!-------------------data control----------------------->

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
            <dso  type="list" procedure="HR_SP_SEL_WG_ROLE"  > 
                <input>
                    <input bind="txtorg_tmp" />
                </input> 
                <output>
                    <output bind="txtwg_tmp" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datRegulation" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid"  parameter="0,5,6,7,8,9,10,11,12,13,15" function="HR_SEL_10010011_REGULATION" procedure="HR_UPD_10010011_REGULATION"> 
                <input bind="grdRegulation" >
                    <input bind="lstOrg" /> 
                    <input bind="lstWG" />
                    <input bind="dtBeginDate" />
                    <input bind="dtEndDate" />
                    <input bind="lstTemp" />
                    <input bind="txtTemp" />
                    <input bind="lstRegulation" /> 
                    <input bind="lstStatus" />											
                </input>
                <output  bind="grdRegulation" />
            </dso> 
        </xml> 
</gw:data>
<!------------------------------------------>
<gw:data id="datRegulation_His" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid"  function="HR_10010011_REGULATION_HIS"> 
                <input bind="grdRegulation1" >
                    <input bind="lstOrg1" /> 
                    <input bind="lstWG1" />
                    <input bind="dtBeginDate1" />
                    <input bind="dtEndDate1" />
                    <input bind="lstTemp1" />
                    <input bind="txtTemp1" />
                    <input bind="lstRegulation1" />
		            <input bind="lstStatus1" />			
                </input>
                <output  bind="grdRegulation1" />
            </dso> 
        </xml> 
</gw:data>
<!------------------------------------------>
<gw:data id="datUser_info" onreceive="OnDataReceive(this)"  > 
        <xml>
            <dso  type="list" procedure="HR_SP_SEL_USER_ROLE2"  > 
                <input>
                    <input bind="iduser_pk" />
                </input> 
                <output>
                    <output bind="txtdept_temp" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<!------------------------------------->
<gw:data id="datRegulation_Old" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid"  function="HR_SP_SEL_regulation_old"> 
                <input bind="grdRegulation_old" >
                    <input bind="txtEmp_PK" /> 
                    <input bind="txtReg_PK" /> 
                </input>
                <output  bind="grdRegulation_old" />
            </dso> 
        </xml> 
</gw:data>
<!-------------------data control----------------------->
<gw:tab id="tabMain"  border=1 style="width:100%;height:100%;"  > 
   <table name="Management" width="100%" cellpadding="0" cellspacing="0" border=1 style="width:100%;height:100%;">
        <tr style="width:100%;height:100%" valign="top">
            <td>
               <table width="100%" id="tblexp" style="height:10%" border=1 cellpadding="0" cellspacing="0">
                    <tr style="border:0;width:100%;height:5%" valign="center" >
                        <td width="10%" style="border:0;" align="right" ><a title="Click here to show Organization" onclick="OnShowPopup(1)" href="#tips" >
                            Organization</a>                  
                        </td>
                        <td width="15%" style="border:0;" align="left" >
                         <gw:list  id="lstOrg" value='ALL' maxlen = "100" styles='width:100%' onchange="onChange_org(1,lstOrg)">
                            <data>
                                <%=ESysLib.SetListDataSQL("select a.pk,lpad('.',level*2-1,'.')|| a.org_nm from tco_org a  where a.del_if = 0 and (a.tco_company_pk=nvl('" + session("COMPANY_PK") + "',a.tco_company_pk) or '" + session("HR_LEVEL") + "'='6')  AND NVL(A.END_DATE,TO_CHAR(SYSDATE+1,'YYYYMMDD')) >  TO_CHAR(SYSDATE,'YYYYMMDD') connect by prior a.pk = a.p_pk start with nvl(a.p_pk,0)=0 order siblings by a.org_id")%>|ALL|Select All
                            </data>
                        </gw:list>
                        </td>
                        <td width="8%" style="border:0;" align="right" >W-Group</td>
                        <td width="13%" style="border:0;" align="left" >
                         <gw:list  id="lstWG" value='ALL' maxlen = "100" styles='width:100%' >
                            <data><%=ESysLib.SetListDataSQL("select a.PK,a.WORKGROUP_NM from thr_work_group a where a.del_if=0 order by a.WORKGROUP_NM")%>|ALL|Select All</data></gw:list>
                        </td>
                        <td width="9%" style="border:0;" align="right">Begin</td>
				        <td  width="10%" style="border:0;"><gw:datebox id="dtBeginDate" nullaccept styles="width:100%" lang="<%=Session("Lang")%>" /></td>
				        <td  width="6%" style="border:0;" align="right">End</td>
				        <td width="10%" style="border:0;"><gw:datebox id="dtEndDate" nullaccept styles="width:100%" lang="<%=Session("Lang")%>" /></td>
                         
                        <td width="7%" style="border:0;" align="right" >
                         <gw:imgBtn img="search" id="ibtnSearch"   alt="Search"  onclick="OnSearch(datRegulation)"/>
                        </td>
                        <td width="3%" style="border:0" align="right">
                         <gw:imgBtn img="save" id="ibtnSave"    alt="Save"  onclick="OnSave()"/>
                        </td>
                        <td width="3%" style="border:0" align="right">
                         <gw:imgBtn img="delete" id="ibtnDelete"    alt="Delete"  onclick="OnDelete()"/>
                        </td>
                        <td width="3%" style="border:0" align="right">
                         <gw:imgBtn img="udelete" id="ibtnUnDelete"    alt="UnDelete"  onclick="OnUnDelete()"/>
                        </td>
                        <td width="3%" style="border:0" align="right">
                         <gw:imgBtn img="excel" id="ibtnReport"    alt="Report"  onclick="OnReport(1)"/>
                        </td>
                    </tr>
                    <tr style="border:0;width:100%;height:5%" valign="middle" >
                        <td  style="border:0" align="right" valign="middle">Search by</td>
					    <td  style="border:0">
					        <gw:list  id="lstTemp" value="2" styles='width:100%' onchange=""> 
							        <data>LIST|1|Name|2|Emp ID|3|Card ID|4|Personal ID|5|Old Code</data> 
					        </gw:list>
				        </td>
                        <td colspan=2  style="border:0"> 
					        <gw:textbox id="txtTemp" onenterkey   ="OnSearch(datRegulation)" styles='width:100%'/>
				        </td>
                        
                        <td style="border:0;" align="right" >Regulation</td>
                        <td  colspan=1 style="border:0;" align="left" >
                         <gw:list  id="lstRegulation" value='ALL' maxlen = "100" styles='width:100%'>
                            <data>
                                <%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0029' order by code_nm")%>|ALL|Select All
                            </data>
                        </gw:list></td>
			            <td style="border:0;" align="right" >Status</td>
			            <td  colspan=1 style="border:0;" align="left" >
                         <gw:list  id="lstStatus" value='A' maxlen = "100" styles='width:100%'>
                            <data>
                                <%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0022' order by code_nm")%>|ALL|Select All
                            </data>
                        </gw:list></td>
                        <td colspan=3 style="border:0" align="right"><gw:label id="lblRecord"  text="0 record(s)" maxlen = "100" styles="color:red;width:90%;font-weight: bold;font-size:12" />
                        </td>
                        <td align="right" style="border:0" valign="bottom"><img status="collapse" id="imgMaster" alt="Show old regulation" src="../../../system/images/iconmaximize.gif" style="cursor:hand" onclick="OnToggle()"  /></td>
                    </tr>
                    
                </table>
                <table width="100%" id="tblMaster" style="height:90%" border=1 cellpadding="0" cellspacing="0">
                    <tr style="border:1;width:100%;height:50%" valign="top">
                        <td colspan=15 style="width:100%;height:50%;"> 
                             <gw:grid   
                                id="grdRegulation"                                   
                                header="_EMP_PK|_Dept|Group|Emp ID|Full Name|Regulation Kind|Remark|Times(H)|Reg Type|Test Weeks|Test Date/Child Birth|From Date|To Date|Create|Register Times|_PK|Register DT" 
                                format="0|0|0|0|0|2|0|0|2|0|4|4|4|3|-0|0|4"  
                                aligns="0|2|2|1|0|1|0|1|1|1|1|1|1|1|1|0|0"  
                                defaults="||||||||||||||||"  
                                editcol="0|0|0|0|0|1|1|1|1|1|1|1|1|1|0|0|0"  
                                widths="0|1500|1700|1000|2700|1900|1700|900|1500|1200|2000|1200|1200|1000|1600|500|1200"  
                                styles="width:100%; height:100%" acceptNullDate
                                sorting="T"   
                                oncellclick="CheckButton();OnShowOld()" />
                        </td>
                    </tr>
                </table>
                <table width="100%" id="tblDetail" style="height:30%;display:none" border=1 cellpadding="0" cellspacing="0">
                    <tr style="border:1;width:100%" valign="top">
                        <td > 
                             <gw:grid   
                                id="grdRegulation_Old"  
                                header="_Dept|Group|Emp ID|Full Name|Regulation Type|Remark|Times(H)|Reg Type|Test Weeks|Test Date|From Date|To Date|Register Times"   
                                format="0|0|0|0|0|0|0|0|0|0|0|0|0"  
                                aligns="2|2|1|0|1|2|1|1|1|1|1|1|1"  
                                defaults="||||||||||||"  
                                editcol="0|0|0|0|0|0|0|0|0|0|0|0|0"  
                                widths="1500|1700|1000|2700|1900|1700|1200|1200|1200|1200|1200|1200|1600"  
                                styles="width:100%; height:100%" acceptNullDate
                                sorting="T"   
                                 /> 
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
     <table name="History" width="100%" cellpadding="0" cellspacing="0" border=1 style="width:100%;height:100%;">
        <tr style="width:100%;height:100%" valign="top">
            <td>
               <table width="100%" id="Table2" style="height:10%" border=1 cellpadding="0" cellspacing="0">
                    <tr style="border:0;width:100%;height:5%" valign="center" >
                        <td width="10%" style="border:0;" align="right" ><a title="Click here to show Organization" onclick="OnShowPopup(2)" href="#tips" >
                            Organization</a>                  
                        </td>
                        <td width="15%" style="border:0;" align="left" >
                         <gw:list  id="lstOrg1" value='ALL' maxlen = "100" styles='width:100%' onchange="onChange_org(2,lstOrg1)" >
                            <data>
                                <%=ESysLib.SetListDataSQL("select a.pk,lpad('.',level*2-1,'.')|| a.org_nm from tco_org a  where a.del_if = 0 and (a.tco_company_pk=nvl('" + session("COMPANY_PK") + "',a.tco_company_pk) or '" + session("HR_LEVEL") + "'='6')  AND NVL(A.END_DATE,TO_CHAR(SYSDATE+1,'YYYYMMDD')) >  TO_CHAR(SYSDATE,'YYYYMMDD') connect by prior a.pk = a.p_pk start with nvl(a.p_pk,0)=0 order siblings by a.org_id")%>|ALL|Select All
                            </data>
                        </gw:list>
                        </td>
                        <td width="8%" style="border:0;" align="right" >W-Group</td>
                        <td width="13%" style="border:0;" align="left" >
                         <gw:list  id="lstWG1" value='ALL' maxlen = "100" styles='width:100%' >
                            <data><%=ESysLib.SetListDataSQL("select a.PK,a.WORKGROUP_NM from thr_work_group a where a.del_if=0 order by a.WORKGROUP_NM")%>|ALL|Select All</data></gw:list>
                        </td>
                        <td width="9%" style="border:0;" align="right">Begin</td>
				        <td  width="10%" style="border:0;"><gw:datebox id="dtBeginDate1" nullaccept  styles="width:100%" lang="<%=Session("Lang")%>" /></td>
				        <td  width="6%" style="border:0;" align="right">End</td>
				        <td width="10%" style="border:0;"><gw:datebox id="dtEndDate1" nullaccept styles="width:100%" lang="<%=Session("Lang")%>" /></td>
                         
                        <td width="7%" style="border:0;" align="right" >
                         <gw:imgBtn img="search" id="ibtnSearch1"   alt="Search"  onclick="OnSearch(datRegulation_His)"/>
                        </td>
                        <td width="3%" style="border:0" align="right">
                         <gw:imgBtn img="excel" id="ibtnReport1"    alt="Report"  onclick="OnReport(2)"/>
                        </td>
                        <td width="3%" style="border:0" align="right">
                         
                        </td>
                        <td width="3%" style="border:0" align="right">
                         
                        </td>
                        <td width="3%" style="border:0" align="right">
                         
                        </td>
                    </tr>
                    <tr style="border:0;width:100%;height:5%" valign="middle" >
                        <td  style="border:0" align="right" valign="middle">Search by</td>
					    <td  style="border:0">
					        <gw:list  id="lstTemp1" value="2" styles='width:100%' onchange=""> 
							        <data>LIST|1|Name|2|Emp ID|3|Card ID|4|Personal ID|5|Old Code</data> 
					        </gw:list>
				        </td>
                        <td colspan=2  style="border:0"> 
					        <gw:textbox id="txtTemp1" onenterkey   ="OnSearch(datRegulation_His)" styles='width:100%'/>
				        </td>
                        
                        <td style="border:0;" align="right" >Regulation</td>
                        <td  colspan=1 style="border:0;" align="left" >
                         <gw:list  id="lstRegulation1" value='ALL' maxlen = "100" styles='width:100%'>
                            <data>
                                <%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0029' order by code_nm")%>|ALL|Select All
                            </data>
                        </gw:list></td>
			            <td style="border:0;" align="right" >Status</td>
			            <td  colspan=1 style="border:0;" align="left" >
                         <gw:list  id="lstStatus1" value='A' maxlen = "100" styles='width:100%'>
                            <data>
                                <%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0022' order by code_nm")%>|ALL|Select All
                            </data>
                        </gw:list></td>
                        <td colspan=3 style="border:0" align="right"><gw:label id="lblRecord1"  text="0 record(s)" maxlen = "100" styles="color:red;width:90%;font-weight: bold;font-size:12" />
                        </td>
                        <td align="right" style="border:0" valign="bottom"></td>
                    </tr>
                    
                </table>
                <table width="100%" id="Table3" style="height:90%" border=1 cellpadding="0" cellspacing="0">
                    <tr style="border:1;width:100%;height:50%" valign="top">
                        <td colspan=15 style="width:100%;height:50%;"> 
                             <gw:grid   
                                id="grdRegulation1"  
                                header="_EMP_PK|_Dept|Group|Emp ID|Full Name|Regulation Type|Remark|Times(H)|Reg Type|Test Weeks|Test Date|From Date|To Date|_Create|Register Times|_PK"   
                                format="0|0|0|0|0|2|0|0|0|0|0|0|0|0|0|0 "  
                                aligns="0|2|2|1|0|1|2|1|1|1|1|1|1|1|1|0"  
                                defaults="|||||||||||||||"  
                                editcol="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"  
                                widths="0|1500|2000|1000|2700|1900|1700|1100|1200|1200|1200|1200|1200|0|1600|500"  
                                styles="width:100%; height:100%" acceptNullDate
                                sorting="T"
                                 /> 
                        </td>
                    </tr>
                </table>
                
            </td>
        </tr>
    </table>
  </gw:tab>
<gw:textbox id="txtdept_temp" styles="display:none"/>
<gw:textbox id="txtUpperDept" styles="display:none"/>
<gw:textbox id="txtGroupData" styles="display:none"/>
<gw:textbox id="txtEmp_PK" styles="display:none"/>
<gw:textbox id="txtReg_PK" styles="display:none"/>
<gw:textbox id="iduser_pk" styles="display:none"/>
<gw:textbox id="txtHr_level" styles="display:none"/>
<gw:textbox id="txtDept" styles="display:none">
<gw:textbox id="txtorg_tmp" styles="display:none"/>
<gw:textbox id="txtwg_tmp" styles="display:none"/> 
<gw:textbox id="menu_id" text="" styles="display:none"  />
<gw:textbox id="txtFlag_View" text="" styles="display:none"  />
</gw:textbox>
</body>


</html>
