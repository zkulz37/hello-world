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
function BodyInit()
{
   iduser_pk.text = "<%=session("USER_PK")%>";
   txtHr_level.text= "<%=session("HR_LEVEL")%>";
   grdLabor_Price.GetGridControl().FrozenCols =5;
   grdLabor_Price_1.GetGridControl().FrozenCols =5;
   grdLabor_Price_1.GetGridControl().ColFormat(12) = "(###,###,###)";
   grdLabor_Price_1.GetGridControl().ColFormat(10) = "(####.#%)";
   grdLabor_Price.GetGridControl().ColFormat(8) = "(###,###,###)";
   grdLabor_Price.GetGridControl().ColFormat(9) = "(####.#)";
   user="<%=session("USER_ID")%>";
   if((Trim(iduser_pk.text)!="")&&(txtHr_level.text=="1")) //QUYEN BI GIOI HAN 
    {
        datUser_info.Call();     	    
    }
    else
        binit=false;
   
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
function OnSearch(objdat)
{
    objdat.Call("SELECT");
}
//--------------------------------------------------
function OnChangeDept(obj)
{
    
    switch (tabMain.GetCurrentPageNo())
    {
        case 0:
            txtDept.text=lstDept_Code.value ;
            break;
        case 1:
            txtDept.text=lstDept_Code_1.value ;
            break;
        
    }    
    datGroupData.Call();
}
//-------------------------------------------------------------
function ChoseList_box(obj_list,value)
{
    obj_list.SetDataText(value)    ;
    obj=obj_list.GetControl();
	if (obj.options.length ==2)
		obj.options.selectedIndex=0;
	else
		obj.options.selectedIndex=obj.options.length-1;
}
//-------------------------------------------------
function OnDataReceive(obj)
{
   if (obj.id=="datDeptData")
   {
        if(txtHr_level.text=="6")
                txtDeptData.text=txtDeptData.text+"|ALL|Select All";
        switch (tabMain.GetCurrentPageNo())
        {
            case 0:
                lstDept_Code.SetDataText(txtDeptData.text);
                txtDept.text=lstDept_Code.value;
                break;
            case 1:
                lstDept_Code_1.SetDataText(txtDeptData.text);
                txtDept.text=lstDept_Code_1.value;
                break;
           
        }  
        datGroupData.Call();
   }
   else if (obj.id=="datUser_info")
   {
        lstDept_Code.SetDataText(txtDeptData.text);
        lstDept_Code_1.SetDataText(txtDeptData.text);
        txtDept.text=lstDept_Code.value;
        datGroupData.Call();
   }
   else if (obj.id=="datGroupData")
   {
        if (binit==true)
        {
            ChoseList_box(lstGrp_Code,txtGroupData.text);
            ChoseList_box(lstGrp_Code_1,txtGroupData.text);
            txtDept.text=lstDept_Code.value;
            txtGroupData.text=lstGrp_Code.value;
        }
        switch (tabMain.GetCurrentPageNo())
        {
            case 0:
            {
                ChoseList_box(lstGrp_Code,txtGroupData.text);
                txtDept.text=lstDept_Code.value;
                txtGroupData.text=lstGrp_Code.value;
                break;
            }
            case 1:
            {
                ChoseList_box(lstGrp_Code_1,txtGroupData.text);
                txtDept.text=lstDept_Code_1.value;
                txtGroupData.text=lstGrp_Code_1.value;
                break;
            }
            
        }  
        datTaskData.Call();
        
   }
   else if (obj.id=="datTaskData")
   {
        if (binit==true)
        {
            ChoseList_box(lstTask_Code,txtTask.text);
            ChoseList_box(lstTask_Code_1,txtTask.text);
            binit=false;
        }
        switch (tabMain.GetCurrentPageNo())
        {
            case 0:
            {
                alert(txtTask.text);
                ChoseList_box(lstTask_Code,txtTask.text);
                break;
            }
            case 1:
            {
                ChoseList_box(lstTask_Code_1,txtTask.text);
                break;
            }
            
        }
   }
   else if (obj.id=="datFind_Report")
   {
        var url=System.RootURL;
        if(tabMain.GetCurrentPageNo()==0)
        {
        url=url + '/reports/ch/gc/'+txtReport_tmp.text + '?p_dept='+lstDept_Code.value+'&p_group='+lstGrp_Code.value+'&p_emp_id='+txtEmpID.text ;
        url+='&p_item_code='+txtItemCode.text+'&p_item_nm='+txtItemName.text+'&p_from_dt='+dtFromDate.value+'&p_to_dt='+dtToDate.value ;
        url+='&p_sale_no='+txtSale_Order.text+'&p_task='+lstTask_Code.value+'&p_item_pk='+txt_tco_item_pk.text;
        }
        else
        {
        url=url + '/reports/ch/gc/'+txtReport_tmp.text + '?p_dept='+lstDept_Code_1.value+'&p_group='+lstGrp_Code_1.value+'&p_emp_id='+txtEmpID_1.text ;
        url+='&p_item_code='+txtItemCode_1.text+'&p_item_nm='+txtItemName_1.text+'&p_from_dt='+dtFromDate_1.value+'&p_to_dt='+dtToDate_1.value ;
        url+='&p_sale_no='+txtSale_Order_1.text+'&p_task='+lstTask_Code_1.value+'&p_item_pk='+txt_tco_item_pk_1.text;
        }
        window.open(url); 
   }
   else if (obj.id=="datLabourPrice")
   {
        lblRecord.text=grdLabor_Price.rows-1 + " rec(s)";
        
        var caption;
        var ctrl=grdLabor_Price.GetGridControl();
        ctrl.OutlineBar =2 ;
        ctrl.MergeCells = 3; // RestricCol or 4
        ctrl.MergeCol(0) = true;
	    ctrl.MergeCol(1) = true;
	    ctrl.MergeCol(2) = true;
	    ctrl.MergeCol(3) = true;
        ctrl.MergeCol(4) =true	;
        var color;
        for (var igroup=0;igroup<=2;igroup++)
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
                    caption='Group:%s';
                    break;
                }
                case 2:
                {
                    color=0xFFCCFF;
                    caption='Item:%s';
                    break;
                }
            }
            ctrl.SubTotal(2,igroup, 8 ,'',color,0x000000,'1',caption,'',true);
            ctrl.SubTotal(2,igroup, 9 ,'',color,0x000000,'1',caption,'',true);
            ctrl.SubTotal(2,igroup, 10 ,'',color,0x000000,'1',caption,'',true);
        }
   }
   else if (obj.id=="datLabourPrice_Special")
   {
        lblRecord_1.text=grdLabor_Price_1.rows-1 + " rec(s)";
        var caption;
        var ctrl=grdLabor_Price_1.GetGridControl();
        ctrl.OutlineBar =2 ;
        ctrl.MergeCells = 3; // RestricCol or 4
        ctrl.MergeCol(0) = true;
	    ctrl.MergeCol(1) = true;
	    ctrl.MergeCol(2) = true;
	    ctrl.MergeCol(3) = true;
        color=0x99FF99;
        caption='Total %s';
        ctrl.SubTotal(2,0, 10 ,'',color,0x000000,'1',caption,'',true);
        ctrl.SubTotal(2,0, 11 ,'',color,0x000000,'1',caption,'',true);
        ctrl.SubTotal(2,0, 12 ,'',color,0x000000,'1',caption,'',true);
   }
   else if (obj.id=="datDetailItems")
   {
        var ctrl=grdItem.GetGridControl();
        ctrl.OutlineBar =2 ;
        var caption;
        var color;
        var maxgroup;
        color=0x99FF99;
        caption='Total:%s';
        ctrl.SubtotalPosition=0;
        ctrl.SubTotal(2,0, 3 ,'#########',color,0x000000,'1',caption,'',true);
        ctrl.SubTotal(2,0, 4,'###,###,###',color,0x000000,'1',caption,'',true);  
        grdItem.SetGridText(grdItem.rows-1,1,'Total');
   }
}
//--------------------------------------------
function OnReport(obj)
{
    switch (obj)
    {
        case 1:
        {
            txtReport_tmp.text="rpt_labour_price_normal.aspx";
            datFind_Report.Call();    
            break;
        }
        case 2:
        {
            txtReport_tmp.text="rpt_labour_price_special.aspx";
            datFind_Report.Call();    
            break;
        }
        case 3:
        {
            var url=System.RootURL;
            url=url + '/reports/ch/gc/rpt_lb_price_template.xls?'; 
            window.open(url); 
            break;
        }
            
    }
    
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
    switch (tabMain.GetCurrentPageNo())
    {
        case 0:
        {
            txtDept.text=lstDept_Code.value;
            txtGroupData.text=lstGrp_Code.value;
            break;
        }
        case 1:
        {
            txtDept.text=lstDept_Code_1.value;
            txtGroupData.text=lstGrp_Code_1.value;
            break;
        }
        
    }
    datTaskData.Call();
}
//----------------------------------------------

