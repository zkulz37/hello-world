<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title>genuwin</title>
  </head>
  
 <% ESysLib.SetUser("esys")%>
 
 <script>

function BodyInit()
{
    <%=ESysLib.SetGridColumnComboFormat( "grdMaster" , 2 , "SELECT tco.code, tco.code_nm FROM tco_abcode tco, tco_abcodegrp cg WHERE ((tco.tco_abcodegrp_pk = cg.pk) AND (cg.ID = 'COBS0030')) ORDER BY tco.code_nm")%>;
	<%=ESysLib.SetGridColumnComboFormat( "grdMaster" , 3 , "SELECT tco.code, tco.code_nm FROM tco_abcode tco, tco_abcodegrp cg WHERE ((tco.tco_abcodegrp_pk = cg.pk) AND (cg.ID = 'COAB0110')) ORDER BY tco.code_nm")%>;
	
	<%=ESysLib.SetGridColumnComboFormat( "grdView" , 2 , "SELECT tco.code, tco.code_nm FROM tco_abcode tco, tco_abcodegrp cg WHERE ((tco.tco_abcodegrp_pk = cg.pk) AND (cg.ID = 'COBS0030')) ORDER BY tco.code_nm")%>;
	<%=ESysLib.SetGridColumnComboFormat( "grdView" , 3 , "SELECT tco.code, tco.code_nm FROM tco_abcode tco, tco_abcodegrp cg WHERE ((tco.tco_abcodegrp_pk = cg.pk) AND (cg.ID = 'COAB0110')) ORDER BY tco.code_nm")%>;
	
	<%=ESysLib.SetGridColumnComboFormat( "grdDetail" , 2 , "SELECT tco.code, tco.code_nm FROM tco_abcode tco, tco_abcodegrp cg WHERE ((tco.tco_abcodegrp_pk = cg.pk) AND (cg.ID = 'COBS0030')) ORDER BY tco.code_nm")%>;
	<%=ESysLib.SetGridColumnComboFormat( "grdDetail" , 3 , "SELECT tco.code, tco.code_nm FROM tco_abcode tco, tco_abcodegrp cg WHERE ((tco.tco_abcodegrp_pk = cg.pk) AND (cg.ID = 'COAB0110')) ORDER BY tco.code_nm")%>;

    grdMaster.GetGridControl().FrozenCols = 5;
    		
    BindingDataList();
}

function BindingDataList()
{
    var data="";    
    data = "DATA|1|Object ID|2|Object Name|3|Object Type|4|Object Version";
    lstObjKey.SetDataText(data);
    lstObjKey.value = "1";
    
    data = "DATA|1|Object ID|2|Object Name|4|Object Version";
    lstViewKey.SetDataText(data);
    lstViewKey.value = "1";
}

function OnSearchMaster()
{
    idData_Dsql_Object.Call('SELECT');
}

function OnSearchView()
{   
    idData_Dsql_View.Call('SELECT');
}

function OnDeleteDetail()
{
    grdDetail.DeleteRow();    
}

function OnSaveDetail()
{       
    idData_Dsql_Detail.Call();
}

function OnDataReceive(obj)
{      
    switch(obj)
    {
        case 'idData_Dsql_Object':
            lbRecord.text = grdMaster.rows - 1 + " record(s)";           
        break;
                         
        case 'idData_Dsql_View':
            lbRecordView.text   = grdView.rows - 1 + " record(s)";            
        break;
        
        case 'idData_Dsql_Detail':         
            lbRecordDetail.text   = grdDetail.rows - 1 + " record(s)";
            
            txtObjectPK.text = grdMaster.GetGridData(grdMaster.row, 0);                        
            idData_Dsql_ObjView.Call("SELECT");
        break;
        
        case 'idData_Dsql_ObjView':        
            lbRecordView.text   = grdView.rows - 1 + " record(s)";
        break;
    }
}

function OnClickRecord()
{
    txtObjectPK.text = grdMaster.GetGridData(grdMaster.row, 0);        
    idData_Dsql_Detail.Call('SELECT');
}

