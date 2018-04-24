<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
</head>
<%  ESysLib.SetUser("acnt")%>


<script>
var typefa
function BodyInit()
{
	OnSearch();
}


function OnSearch()
{
	dso_project.Call();
}

function Select()
{

	var code_data=new Array();
	var ctrl = idGrid.GetGridControl();
	if(ctrl.SelectedRows == 0)
	{
	   alert("Please select an item.");
	   return ;
	}
	else
	{
		//code
		code_data[0] = idGrid.GetGridData( ctrl.row , 0 );
		//code name
		code_data[1] = idGrid.GetGridData( ctrl.row , 1 );
		// value1 --> PK
		code_data[2] = idGrid.GetGridData( ctrl.row , 2 );
		
		window.returnValue = code_data;
		this.close();
	}
}

function OnCancel()
{
	if(typefa!="")
	{
		this.close();
	}
	else
	{
		var code_data=new Array()
		code_data[0] = 0;
		window.returnValue = code_data; 
		this.close();
	}
}

</script>


<body>

<gw:data id="dso_project" > 
        <xml> 
            <dso id="1" type="grid"  function="acnt.sp_sel_gfqc00090_pro_2" >
                <input bind="idGrid"> 
                    <input bind="idcode" />
					<input bind="idname" />		
                </input> 
                <output bind="idGrid" /> 
            </dso> 
        </xml> 
    </gw:data> 

<table  border="0" width="100%" height="100%" cellpadding="0" cellspacing="0" >
  <tr> 
    <td width="100%" height="100%">
    	<table width="100%" height="100%" cellpadding=0 cellspacing=0 border=1>
            <tr height="15%">
	            <td class="itable_title">
			        <table class="table" CELLSPACING="0" CELLPADDING="0" width="100%" height="100%">
						<tr>
							<td class="table_title" width="25%" align="right">Project Code</td>
							<td class="table_content"><gw:textbox id="idcode" styles="width:100%;height:25" onenterkey="OnSearch()"/></td>
		                </tr>
		                <tr>
							<td class="table_title" width="25%"  align="right">Project Name</td>
							<td class="table_content"><gw:textbox id="idname" styles="width:100%;height:25" onenterkey="OnSearch()"/></td>
						</tr>  
		        
				    </table>
		        </td>
	    	</tr>
	    	
	    	<tr height="80%"> 
	    		<td>
	    			<table class="table" CELLSPACING="0" CELLPADDING="0" width="100%" height="100%">
	    				<tr>
					    	<td class="itable_content" height="80%">   
							<gw:grid   
							    id="idGrid"  
							    header="Project Code|Project Name|_pk"
							    format="0|0|0"  
							    aligns="0|0|0"  
							    defaults="||"  
							    editcol="0|0|0"
							    widths="2000|2500|0"  
							    styles="width:100%; height:100%"   
							    sorting="T"   
							    param="0,1,2"  
							    oncelldblclick="Select()" /> 					    		    
				            </td>
		            	</tr>
		            </table>
            	<td>
	    	</tr>
	    	
		    <tr height="5">
				<td>
			    <table class="table" border=1 CELLSPACING="0" CELLPADDING="0" width="100%" height="100%" >
					<tr align="center"> 
					    <td>
					    	<table>
					    	    <tr>
									<td> 
									<gw:icon id="idBtnSelect" img="in" text="OK" styles="width:100"  onclick="Select()" />  
									</td> 
									<td> 
									<gw:icon id="idBtnSelect" img="in" text="EXIT" styles="width:100"  onclick="OnCancel()" />  
									</td> 
								</tr>
							</table>	
						<td>	
					</tr>
				</table>
				</td>
			</tr>
	
		</table>  
		
    </td>
	</tr>
</table>


</body>
</html>