function OnToggle()
{
        if(imgMaster.status == "expand")
        {
            imgMaster.status = "collapse";
			tdDetail.style.display="none";
            tdDetail.style.width="0%";
            tdMaster.style.height="100%";
            imgMaster.src = "../../../system/images/iconmaximize.gif";
			imgMaster.alt="Show Detail Items";
			grdItem.ClearData();
        }
        else
        {
            imgMaster.status = "expand";
            tdDetail.style.display="";
            tdDetail.style.width="30%";
            tdMaster.style.height="70%";
            imgMaster.src = "../../../system/images/close_popup.gif";
			imgMaster.alt="Close Detail Items";
			
			if (grdLabor_Price_1.row>1)
            {
                txtDate.text=grdLabor_Price_1.GetGridData(grdLabor_Price_1.row,0);
                txtGroup.text=grdLabor_Price_1.GetGridData(grdLabor_Price_1.row,13);
                if (txtGroup.text=="")
                    txtDate.text=String(txtDate.text).substr(6,String(txtDate.text).length-6)
                datDetailItems.Call("SELECT");
            }
        }
  
}
//-----------------------
function show_detail()
{
    if(imgMaster.status == "expand")
    {
        if (grdLabor_Price_1.row>=1)
            {
                
                txtDate.text=grdLabor_Price_1.GetGridData(grdLabor_Price_1.row,0);
                txtGroup.text=grdLabor_Price_1.GetGridData(grdLabor_Price_1.row,13);
                if (txtGroup.text=="")
                    txtDate.text=String(txtDate.text).substr(6,String(txtDate.text).length-6)
                datDetailItems.Call("SELECT");
            }
    }
}
/*
function OnProcess()
{
    
    var myApp = new ActiveXObject("Excel.Application"); 
    var vfilename = inputfile.value; 
    
    if (!CheckValidFile(vfilename) || inputfile.value =="")
    {
        alert("Please select excel file");
        return;
    }
    try
    {
        myApp.Workbooks.Open(vfilename); 
        var workSheet = myApp.ActiveSheet; 
        var semp_id,slb_price;
        var maxRow =workSheet.UsedRange.Rows.Count;
        for (var j =2;j <=maxRow; j++) 
        { 
            semp_id=workSheet.Cells(j,1).value;
            slb_price=workSheet.Cells(j,2).value;
            if (semp_id=="" )
               alert("Please input employee id at row " + j);
            else if (slb_price=="")
                alert("Please input labour price at row " + j);
            else if (isNaN(slb_price))
                alert("Please input labour price by number value at row " + j);
            else
            {
                grdLabor_Price_1.AddRow();
                grdLabor_Price_1.SetGridText(grdLabor_Price_1.rows-1,2,semp_id);
                grdLabor_Price_1.SetGridText(grdLabor_Price_1.rows-1,4,slb_price);
                grdLabor_Price_1.SetGridText(grdLabor_Price_1.rows-1,7,dtMonth_1.value);
            }
        } 
        myApp.Quit();
    }
    catch(e)
    {
        alert("Could not read Excel File. (or) Excel was not installed in the machine you are using or it has incompatible version?"); 
    }
        
}
function CheckValidFile(vfile)
{
    var sext;
    sext=vfile.substring(vfile.length-4,vfile.length);
    if (sext!=".xls")
        return false;
    return true;
}
*/
</script>
<body >

