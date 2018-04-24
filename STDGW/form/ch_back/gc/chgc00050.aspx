<!-- #include file="../../../system/lib/form.inc"  -->
 <% ESysLib.SetUser("hr")%>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Untitled Page</title>
</head>
<script>
var binit=true;
var user;
var v_language = "<%=Session("SESSION_LANG")%>";
var bgrp=true;
function BodyInit()
{
   iduser_pk.text = "<%=session("USER_PK")%>";
   txtHr_level.text= "<%=session("HR_LEVEL")%>";
   grdProduct_Salary.GetGridControl().FrozenCols =3;
   ChangeHeader('N');
   user="<%=session("USER_ID")%>";
   if((Trim(iduser_pk.text)!="")&&(txtHr_level.text=="1")) //QUYEN BI GIOI HAN 
    {
        datUser_info.Call();     	    
    }
}
//--------------------------------
function ChangeHeader()
{
    if (lstGroup_Special.value=='N')
    {
        grdProduct_Salary.SetGridText(0,7,'Labour Price');
        grdProduct_Salary.GetGridControl().ColFormat(7) = "(#,###.#)";
        grdProduct_Salary.GetGridControl().ColHidden(1)=0;
        grdProduct_Salary.GetGridControl().ColHidden(2)=0;
        grdProduct_Salary.GetGridControl().ColHidden(3)=0;
        grdProduct_Salary.GetGridControl().ColHidden(7)=0;
    }
    else
    {
        grdProduct_Salary.SetGridText(0,7,'Ratio');
        grdProduct_Salary.GetGridControl().ColHidden(7)=1;
        grdProduct_Salary.GetGridControl().ColHidden(1)=1;
        grdProduct_Salary.GetGridControl().ColHidden(2)=1;
        grdProduct_Salary.GetGridControl().ColHidden(3)=1;
    }
}

//----------------------------------
function OnShowPopup()
{
    
    var fpath = System.RootURL + "/form/ch/ae/chae00010_dept.aspx";
    var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:no;status:no;dialogWidth:20;dialogHeight:20;dialogLeft:10;dialogTop:240;edge:sunken;scroll:no;unadorned:yes;help:no');
    if (obj!=null)
    {
        txtUpperDept.text=obj;
        datDeptData.Call();
    }
}
//-----------------------------------------------------

function TabPopUp()
{
    
    var fpath = System.RootURL + "/form/fp/ab/PopUpGetOneItem.aspx?purchase_yn=N&item_code=" + txtItemCode.text + "&item_name=" + txtItemName.text; 	
    var aValue  = System.OpenModal(  fpath , 800 , 550 , 'resizable:no;status:yes');	
    if ( aValue != null )  
    {            
        txt_tco_item_pk.text = aValue[0] ;
        txtItemCode.text     = aValue[1];					
        txtItemName.text     = aValue[2];
    }
}
//--------------------------
function OnSearch()
{
    datProductSalary.Call("SELECT");
}
//------------------------------------------------
function OnChangeDept()
{
    datGroupData.Call();
}
//-------------------------------------------------
function OnDataReceive(obj)
{
   if (obj.id=="datDeptData")
   {
        if(txtHr_level.text=="6")
                txtDeptData.text=txtDeptData.text+"|ALL|Select All";
            lstDept_Code.SetDataText(txtDeptData.text)    ;
            
              obj=lstDept_Code.GetControl()
		    if (obj.options.length ==2)
			    obj.options.selectedIndex=0;
		    else
			    obj.options.selectedIndex=0;
        datGroupData.Call();
   }
   else if (obj.id=="datUser_info")
   {
        lstDept_Code.SetDataText(txtDeptData.text);
        datGroupData.Call();
   }
   else if (obj.id=="datGroupData")
   {
        obj=lstGrp_Code.GetControl();
	    if (obj.options.length ==2)
		    obj.options.selectedIndex=0;
	    else
		    obj.options.selectedIndex=obj.options.length-1;
        datTaskData.Call();
        
   }
   else if (obj.id=="datTaskData")
   {
        obj=lstTask_Code.GetControl();
	    if (obj.options.length ==2)
		    obj.options.selectedIndex=0;
	    else
		    obj.options.selectedIndex=obj.options.length-1;
        
   }
   else if (obj.id=="datFind_Report")
   {
        var url=System.RootURL;
        url=url + '/reports/ch/gc/'+txtReport_tmp.text+'?p_tco_dept_pk=' + lstDept_Code.value + '&p_thr_group_pk=' + lstGrp_Code.value 
        + '&p_month=' + dtMonth.value + '&p_tco_item_pk=' + txt_tco_item_pk.text + '&p_itemcode=' + txtItemCode.text + '&p_itemname=' + txtItemName.text ;
        window.open(url); 
   }
   else if (obj.id=="datProductSalary")
   {
        ChangeHeader();
        lblRecord.text=grdProduct_Salary.rows-1 + " rec(s)";
        
        GroupTotal(2);
   }
   
}
function OnReport(obj)
{
    txtReport_tmp.text="rpt_item_result.aspx";
    datFind_Report.Call();
}