function removeViewFrom()
{   
	var mapView   = grdView.GetGridControl();
	var mapDetail = grdDetail.GetGridControl();
    var objPK     = txtObjectPK.text;
    var viewPK    = grdView.GetGridData(grdView.row, 0);
    var objIDView = grdView.GetGridData(grdView.row, 4);
    
    if (Trim(objPK) != "")
    {   
        if ( objPK != viewPK)
        {    
            if (mapView.SelectedRows > 0) 
            {	        
                for (i = mapView.Rows-1; i > 0; i--) 
                {		 
	                if (mapView.IsSelected(i)) 
	                {   		            
		                grdDetail.AddRow();			        
    			        			        
		                mapDetail.TextMatrix(mapDetail.Rows -1 ,1) = mapView.TextMatrix(i , 1);
		                mapDetail.TextMatrix(mapDetail.Rows -1 ,2) = mapView.TextMatrix(i , 2);
		                mapDetail.TextMatrix(mapDetail.Rows -1 ,3) = mapView.TextMatrix(i , 3);
		                mapDetail.TextMatrix(mapDetail.Rows -1 ,4) = mapView.TextMatrix(i , 4);
		                mapDetail.TextMatrix(mapDetail.Rows -1 ,5) = mapView.TextMatrix(i , 5);
		                mapDetail.TextMatrix(mapDetail.Rows -1 ,6) = mapView.TextMatrix(i , 6);
		                mapDetail.TextMatrix(mapDetail.Rows -1 ,7) = mapView.TextMatrix(i , 7);
		                mapDetail.TextMatrix(mapDetail.Rows -1 ,8) = mapView.TextMatrix(i , 8);
		                mapDetail.TextMatrix(mapDetail.Rows -1 ,9) = mapView.TextMatrix(i , 9);
		                mapDetail.TextMatrix(mapDetail.Rows -1 ,10) = mapView.TextMatrix(i , 10);
		                mapDetail.TextMatrix(mapDetail.Rows -1 ,11) = mapView.TextMatrix(i , 11);
		                mapDetail.TextMatrix(mapDetail.Rows -1 ,12) = mapView.TextMatrix(i , 12);
		                mapDetail.TextMatrix(mapDetail.Rows -1 ,13) = mapView.TextMatrix(i , 13);
		                mapDetail.TextMatrix(mapDetail.Rows -1 ,14) = mapView.TextMatrix(i , 14);
		                mapDetail.TextMatrix(mapDetail.Rows -1 ,15) = mapView.TextMatrix(i , 15);
		                mapDetail.TextMatrix(mapDetail.Rows -1 ,16) = mapView.TextMatrix(i , 16);
		                mapDetail.TextMatrix(mapDetail.Rows -1 ,17) = mapView.TextMatrix(i , 17);
		                mapDetail.TextMatrix(mapDetail.Rows -1 ,18) = objPK;                        
		                mapDetail.TextMatrix(mapDetail.Rows -1 ,19) = mapView.TextMatrix(i , 0);; // View_PK
    			        
		                mapView.RemoveItem(i);
                        		       			        
		                OnDataReceive('idData_Dsql_View');
		            }
                }
            } 
            else 
            {
                alert ("Please select ObjectRole for removing.");
            }           
        }
        else
        {
            alert("Please select Object other.");
        }        
    }
    else
    {
        alert ("Please select object Master.");
    }    
}


</script>

<body>
<!-- Master Object-->
<gw:data id="idData_Dsql_Object" onreceive="OnDataReceive('idData_Dsql_Object')" > 
    <xml> 
        <dso id="1" type="grid" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17" function="esys.sp_get_tes_object" procedure="esys.sp_process_tes_object">
            <input bind="grdMaster" >                            
                <input bind="lstObjKey" />                            
                <input bind="txtObjectFilter" />
                <input bind="chkActive" />
            </input>
            <output bind="grdMaster" />
        </dso>                    
    </xml>
</gw:data>

<!--Views-->
<gw:data id="idData_Dsql_View" onreceive="OnDataReceive('idData_Dsql_View')" > 
    <xml>
        <dso id="2" type="grid" function="esys.sp_get_tes_object">
            <input bind="grdView" >                
                <input bind="lstViewKey" />                            
                <input bind="txtViewtFilter" />
                <input bind="chkViewActive" />
            </input>
            <output bind="grdView" />
        </dso>                    
    </xml>
</gw:data>

<!--Details Object-->
<gw:data id="idData_Dsql_Detail" onreceive="OnDataReceive('idData_Dsql_Detail')">
    <xml> 
        <dso id="3" type="grid" parameter="0,18,19" function="esys.sp_get_tes_objfamily" procedure="esys.sp_process_tes_objfamily">
            <input bind="grdDetail" >                            
                <input bind="txtObjectPK" />                
            </input>
            <output bind="grdDetail" />
        </dso>                    
    </xml>
</gw:data>

<!--***********************************************************************-->
<gw:data id="idData_Dsql_ObjView" onreceive="OnDataReceive('idData_Dsql_ObjView')" > 
    <xml>
        <dso id="2" type="grid" function="esys.sp_get_tes_objview">
            <input bind="grdView" >                
                <input bind="txtObjectPK" />                
            </input>
            <output bind="grdView" />
        </dso>                    
    </xml>
</gw:data>

