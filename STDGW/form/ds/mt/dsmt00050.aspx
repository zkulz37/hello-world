<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<%  
    ESysLib.SetUser(Session("APP_DBUSER"))
    Dim l_user As String
    l_user = ""
%>
<head>
    <title>Partner Group</title>
</head>

<script type="text/javascript">
 
    var lastrow = -1 ;
    
    var G1_PK                   = 0, 
        G1_TLG_DIVISION_PK      = 1, 
        G1_TCO_BUSPARTNER_PK    = 2,
        G1_SEQ                  = 3,   
        G1_PARTNER_ID           = 4, 
        G1_PARTNER_NAME         = 5,
        G1_PARTNER_LNAME        = 6, 
		G1_PARTNER_FNAME		= 7,
		G1_DESCRIPTION			= 8;
        
 //---------------------------------------------------------
function OnToggle(pos)
{
    switch (pos)
    {
        case '1':
            var left = document.all("left"); 
            var right = document.all("right"); 
            var imgArrow = document.all("imgArrow"); 

            if(imgArrow.status == "expand")
            {
                left.style.display="none";
                imgArrow.status = "collapse";
                right.style.width="100%";
                imgArrow.src = "../../../system/images/button/next.gif";
            }
            else
            {
                left.style.display="";
                imgArrow.status = "expand";
                right.style.width="70%";
                imgArrow.src = "../../../system/images/button/previous.gif";
            }        
        break; 
    }    
}
//------------------------------------------------------------ 

function BodyInit()
{   
    System.Translate(document); 
    txtParentNm.SetEnable(false);
 
    //------------------------------
    SetGridFormat();
    //------------------------------
	
	OnSearch('Group');   
} 

//------------------------------------------------------------
function SetGridFormat()
{
     
}

//------------------------------------------------------------ 
function OnSave(pos)
{
    switch (pos)
    {
        case 'Item':
            data_dsmt00050_2.Call();   
        break;        
        case 'Group':
            data_dsmt00050_1.Call();
        break;     
    }   
}
//------------------------------------------------------------ 
function OnAddNew(pos)
{
    switch(pos)
    {
        case 'Item' :
            if ( txtGroup_PK.text != '' )
            {
                if ( txtLeafYN.text == 'Y' )
                {
	                var data ;
	                var path = System.RootURL + '/form/fp/ab/fpab00480.aspx';
	                var obj = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
	                if ( obj != null )
	                {
	                    for (var i = 0 ; i< obj.length; i++)
	                    {
	                        grdItem.AddRow();
	                        data = obj[i];            
	                        grdItem.SetGridText(grdItem.rows-1,G1_TLG_DIVISION_PK,txtGroup_PK.text);
	                        grdItem.SetGridText(grdItem.rows-1,G1_TCO_BUSPARTNER_PK,data[0]);
	                        grdItem.SetGridText(grdItem.rows-1,G1_SEQ, i + 1);
	                        grdItem.SetGridText(grdItem.rows-1,G1_PARTNER_ID,data[1]);
	                        grdItem.SetGridText(grdItem.rows-1,G1_PARTNER_NAME,data[2]);
	                        grdItem.SetGridText(grdItem.rows-1,G1_PARTNER_LNAME,data[3]);
	                        //grdItem.SetGridText(grdItem.rows-1,G1_PARTNER_FNAME,data[5]);
	                     }
	                }                                
                }
                else
                {
                    alert("Add new for Leaf Group only.");
                }    
            }
            else
            {
                alert('Pls Select Group first !!!');
            }    
        break;
        
        case 'group' :
            data_dsmt00050_1.StatusInsert();
            if(oTree.GetCurrentNode() != null)
            {
                txtParentPK.text = oTree.GetCurrentNode().oid; 
                txtParentNm.text = oTree.GetCurrentNode().text;            
            }
            txtGrpCD.text = '<< New Code >>' ;
            txtGrpNm.text = '<< New Name >>' ;
        break;  
        
        case 'update_group' :
            txtGroupNew_PK.text = oTree.GetCurrentNode().oid;
            data_dsmt00050_1.Call("SELECT");
        break;      
    }    
}
//------------------------------------------------------------ 
function OnDataReceive(obj)
{
    switch(obj.id)
    {
        case "data_dsmt00050_3":
             data_dsmt00050_2.Call("SELECT");
        break;
        
        case 'data_dsmt00050_2':
            lblRecord.text = grdItem.rows-1 + ' row(s)';
        break;
                
        case 'data_dsmt00050_1':
            OnSearch('Group');
        break;  
                
    }
}
 
