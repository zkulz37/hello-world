<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title>genuwin</title>
  </head>
  
 <% ESysLib.SetUser("esys")%>
 
 <script>

function BodyInit()
{
    <%=ESysLib.SetGridColumnComboFormat( "grdObject" , 2 , "SELECT tco.code, tco.code_nm FROM tco_abcode tco, tco_abcodegrp cg WHERE ((tco.tco_abcodegrp_pk = cg.pk) AND (cg.ID = 'COBS0030')) ORDER BY tco.code_nm")%>;
   
	<%=ESysLib.SetGridColumnComboFormat( "grdObject" , 3 , "SELECT tco.code, tco.code_nm FROM tco_abcode tco, tco_abcodegrp cg WHERE ((tco.tco_abcodegrp_pk = cg.pk) AND (cg.ID = 'COAB0110')) ORDER BY tco.code_nm")%>;
	
	grdObject.SetComboFormat(3, '#10;Form|#20;Proceduce|#30;Image|#40;DB Script');
	
	grdObject.SetComboFormat(14, '#comm;comm|#hr;hr|#esys;esys|#acnt;acnt|#inv;inv|#prod;prod|#sale;sale');
	
    BindingDataList();	
}

function BindingDataList()
{
    var data="";    
    data = "DATA|1|Object ID|2|Object Name|3|Object Type|4|Object Version";
    lstObjKey.SetDataText(data);
    lstObjKey.value = "1";
    
    
    
}

function OnSearch()
{
    idData_Dsql_Object.Call("SELECT");
}

function TapPopUp()
{    
    var url = '/form/comm/mn/wcomn00200_1.aspx' ;
	aValue = System.OpenModal( System.RootURL + url , 900 , 550 , 'resizable:yes;status:yes') 
	
	if (aValue != null)
    {    
	    for(var i = 0; i < aValue.length; i++)
	    {
		    var aTemp = aValue[i];
		    grdObject.AddRow();
                 		                
		    grdObject.SetGridText(grdObject.rows-1,2,  aTemp[1]);  // Status
		    grdObject.SetGridText(grdObject.rows-1,4,  aTemp[3]);  // Object ID
		    grdObject.SetGridText(grdObject.rows-1,5,  aTemp[4]);  // Name
		    grdObject.SetGridText(grdObject.rows-1,6,  aTemp[5]);  // LName
		    grdObject.SetGridText(grdObject.rows-1,7,  aTemp[6]);  // FName
		    grdObject.SetGridText(grdObject.rows-1,8,  aTemp[7]);  // Menu ID
		    grdObject.SetGridText(grdObject.rows-1,9,  aTemp[8]);  // Active
		    grdObject.SetGridText(grdObject.rows-1,10, aTemp[9]);  // S_Date
		    grdObject.SetGridText(grdObject.rows-1,11, aTemp[10]); // E_Date
		    grdObject.SetGridText(grdObject.rows-1,12, aTemp[15]); // File Path
	    }
    }	
}

function SaveObject()
{  
    idData_Dsql_Object.Call("INSERT");   
}

function OnDelete()
{
    grdObject.DeleteRow();
}

function OnUnDelete()
{
    grdObject.UnDeleteRow();
}

function OnDataReceive()
{      
    lbRecord.text = grdObject.rows - 1 + " record(s)";    
           
    for( i = 1; i < grdObject.rows; i++ )
    {
        if (grdObject.GetGridData(i, 12) != "")
        {   
            return;
        }
        else
        {
            grdObject.SetCellBgColor(i, 0, i, 13, 0xfeb404 );
        }
    }  
}

function OnClickUpload()
{  
    if (grdObject.col == 12)
    {
        imgFile.ChangeImage();
        
        
        grdObject.SetGridText(grdObject.row, 13, imgFile.oid);        
    }   
}

function onNew()
{
    grdObject.AddRow();
}

function AfterEdit()
{
    if ( grdObject.GetGridData(grdObject.row, 11) < grdObject.GetGridData(grdObject.row, 10) )
    {
        alert("End Date must larger than Start Date.");
        grdObject.SetGridText(grdObject.row, 11, '');
        return;
    }
}
</script>

<body>
<table  width="100%" cellspacing="1">
    <tr>
        <td width="100%">
            <table width="100%" cellpadding="0" cellspacing="0" >
                <tr width="100%" style="background-color: White">                                       
                    <td width="10%" align="right"><b>Filter key</b></td>
                    <td width="15%" align="right"><gw:list id="lstObjKey" styles='width:90%' /></td>                                        
                    <td width="20%" align="right"><gw:textbox id="txtObjectFilter" styles='width:99%' csstype="filter" onenter="OnSearch()" /></td>
                    <td width="5%"></td>
                    <td width="5%"><b>Active</b></td>
                    <td width="3%"><gw:checkbox id="chkActive" mode="01" value="-1"/></td>
                    <td width="2%"></td>
                    <td width="3%"><gw:imgBtn id="btnNew"      img="new"     alt="New Object"        onclick="onNew()" /></td>
                    <td width="3%"><gw:imgBtn id="btnPopup"    img="popup"   alt="Get Object"        onclick="TapPopUp()" /></td>
                    <td width="3%"><gw:imgBtn id="btnSearch"   img="search"  alt="Search Object"     onclick="OnSearch()" /></td>
                    <td width="3%"><gw:imgBtn id="btnDelete"   img="delete"  alt="Delete Object"     onclick="OnDelete()" /></td>
                    <td width="3%"><gw:imgBtn id="btnUnDelete" img="udelete" alt="UnDelete Object"   onclick="OnUnDelete()" /></td>
                    <td width="3%"><gw:imgBtn id="btnSave"     img="save"    alt="Save Object"       onclick="SaveObject()" /></td>
                    <td width="2%"></td>
                    <td width="10%" style="color: Blue" ><b><gw:label id="lbRecord" /></b></td>
                    <td width="10%"></td>
                </tr>
            </table>
        </td>
    </tr>    
    <tr style="background-color: #BDE9FF" cellspacing="2">    
        <td width="100%" >
            <gw:data id="idData_Dsql_Object" onreceive="OnDataReceive()" > 
                <xml> 
                    <dso id="1" type="grid" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14" function="esys.sp_sel_tes_object" procedure="esys.sp_upd_tes_object">
                        <input bind="grdObject" >
                            <input bind="lstObjKey" />                            
                            <input bind="txtObjectFilter" />
                            <input bind="chkActive" />
                        </input>
                        <output bind="grdObject" />
                    </dso>                    
                </xml>
            </gw:data>
            <gw:grid
                id="grdObject"
                header="_PK|Version|Status|Type|Object ID|Name|LName|FName|Menu ID|Active|Start Date|End Date|File Path|_tes_fileobject_pk|Oracle User"
                format="0|0|0|0|0|0|0|0|0|3|4|4|0|0|0"
                aligns="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
                defaults="||||||||||||||"
                editcol="0|1|1|1|1|1|1|1|1|1|1|1|1|0|0"
                widths="0|0|1000|1500|0|1000|1500|1500|2000|0|1500|1500|2500|0|800"
                styles="width:100%; height:440"
                oncelldblclick="OnClickUpload()"
                onafteredit="AfterEdit()"
                sorting="T"
                param="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14"
                 />
        </td>
    </tr>	
</table>
<gw:image id="imgFile" table_name="TES_FILEOBJECT" view="/binary/ViewFile.aspx" post="/binary/PostFile.aspx" styles="width:100;height:100;display:none"  />
</body>
</html>
