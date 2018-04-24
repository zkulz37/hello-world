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
   System.Translate(document); 
	OnSearch();
}
function OnSearch()
{
    dsoForm.Call("SELECT");
}

function Select()
{
    
       var code_data=new Array();
	var ctrl = idGrid.GetGridControl();
	if(ctrl.SelectedRows == 0)
	{
	   alert("Please Select an Form Name.");
	   return ;
	}
	else
	{
		//code name
		code_data[1] = idGrid.GetGridData( ctrl.row , 1 );
		// value1 --> PK
		code_data[2] = idGrid.GetGridData( ctrl.row , 2 );
		
		window.returnValue = code_data;
		this.close();
	}
	
}

</script>

<body>

    <gw:data id="dsoForm"> 
        <xml> 
           <dso type="grid" function="acnt.sp_sel_agga00110_popup" > 
                  <input bind="idGrid" > 
                    
                    <input bind="txtFormName"/>
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
      
                <td width="15%" align="right">Form Name:</td>
	            <td width="75%"><gw:textbox id="txtFormName" styles="width:98%;height:20" onenterkey="OnSearch()"/></td>
	            
	           
	            
                <td align="right" width="5%"><gw:imgBtn id="idSearch" img="search" alt="Search" text="Search" onclick="OnSearch();" /></td>
                <td style="width: 5%">
                            <gw:imgbtn id="btnSelect" img="select" alt="Select" onclick="Select()" />
                        </td>
                
             </tr>
		 </table>  
     </fieldset>
    </td>
  </tr>
  <tr style="height:95%">
        <td colspan = "9">
		<gw:grid   
							    id="idGrid"  
							    header="No|Form Name|_PK"
							    format="0|0|0"
							    aligns="1|0|0"  
							    defaults="||"  
							    editcol="0|0|0"  
							    widths="500|2500|0"  
							    styles="width:100%; height:100%"   
							    sorting="T"   
							    param="0,1,2"
							    oncelldblclick="Select()" />
	</td>
  </tr>
</table>

</body>
</html>