//------------------------------------------------------------
function OnDelete(pos)
{
    switch (pos)
    {
        case 'Item' :
            if( confirm('Do you want to delete this item ?'))
	        {
	            grdItem.DeleteRow();
	        }        
        break;
        
        case 'Group':
            if(confirm('Do you want to delete selected group?'))
            {                
                data_dsmt00050_1.StatusDelete();
                data_dsmt00050_1.Call('');
	        }        
        break;
    }
}

 //------------------------------------------------------------------
 function CheckInput()
 {   
    var  row, col 
        
    row = event.row ;
    col = event.col ;    
        
    if ( col == G1_UNIT_PRICE || col == G1_PUR_PRICE || col == G1_PROD_PRICE )
    {      
        var dQuantiy
        
        dQuantiy =  grdItem.GetGridData(row,col)
        
        if (Number(dQuantiy))
        {   
            if (dQuantiy >0)
            {
                grdItem.SetGridText(row,col,parseFloat(dQuantiy+"").toFixed(2));
            }
            else
            {
                alert(" Value must greater than zero !!");
                grdItem.SetGridText(row,col,"")
            }
        }
        else
        {
            grdItem.SetGridText(row,col,"")
        }
         //---------------------------------------------
    } 
 } 
//============================================================
function OnSearch(pos)
{
    switch (pos)
    {
        case 'Group':
            data_dsmt00050.Call("SELECT");
        break;
        
        case 'ItemList': 
            txtGroup_PK.SetDataText(oTree.GetCurrentNode().oid);
            
            data_dsmt00050_3.Call("SELECT");                              
        break;    
    }
}
//===========================================================

function CheckFilesExist(filepath)
{

        if (Trim(filepath)=='') 
        {
            alert("Please, select an excel source file!!")
            return false;
        }
	    //test file exist
	    var fso = new ActiveXObject("Scripting.FileSystemObject");		

        if (!fso.FileExists(filepath))    
        {
            alert(filepath+" doesn't exist.");        
            return false;
        }	
        return true;
    
}

//-------------------------read data form exel file ----------------
function ReadFiles()
{
    if ( txtGroup_PK.text != '' )
    {
        if ( txtLeafYN.text == 'Y' )
        {
        	var fl = document.getElementById("idtext").value;  
                
              //  if ( CheckFilesExist(fl) )
              //  {
                    var excel = new ActiveXObject("Excel.Application");
                    var excel_file  = excel.Workbooks.Open(fl);
                    var excel_sheet = excel.Worksheets("Sheet1"); 
                    var maxRow    = excel.Worksheets("Sheet1").UsedRange.Rows.Count
                    var lrow, lcol, data
                 
                    for(lrow = 2; lrow <= maxRow ; lrow++) 
                    {
                           grdItem.AddRow();
                           
                           for ( lcol = 1; lcol < 12; lcol++ )
                           {
                               data = excel_sheet.Cells( lrow, lcol ).Value; 
                               
                               grdItem.SetGridText( grdItem.rows-1, lcol, data);
                               grdItem.SetGridText( grdItem.rows-1, G1_GRP_PK, txtGroup_PK.text);
                           }                                                    
                    }          
                   lblRecord.text = (grdItem.rows -1)+" row(s).";
                    excel.Quit();
                    excel = null;
              //  }
        }
        else
        {
            alert("Add new for Leaf Group only.");
        }            
    }    
    else
    {
        alert('Pls Select Group first !!!');
    }  
}
//============================================================

function OnCellDoubleClick(obj)
{
	switch(obj.id)
	{
		case 'grdItem':
			var col = event.col ;
			var row = event.row ;
		 
			if (col == G1_WH_ACC || col == G1_EXPENSE_ACC || col == G1_REVENUE_ACC )
			{
 				fpath = System.RootURL + '/form/fp/ab/fpab00490.aspx';
            	var aValue  = System.OpenModal(  fpath , 550 , 500 , 'resizable:yes;status:yes');
            
            	if ( aValue != null )
            	{      
                	grdItem.SetGridText( row, col-1, aValue[0] );
					grdItem.SetGridText( row, col,   aValue[1] + ' - ' + aValue[2] );                	 
            	}				
			}
		break;
	}
}
//===============================================================================
function OnPopUp(pos)
{
    switch(pos)
    {
		case 'Import':
			var url =System.RootURL + '/form/ag/ci/agci00070_import.xls';
        	window.open(url);
		break;       
    }	       
}