<table  width="100%">
    <tr>       
        <td width="100%" >            
            <table width="100%" >
                <tr width="100%" >                                       
                    <td width="10%" align="right"><b>Filter key</b></td>
                    <td width="15%" align="right"><gw:list id="lstObjKey" styles='width:90%' /></td>                                        
                    <td width="20%" align="right"><gw:textbox id="txtObjectFilter" styles='width:99%' csstype="filter" onenter="OnSearchMaster()" /></td>
                    <td width="5%"></td>
                    <td width="5%"><b>Active</b></td>
                    <td width="3%"><gw:checkbox id="chkActive" mode="01" value="-1"/></td>
                    <td width="5%"></td>                    
                    <td width="3%"><gw:imgBtn id="btnSearch" img="search" alt="Search Object"     onclick="OnSearchMaster()" /></td>
                    <td width="4%"></td>
                    <td width="10%" style="color: Blue" ><b><gw:label id="lbRecord" /></b></td>
                    <td width="20%"></td>
                </tr>
            </table>
        </td>
    </tr>    
    <tr style="background-color: #BDE9FF" >
        <td width="100%" >
            <table width="100%" style="background-color: White" cellspacing="1">
                <tr>
                    <td width="100%">
                        <gw:grid
                        id="grdMaster"
                        header="_PK|Version|Status|Type|Object ID|Name|LName|FName|Menu ID|Active|Start Date|End Date|Create By|Create DT|Mod By|Mod DT|File Path|_tes_fileobject_pk"
                        format="0|0|0|0|0|0|0|0|0|3|4|4|0|4|0|4|0|0"
                        aligns="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
                        defaults="|||||||||||||||||"
                        editcol="0|1|0|0|0|0|0|0|0|0|0|0|1|1|1|1|0|0"
                        widths="0|0|1000|1500|0|1000|1500|1500|2000|0|1500|1500|1500|1500|1500|1500|1500|0"
                        styles="width:100%; height:200"
                        onclick="OnClickRecord()"
                        sorting="T"
                        param="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17"
                         />
                    </td>    
                </tr>
            </table>
        </td>
    </tr>
    <tr style="background-color: #BDE9FF" >
        <td width="100%" >
            <table width="100%" cellspacing="1">
                <tr>
                    <td width="40%" style="background-color: White">
                        <table width="100%" cellspacing="1" >
                             <tr>
                                <td width="10%" align="right"><b>Filter</b></td>
                                <td width="50%" align="right"><gw:list id="lstViewKey" styles='width:90%' /></td>                                
                                <td width="25%" align="right"><b>Active</b> <gw:checkbox id="chkViewActive" mode="01" value="-1"/></td>                                
                                <td width="15%"><gw:imgBtn id="btnSearchView" img="search" alt="Search View"     onclick="OnSearchView()" /></td>                                                                
                            </tr>
                            <tr >
                                <td width="10%" align="right"><b>Input</b></td>
                                <td width="50%" align="right"><gw:textbox id="txtViewtFilter" styles='width:90%' csstype="filter" onenter="OnSearchView()" /></td>                                
                                <td width="40%" align="center" style="color: Blue" colspan="2" ><b><gw:label id="lbRecordView" /></b></td>
                            </tr>                           
                        </table>
                    </td>
                    <td width="60%" style="background-color: White">
                        <table width="100%">
                            <tr>
                                <td width="94%"></td>
                                <td width="3%"><gw:imgBtn id="btnDelete" img="delete" alt="Delete Object"     onclick="OnDeleteDetail()" /></td>
                                <td width="3%"><gw:imgBtn id="btnSave"   img="save"   alt="Save Object"       onclick="OnSaveDetail()" /></td>
                            </tr>
                            <tr>                                
                                <td width="100%" align="right" style="color: Blue" colspan="3" ><b><gw:label id="lbRecordDetail" /></b></td>
                            </tr>                            
                        </table>
                    </td>
                </tr>
                <tr style="background-color: White">
                    <td width="40%">
                        <gw:grid
                        id="grdView"
                        header="_PK|Version|_Status|_Type|Object ID|Name|_LName|_FName|_Menu ID|_Active|_Start Date|_End Date|_Create By|_Create DT|_Mod By|_Mod DT|_File Path|_tes_fileobject_pk"
                        format="0|0|0|0|0|0|0|0|0|3|4|4|0|4|0|4|0|0"
                        aligns="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
                        defaults="|||||||||||||||||"
                        editcol="0|1|0|0|0|0|0|0|0|0|0|0|1|1|1|1|0|0"
                        widths="0|0|1000|1500|1500|1000|1500|1500|2000|0|1500|1500|1500|1500|1500|1500|1500|0"
                        styles="width:100%; height:170"
                        sorting="T"
                        oncelldblclick="removeViewFrom()"
                        param="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17"
                         />
                    </td>
                    <td width="60%">
                        <gw:grid
                        id="grdDetail"
                        header="_PK|Version|Status|Type|Object ID|Name|LName|FName|Menu ID|Active|Start Date|End Date|Create By|Create DT|Mod By|Mod DT|File Path|_tes_fileobject_pk|_tes_objpk|_obj_family_pk"
                        format="0|0|0|0|0|0|0|0|0|3|4|4|0|4|0|4|0|0|0|0"
                        aligns="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
                        defaults="|||||||||||||||||||"
                        editcol="0|1|0|0|0|0|0|0|0|0|0|0|1|1|1|1|0|0|0|0"
                        widths="0|0|1000|1500|0|1000|1500|1500|2000|0|1500|1500|1500|1500|1500|1500|1500|0|0|0"
                        styles="width:100%; height:170"
                        sorting="T"                        
                        param="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19"
                         />
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<gw:textbox id="txtObjectPK" style="display:none" />
<gw:textbox id="txtViewPK"   style="display:none" />
<gw:textbox id="txtDetailPK"   style="display:none" />
</body>
</html>
