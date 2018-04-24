<!-- #include file="../../../system/lib/form.inc"  -->
<html>
<head>
    <title>Object Entry</title>
</head>
<%  ESysLib.SetUser(Session("APP_DBUSER"))%>
<script>
var G_Status=0,
	G_Type=1,
	G_Charger=2,
	G_Sub_Charger=3,
	G_Object_ID=4,
	G_Object_Name=5,  
	G_LName_FName=6,
	G_Menu_ID=7,
	G_Select=8,
	G_Insert=9,
	G_Update=10,
	G_Delete=11,
	G_Print=12,
	G_Direction=13, 
	G_Active=14,
	G_Start_Date=15,
	G_End_Date=16,
	G_IsLogistics=17,
	G_IsAccount=18,
	G_IsHR=19,
	G_IsInventory=20,
	G_pk=21,    
	G_Priv=22;
//_pk|Status|Type|_Priv|Charger|Sub Charger|Object ID|Object Name|LName|FName|Menu ID|Select|Insert|Update|Delete|Print|Direction|Active|Start Date|End Date|IsLogistics|IsAccount|IsHR|IsInventory
function BodyInit()
{
	<%=ESysLib.SetGridColumnComboFormat( "grdObject" , 0 , "SELECT tco.code, tco.code_nm FROM tco_abcode tco, tco_abcodegrp cg WHERE ((tco.tco_abcodegrp_pk = cg.pk) AND (cg.ID = 'COBS0030')) ORDER BY tco.code_nm")%>;
	<%=ESysLib.SetGridColumnComboFormat( "grdObject" , 1 , "SELECT tco.code, tco.code_nm FROM tco_abcode tco, tco_abcodegrp cg WHERE ((tco.tco_abcodegrp_pk = cg.pk) AND (cg.ID = 'COAB0110')) ORDER BY tco.code_nm")%>;
	
	grdObject.GetGridControl().FrozenCols = 5;
	//grdObject.GetGridControl().SheetBorder = 0xF3D781;
	
	BindingDataList();
}

function BindingDataList()
{
    var data="";
    
    data = "<%=ESysLib.SetListDataFUNC("SELECT F_COMMONCODE('COAB0110','','') FROM DUAL")%>|%|Select All";
    //alert(data)
    lstObjType.SetDataText(data);
    lstObjType.value = "%";
    
    data = "DATA|1|Object Name|2|Object ID|3|Menu ID";
    lstObjKey.SetDataText(data);
    lstObjKey.value = "1";
}
function OnNew()
{
	grdObject.AddRow();
	grdObject.SetGridText(grdObject.rows - 1, G_Direction, 'Y'); 
	grdObject.SetGridText(grdObject.rows - 1, G_Start_Date, '');	
	if (lstObjType.GetData() != "%") 
	{
		grdObject.SetGridText(grdObject.rows - 1, G_Type, lstObjType.GetData());
	}	
}
function OnDelete() 
{
   if(confirm("If you delete these objects. \nMenu, role object of these objects will be delete.")){
	    grdObject.DeleteRow();
   }
}
function MakeObjectAttribute()
{
    var i=0, k=0;
	var val = "";	
	for (k=1; k<grdObject.rows; k++)
	{
	    if(grdObject.GetRowStatus(k) == 0) continue;
		val = "";
		for (i=0; i<6; i++)
		{
		  if (grdObject.GetGridData(k,G_Select+i)==-1)
		  {
		     val=val +'1' 
		  }
		  else 
		  {
		     val=val + '0'
		  }				
		}
		grdObject.SetGridText(k,G_Priv,val)			
	}
}
function OnSave()
{	
	MakeObjectAttribute();
	
	if (CheckDataIsValid()) 
	{
		dsoObject.Call();
	}
}

