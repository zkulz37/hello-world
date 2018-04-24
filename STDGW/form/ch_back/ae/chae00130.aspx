<!-- #include file="../../../system/lib/form.inc"  -->
 <%  ESysLib.SetUser(Session("APP_DBUSER"))%>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Untitled Page</title>
</head>
<script>
var v_language = "<%=Session("SESSION_LANG")%>";

var G1_Salary = 3,
    G1_Total_Allow =4;
var check_init=0;    
function BodyInit()
{
    grdEmployee.GetGridControl().ScrollTrack=true;
    grdSalary.GetGridControl().ScrollTrack=true;
    grdCT.GetGridControl().ScrollTrack=true;
    grdDis.GetGridControl().ScrollTrack=true;
    if (v_language!="ENG")
        System.Translate(document);
    iduser_pk.text = "<%=session("USER_PK")%>";
    txtHr_level.text= "<%=session("HR_LEVEL")%>";
    ChangeColorItem(lstOrg.GetControl());
   if((Trim(iduser_pk.text)!="")&&(txtHr_level.text=="1")) //QUYEN BI GIOI HAN 
	{
        datUser_info.Call();     	    
	}
	else
        datSal_security.Call();
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


//------------------------------------------------
function OnChangeDept()
{
    txtDept.text=lstOrg.value ;
    //datGroupData.Call();
	datTeamData.Call();
}
//----------------------------------------------------
function ChoseList_box(obj_list,value)
{
    obj_list.SetDataText(value )    ;
    obj=obj_list.GetControl()
	if (obj.options.length ==2)
		obj.options.selectedIndex=0;
	else
		obj.options.selectedIndex=obj.options.length-1;
}
//----------------------------------
function OnShowPopup(n)
{
	if(check_init==1)
	{
        var fpath = System.RootURL + "/form/ch/ae/chae00010_org.aspx?";
        var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:yes;status:no;dialogWidth:20;dialogHeight:20;dialogLeft:60;dialogTop:200;edge:sunken;scroll:yes;unadorned:yes;help:no');
        if (obj!=null)
        {
             lstOrg.value=obj;
        }
	}	
}
//-----------------------------------------------
function OnToggle()
{
    if(imgArrow.status == "expand")
    {
        idLeftDiv.style.display="none";
        imgArrow.status = "collapse";
        imgArrow.src = "../../../system/images/next_orange.gif";
    }
    else
    {
        idLeftDiv.style.display="";
        imgArrow.status = "expand";
        imgArrow.src = "../../../system/images/prev_orange.gif";
    }
    
}
//------------------------------------------------
function OnSearch()
{
    if(check_init==1)
	{
		grdSalary.ClearData();
		grdDis.ClearData();
		datEmployee_Main_Search.Call("SELECT");
	}	
}
//-------------------------------------------------
function OnClickRow()
{
    var icurpage=idTab.GetCurrentPageNo();    

    txtEmpPK.text=grdEmployee.GetGridData(grdEmployee.row,0);
    
    if (icurpage==0) //contract tab
    {
        datEmployee_Detail_2.Call("SELECT");
    }
    else if (icurpage==1) //discip tab
    {
        datEmployee_Detail_3.Call("SELECT");
    }
    else if (icurpage==2) //salary tab
    {
        grdSalary.ClearData()
        datEmployee_Detail_1.Call("SELECT");
    }
    else if (icurpage==3) //salary change tab
    {
        grdSalary2.ClearData();
        datEmployee_Detail_4.Call("SELECT");
    }
}
//--------------------------------------------------
function OnDataReceive(obj)
{
       if (obj.id=="datEmployee_Main_Search")
       {
            txtEmpPK.text='';
            auto_resize_column(grdEmployee,0,grdEmployee.cols-1,0)
        }
       else if (obj.id=="datEmployee_Detail_1")     
       {
            auto_resize_column(grdSalary,0,grdSalary.cols-1,0)
            //set_color(0,grdSalary.cols-1,grdSalary);
       }    
       else if (obj.id=="datEmployee_Detail_2")     
            auto_resize_column(grdCT,0,grdCT.cols-1,0)     
       else if (obj.id=="datEmployee_Detail_3")
            auto_resize_column(grdDis,0,grdDis.cols-1,0)
       else if (obj.id=="datEmployee_Detail_4")
       {
            auto_resize_column(grdSalary2,0,grdSalary2.cols-1,0);
            set_color(2,11,grdSalary2);
       }
		else if (obj.id=="datUser_info")
		{
            ChangeColorItem(lstOrg.GetControl());
            datSal_security.Call();
		}	
       else if (obj.id=="datSal_security")
       {
    
         if(txt_sal_security.text=='N') 
           {
               idTab.HideTab(2)  //an tab salary   
               grdCT.GetGridControl().ColHidden(G1_Salary)=1;  // an cot salary grid contract
               grdCT.GetGridControl().ColHidden(G1_Total_Allow)=1;
           }
         datAllowance.Call("SELECT");
       } 
       else if (obj.id=="datAllowance")
       {
            var icol=4; //value of allowance col
            Allowance_Grid_Control(grdSalary);
            Allowance_Grid_Control(grdSalary2);
			check_init=1;
 
       } 
            
}
function Allowance_Grid_Control(obj)
{
    var icol=4; //value of allowance col
    obj.GetGridControl().ColHidden(icol)=!(Number(grdAllowance.GetGridData(1,8)));
    obj.SetGridText(0,icol,grdAllowance.GetGridData(1,0));
            
    icol+=1;
    obj.GetGridControl().ColHidden(icol)=!(Number(grdAllowance.GetGridData(1,9)));
    obj.SetGridText(0,icol,grdAllowance.GetGridData(1,1));
            
    icol+=1;
    obj.GetGridControl().ColHidden(icol)=!(Number(grdAllowance.GetGridData(1,10)));
    obj.SetGridText(0,icol,grdAllowance.GetGridData(1,2));
            
    icol+=1;
    obj.GetGridControl().ColHidden(icol)=!(Number(grdAllowance.GetGridData(1,11)));
    obj.SetGridText(0,icol,grdAllowance.GetGridData(1,3));
            
    icol+=1;
    obj.GetGridControl().ColHidden(icol)=!(Number(grdAllowance.GetGridData(1,12)));
    obj.SetGridText(0,icol,grdAllowance.GetGridData(1,4));
            
    icol+=1;
    obj.GetGridControl().ColHidden(icol)=!(Number(grdAllowance.GetGridData(1,13)));
    obj.SetGridText(0,icol,grdAllowance.GetGridData(1,5));
            
    icol+=1;
    obj.GetGridControl().ColHidden(icol)=!(Number(grdAllowance.GetGridData(1,14)));
    obj.SetGridText(0,icol,grdAllowance.GetGridData(1,6));
            
    icol+=1;
    obj.GetGridControl().ColHidden(icol)=!(Number(grdAllowance.GetGridData(1,15)));
    obj.SetGridText(0,icol,grdAllowance.GetGridData(1,7));
}
//---------------------------------------------------
function auto_resize_column(obj,col1,col2,font_size)
{
  if(font_size!=0)
        obj.GetGridControl().FontSize =font_size;   
  obj.GetGridControl().AutoSize(col1,col2,false,0);  
}
function onPageActive()
{
    var icurpage=idTab.GetCurrentPageNo();
    if (icurpage==0) //salary tab
    {
        grdSalary.ClearData()
        datEmployee_Detail_1.Call("SELECT");
    }
    else if (icurpage==1) //contract tab
    {
        datEmployee_Detail_2.Call("SELECT");
    }
    else if (icurpage==2) //discip tab
    {
        datEmployee_Detail_3.Call("SELECT");
    }
    else if (icurpage==3) //salary change tab
    {
        
        datEmployee_Detail_4.Call("SELECT");
    }
}
function set_color(col1,col2,obj)
{
    var ctrl=obj.GetGridControl();
    //alert("Change 1" + ctrl.rows);
    for(var i=1;i<ctrl.rows - 1;i++)
        for(var j=col1;j<=col2;j++)
            if(obj.GetGridData(i,j)!=obj.GetGridData(i + 1,j))
            {
                    obj.SetCellBgColor(i + 1, j,i+ 1, j, 0x3366FF );
            }   
}

//--------------------------------------------------
function OnReport()
{
    if(txtEmpPK.text=="" || txtEmpPK.text==null)
    {
        alert("Please select employee to print");
        return;
    }
    var url=System.RootURL + '/reports/ch/ae/rpt_emp_history.aspx?emp_pk='+txtEmpPK.text+ '&sal_yn='+ txt_sal_security.text;    
    window.open(url);
}
//-----------------------------------------------
function OnShowPopup()
{
        var fpath = System.RootURL + "/form/ch/ae/chae00010_org.aspx?";
        var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:no;status:no;dialogWidth:20;dialogHeight:20;dialogLeft:60;dialogTop:200;edge:sunken;scroll:no;unadorned:yes;help:no');
        if (obj!=null)
        {
             lstOrg.value=obj;
        }
}
function OnTabClick()
{
    if(txtEmpPK.text!='')
        OnClickRow();
}

</script>
<body >
<!-------------------data control----------------------->
<!-- Kiem tra quyen xem luong ---------------------------------------->
    <gw:data id="datSal_security" onreceive="OnDataReceive(this)"  > 
            <xml>
                <dso  type="process" procedure="HR_PRO_10010003_SAL_DISPLAY"  > 
                    <input>
                        <input bind="iduser_pk" />
                    </input> 
                    <output>
                        <output bind="txt_sal_security" />
                    </output>
                </dso> 
            </xml> 
    </gw:data>
<!------------------------------------------------------>
<gw:data id="datAllowance" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="grid" function="HR_SP_SEL_ALLOWANCE_SALARY" > 
                <input bind="grdAllowance" >
                </input>
                <output  bind="grdAllowance" />
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datEmployee_Main_Search"  onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="grid"   function="HR_SEL_10010013_EMP_HIS" > 
                <input bind="grdEmployee" >
                    <input bind="lstOrg" />
                    <input bind="chkTemp" />
                    <input bind="txtTemp" />
					<input bind="lstNation" />
					
                </input>
                <output  bind="grdEmployee" />
            </dso> 
        </xml> 
</gw:data>
<!-------------------------------------------------------------->
<gw:data id="datEmployee_Detail_1" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="grid"   function="HR_SEL_10010013_EMP_SAL_HIS" > 
                <input bind="grdSalary" >
                <input bind="txtEmpPK" />
                </input>
                <output  bind="grdSalary" />
            </dso> 
        </xml> 
</gw:data>
<!-------------------------------------------------------------->
<gw:data id="datEmployee_Detail_2" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="grid"   function="HR_SEL_10010013_CONTRACT_HIS" > 
                <input bind="grdCT" >
                <input bind="txtEmpPK" />
                </input>
                <output  bind="grdCT" />
            </dso> 
        </xml> 
</gw:data>
<!-------------------------------------------------------------->
<gw:data id="datEmployee_Detail_3" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="grid"   function="HR_SEL_10010013_EMP_DIS_HIS" > 
                <input bind="grdDis" >
                <input bind="txtEmpPK" />
                </input>
                <output  bind="grdDis" />
            </dso> 
        </xml> 
</gw:data>
<!-------------------------------------------------------------->
<gw:data id="datEmployee_Detail_4" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="grid"   function="HR_SEL_10010013_sal_change_his" > 
                <input bind="grdSalary2" >
                <input bind="txtEmpPK" />
                </input>
                <output  bind="grdSalary2" />
            </dso> 
        </xml> 
</gw:data>
<gw:data id="datDeptData" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="list" procedure="HR_SP_PRO_DEPT_DATA_ALL" > 
                <input>
                    <input bind="txtUpperDept" /> 
                </input> 
                <output>
                    <output bind="txtDeptData" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<!------------------------------------->
<gw:data id="datGroupData" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="list" procedure="hr.sp_pro_group_data_all" > 
                <input>
                    <input bind="lstOrg" /> 
                </input> 
                <output>
                    <output bind="txtGroupData" />
                </output>
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
                    <output bind="lstOrg" />
                </output>
            </dso> 
        </xml> 
</gw:data>


<!----------------------------------->
<table  border="1" width="100%" height="100%" cellpadding="0" cellspacing="0" >
    <tr> 
        <td  id="idLeftDiv" valign="top" width="40%" height="100%">
        
            <table width="100%" height="100%" cellpadding=0 cellspacing=0 border=0 class="itable">
			    <tr   style="border:0;height:5%">
			        <td width="20%" style="border:0"  align="right" valign="middle"><a title="Click here to show organization" onclick="OnShowPopup()" href="#tips" style="text-decoration : none; color=#0000FF">Organization</a></td>
				    <td width="70%" style="border:0" colspan=4>
					    <gw:list  id="lstOrg" value="ALL" styles='width:100%' onchange=""> 
					    <data>
                                <%=ESysLib.SetListDataSQL("select a.pk,lpad('.',level*2-1,'.')|| a.org_nm from tco_org a  where a.del_if = 0 and (a.tco_company_pk=nvl('" + session("COMPANY_PK") + "',a.tco_company_pk) or '" + session("HR_LEVEL") + "'='6')  AND NVL(A.END_DATE,TO_CHAR(SYSDATE+1,'YYYYMMDD')) >  TO_CHAR(SYSDATE,'YYYYMMDD') connect by prior a.pk = a.p_pk start with nvl(a.p_pk,0)=0 order siblings by a.org_id")%>|ALL|Select All
                            </data></gw:list>
				    </td>
				    <td width=10%></td>
			    </tr>
				<tr  style="border:0;height:5%" >
				    <td align="right">Nation</td>
						<td width="40%" ><gw:list  id="lstNation" value='01' maxlen = "100" styles='width:100%' >
							<data><%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0009' order by code_nm")%>|ALL|Select All</data></gw:list></td>
				</tr>
				<tr  style="border:0;height:5%">
		            <td width="25%" style="border:0" align="right">Search by</td>
		            <td width="25%" style="border:0">									
			            <gw:list  id="chkTemp" value="2" styles="color:blue;width:100%" onchange=""> 
					            <data> LIST|1|Full Name|2|Emp ID|3|Card ID|4|Person ID</data> 
			            </gw:list>
		            </td>
		            <td width="20%" style="border:0" align=right><gw:textbox id="txtTemp" styles="color:blue;width:98%"  onenterkey ="OnSearch()"  /></td>
		            <td width="15%" style="border:0" align="right"><gw:imgBtn id="ibtnSearch"  alt="Search"  img="search" text="Search"  onclick="OnSearch()" /></td>
		            <td width="15%" style="border:0" align="right"><gw:imgBtn id="ibtnRPT"  alt="Report"  img="excel" text=""  onclick="OnReport()" /></td>
				</tr >
		        <tr  style="border:1;height:85%">
		            <td colspan=6 style="width:100%;height:100%">
		               <table border=1 width=100% style="height:100%" cellspacing=0 border=0>
		                    <tr>
		                        <td>
		                            <gw:grid   
			                        id="grdEmployee"  
			                        header="_PK|Full Name|Emp ID|Join DT|PERSON ID"
			                        format="0|0|0|0|0"  
			                        aligns="0|0|0|0|0"
			                        defaults="||||"  
			                        editcol="0|0|0|0|0"  
			                        widths="0|2500|1000|1500|1000"  
			                        styles="width:100%; height:100%"   
			                        sorting="T"   oncellclick ="OnClickRow()"
			                        param="0,1,2,3,4"   />
		                        </td>
		                    </tr>
		               </table>
		            </td>
		        </tr>
	        </table>
	    </td>     
        <td  id="idRightDiv" align="top" height="100%">
            <gw:tab id="idTab" onpageactivate="OnTabClick()">
	            <table  name="Contract" align = top  cellspacing=0 cellpadding=0 border=1 style="width:100%;height:100%;" >
		            <tr> 
		                <td align = top  >
			                <gw:grid   
                                id="grdCT"  
                                header="Times|Contract Date|Contract Kind|Salary|Total Allowance"   
			                    format="0|0|0|1|0"  
			                    aligns="0|0|0|2|0"  
			                    defaults="||||"  
			                    editcol="0|0|0|0|0|0"  
			                    widths="3000|3000|1500|1500"  
			                    styles="width:100%; height:100%"   
			                    sorting="T"   
                                /> 
			            </td>
			        </tr>
	            </table>
	            <table   name="Discipline" align = top  cellspacing=0 cellpadding=0 border=1 style="width:100%;height:100%;" >
		            <tr> 
		                <td align = top  >
			               <gw:grid   
                               id="grdDis"  
                                header="No|Date|Level|Reason|Remark"   
                                format="0|0|0|0|0"  
                                aligns="0|1|0|1|0"  
                                defaults="||||"  
                                editcol="0|0|0|0|0"  
                                widths="1000|1000|2500|1000|2500"  
                                styles="width:100%; height:100%"   
                                sorting="T"   
                                /> 
		                </td> 
		            </tr>
	            </table>
	            <table  name="Salary" align = top  cellspacing=0 cellpadding=0 border=1 style="width:100%;height:100%;" >
		            <tr> 
		                <td align = top  >
			                <gw:grid   
                                id="grdSalary"  
                                header="Organization|Month|Salary|Confirm DT|Allow 1|Allow 2|Allow 3|Allow 4|Allow 5|Allow 6|Allow 7|Allow 8|Total Allowance|Position"   
			                    format="0|0|1|0|1|1|1|1|1|1|1|1|1|0"  
			                    aligns="0|0|2|0|1|1|1|1|1|1|1|1|1|0"  
			                    defaults="|||||||||||||"  
			                    editcol="0|0|0|0|0|0|0|0|0|0|0|0|0|0"  
			                    widths="3000|1500|1500|1500|1000|1000|1000|1000|1000|1000|1000|1000|1500|1500"  
			                    styles="width:100%; height:100%"   
			                    sorting="T"   
                                /> 
			            </td>
			        </tr>
	            </table>
                <table  name="Salary Change" align = top  cellspacing=0 cellpadding=0 border=1 style="width:100%;height:100%;" >
		            <tr> 
		                <td align = top  >
			                <gw:grid   
                                id="grdSalary2"  
                                header="Organization|Month|Salary|Confirm DT|Allow 1|Allow 2|Allow 3|Allow 4|Allow 5|Allow 6|Allow 7|Allow 8|Total Allowance|Position"   
			                    format="0|0|1|0|1|1|1|1|1|1|1|1|1|0"  
			                    aligns="0|0|2|0|1|1|1|1|1|1|1|1|1|0"  
			                    defaults="|||||||||||||"  
			                    editcol="0|0|0|0|0|0|0|0|0|0|0|0|0|0"  
			                    widths="3000|1500|1500|1500|1000|1000|1000|1000|1000|1000|1000|1000|1500|1500"  
			                    styles="width:100%; height:100%"   
			                    sorting="T"   
                                /> 
			            </td>
			        </tr>
	            </table>
	        </gw:tab>
        </td>
    </tr>
</table>
	<img status="expand" id="imgArrow" src="../../../system/images/prev_orange.gif" style="cursor:hand;position:absolute;left:4;top:6;" onclick="OnToggle()"  /> 
<gw:textbox id="txtEmpPK" styles="display:none"/>
<gw:textbox id="txtDept" styles="display:none"/>	
<gw:textbox id="txtDeptData" styles="display:none"/>
<gw:textbox id="txtUpperDept" styles="display:none"/>
<gw:textbox id="txtGroupData" styles="display:none"/>
<gw:textbox id="txtPhoto_PK" styles="display:none"/>
<gw:textbox id="iduser_pk" styles="display:none"/>
<gw:textbox id="txt_sal_security" styles="display:none"/>
<gw:textbox id="txtHr_level" styles="display:none"/>
<gw:list  id="lstWorkGroup" value='ALL' maxlen = "100" styles="display:none"><data>|ALL|Select All</data></gw:list>
 <gw:grid   
    id="grdAllowance"  
    header="Code Name 1|Code Name 2|Code Name 3|Code Name 4|Code Name 5|Code Name 6|Code Name 7|Code Name 8|Display 1|Display 2|Display 3|Display 4|Display 5|Display 6|Display 7|Display 7"
    format="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"  
    aligns="0|2|2|1|0|0|1|1|2|1|0|0|0|0|0|0"  
    defaults="||||||||||||||"  
    editcol="0|0|0|0|0|1|1|1|1|1|0|0|0|0|0|0"  
    widths="0|1500|1600|1000|2500|1500|1700|1500|1700|1500|1500|1200|1200|1200|1200|1200"  
    styles="display:none" 
    sorting="T"    
/> 
</html>
