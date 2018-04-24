<!-- #include file="../../../system/lib/form.inc"  -->
<%  ESysLib.SetUser(Session("APP_DBUSER"))%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script>
var v_language = "<%=Session("SESSION_LANG")%>";
var lang= "<%=Session("Lang")%>";

function BodyInit()
{
    BindingDataList(); 
}

function BindingDataList()
{
    data = "<%=ESysLib.SetListDataSQL("SELECT CODE,CODE_NM FROM VHR_HR_CODE WHERE ID='HR0173' ORDER BY CODE_NM")%>";
    lstTypeProgram.SetDataText(data);
    
    data = "<%=ESysLib.SetListDataSQL("SELECT CODE,CODE_NM FROM VHR_HR_CODE WHERE ID='HR0010' and code in('173', '159', '166','167','164','165','55','162','163','177') ORDER BY CODE")%> |ALL|Select All";
    lstJobClass.SetDataText(data);
    lstJobClass.value = 'ALL';

    data = "<%=ESysLib.SetListDataSQL("SELECT CODE,CODE_NM FROM VHR_HR_CODE WHERE ID='HR0008' and code in ('28', '36', '40', '51', '55', '54') ORDER BY CODE")%> |ALL|Select All";
    lstJobTitle.SetDataText(data);
    lstJobTitle.value = 'ALL';
    
    data = "<%=ESysLib.SetListDataSQL("SELECT CODE,CODE_NM FROM VHR_HR_CODE WHERE ID='HR0078' ORDER BY CODE_NM")%> |ALL|Select All";
    lstCategory.SetDataText(data);
    lstCategory.value = 'ALL';

    <%=ESysLib.SetGridColumnComboFormat( "idGrid" , 1 , "SELECT CODE, CODE_NM FROM VHR_HR_CODE WHERE ID='HR0173' ORDER BY CODE_NM") %>;
    <%=ESysLib.SetGridColumnComboFormat( "idGrid" , 2 , "SELECT CODE, CODE_NM FROM VHR_HR_CODE WHERE ID='HR0010' and code in('173', '159', '166','167','164','165','55','162','163','177') ORDER BY CODE") %>;
    <%=ESysLib.SetGridColumnComboFormat( "idGrid" , 3 , "SELECT null, null from dual UNION ALL SELECT CODE, CODE_NM FROM VHR_HR_CODE WHERE ID='HR0008' and code in ('28', '36',  '40', '51', '55', '54')") %>;
    <%=ESysLib.SetGridColumnComboFormat( "idGrid" , 4 , "SELECT CODE, CODE_NM FROM VHR_HR_CODE WHERE ID='HR0078' ORDER BY CODE_NM") %>;
    <%=ESysLib.SetGridColumnComboFormat( "idGrid" , 5 , "SELECT CODE, CODE_NM FROM VHR_HR_CODE WHERE ID='HR0168' ORDER BY CODE") %>;
}

function OnDataReceive(obj)
{ 
    switch  (obj.id)
    {
        case 'dso_chkr00130':
            lbRecord.text = (idGrid.rows-1) + " record(s) found.";;
            break; 
    }
}

function OnSearchData()
{
    dso_chkr00130.Call('SELECT');
}

function OnAddnewData()
{
    idGrid.AddRow();

    if (lstTypeProgram.value != 'ALL')
        idGrid.SetGridText(idGrid.rows-1, 1, lstTypeProgram.value);        

    if (lstJobClass.value != 'ALL')
        idGrid.SetGridText(idGrid.rows-1, 2, lstJobClass.value);

    if (lstJobTitle.value != 'ALL')
        idGrid.SetGridText(idGrid.rows-1, 3, lstJobTitle.value);

    if (lstCategory.value != 'ALL')
        idGrid.SetGridText(idGrid.rows-1, 4, lstCategory.value);
}

function OnDeleteData()
{
    if (idGrid.GetGridData(idGrid.row, 0) == '')
        idGrid.RemoveRowAt(idGrid.row);
    else
    {
        if (confirm('Are you sure delete this row ???'))
        {
            idGrid.DeleteRowAt(idGrid.row);
        }
    }
}

function OnSaveChangedData()
{
    if (lstJobTitle.value != 'All')
        
    dso_chkr00130.Call();
}
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Mapping Course</title>
</head>
<body>

<gw:data id="dso_chkr00130" onreceive="OnDataReceive(this)"> 
        <xml> 	 
            <dso type="grid"  parameter="0,1,2,3,4,5,6" function="HR_CHKR10200010_SEL_Mapping" procedure="HR_CHKR10200010_UPD_Mapping" > 
                <input> 
                    <input bind="lstTypeProgram" /> 
                    <input bind="lstJobClass" />
                    <input bind="lstJobTitle" />
                    <input bind="lstCategory" />
                </input> 
                <output bind="idGrid" /> 
            </dso> 
        </xml> 
</gw:data> 
<form id="form1" runat="server">
<table border=0 cellpadding=0 cellspacing=0 style="width:100%;height:100%">                                                                                                                                                                                             
    <tr>
        <td style="width:100%;height:4%">  
           <table border=0 width=100% cellpadding=0 cellspacing=0>
               <tr>
                   <td width="8%" align="right">Type</td>
                   <td width="17%"><gw:list  id="lstTypeProgram" value = "ALL" styles='width:100%' onchange="OnSearchData()" ></gw:list></td>
                   <td width="8%" align="right">Job Class</td>
                   <td width="17%"><gw:list  id="lstJobClass" value = "ALL" styles='width:100%' onchange="OnSearchData()" ></gw:list></td>
                   <td width="8%" align="right">Job Title</td>
                   <td width="17%"><gw:list  id="lstJobTitle" value = "ALL" styles='width:100%' onchange="OnSearchData()" ></gw:list></td>
                   <td width="8%" align="right">Category</td>
                   <td width="17%"><gw:list  id="lstCategory" value = "ALL" styles='width:100%' onchange="OnSearchData()" ></gw:list></td>
               </tr>
               <tr>
                <td colspan="8">
                     <table border=0 width=100% cellpadding=0 cellspacing=0>
                       <tr>
                           <td align="right">
                                <gw:label id="lbRecord" text="0 record(s) found." />
                           </td>
                           <td width="1%"><gw:imgBtn id="btnSearch" img="search" alt="Search item" onclick="OnSearchData()" /></td>	
				           <td width="1%"><gw:imgBtn id="btnAddnew" img="new" alt="Add new item to list" onclick="OnAddnewData()" /></td>
				           <td width="1%" style="display:none"><gw:imgBtn id="btnDelete" img="delete" alt="Delete Selected item from list" onclick="OnDeleteData()" /></td>
				           <td width="1%"><gw:imgBtn id="btnSave" img="save" alt="Save all changed Information" onclick="OnSaveChangedData()" /></td>                
                       </tr>
                    </table>
                </td>
               </tr>
           </table>        
        </td>
    </tr>
    <tr>
        <td id="td_Master" style="width:100%;height:90%">  
            <gw:grid   
            id="idGrid" 
            header="_PK|Type Program|Job Class|Job Title|Category|Train Type|Active YN"
            format="0|0|0|0|0|0|3"
            aligns="0|0|0|0|0|0|0"
            defaults="||||||"
            editcol="0|0|0|0|0|0|0"
            widths="0|0|0|0|0|0|0"
            styles="width:100%; height:100%"   
            acceptNullDate="T"
            autosize="true"
            debug="false"
            sorting="T"/>                
        </td>
    </tr>
</table>   
</form>
</body>
</html>
