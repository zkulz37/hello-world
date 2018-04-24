<!-- #include file="../../../system/lib/form.inc"  -->
<%ESysLib.SetUser(Session("APP_DBUSER"))%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Time machine info</title>
</head>
<script>
var d1,d2
var v_language = "<%=Session("SESSION_LANG")%>";
function BodyInit()
{
    idGrid.GetGridControl().ScrollTrack=true;
    if (v_language!="ENG")
        System.Translate(document);
	idWorkDT.text="<%=request.QueryString("dt")%>";
	
	
	dat_chba0002_01.Call("SELECT");
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
    
}


function OnOK()
{
	window.close();
}

</script>
<body>
<gw:data id="dat_chba0002_01" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid"  parameter="" function="HR.SP_SEL_WG_STATUS"> 
                <input bind="idGrid" >
                    <input bind="idWorkDT" />
                </input>
                <output  bind="idGrid" />
            </dso> 
        </xml> 
</gw:data>

<table align = top class="itable" cellspacing=0 cellpadding=0 border=1 style="width:100%;height:100%;">
 <tr>
	<td> 	
	    <table width="100%" height=5%>		
			<tr>
				<td></td>
  			</tr>
		</table>
		<table width="100%" height=85%>		
			<tr>
				<td align = top height=100%>					
					<gw:grid   
						id="idGrid"  
						header="Work DT|WorkGroup|Process Status|Process Time|Process By"   
						format="4|0|0|0|0"  
						aligns="0|0|0|0|0"  
						defaults="||||"  
						editcol="0|0|0|0|0"  
						widths="2000|3000|2000|2000|2000"  
						styles="width:100%; height:90%"   
						sorting="T"   
						/> 
	
  				</td>
  			</tr>
		</table>
		<table width="100%" height=10%>		
			<tr>
			    <td width="40%"></td>
				<td width="20%"><gw:icon id="idBtnSet"  styles='width:90%' img="in"  text="OK"  onclick="OnOK()"/></td>
				<td width="40%"></td>
  			</tr>
		</table>
	</td>		
</tr>	
</table>
<gw:textbox id="txtdt1" styles="display:none"/>
<gw:textbox id="txtdt2" styles="display:none"/>
<gw:textbox id="idWorkDT" styles="display:none"/>

</body>
</html>