//-----------------------------------------------
function OnReset()
{
    txt_tco_item_pk.text="";
    txtItemCode.text="";
    txtItemName.text="";
}
//-------------------------------------
function OnChangeGroup()
{
    datTaskData.Call();
}
//-----------------------------------------------
function GroupGrid()
{
    if (bgrp==false)
    {
        GroupTotal(2)
        bgrp=true;
        ibtnGroupGrid.SetHint("Remove group total");
    }
    else
    {
        GroupTotal(1);
        bgrp=false;
        ibtnGroupGrid.SetHint("Group total");
    }
}
//----------------------------------------
function GroupTotal(hidetype)
{
    var ctrl=grdProduct_Salary.GetGridControl();
    ctrl.OutlineBar =2 ;
    ctrl.MergeCells = 3; // RestricCol or 4
    ctrl.MergeCol(0) = true;
    ctrl.MergeCol(1) = true;
    ctrl.MergeCol(2) = true;
    var caption;
    var color;
    var maxgroup;
    if (lstGroup_Special.value=='Y')
        maxgroup=0;
    else
        maxgroup=1;
    for (var igroup=0;igroup<=maxgroup;igroup++)
    {
        switch (igroup)
        {
            case 0:
            {
                color=0x99FF99;
                caption='Total:%s';
                break;
            }
            case 1:
            {
                color=0x99FFFF;
                caption='Item:%s';
                break;
            }
            
        }
        ctrl.SubTotal(hidetype,igroup, 7 ,'',color,0x000000,'1',caption,'',true);
        ctrl.SubTotal(hidetype,igroup, 8 ,'',color,0x000000,'1',caption,'',true);
        ctrl.SubTotal(hidetype,igroup, 9 ,'',color,0x000000,'1',caption,'',true);            
    }
}
//-------------------------------------------
function OnClickGrid()
{
    var p_group_special,p_month,p_emp_pk,p_item_pk;
    var iemp_pk=10;
    var iitem_pk=11;
    var imonth=12;
    var igroup_special=13;
    var irow=grdProduct_Salary.row;
    p_emp_pk=grdProduct_Salary.GetGridData(irow,iemp_pk);
    p_item_pk=grdProduct_Salary.GetGridData(irow,iitem_pk);
    p_group_special=grdProduct_Salary.GetGridData(irow,igroup_special);
    p_month=grdProduct_Salary.GetGridData(irow,imonth);
    if (p_emp_pk!="")
    {
        var fpath = System.RootURL + "/form/ch/gc/chcs0050_detail.aspx?l_group_special=" + p_group_special + "&l_month=" + p_month + "&l_emp_pk=" + p_emp_pk + "&l_item_pk=" + p_item_pk;
        System.OpenModal(  fpath , 800 , 550 , 'resizable:no;status:yes');	
    }            
}
</script>
<body >

<!------------------------------------->
<gw:data id="datGroupData" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="list" procedure="hr.sp_pro_group_data_all" > 
                <input>
                    <input bind="lstDept_Code" /> 
                </input> 
                <output>
                    <output bind="lstGrp_Code" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<!-------------------data control----------------------->