//======================================================================
function OnToggleGrid()
{
    if(imgMaster.status == "expand")
    {
        imgMaster.status = "collapse";

		grdItem.GetGridControl().ColHidden(G1_VIRTUAL_CODE) = true ;
		grdItem.GetGridControl().ColHidden(G1_SPEC_01)      = true ;
		grdItem.GetGridControl().ColHidden(G1_SPEC_02)      = true ;
		grdItem.GetGridControl().ColHidden(G1_SPEC_03)      = true ;
		grdItem.GetGridControl().ColHidden(G1_SPEC_04)      = true ;
		grdItem.GetGridControl().ColHidden(G1_SPEC_05)      = true ;
		
        imgMaster.src = "../../../system/images/iconmaximize.gif";
		imgMaster.alt="Show all column";
		
    }
    else
    {
        imgMaster.status = "expand";
        
		grdItem.GetGridControl().ColHidden(G1_VIRTUAL_CODE) = false ;
		grdItem.GetGridControl().ColHidden(G1_SPEC_01)      = false ;
		grdItem.GetGridControl().ColHidden(G1_SPEC_02)      = false ;
		grdItem.GetGridControl().ColHidden(G1_SPEC_03)      = false ;
		grdItem.GetGridControl().ColHidden(G1_SPEC_04)      = false ;
		grdItem.GetGridControl().ColHidden(G1_SPEC_05)      = false ;			
		
        imgMaster.src = "../../../system/images/close_popup.gif";
		imgMaster.alt="Hide unuse column";
    }
}

//============================================================
function OnReport()
{
     var url =System.RootURL + "/reports/ds/mt/rpt_dsmt00050.aspx?p_item="+txtItem.text+"&p_grp_pk="+txtGroup_PK.text; 
     System.OpenTargetPage(url); 
}
</script>

