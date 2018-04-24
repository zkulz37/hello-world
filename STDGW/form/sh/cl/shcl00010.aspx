<%@ Page Language="C#" %>

<%@ Import Namespace="System.Web" %>
<%@ Import Namespace="System.Web.Security" %>
<%@ Import Namespace="System.Security.Principal" %>
<%@ Import Namespace="System.Runtime.InteropServices" %>
<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>genuwin</title>
</head>
<% ESysLib.SetUser("comm");%>

<script language="javascript" type="text/javascript">
 
 function BodyInit()
 {
    //<%=ESysLib.SetGridColumnComboFormat("grdMonthly", 7, "select 'O', 'Opened' from dual union select 'C', 'Closed' from dual")%>; 
    BindingDataList();
    onSearch();
 }
//---------------------------------------------------------------------------------------------------
 function BindingDataList()
 {  
     var data1 = "<%=ESysLib.SetListDataSQL("SELECT pk, PARTNER_NAME FROM TCO_company  where del_if=0")%>";   
     cboCompany.SetDataText(data1);            
 }
//------------------------------------------------------------------------------------
function onAddRow()
 {
    for(var i=1;i<10;i++)
    {
        grdMonthly.AddRow();
        grdMonthly.SetGridText(grdMonthly.rows-1,1,i);
        grdMonthly.SetGridText(grdMonthly.rows-1,2,dtYear.value);
        grdMonthly.SetGridText(grdMonthly.rows-1,3,'0'+ i + '/' + dtYear.value);
        grdMonthly.SetGridText(grdMonthly.rows-1,4,dtYear.value + '0'+ i );
        grdMonthly.SetGridText(grdMonthly.rows-1,5,dtYear.value + '0' + i + '01');
        grdMonthly.SetGridText(grdMonthly.rows-1,6,dtYear.value + '0' + i + '20');
        grdMonthly.SetGridText(grdMonthly.rows-1,7,"Open");        
    }   
    for(var i=10;i<13;i++)
    {
        grdMonthly.AddRow();
        grdMonthly.SetGridText(grdMonthly.rows-1,1,i);
        grdMonthly.SetGridText(grdMonthly.rows-1,2,dtYear.value);
        grdMonthly.SetGridText(grdMonthly.rows-1,3,i + '/' + dtYear.value);
        grdMonthly.SetGridText(grdMonthly.rows-1,4,dtYear.value +  i );
        grdMonthly.SetGridText(grdMonthly.rows-1,5,dtYear.value + i + '01');
        grdMonthly.SetGridText(grdMonthly.rows-1,6,dtYear.value + i + '20');
        grdMonthly.SetGridText(grdMonthly.rows-1,7,"Open");        
    }   
 }
 //---------------------------------------------------------------------------------------
 function onSave()
 {
    if (onValidate())
    {
        for(var i=1;i<13;i++)
        {        
            grdMonthly.SetGridText(i,9,cboCompany.value);
            grdMonthly.SetGridText(i,10,"<%=Session["USER_PK"]%>");        
        }  
        dat_hddp00010_1.Call(); 
    }
 }
 //---------------------------------------------------------------------------------------
 function onOpen()
 {
    var ctrl=grdMonthly.GetGridControl();
    if(ctrl.SelectedRows>1)
    {
        alert("Please Select 1 row to Open");
    }
    if(ctrl.SelectedRows==1)
    {
        if(grdMonthly.GetGridData(grdMonthly.row,7)=="Open")
        {
            alert("It's Already Open");
        }
        else
        {
            grdMonthly.SetGridText(grdMonthly.row,7,'Opening...');
            if(onCheckValidate(1)==true)
            {
               for(var i=1;i<13;i++)
                {                        
                    grdMonthly.SetGridText(i,10,cboCompany.value);
                    grdMonthly.SetGridText(i,11,"<%=Session["USER_PK"]%>");        
                }  
                dat_hddp00010_1.Call(); 
            }
        }
    }
 }
 //---------------------------------------------------------------------------------------
  function onClose()
 {
    var ctrl=grdMonthly.GetGridControl();
    if(ctrl.SelectedRows>1)
    {
        alert("Please Select 1 row to Close");
    }
    if(ctrl.SelectedRows==1)
    {
        if(grdMonthly.GetGridData(grdMonthly.row,7)=="Close")
        {
            alert("It's Already Close");
        }
        else
        {
            grdMonthly.SetGridText(grdMonthly.row,7,'Closing...');
            if(onCheckValidate(2)==true)
            {
               for(var i=1;i<13;i++)
                {                        
                    grdMonthly.SetGridText(i,10,cboCompany.value);
                    grdMonthly.SetGridText(i,11,"<%=Session["USER_PK"]%>");        
                }  
                dat_hddp00010_1.Call(); 
            }
        }
    }
 }
 //---------------------------------------------------------------------------------------
 function onCheckValidate(pos)
 {
    switch(pos)
    {
        case 1:
            for(var i=1;i<12;i++)
            { 
                if((grdMonthly.GetGridData(i+1,7)=='Close')&&(grdMonthly.GetGridData(i,7)=='Opening...') ) 
                {
                    
                    alert("You must Open month " + (i+1) + " first!");
                    grdMonthly.SetGridText(grdMonthly.row,7,'Close');
                    return false;
                }              
            } 
            return true;
        break;
        case 2:
            for(var i=2;i<13;i++)
            { 
                if((grdMonthly.GetGridData(i-1,7)=='Open')&&(grdMonthly.GetGridData(i,7)=='Closing...') ) 
                {
                    alert("You must Close month " + (i-1) + " first!");
                    grdMonthly.SetGridText(grdMonthly.row,7,'Open');
                    return false;
                }              
            } 
            return true;
        break;
    }
            
 }
 //--------------------------------------------------------------------------------------
 function OnDataReceive(obj)
 {
    switch (obj.id)
    {
        case 'dat_hddp00010_1' :
            if (grdMonthly.rows==1) 
                onAddRow();
        break;
    }    
 }
 //----------------------------------------------------------------------------------------
 function onSearch()
 {
    dat_hddp00010_1.Call("SELECT");
 }
