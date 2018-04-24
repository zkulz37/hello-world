<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<%  ESysLib.SetUser("comm")%>
<head>
    <title>Spec</title>
</head>
<script type="text/javascript" language="javascript">

function BodyInit()
{
	// init value
	 var data = "<%=ESysLib.SetListDataSQL("select PK, SPECGRP_NM from TCO_SPECGRP where DEL_IF=0 order by SPECGRP_NM")%>";   
	 lstGroupSpec.SetDataText(data);
	 lstGroupSpec.SetEnable(false);
	 var pk="<%=request.QueryString("pk")%>";
	 lstGroupSpec.SetDataText(pk);
	 wcoci00001_4.Call('SELECT');  
}
function DSOReceive( dsoinfo  )
{

	if ( dsoinfo.errno > 0 )
	{
		alert( dsoinfo.errmsg );
		return ;
	}
}
// filter data 
function searchOnClick()
{
	// ....here is your source code .................
}
//------------------------------------------------------------
function RowDbClick(flag)
{
	var aValue = new Array();
	// set value to send back parent window 
	aValue[0] = 'CISPECPopup.asp';
	if(flag==0)
	{//reset
		aValue[1] = "";
		aValue[2] = "";
		aValue[3] = "";
		aValue[4] = "";
		aValue[5] = "";
	}	
	else
	{	
		aValue[1] = idGrid.GetGridData( idGrid.row, 0);
		aValue[2] = idGrid.GetGridData( idGrid.row, 1) + ' ' + idGrid.GetGridData( idGrid.row, 2);
		aValue[3] = lstGroupSpec.GetText();
		aValue[4] = lstGroupSpec.GetData();
		aValue[5] = idGrid.GetGridData( idGrid.row, 1) ;
		aValue[6] = idGrid.GetGridData( idGrid.row, 2);
		aValue[7] = idGrid.GetGridData( idGrid.row, 3);
	}
	window.returnValue = aValue; 
	window.close();
}
//--------------------------------------------------------
function OnNew()
{
   if (lstGroupSpec.GetData() != "" && lstGroupSpec.GetData() != "ALL")
   {
     idGrid.AddRow();
	 //idGrid.GetGridText(idGrid.rows-2,1,Trim(txtSpecID.text));
     idGrid.SetGridText(idGrid.rows-1,1,Trim(txtSpecID.text));
     idGrid.SetGridText(idGrid.rows-1,2,Trim(txtSpecName.text));
     idGrid.SetGridText(idGrid.rows-1,7,lstGroupSpec.GetData());
   }
   
   
}
//--------------------------------------------------------
function OnSave()
{
  if(CheckDataIsvalid())
  {
    wcoci00001_4.Call();
  }
   
}
//--------------------------------------------------------function CheckDataIsvalid()
function CheckDataIsvalid()
{
  for (var i=1;i<idGrid.rows;i++)
  {
     if(Trim(idGrid.GetData(i,1))=="")
     {
        alert("Please input ID of spec.");
        return false;
     }
     
     if(Trim(idGrid.GetData(i,2))=="")
     {
        alert("Please input Name of spec.");
        return false;
     }
  }
  return true;
}
//--------------------------------------------------------
function OnSearch()
{
  wcoci00001_4.Call('SELECT');
}
//--------------------------------------------------------
</script>
<body>
<!-- This is a public source code block --> 
 <gw:data id="wcoci00001_4"  onreceive="" > 
        <xml>                                   
             <dso id="1" type="grid" user="comm"  parameter="0,1,2,3,7" function="comm.sp_get_cispec"  procedure="comm.sp_tco_spec_entry"> 
              <input  bind="idGrid">
                    <input bind="lstGroupSpec" /> 
                    <input bind="txtSpecID" />
                    <input bind="txtSpecName" /> 
                </input> 
                <output bind="idGrid" /> 
            </dso> 
        </xml> 
</gw:data> 
<!-- This is our html --------------------------------------------------  -->
<table  width="100%" >
<tr>
	<td>
		<table width="100%" >
		<tr> 
		     <td width="5%"><b>Type</b></td>
			 <td width="25%">	  
			    <gw:list id="lstGroupSpec" styles="width:100%">
			    </gw:list> 				
			 </td>
			 <td width=5%><b>ID</b></td>
			 <td width=20%><gw:textbox id="txtSpecID" text="<%=Request.QueryString("spec_id")%>" styles="width:100%" onenterkey="OnSearch()" /></td>
			 <td width=5%><b>Name</b></td>
			 <td width=20%><gw:textbox id="txtSpecName" text="<%=Request.QueryString("spec_name")%>" styles="width:100%" onenterkey="OnSearch()" /></td>
			 <td width="4%"></td>  	
			  <td width="4%"><gw:imgBtn id="idSearch" img="search" alt="Search" onclick="OnSearch()" /></td>					
	          <td width="4%"><gw:imgBtn id="ibtnNew" img="new" alt="Add new"  onclick="OnNew()" /></td> 
	          <td width="4%"><gw:imgBtn id="ibtnSave" img="save" alt="Save"  onclick="OnSave()" /></td> 
			 </td>						
		</tr>
		</table>	
	</td>	
</tr>
<tr>
	<td>
		<!-- This is Grid script -->
		<table class="table" border=0 cellpadding=0 cellspacing=0 width="100%" >
			<tr>
				<td colspan="3">
			<gw:grid   
				id="idGrid"  
				header="_PK|SPEC_ID|spec name|spec lname|_spec fname|_remark|_grpname|_grpspec_pk"   
				format="0|0|0|0|0|0|0|0"  
				aligns="0|0|0|0|0|0|0|0"  
				defaults="|||||||"  
				editcol="1|1|1|1|1|1|1|1"  
				widths="0|1500|2000|2000|0|0|0|0"  
				styles="width:100%; height:400"   
				sorting="T"   
				oncelldblclick="RowDbClick()"
				param="0,1,2,3,4,5,6,7"  /> 
				</td>
			</tr> 
		</table>	
	</td>	
</tr>
</table>

</body>
</html>




