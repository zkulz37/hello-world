<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Web" %>
<%@ Import Namespace = "System.Web.Security" %>
<%@ Import Namespace = "System.Security.Principal" %>
<%@ Import Namespace = "System.Runtime.InteropServices" %>

<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>genuwin</title>
</head>
<%ESysLib.SetUser("acnt");%>

<script>

function BodyInit()
{
    var lst_Search = "<%=ESysLib.SetListDataFUNC("SELECT acnt.SF_A_GET_COMMONCODE('EACBK033') FROM DUAL")%>";
    
    lstSearch.SetDataText(lst_Search);
    var ls_company =  "<%=Request["company_pk"]%>"; 
   
    txt_company.text = ls_company;

	OnSearch();
}
function OnSearch()
{
    dsoAccountT.Call("SELECT");
}

function OnCancel()
{
	var code_data=new Array();
	tmp= new Array();
	tmp[0]       = 0
	code_data[0] = tmp;
	
	window.returnValue = code_data; 
	this.close();
}

function SelectCheck()
{
	
	var aValue = new Array();
	for(i=1;i<idGrid.rows;i++)
    {
    
		if(idGrid.GetGridData(i,0)== "-1")
		{
			tmp= new Array();
			
			
			for(j=0;j<idGrid.cols;j++)
            {
				tmp[tmp.length] = idGrid.GetGridData(i,j);
				
			}
			aValue[aValue.length]=tmp; 
		}
    }
	window.returnValue = aValue; 
	window.close(); 
}
function OnSelectAll()
{	
    var ctrl=idGrid.GetGridControl();
    if( chkSelectAll.GetData()=='T')
    {
        for(var i=1;i<ctrl.rows;i++)
        idGrid.SetGridText(i,0,"-1");
    }
	else
	{
            for(var i=0;i<ctrl.rows;i++)
            idGrid.SetGridText(i,0,"0");
    }        

}

function Select()
{
    if(event.col=="1" || event.col=="2")
    {
        var aValue = new Array();
	    var ctrl = idGrid.GetGridControl();
	    tmp= new Array();
	    for(j=0;j<idGrid.cols;j++)
	    {
		    tmp[tmp.length] = idGrid.GetGridData(ctrl.row,j);
	    }
	    aValue[aValue.length]=tmp; 

	    window.returnValue = aValue; 
	    window.close(); 
	}
}
</script>

<body>

    <gw:data id="dsoAccountT"  > 
        <xml> 
           <dso type="grid" function="acnt.sp_sel_gfka00280_popup" > 
                  <input bind="idGrid" > 
                    <input bind="txtCode"/> 
                    
                    <input bind="txt_company"/>
                    <input bind="lstSearch"/>
                  </input> 
                <output bind="idGrid" /> 
            </dso> 
        </xml> 
    </gw:data>

 <table style="margin-left:5;height:100%" align="center" width="100%"  border="0" cellspacing="0" cellpadding="0">
  <tr style="height:5%">
    <td>
     <fieldset style="width: 100%; height: 100%; padding: 2">
        <table border="0" width="100%" cellpadding="0" cellspacing="2"  id="table1">
			<tr>
                <td width="1%"><gw:checkbox id="chkSelectAll" value="F" onclick="OnSelectAll()" /> </td>
                <td width="10%" align="left"> Select All</td>
                 <td width="10%" align="right">Search by</td>
	            <td width="14%"><gw:list id="lstSearch"  styles='width:98%'></gw:list></td>
                <td width="10%" align="right">Account:</td>
	            <td width="35%"><gw:textbox id="txtCode" styles="width:98%;height:20" onenterkey="OnSearch()"/></td>
	            <td width="5%"></td>
	           
	            
                <td align="right" width="5%"><gw:imgBtn id="idSearch" img="search" alt="Search" text="Search" onclick="OnSearch();" /></td>
                <td align="right" width="5%"><gw:imgBtn id="idSelect" img="select" alt="Search" text="Select" onclick="SelectCheck();" /></td>
                <td align="right" width="5%"><gw:imgBtn id="idCancel" img="cancel" alt="Exit" text="Exit" onclick="OnCancel();" /></td>
             </tr>
		 </table>  
     </fieldset>
    </td>
  </tr>
  
  <tr style="height:95%">
      <!--0.Chk|1.User ID|2.Emp ID|3.Employee Name|4.Department|5.tco_bsuser_pk|TAC_ABTRTYPE_pk-->
	  <td height="80%">   
							<gw:grid   
							    id="idGrid"  
							    header="Chk|Account Code|Account Name|Account Local Name|Local Account Code|_PK"
							    format="3|0|0|0|0|0"
							    aligns="1|0|0|0|0|0"  
							    defaults="|||||"  
							    editcol="0|0|0|0|0|0"  
							    widths="500|1300|2500|2500|2000|0"  
							    styles="width:100%; height:100%"   
							    sorting="T"   
							    param="0,1,2,3,4,5"
							    oncelldblclick="Select()" />
				            </td>
  </tr>
</table>
<gw:textbox id="txt_company"   text="" style="display: none" />


</body>
</html>