<body>
    <!------------------------------------------------------------------------------->
    <gw:data id="data_dsmt00050" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="tree" function="<%=l_user%>lg_sel_dsmt00050" > 
                <input>
                    <input bind="txtGroupSearch" />
                </input>
                <output bind="oTree" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------------------->
    <gw:data id="data_dsmt00050_1" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="control" parameter="0,1,2,3,4" function="<%=l_user%>lg_sel_dsmt00050_1"  procedure="<%=l_user%>lg_upd_dsmt00050_1"> 
                <inout> 
                     <inout  bind="txtGroupNew_PK" /> 
                     <inout  bind="txtParentPK" />
                     <inout  bind="txtParentNm" />
                     <inout  bind="txtGrpCD" />
                     <inout  bind="txtGrpNm" />                	                 
                </inout>
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------------------->
    <gw:data id="data_dsmt00050_3" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="control" parameter="0,1,2" function="<%=l_user%>lg_sel_dsmt00050_3"> 
                <inout> 
                     <inout  bind="txtGroup_PK" /> 
                     <inout  bind="lbGroupName" />
                     <inout  bind="txtLeafYN" />              	                 
                </inout>
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------------------->
    <gw:data id="data_dsmt00050_2" onreceive="OnDataReceive(this)"> 
        <xml> 
           <dso id="1" type="grid" parameter="0,1,2,3,4,5,6,7,8" function="<%=l_user%>lg_sel_dsmt00050_2" procedure="<%=l_user%>lg_upd_dsmt00050_2" > 
                <input bind="grdItem" > 
                    <input bind="txtItem" /> 
                    <input bind="txtGroup_PK" />
                </input> 
                <output bind="grdItem" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------------------->
    <table style="width: 100%; height: 100%" border="1">
        <tr valign="top" style="height: 100%">
            <td style="width: 35%" id="left">
                <table style="width: 100%; height: 100%" border="0">
                    <tr style="height: 1%">
                        <td style="width: 5%; white-space: nowrap" align="right">
                            Search
                        </td>
                        <td style="width: 50%">
                            <gw:textbox id="txtGroupSearch" styles='width:100%' onenterkey="OnSearch('Group')" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="ibtnSearchGroup" img="search" alt="Search" text="Search" onclick="OnSearch('Group')" />
                        </td>
                        <td style="width: 1%" align="right">
                            <gw:imgbtn id="ibtnAddNew" img="new" alt="New" text="New" onclick="OnAddNew('group')" />
                        </td>
                        <td style="width: 1%" align="right">
                            <gw:imgbtn id="ibtnUpdate" img="update" alt="Update" text="Update" onclick="OnAddNew('update_group')" />
                        </td>
                        <td style="width: 1%" align="right">
                            <gw:imgbtn id="ibtnDelete" img="delete" alt="Delete" text="Delete" onclick="OnDelete('Group')" />
                        </td>
                        <td style="width: 1%" align="right">
                            <gw:imgbtn id="ibtnSave01" img="save" alt="Save" text="Save" onclick="OnSave('Group')" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td style="width: 5%; white-space: nowrap" align="right">
                            Parent
                        </td>
                        <td style="width: 92%; white-space: nowrap" colspan="6">
                            <gw:textbox id="txtParentPK" styles='width:100%; display:none' />
                            <gw:textbox id="txtParentNm" styles='width:100%' csstype="mandatory" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td style="width: 5%; white-space: nowrap" align="right">
                            Group
                        </td>
                        <td style="width: 92%; white-space: nowrap" colspan="6">
                            <gw:textbox id="txtGrpCD" styles='width:30%' csstype="mandatory" />
                            <gw:textbox id="txtGrpNm" styles='width:70%' csstype="mandatory" />
                        </td>
                    </tr>
                    <tr style="height: 99%">
                        <td style="width: 100%;" colspan="7">
                            <gw:tree id="oTree" style="width: 100%; height: 100%; overflow: auto;" onclicknode="OnSearch('ItemList')" />
                        </td>
                    </tr>
                </table>
            </td>
            <td style="width: 65%" id="right">
                <table style="width: 100%; height: 100%" border="0">
                    <tr style="height: 1%">
                        <td style="width: 5%" align="right">
                            Partner
                        </td>
                        <td style="width: 91%">
                            <gw:textbox id="txtItem" styles='width:100%' onenterkey="OnSearch('ItemList')" />
                        </td>
                        <td style="width: 1%" valign="bottom" align="right">
                            <gw:imgbtn id="ibtnSearch" img="search" alt="Search" text="Search" onclick="OnSearch('ItemList')" />
                        </td>
                        <td style="width: 1%" valign="bottom" align="right">
                            <gw:imgbtn id="ibtnAdd" img="new" alt="Add New Item" text="Add New Item" onclick="OnAddNew('Item')" />
                        </td>
                        <td style="width: 1%" valign="bottom" align="right">
                            <gw:imgbtn id="ibtnDel" img="delete" alt="Delete Item" text="Delete Item" onclick="OnDelete('Item')" />
                        </td>
                        <td style="width: 1%" align="right">
                            <gw:imgbtn img="excel" alt="Report" id="btnReport" onclick="OnReport()" />
                        </td>
                        <td style="width: 1%" valign="bottom" align="right">
                            <gw:imgbtn id="ibtnSave" img="save" alt="Save Item" text="Save Item" onclick="OnSave('Item')" />
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 5%" align="left">
                            <img status="expand" id="imgArrow" src="../../../system/images/button/previous.gif"
                                style="cursor: hand" onclick="OnToggle('1')" />
                        </td>
                        <td style="width: 91%" align="left">
                            <gw:label id="lbGroupName" styles="color: red">-</gw:label>
                        </td>
                        <td style="width: 4%" align="center" colspan="4">
                            <gw:label id="lblRecord" styles="color: blue"></gw:label>
                        </td>
                    </tr>
                    <tr style="height: 99%">
                        <td style="width: 100%" colspan="8">
                            <gw:grid id='grdItem' header='_PK|_TLG_DIVISION_PK|_TCO_BUSPARTNER_PK|Seq|Partner ID|Partner Name|Partner L Name|Partner F Name|Remark'
                                format='1|1|1|0|0|0|0|0|0' aligns='0|0|0|1|1|0|0|0|0' check='||||||||' editcol='0|0|0|1|0|0|0|0|1'
                                widths='0|0|0|800|2000|3000|2000|2000|1000' sorting='T' styles='width:100%; height:100%' />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <!------------------------------------------->
    <gw:textbox id="txtGroupNew_PK" styles='display:none' />
    <!------------------------------------------------------------------------------>
    <gw:textbox id="txtGroup_PK" styles='display:none' />
    <gw:textbox id="txtLeafYN" styles='display:none' />
    <!------------------------------------------------------------------------------>
</body>
</html>
