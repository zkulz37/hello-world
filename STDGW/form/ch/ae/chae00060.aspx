<!-- #include file="../../../system/lib/form.inc"  -->
 <%  ESysLib.SetUser(Session("APP_DBUSER"))%>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Untitled Page</title>
</head>
<script>
var strcodereturn;
var v_language = "<%=Session("SESSION_LANG")%>";
var emp_pk_list;
var print_meal=0;
function BodyInit()
{
    
    

    grdEmployee.GetGridControl().ScrollTrack=true;
    if (v_language!="ENG")
        System.Translate(document);
    txtEmpID.SetEnable(false);
    iduser_pk.text = "<%=session("USER_PK")%>";
    txtHr_level.text= "<%=session("HR_LEVEL")%>";

    menu_id.text=System.Menu.GetMenuID();

     ChangeColorItem(lstOrg_Code.GetControl());

    datCheck_View.Call();

    if((Trim(iduser_pk.text)!="")&&(txtHr_level.text=="1")) //QUYEN BI GIOI HAN 
	{
        datUser_info.Call();     	    
	}
	  
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
                        lstctl.options.item(i).style.color = "FF3333";
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
function OnShowPopup()
{
    var strcom;
    var fpath = System.RootURL + "/form/ch/ae/chae00010_org.aspx?";
    var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:no;status:no;dialogWidth:20;dialogHeight:20;dialogLeft:'+window.event.screenX+';dialogTop:'+window.event.screenY+';edge:sunken;scroll:yes;unadorned:yes;help:no');
    if (obj!=null)
    {
        txtUpperDept.text=obj;
        lstOrg_Code.value=obj;
        //datDeptData.Call();
    }
    
}
//----------------------------------------------
function OnDataReceive(obj)
{
   if(obj.id == "datCheck_View")
   {
        if(txtFlag_View.text == 'Y')
        {
            ibtnDelete.style.display = "none";
            
        }
        if((Trim(iduser_pk.text)!="")&&(txtHr_level.text=="1")) //QUYEN BI GIOI HAN 
	    {
            datUser_info.Call();     	    
	    }
   }
   else if (obj.id=="datEmployee_Card")
   {
        lblRecord.text=grdEmployee.rows-1 + " record(s).";
        if (grdEmployee.rows==1)
            chkCheckAll.value='F';
        else
            chkCheckAll.value='T';
   }
   else if (obj.id=="datUser_info")
   {
        ChangeColorItem(lstOrg_Code.GetControl());
        //datGroupData.Call();
   }
   else if (obj.id=="datFind_Report")
   {
        var url =System.RootURL + '/reports/ch/ae/'+txtReport_tmp.text+'?emp_pk=' + emp_pk_list+'&l_month='+dtMonth.value;   
        window.open(url); 
         
   }    
       
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
//----------------------------------------------------
function OnSearch(obj)
{
    if (obj==2 && txtEmpID.text=="") 
        alert("Please input some employee id");
    else
    {    
        chkCheckAll.value='F';   
        datEmployee_Card.Call("SELECT");
    }
        
}
//-------------------------------------------------------------
function SelectOption(obj)
{
    if (obj==1)
    {
        txtOption.text="1";
        lstTemp.SetEnable(false);
        txtTemp.SetEnable(false);
        txtEmpID.SetEnable(true);
        txtTemp.text="";
        txtEmpID.GetControl().select();
    }
    else if (obj==2)
    {
        txtOption.text="2";
        lstTemp.SetEnable(true);
        txtTemp.SetEnable(true);
        txtEmpID.SetEnable(false);
        txtEmpID.text="";
        txtTemp.GetControl().select();
    }
    
}
//------------------------------------------------------------
function doSelectAll()
{	
	var tmp;
	if( chkCheckAll.GetData()=='T')
		tmp=-1;
	else
		tmp=0;
     var ctrl = grdEmployee.GetGridControl();
    if (ctrl.SelectedRows >0)
        
	    for ( var i =  0 ; i < ctrl.SelectedRows ; i++ )
		    {
			    var row = ctrl.SelectedRow(i);
			    if ( row > 0 )
			    {		
				    grdEmployee.SetGridText(row,0,tmp);
			    }	
		    }
	else
	    for ( var i =  1 ; i < grdEmployee.rows ; i++ )
		    {
				    grdEmployee.SetGridText(i,0,tmp);
		    }
}
//-----------------------------------------------
function OnReport(n)
{
    
    emp_pk_list="";
                
    for (var i=1;i<=grdEmployee.rows-1;i++)
    {
        if (grdEmployee.GetGridData(i,0)=="-1")
        {
            emp_pk_list = emp_pk_list + grdEmployee.GetGridData(i,9) + ",";
        }   
    }
    if (emp_pk_list=="")
        alert("Please choose employees to print");
    else
    {
        emp_pk_list=emp_pk_list.substr(0,emp_pk_list.length-1);
        txtReport_tmp.text=lstReport_Type.value;
		txtOrg_tmp_pk.text=lstOrg_Code.value; 
        datFind_Report.Call();
        
    }
}
//-----------------------------------------------
function OnDelete()
{
    var ctrl = grdEmployee.GetGridControl();
    if (ctrl.SelectedRows >0)
    {
        grdEmployee.DeleteRow();
        datEmployee_Card.Call();
    }
	else
	   alert("Please select employee on the gird before deleting! \n Hãy chọn nhân viên dưới lưới trước khi xóa!");
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
<gw:data id="datUser_info" onreceive="OnDataReceive(this)"  > 
        <xml>
            <dso  type="list" procedure="HR_SP_SEL_USER_ROLE2"  > 
                <input>
                    <input bind="iduser_pk" />
                </input> 
                <output>
                    <output bind="lstOrg_Code" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<!------------------------------------->
<gw:data id="datEmployee_Card" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="grid" function="HR_SEL_10010006_EMPLOYEE_CARD " procedure="HR_UPD_10010006_EMPLOYEE_CARD" parameter="9"> 
                <input>
                    <input bind="lstOrg_Code" /> 
                    <input bind="lstWorkGroup" /> 
                    <input bind="dtFrom_JoinDate" /> 
                    <input bind="dtTo_JoinDate" />
                    <input bind="txtOption" /> 
                    <input bind="txtEmpID" /> 
                    <input bind="lstTemp" /> 
                    <input bind="txtTemp" />
                    <input bind="lstHavePicture" />
					<input bind="lstContract" />
					<input bind="lstNation" />
					<input bind="lstStatus" />
                </input> 
                <output bind="grdEmployee" />
            </dso> 
        </xml> 
</gw:data>

<!------------------------------------------------>
<gw:data id="datFind_Report" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="HR_SP_PRO_FIND_REPORT_2" > 
                <input>
                    <input bind="txtReport_tmp" /> 
                    <input bind="txtOrg_tmp_pk" /> 
                </input> 
                <output>
                    <output bind="txtReport_tmp" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<!-------------------data control----------------------->
   <table id="expand" width="100%" cellpadding="0" cellspacing="0" border=1 style="width:100%;height:100%;">
        <tr style="width:100%;height:100%" valign="top">
            <td>
               <table width="100%" id="tblexp" style="height:100%" border=0 cellpadding="0" cellspacing="0">
                    <tr width="100%">
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
                        <td colspan="5" style="border:0;" align="right" ><a title="Click here to show Organization" onclick="OnShowPopup()" href="#tips" >Organization</a></td>
                        <td colspan="10" style="border:0;" align="left" >
                         <gw:list  id="lstOrg_Code" value='ALL' maxlen = "100" styles='width:100%'onchange="" >
                            <data>
                                <%=ESysLib.SetListDataSQL("select a.pk,lpad('.',level*2-1,'.')|| a.org_nm from tco_org a  where a.del_if = 0 and (a.tco_company_pk=nvl('" + session("COMPANY_PK") + "',a.tco_company_pk) or '" + session("HR_LEVEL") + "'='6')  AND NVL(A.END_DATE,TO_CHAR(SYSDATE+1,'YYYYMMDD')) >  TO_CHAR(SYSDATE,'YYYYMMDD') connect by prior a.pk = a.p_pk start with nvl(a.p_pk,0)=0 order siblings by a.org_id")%>|ALL|Select All
                            </data>
                        </gw:list>
                        </td>
                        <td colspan="5" style="border:0;" align="right">Work Group</td>
				        <td colspan="10" width="7%" style="border:0;">
						 <gw:list  id="lstWorkGroup" value='ALL' maxlen = "100" styles='width:100%' >
							<data><%=ESysLib.SetListDataSQL("select a.PK,a.WORKGROUP_NM from thr_work_group a where a.del_if=0 order by a.WORKGROUP_NM")%>|ALL|Select All</data>
							</gw:list>
						</td>
				        <td colspan="5" style="border:0;" align="right">Contract</td>
                        <td colspan="5" style="border:0;" align="right" colspan="2" >
                         <gw:list  id="lstContract" value='ALL' maxlen = "100" styles='width:100%' >
                            <data><%=ESysLib.SetListDataSQL("select code,code_nm from vhr_hr_code where id='HR0001' order by code_nm")%>|ALL|Select All</data></gw:list>
                        </td>
						<td colspan="2" ></td>
						<td colspan="6" style="border:0;" align="left" >
                         <gw:list  id="lstHavePicture" value='ALL' maxlen = "100" styles='width:100%' >
                            <data>|Y|Yes|N|No|ALL|Have picture-All</data></gw:list>
                        </td>
                        <td  colspan="1"  style="border:0;" align="right" >
                         <gw:imgBtn img="search" id="ibtnSearch"   alt="Search"  onclick="OnSearch(1)"/>
                        </td>
                        <td  colspan="1"  style="border:0" align="right">
                         <gw:imgBtn img="delete" id="ibtnDelete"    alt="Delete Picture"  onclick="OnDelete()"/>
                        </td>
                    </tr>
					<tr style="border:0;width:100%;height:5%" valign="center" >
                        <td colspan="5" style="border:0;" align="right" >Nation</td>
                        
                        <td colspan="10" style="border:0;" align="left" ><gw:list  id="lstNation" value='01' maxlen = "100" styles='width:100%' >
							<data><%=Esyslib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0009' order by code_nm" )%>|ALL|Select All</data></gw:list></td>
                        <td colspan="5" style="border:0;" align="right">Join Date</td>
				        <td colspan="4" style="border:0;"><gw:datebox id="dtFrom_JoinDate" nullaccept styles="width:100%" lang="<%=Session("Lang")%>" /></td>
				        <td colspan="2" style="border:0;" align="center">~</b></td>
				        <td colspan="4" style="border:0;"><gw:datebox id="dtTo_JoinDate" nullaccept styles="width:100%" lang="<%=Session("Lang")%>" /></td>
                        <td colspan="5" style="border:0;" align="right" >Status</td>
                        <td colspan="5" style="border:0;" align="left" >
                         <gw:list  id="lstStatus" value='A' maxlen = "100" styles='width:100%' >
                            <data>|A|Active|R|Resign|ALL|Select ALL</data></gw:list>
                        </td>
                        <td  colspan="2"  style="border:0;" align="right" >Option
                        </td>
                        <td  colspan="6"  style="border:0;" align="right" ><gw:list  id="lstReport_Type" value="rpt_TimeCard.aspx" styles="color:blue;width:100%" onchange=""> 
					             <data><%=ESysLib.SetListDataSQL("select char_2,CODE_NM from vhr_hr_code where id='HR0156' and char_1='chae00060' order by seq")%></data>
			            </gw:list>
                        </td>
                        <td  colspan="2"  style="border:0;" align="right" >
                         <gw:imgBtn img="excel" id="ibtnPrinter"    alt="Report"  onclick="OnReport(1)"/>
                        </td>
                    </tr>
                    <tr style="border:0;width:100%;height:5%" valign="center" >
                       <td colspan="1" style="border:0" align="center"><gw:checkbox id="chkCheckAll" value="F" onclick="doSelectAll()" ></gw:checkbox ></td>
                       <td colspan="2"><font color="black" >Select</font></td>
						<td colspan="7" style="border:0" align="right">
                            <input type="radio"  id="idOption1" name="option" value="1"  onclick="SelectOption(1)"/><font color="black" >Emp ID (in)</font></td>
                        <td style="border:0;" colspan="5" align="right" ><gw:textbox id="txtEmpID"  text="" maxlen = "100" styles='width:100%' onenterkey="OnSearch(2)" />
                        </td>
                       <td colspan="7" style="border:0" align="right" valign="middle">
                            <input type="radio"  id="idOption2" name="option" value="2"  checked onclick="SelectOption(2)"/><font color="black" >Search by</font></td>
					   <td colspan="4" style="border:0">
					        <gw:list  id="lstTemp" value="2" styles='width:100%' onchange=""> 
							        <data>LIST|1|Name|2|Emp ID|3|Card ID</data> 
					        </gw:list>
				        </td>
				        <td colspan="4" style="border:0"> 
					        <gw:textbox id="txtTemp" onenterkey   ="OnSearch()" styles='width:100%'/>
				        </td>
				        <td colspan="5" style="border:0;" align="right" ><font color="black" >Meal Card</font></td>
				        <td colspan="4" style="border:0;" align="left" ><gw:datebox id="dtMonth"  maxlen = "10" text="" styles='width:50%'lang="<%=Session("Lang")%>" type="month" onchange="" />
                        </td>
                        <td colspan="3" style="border:0"> </td>
                        <td style="border:0" colspan="4" align="right"><gw:label id="lblRecord"  text="0 record(s)." maxlen = "100" styles="color:red;width:90%;font-weight: bold;font-size:13" /></td>
						<td></td>
                        
                    </tr>
                    <tr style="border:1;width:100%;height:90%" valign="top">
                        <td colspan="50" style="width:100%;height:100%;"> 
                             <gw:grid   
                                id="grdEmployee"  
                                header="Print|_Department|Team/Section|Full Name|Emp ID|Card ID|Join Date|Person ID|Position|_PK Emp"   
                                format="3|0|0|0|0|0|0|0|0|0"  
                                aligns="0|0|0|0|1|1|1|1|0|0"  
                                defaults="|||||||||"  
                                editcol="1|0|0|0|0|0|0|0|0|0"  
                                widths="1000|1500|1500|2500|1500|1500|1500|2500|200|0"
                                styles="width:100%; height:100%"   
                                sorting="F" 
                                param="0,1,2,3,4,5,6,7,8,9"  /> 
                        </td>
                    </tr>
               </table> 
            </td>
        </tr>
    </table>
</body>
<gw:textbox id="txtDeptData" styles="display:none"/>
<gw:textbox id="txtUpperDept" styles="display:none"/>
<gw:textbox id="txtGroupData" styles="display:none"/>
<gw:textbox id="txtOption" text="2" styles="display:none"/>   
<gw:textbox id="iduser_pk" styles="display:none"/>
<gw:textbox id="txtHr_level" styles="display:none"/>
<gw:textbox id="txtResult" styles="display:none"/>
<gw:textbox id="txtReport_tmp" styles="display:none"/>
<gw:textbox id="txtOrg_tmp_pk" text="" styles="display:none"  />
<gw:textbox id="menu_id" text="" styles="display:none"  />
<gw:textbox id="txtFlag_View" text="" styles="display:none"  />  
</html>