<gw:data id="datDeptData" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="list" procedure="comm.sp_pro_dept_data_all" > 
                <input>
                    <input bind="txtUpperDept" /> 
                </input> 
                <output>
                    <output bind="txtDeptData" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<!-------------------data control----------------------->
<gw:data id="datUser_info" onreceive="OnDataReceive(this)"  > 
        <xml>
            <dso  type="list" procedure="hr.sp_sel_user_role2"  > 
                <input>
                    <input bind="iduser_pk" />
                </input> 
                <output>
                    <output bind="lstDept_Code" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<!-------------------data control----------------------->
<gw:data id="datProductSalary" onreceive="OnDataReceive(this)" > 
    <xml> 
        <dso  type="grid" function="hr.sp_sel_product_salary"  parameter="" procedure="" > 
            <input  bind="grdProduct_Salary" > 
                <input bind="lstDept_Code" /> 
                <input bind="lstGrp_Code" /> 
                <input bind="dtMonth" /> 
                <input bind="txt_tco_item_pk" /> 
                <input bind="txtItemCode" /> 
                <input bind="txtItemName" /> 
                <input bind="txtEmpID" /> 
                <input bind="lstTask_Code" /> 
                <input bind="txtSale_Order" /> 
                <input bind="lstGroup_Special" /> 
            </input> 
            <output bind="grdProduct_Salary" /> 
        </dso> 
   </xml> 
</gw:data> 
<!-------------------data control----------------------->
<gw:data id="datTaskData" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="list" procedure="hr.sp_pro_task_data_all" > 
                <input>
                   <input bind="lstDept_Code" /> 
                   <input bind="lstGrp_Code" />
                </input> 
                <output>
                    <output bind="lstTask_Code" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<!-------------------data control----------------------->
