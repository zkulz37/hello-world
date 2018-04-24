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
    ESysLib.SetUser("hr");
%>

<script>

function BodyInit()
{
    
     
    
    id.text="<%=Request["id"]%>";
    datOrg.Call("SELECT");
    
}
function OnDataReceive(obj)
{
    if(obj.id=="datOrg")
    {
            //To mau Record hien tai
            for(var i=1;i<idGrid.rows;i++)
                if(id.text==idGrid.GetGridData(i,0))
                {
                    idGrid.SetCellBgColor(i, 0,i, 4, 0x3366FF );
                    idGrid.SetCellBold(i,0,i,4,true);    
                 }   
    }
}
function OnSearch()
{
    
	idData_Dsql_Cost_Center.Call("SELECT");
}

function Select()
{
	var code_data=new Array();
	var ctrl = idGrid.GetGridControl();
	if(ctrl.SelectedRows == 0)
	{
	   alert("Please Select an Item.");
	   return ;
	}
	else
	{
		//pk
		code_data[0] = idGrid.GetGridData( ctrl.row , 0 );
		//group name
		code_data[1] =  idGrid.GetGridData( ctrl.row , 3 );
				
		window.returnValue = code_data;
		this.close();
	}
}

function OnCancel()
{
//	var code_data=new Array()
//	    code_data[0] = 0;
//		window.returnValue = code_data; 
		this.close();
}
</script>
<body>

    <gw:data id="datOrg" onreceive="OnDataReceive(this)" >
        <xml>
            <dso type="grid" function="hr.SP_SEL_ORG">
                <input bind="idGrid" >
                </input>
                <output bind="idGrid" />
            </dso>
        </xml>
    </gw:data>
    
<table  border="0" width="100%" height="100%" cellpadding="0" cellspacing="0" >
  <tr> 
    <td width="100%" height="100%">
    	<table width="100%" height="100%" cellpadding=0 cellspacing=0 border=1>
            
	    	
	    	<tr height="100%"> 
	    		<td>
	    			<table class="table" CELLSPACING="0" CELLPADDING="0" width="100%" height="100%">
	    				<tr>
					    	<td class="itable_content" height="80%">   
							<gw:grid   
							    id="idGrid"  
							    header="_PK|ORDINAL|COMPANY NAME|GROUP NAME"
							    format="0|0|0|0"  
							    aligns="0|0|0|0"  
							    defaults="|||"  
							    editcol="0|0|0|0"
							    widths="500|1000|3000|4000"  
							    styles="width:100%; height:100%"   
							    sorting="T"   
							    param="0,1,2,3" 
							    oncelldblclick="Select()"/> 					    		    
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

<gw:textbox id="txtItem"    styles="width:100%;height:25" style="display:none"/>
<gw:textbox id="txtVal"     styles="width:100%;height:25" style="display:none"/>
<gw:textbox id="id"     styles="width:100%;height:25" style="display:none"/>
</body>

</html>