<!------------------------------------->
<gw:data id="datGroupData" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="list" procedure="hr.sp_pro_group_data_all" > 
                <input>
                    <input bind="txtDept" /> 
                </input> 
                <output>
                    <output bind="txtGroupData" />
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
                    <output bind="txtDept" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<!-------------------data control----------------------->
<gw:data id="datLabourPrice" onreceive="OnDataReceive(this)" > 
    <xml> 
        <dso  type="grid" function="hr.sp_sel_daily_prod "  > 
            <input  bind="grdLabor_Price" > 
                <input bind="lstDept_Code" /> 
                <input bind="lstGrp_Code" /> 
                <input bind="dtFromDate" /> 
                <input bind="dtToDate" /> 
                <input bind="txt_tco_item_pk" /> 
                <input bind="txtItemCode" /> 
                <input bind="txtItemName" /> 
                <input bind="txtEmpID" /> 
                <input bind="lstTask_Code" /> 
                <input bind="txtSale_Order" /> 
            </input> 
            <output bind="grdLabor_Price" /> 
        </dso> 
   </xml> 
</gw:data> 
<!-------------------data control----------------------->
<gw:data id="datLabourPrice_Special" onreceive="OnDataReceive(this)" > 
    <xml> 
        <dso  type="grid" function="hr.sp_sel_daily_prod_special "  > 
            <input  bind="grdLabor_Price_1" > 
                <input bind="lstDept_Code_1" /> 
                <input bind="lstGrp_Code_1" /> 
                <input bind="dtFromDate_1" /> 
                <input bind="dtToDate_1" /> 
                <input bind="txtEmpID_1" /> 
                <input bind="lstTask_Code_1" /> 
            </input> 
            <output bind="grdLabor_Price_1" /> 
        </dso> 
   </xml> 
