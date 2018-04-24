<!-- #include file="../../../system/lib/form.inc"  -->
<%ESysLib.SetUser("hr")%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Project Code Info</title>
</head>
<script>
var flag;
var v_language = "<%=Session("SESSION_LANG")%>";

function BodyInit()
{
    idGrid.GetGridControl().ScrollTrack=true;
    if (v_language!="ENG")
        System.Translate(document);
	idProject_PK.text="<%=request.QueryString("p_project_pk")%>"
	idCompany_PK.text= "<%=Session("COMPANY_PK")%>";
	dat_salary_project.Call("SELECT")
}

function DSOReceive( dsoinfo  )
{

	if ( dsoinfo.errno > 0 )
	{
		alert( dsoinfo.errmsg );
		return ;
	}	
}
function OnDataReceive(obj)
{
    if(obj.id=="dat_salary_project")
    {
        for(var i=1;i<idGrid.rows;i++)
            if(idProject_PK.text==idGrid.GetGridData(i,0))
            {
                idGrid.SetCellBgColor(i, 0,i, 2, 0xcc99ff );
                idGrid.SetCellBold(i,0,i,2,true);    
             }   
    }
}
function OnSelect()
{
    
    var obj= Array();
    var irow;
    irow=idGrid.row;
    if (irow>0) 
    {
        obj[0]=idGrid.GetGridData(irow,0); //pk
    }    
    else 
    {
        obj=null;
    }
	window.returnValue = obj; 
	window.close();
}

</script>
<body>
<gw:data id="dat_salary_project" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid"  parameter="" function="HR.SP_SEL_SALARY_PROJECT"> 
                <input bind="idGrid" >
                    <input bind="idProject_PK" />
                    <input bind="idCompany_PK" />
                </input>
                <output  bind="idGrid" />
            </dso> 
        </xml> 
</gw:data>

<table align = top style='margin-left:10px' class="itable" cellspacing=0 cellpadding=0 border=0 style="width:100%;height:100%;">
 <tr>
	<td> 	
	    <table width="100%" height=7% cellspacing=0 cellpadding=0>		
			<tr>
				<td align = top width=100%><b style="color:#FF0066;font-size:15">Double click to choose</b></td>
  			</tr>
		</table>
		<table width="100%" border=1 height=93% cellspacing=0 cellpadding=0>		
			<tr>
				<td align = top height=100%>					
					<gw:grid   
						id="idGrid"  
						header="_PK|Code|Code Name"   
						format="0|0|0"  
						aligns="0|1|0"  
						defaults="|||"  
						editcol="0|0|0"  
						widths="0|2000|2500"  
						styles="width:100%; height:100%"   
						sorting="T"   
						param="0,1" oncelldblclick="OnSelect()" /> 
	
  				</td>
  			</tr>
		</table>
	</td>		
</tr>	
</table>
<gw:textbox id="idCompany_PK" styles="display:none"/>
<gw:textbox id="idProject_PK" styles="display:none"/>

</body>
</html>