function CheckDataIsValid() 
{
	for (var i=1;i<grdObject.rows;i++) 
	{
		if ( Trim(grdObject.GetGridData(i,G_Type))=="" ) 
		{
			alert('Object Type can not be blank.');
			return false;
		}	
		if ( Trim(grdObject.GetGridData(i,G_Object_ID))=="" )    
		{
			alert('Object ID can not be blank.');
			return false;
		}			
		if ( Trim(grdObject.GetGridData(i,G_Object_Name))=="" ) 
		{
			alert('Object Name can not be blank.');
			return false;
		}			
	}
	return true;
}
function OnSearch()
{
	switch (lstObjKey.GetData()) {
		case '1' : {
			txtObjectName.text = txtObjectFilter.text;
			txtObjectID.text = '';
			txtMenuID.text = '';			
			break;
		}
		case '2' : {
			txtObjectID.text = txtObjectFilter.text;
			txtObjectName.text = '';
			txtMenuID.text = '';
			break;		
		}
		case '3' : {
			txtMenuID.text = txtObjectFilter.text;
			txtObjectID.text = '';
			txtObjectName.text = '';
			break;		
		}				
	}
	dsoObject.Call('SELECT');
}
</script>

<body>
    <gw:data id="dsoObject"> 
        <xml> 
            <dso type="grid" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23" function="GASP.sp_get_tco_bsobj" procedure="GASP.sp_tco_bsobj_entry">  
                <input bind="grdObject"   > 
				    <input bind="lstObjType" /> 
                    <input bind="txtObjectID" /> 
                    <input bind="txtObjectName" />  
                    <input bind="txtMenuID" /> 	
                    <input bind="chkActive" /> 															
                </input> 
                <output bind="grdObject" /> 
            </dso> 
        </xml> 
    </gw:data> 	

	<table width="100%" >
      <tr> 
        <td width="10%"><b>Object Type</b></td>
        <td width="10%"><gw:list id="lstObjType" onchange="" /></td>
        <td width="10%" ><b>Filter key</b></td>
        <td width="15%"><gw:list id="lstObjKey" onchange="" /></td>
        <td width="5%"><b>Value</b></td>
        <td width="10%"><gw:textbox id="txtObjectFilter" csstype="filter" /></td>
        <td width="5%"><b>Active</b></td>
        <td width="5%"><gw:checkbox id="chkActive" mode="01" value="-1"/></td>
        <td width="15%"></td>
        <td width="3%"><gw:imgBtn id="btnSearch" img="search" alt="Search"  onclick="OnSearch()" /></td>
        <td width="3%"><gw:imgBtn id="btnNew" img="new" alt="New" styles="display:none" onclick="OnNew()"/> </td>
        <td width="3%"><gw:imgBtn id="btnDelete" img="delete" alt="Delete" styles="display:none" onclick="OnDelete()"/></td>
        <td width="3%"><gw:imgBtn id="btnUnDelete" img="udelete" alt="UnDelete" styles="display:none" onclick="OnUnDelete()"/></td>
        <td width="3%"><gw:imgBtn id="btnSave" img="save" alt="Save" styles="display:none" onclick="OnSave()"/>  </td>
     </tr>
     <tr>
         <td colspan=14>       
                <div style="width:100%; height:435; overflow:auto">
						<gw:grid
							id="grdObject"
							header="Status|Type|Charger|Sub Charger|Object ID|Object Name|LName|FName|Menu ID|Select|Insert|Update|Delete|Print|Direction|Active|Start Date|End Date|IsLogistics|IsAccount|IsHR|IsInventory|_pk|_Priv"
							format="0|0|0|0|0|0|0|0|0|3|3|3|3|3|3|3|4|4|3|3|3|3|0|0"
							aligns="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
							defaults="|U||||||||||||||||||||||M"
							editcol="1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1"
							styles="width:100%; height:450"
							sorting="T" autosize="true"
							acceptNullDate="true" />
				</div>
        </td>
	</tr>
</table>
<gw:textbox id="txtObjectID" styles="display:none" />
<gw:textbox id="txtObjectName" styles="display:none" />
<gw:textbox id="txtMenuID" styles="display:none" />
</body>
</html>