</script>

<body>
    <!------------------------------------------------------------------>
    <gw:data id="dat_hddp00010_1" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid" parameter="0,1,4,5,6,7,8,9,10,11" function="prod.sp_sel_tpr_mmclosing_sh"   procedure="prod.sp_upd_tpr_mmclosing_sh"> 
                <input bind="grdMonthly">    
                    <input bind="cboCompany" />                 
                    <input bind="dtYear" /> 
                </input> 
                <output bind="grdMonthly" /> 
            </dso> 
        </xml> 
</gw:data>
    <!------------------------------------------------------------------>
    <form id="form1" runat="server">
        <div>
            <table>
                <tr>
                    <td width="8%">
                        Company</td>
                    <td width="20%">
                        <gw:list id="cboCompany" styles="width:100%;"></gw:list>
                    </td>
                    <td width="10%" align="right">
                        Year</td>
                    <td width="6%">
                        <gw:datebox id="dtYear" lang="1" type="year" onchange="onSearch()" />
                    </td>
                    <td width="40%">
                    </td>
                    <td width="2%">
                        <gw:imgbtn id="btnSearch" img="search" alt="Search" text="Search" onclick="onSearch()" />
                    </td>
                    <td width="2%">
                        <gw:button id="btnOpen" img="open" alt="open" text="Open" onclick="onOpen()" />
                    </td>
                    <td width="2%">
                        <gw:button id="btnClose" img="close" alt="close" text="Close" onclick="onClose()" />
                    </td>
                </tr>
                <tr>
                    <td colspan="8">
                        &nbsp;</td>
                </tr>
                <tr>
                    <td colspan="8">
                        <gw:grid id="grdMonthly" header="PK|Seq|Year|Month|_MonthDB|From Date|To Date|Status|Close Date|Remark|_company|_emp_pk"
                            format="0|0|0|0|0|4|4|2|4|0|0|0" aligns="2|1|1|0|1|1|1|1|1|0|0|0" defaults="||||||||||||"
                            editcol="1|1|1|1|1|1|1|1|0|1|1|1" widths="0|800|1200|1500|0|1500|1500|1200|1500|3000|0|0"
                            styles="width:100%; height:435" sorting="T" param="0,1,2,3,4,5,5,6,7,8,9,10,11"
                            oncelldblclick="" acceptnulldate='T' />
                    </td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>
