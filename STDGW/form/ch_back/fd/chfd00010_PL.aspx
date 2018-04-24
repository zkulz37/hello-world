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
<% 
    ESysLib.SetUser("acnt");
%>

<script>

function BodyInit()
{
    
	OnSearch();
}

function DSOReceive( dsoinfo  )
{
	if ( dsoinfo.errno > 0 )
	{
		alert(dsoinfo.errmsg);
		return;
	}
}

function OnSearch()
{
    idData_Dsql.Call("SELECT");
}

function OnSelect()
{
	var code_data=new Array();
	var ctrl = grdPL.GetGridControl();
	if(ctrl.SelectedRows == 0)
	{
	   alert("Please Select an Item.");
	   return ;
	}
	else
	{
		//PK
		code_data[0] = grdPL.GetGridData( ctrl.row , 0 );
		//PL Code
		code_data[1] = grdPL.GetGridData( ctrl.row , 1 );
		// PL Name
		code_data[2] = grdPL.GetGridData( ctrl.row , 2 );
		
		window.returnValue = code_data;
		this.close();
	}
}

function OnCancel()
{
	window.returnValue = null; 
	this.close();
}
function EXITOnClick()
{
    OnCancel();
}
</script>
<body>

    <gw:data id="idData_Dsql" onreceive="" >
        <xml>
            <dso type="grid" parameter="0,1" function="acnt.sp_sel_biz_pl">
                <input bind="grdPL" >
                    <input bind="idcode"/>
                    <input bind="idname"/>
                </input>
                <output bind="grdPL" />
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
							<td class="table_title" width="25%" align="right"><b>PL Code</b></td>
							<td class="table_content"><gw:textbox id="idcode" styles="width:100%;height:25" onenterkey="OnSearch()"/></td>
							<td class="table_title" width="25%" align="right"><b>PL Name</b></td>
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
							    id="grdPL"  
							    header="PK|PL Code|PL Name"
							    format="0|0|0"  
							    aligns="0|0|0"  
							    defaults="||"  
							    editcol="0|0|0"
							    widths="2000|2500|2500"  
							    styles="width:100%; height:100%"   
							    sorting="T"   
							    oncelldblclick="OnSelect()"/> 					    		    
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
									<gw:icon id="idBtnSelect" img="in" text="OK" styles="width:100"  onclick="OnSelect()" />  
									</td> 
									<td> 
									<gw:icon id="idBtnSelect2" img="in" text="EXIT" styles="width:100"  onclick="OnCancel()" />  
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
<gw:textbox id="txtCompany" styles="width:100%;height:25" style="display:none"/>
<gw:textbox id="txtItem"    styles="width:100%;height:25" style="display:none"/>
<gw:textbox id="txtVal"     styles="width:100%;height:25" style="display:none"/>
</body>

</html>