</gw:data> 
 
<!-------------------data control----------------------->
<gw:data id="datTaskData" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="list" procedure="hr.sp_pro_task_data_all" > 
                <input>
                   <input bind="txtDept" /> 
                   <input bind="txtGroupData" />
                </input> 
                <output>
                    <output bind="txtTask" />
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
<gw:data id="datDetailItems" onreceive="OnDataReceive(this)" > 
    <xml> 
        <dso  type="grid" function="hr.sp_sel_daily_Items "  > 
            <input  bind="grdItem" > 
                <input bind="txtDate" /> 
                <input bind="txtGroup" /> 
            </input> 
            <output bind="grdItem" /> 
        </dso> 
   </xml> 
</gw:data> 
<!-------------------data control----------------------->
<gw:tab id="tabMain"  border=1 style="width:100%;height:100%;" onpageactivate=""  > 
   <table  name="Normal" id="management" width="100%" cellpadding="0" cellspacing="0" border=1 style="width:100%;height:100%;">
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
                        <td width="6%" align="right" style="border:0;">Group</td>
                        <td width="12%"  align="left" style="border:0;">
                         <gw:list  id="lstGrp_Code" value='ALL' maxlen = "100" styles='width:100%' onchange="OnChangeGroup()">
                            <data><%=Esyslib.SetListDataSQL("SELECT pk,Group_NM FROM Thr_Group WHERE DEL_IF = 0 and use_yn='Y'  order by seq, Group_NM" )%>|ALL|Select All</data></gw:list>
                        </td>
                        <td  colspan=2 width="8%"  align="right" valign="middle" style="border:0;">Task</td>
					    <td   width="13%" colspan=2 style="border:0;">
					        <gw:list  id="lstTask_Code" value='ALL'  maxlen = "40" styles='width:100%' onchange="" >
                            <data>
                                <%=Esyslib.SetListDataSQL("select a.PK, a.TASK_NAME from prod.tpr_task a where a.DEL_IF=0 and a.USE_YN = 'Y' order by task_name" )%>|ALL|Select All
                            </data>
                            </gw:list>
				        </td>
				        <td   width="10%"  align="right" valign="middle" style="border:0;">Emp ID</td>
				        <td width="10%" style="border:0;" align="left" >
				         <gw:textbox id="txtEmpID"	styles="width:100%" onenterkey="OnSearch(datLabourPrice)" />
				        </td>
				        <td width="11%" style="border:0;" align="center" >
				         <gw:label id="lblRecord" styles="width:100%;color:red"></gw:label></td>
				        <td width="3%" style="border:0;" align="right" >
                         <gw:imgBtn img="search" id="ibtnSearch"   alt="Search"  onclick="OnSearch(datLabourPrice)"/></td>
                         <td width="3%" style="border:0;" align="right" >
                         <td width="3%" style="border:0" align="right">
                        <gw:imgBtn img="excel" id="ibtnReport"    alt="Report"  onclick="OnReport(1)"/></td>
                    </tr>
                    <tr style="border:1;width:100%;height:5%" valign="center" >
                        <td  align="right" style="border:0;"><a title="Click here to show Item"  onclick="TabPopUp()" href="#tips" >Item</a></td>
                        <td  align="left" style="border:0;">
                         <gw:textbox id="txtItemCode"	styles="width:100%" onenterkey="OnSearch(datLabourPrice)" />
                        </td>
                        <td  colspan=2 align="right" style="border:0;"><gw:textbox id="txtItemName"	styles="width:100%" onenterkey="OnSearch(datLabourPrice)" /></td>
                        <td  width="3%" style="border:0;" align="center" ><gw:imgBtn img="Reset" id="ibtnReset"   alt="Reset Item"  onclick="OnReset()"/></td>
                        <td  width="5%" align="right" style="border:0;">Date</td>
                        <td  width="10%"  style="border:0;">
					        <gw:datebox id="dtFromDate"  text="" maxlen = "10" styles='width:100%' lang="<%=Session("Lang")%>" type="date"  />                  
				        </td>
				        <td  width="3%" align="center" style="border:0;"><b>~</b></td>
				        <td  style="border:0;">
					        <gw:datebox id="dtToDate"  text="" maxlen = "10" styles='width:100%' lang="<%=Session("Lang")%>" type="date"  />                  
				        </td>
				         <td   align="right" style="border:0;">Sale Order</td>
                        <td  colspan=3  style="border:0;">
					        <gw:textbox id="txtSale_Order"	styles="width:100%" onenterkey="OnSearch(datLabourPrice)" />
				        </td>
                    </tr>
                    <tr style="border:1;width:100%;height:90%" valign="center" >
                       <td colspan=14  style="width:100%;height:100%;"> 
                            <gw:grid id='grdLabor_Price'
                            header='Date|Group|Item Code|Item Name|Sale Order No|Task Name|Emp ID|Full Name|Quantity|Labour|Amount'
                            format='0|0|0|0|0|1|0|0|0|1|1'
                            aligns='0|1|0|0|0|1|1|0|1|0|0'
                            defaults='||||||||||'
                            editcol='0|0|0|0|0|0|0|0|0|0|0'
                            widths='2200|1215|2500|1300|1225|1200|1000|2010|1125|1000|1000'
                            sorting='T'
                            param="0,1,2,3,4,5,6,7,8,9,10"
                            styles='width:100%; height:100%'
                            />
                        </td>
                    </tr>
               </table> 
            </td>
        </tr>
    </table>    
    <table  name="Special" id="Table1" width="100%" cellpadding="0" cellspacing="0" border=1 style="width:100%;height:100%;">
        <tr style="width:100%;height:100%" valign="top">
            <td>
               <table width="100%" id="Table2" style="height:100%" border=1 cellpadding="0" cellspacing="0">
                    <tr style="border:1;width:100%;height:5%" valign="center" >
                        <td width="8%" align="right" style="border:0;"><a title="Click here to show department" onclick="OnShowPopup()" href="#tips" >Department</a>                  
                        </td>
                        <td width="12%" align="left" style="border:0;">
                         <gw:list  id="lstDept_Code_1" value='ALL' maxlen = "100" styles='width:100%' onchange="OnChangeDept(lstDept_Code_1)" >
                            <data>
                                <%=ESysLib.SetListDataSQL("select pk,dept_nm from comm.tco_dept a where del_if=0 order by a.dept_id")%>|ALL|Select All
                            </data>
                        </gw:list>
                        </td>
                        <td width="6%" align="right" style="border:0;">Group</td>
                        <td width="12%"  align="left" style="border:0;">
                         <gw:list  id="lstGrp_Code_1" value='ALL' maxlen = "100" styles='width:100%' onchange="OnChangeGroup()">
                            <data><%=Esyslib.SetListDataSQL("SELECT pk,Group_NM FROM Thr_Group WHERE DEL_IF = 0 and use_yn='Y'  order by seq, Group_NM" )%>|ALL|Select All</data></gw:list>
                        </td>
                        <td  colspan=2 width="8%"  align="right" valign="middle" style="border:0;">Task</td>
					    <td   width="13%" colspan=2 style="border:0;">
					        <gw:list  id="lstTask_Code_1" value='ALL'  maxlen = "40" styles='width:100%' onchange="" >
                            <data>
                                <%=Esyslib.SetListDataSQL("select a.PK, a.TASK_NAME from prod.tpr_task a where a.DEL_IF=0 and a.USE_YN = 'Y' order by task_name" )%>|ALL|Select All
                            </data>
                            </gw:list>
				        </td>
				        <td   width="10%"  align="right" valign="middle" style="border:0;">Emp ID</td>
				        <td width="10%" style="border:0;" align="left" >
				         <gw:textbox id="txtEmpID_1"	styles="width:100%" onenterkey="OnSearch(datLabourPrice_Special)" />
				        </td>
				        <td width="11%" style="border:0;" align="center" >
				         <gw:label id="lblRecord_1" styles="width:100%;color:red"></gw:label></td>
				        <td width="3%" style="border:0;" align="right" >
                         <gw:imgBtn img="search" id="ibtnSearch_1"   alt="Search"  onclick="OnSearch(datLabourPrice_Special)"/></td>
                         <td width="3%" style="border:0;" align="right" >
                          <td width="3%" style="border:0" align="right">
                        <gw:imgBtn img="excel" id="ibtnReport_1"    alt="Report"  onclick="OnReport(2)"/></td>
                    </tr>
                    <tr style="border:1;width:100%;height:5%" valign="center" >
                        <td  align="right" style="border:0;">Date</td>
                        <td  align="left" style="border:0;"><gw:datebox id="dtFromDate_1"  text="" maxlen = "10" styles='width:100%' lang="<%=Session("Lang")%>" type="date"  />                  
                        </td>
                        <td   align="center" style="border:0;"><b>~</b></td>
                        <td  align="right" style="border:0;"><gw:datebox id="dtToDate_1"  text="" maxlen = "10" styles='width:100%' lang="<%=Session("Lang")%>" type="date"  />                  </td>
                        <td   style="border:0;" align="center" ></td>
                        <td   align="right" style="border:0;"></td>
                        <td    style="border:0;">
				        </td>
				        <td  style="border:0;">
				        </td>
				         <td   align="right" style="border:0;"></td>
                        <td  colspan=5  style="border:0;"  align="right" valign="bottom">
				        <img status="collapse" id="imgMaster" alt="Show Detail Items" src="../../../system/images/iconmaximize.gif" style="cursor:hand" onclick="OnToggle()"  /> </td>
                    </tr>
                    <tr style="border:1;width:100%;height:90%" valign="center" >
                       <td colspan=14  style="width:100%;height:100%;"> 
                            <table id="tblMain" style="width:100%;height:100%" border=1 cellpadding="0" cellspacing="0">
	                            <tr style="width:100%;height:100%">
	                                <td id="tdMaster" style="width:70%">
	                                    <gw:grid id='grdLabor_Price_1'
                                            header='Date|_Item Code|_Item Name|_Sale Order No|Group|Task Name|Emp ID|Full Name|Work time|Ratio (Max)|Ratio|Quantity|Amount|_Group_pk'
                                            format='0|0|0|0|0|1|0|0|0|0|0|1|1|0'
                                            aligns='0|1|0|0|0|1|1|0|1|0|0|0|0|0'
                                            defaults='|||||||||||||'
                                            editcol='0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                                            widths='2200|1215|2500|1300|2000|1700|1000|2500|1125|1125|1000|1400|1000|1000|0'
                                            sorting='T'
                                            oncelldblclick="show_detail()"
                                            styles='width:100%; height:100%'
                                            />
	                                </td>
	                                <td id="tdDetail" style="width:30%;display:none">
	                                    <gw:grid   
				                        id="grdItem"  
				                        header="_Date|Item Code|Item Name|Quantity|Amount"   
				                        format="0|0|0|0|0"  
				                        aligns="0|0|0|0|0"  
				                        defaults="||||"  
				                        editcol="0|0|0|0|0"  
				                        widths="1000|1500|0|0|0"  
				                        styles="width:100%; height:100%"   
				                        sorting="T"   
				                        />
	                                </td>
	                            </tr>
	                        </table>
                        </td>
                    </tr>
               </table> 
            </td>
        </tr>
    </table>    
</gw:tab>  
</body>
<gw:textbox id="txtReport_tmp" styles="display:none"/>
<gw:textbox id="txtTask" styles="display:none"/>
<gw:textbox id="txtGroupData" styles="display:none"/>
<gw:textbox id="txtDept" styles="display:none"/>
<gw:textbox id="txt_tco_item_pk" styles="display:none"/>
<gw:textbox id="txt_tco_item_pk_1" styles="display:none"/>
<gw:textbox id="txtDeptData" styles="display:none"/>
<gw:textbox id="iduser_pk" styles="display:none"/>
<gw:textbox id="txtHr_level" styles="display:none"/>  
<gw:textbox id="txtUpperDept" styles="display:none"/>

<gw:textbox id="txtDate" styles="display:none"/>  
<gw:textbox id="txtGroup" styles="display:none"/>


</html>