<gw:data id="datFind_Report" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr.sp_pro_find_report" > 
                <input>
                    <input bind="txtReport_tmp" /> 
                </input> 
                <output>
                    <output bind="txtReport_tmp" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<!-------------------data control----------------------->
   <table  id="management" width="100%" cellpadding="0" cellspacing="0" border=1 style="width:100%;height:100%;">
        <tr style="width:100%;height:100%" valign="top">
            <td>
               <table width="100%" id="tblexp" style="height:100%" border=1 cellpadding="0" cellspacing="0">
                    <tr style="border:1;width:100%;height:5%" valign="center" >
                        <td width="8%" align="right" style="border:0;"><a title="Click here to show department" onclick="OnShowPopup()" href="#tips" >Department</a>                  
                        </td>
                        <td width="12%" align="left" style="border:0;">
                         <gw:list  id="lstDept_Code" value='ALL' maxlen = "100" styles='width:100%' onchange="OnChangeDept(lstDept_Code)" >
                            <data>
                                <%=ESysLib.SetListDataSQL("select pk,dept_nm from comm.tco_dept a where del_if=0 order by a.dept_id")%>|ALL|Select All
                            </data>
                        </gw:list>
                        </td>
                        <td width="8%" align="right" style="border:0;">Group</td>
                        <td width="13%"  align="left" style="border:0;">
                         <gw:list  id="lstGrp_Code" value='ALL' maxlen = "100" styles='width:100%' onchange="OnChangeGroup()">
                            <data><%=Esyslib.SetListDataSQL("SELECT pk,Group_NM FROM Thr_Group WHERE DEL_IF = 0 and use_yn='Y'  order by seq, Group_NM" )%>|ALL|Select All</data></gw:list>
                        </td>
                        <td  colspan=2 width="10%"  align="right" valign="middle" style="border:0;">Task</td>
					    <td   width="15%" style="border:0;">
					        <gw:list  id="lstTask_Code" value='ALL'  maxlen = "40" styles='width:100%' onchange="" >
                            <data>
                                <%=Esyslib.SetListDataSQL("select a.PK, a.TASK_NAME from prod.tpr_task a where a.DEL_IF=0 and a.USE_YN = 'Y' order by task_name" )%>|ALL|Select All
                            </data>
                            </gw:list>
				        </td>
				        <td  width="5%" style="border:0;" align="right" >Type
                         </td>
                        <td width="8%" style="border:0;" align="left" >
				         <gw:list  id="lstGroup_Special" value='N'  maxlen = "40" styles='width:100%'  >
                            <data>|N|Normal|Y|Special</data>
                            </gw:list>
				        </td> 
				        <td   width="5%"  align="right" valign="middle" style="border:0;">Emp ID</td>
				        <td width="7%" style="border:0;" align="left" >
				         <gw:textbox id="txtEmpID"	styles="width:100%" onenterkey="OnSearch()" />
				        </td>
				        <td  width="3%" style="border:0;" align="right" >
                         <gw:imgBtn img="search" id="ibtnSearch"   alt="Search"  onclick="OnSearch()"/></td>
                        <td width="3%" style="border:0;" align="right">
                             <gw:imgBtn img="adjust" id="ibtnGroupGrid"   alt="Remove group total"  onclick="GroupGrid()"/>
                        </td>
				        
                        <td width="3%" style="border:0" align="right">
                        <gw:imgBtn img="excel" id="ibtnReport"    alt="Report"  onclick="OnReport()"/></td>
                        
                    </tr>
                    <tr style="border:1;width:100%;height:5%" valign="center" >
                        <td  align="right" style="border:0;"><a title="Click here to show Item"  onclick="TabPopUp()" href="#tips" >Item</a></td>
                        <td  align="left" style="border:0;">
                         <gw:textbox id="txtItemCode"	styles="width:100%" onenterkey="OnSearch()" />
                        </td>
                        <td  colspan=2 align="right" style="border:0;"><gw:textbox id="txtItemName"	styles="width:100%" onenterkey="OnSearch()" /></td>
                        <td  width="3%" style="border:0;" align="center" ><gw:imgBtn img="Reset" id="ibtnReset"   alt="Reset Item"  onclick="OnReset()"/></td>
                        <td  width="5%" align="right" style="border:0;">Month</td>
                        <td    style="border:0;">
					        <gw:datebox id="dtMonth"  text="" maxlen = "10" styles='width:90%' lang="<%=Session("Lang")%>" type="month"  />                  
				        </td>
				         <td   colspan=2 align="right" style="border:0;">Sale Order</td>
                        <td   colspan=2 style="border:0;">
					        <gw:textbox id="txtSale_Order"	styles="width:100%" onenterkey="OnSearch()" />
				        </td>
                        <td  colspan=3 style="border:0;" align="right" >
                        <gw:label id="lblRecord" styles="width:100%;color:red"></gw:label></td>
                    </tr>
                    <tr style="border:1;width:100%;height:90%" valign="center" >
                       <td colspan=14  style="width:100%;height:100%;"> 
                            <gw:grid id='grdProduct_Salary'
                            header='Group|Item Code|Item Name|Sale Order No|Task Name|Emp ID|Full Name|Labor Price|Quantity|Emp Amount|_Emp_Pk|_Item_pk|_Month|_Group Special|_Group_pk'
                            format='0|0|0|0|0|0|0|0|1|1|0|0|0|0|0'
                            aligns='0|1|0|0|0|1|0|1|1|0|0|0|0|0|0'
                            defaults='||||||||||||||'
                            editcol='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                            widths='2500|1215|2000|1500|1500|1200|2600|1300|1300|1200|0|0|0|0|0'
                            sorting='T'
                            styles='width:100%; height:100%'
                            oncelldblclick="OnClickGrid()"
                            />
                        </td>
                    </tr>
               </table> 
            </td>
        </tr>
    </table>    
</body>
<gw:textbox id="txtReport_tmp" styles="display:none"/>
<gw:textbox id="txt_tco_item_pk" styles="display:none"/>
<gw:textbox id="txtDeptData" styles="display:none"/>
<gw:textbox id="iduser_pk" styles="display:none"/>
<gw:textbox id="txtHr_level" styles="display:none"/>  
<gw:textbox id="txtUpperDept" styles="display:none"/>


</html>
