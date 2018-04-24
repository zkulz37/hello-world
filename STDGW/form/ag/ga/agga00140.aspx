<!-- #include file="../../../system/lib/form.inc"  -->
<%  ESysLib.SetUser("ACNT")%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Material Project Plan</title>
</head>

<script>
function BodyInit()
{   
       System.Translate(document); 
}
function OnSearch()
{
   dsoMaterial.Call("SELECT");
}
function OnDelete()
{
    if(confirm('Are you sure to delete ?'))
            {
                grdMaterial.DeleteRow();
                dsoMaterial.Call();
            }
}
function OnNew()
{
    if(txtProjectPK.GetData()!= "")
    {
        var path = System.RootURL + '/form/fp/ab/fpab00070.aspx?group_type=||Y|Y|Y|Y';
                 var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
                 
                 if ( object != null )
                 {
                        var arrTemp
                        
                        for( var i=0; i < object.length; i++)	  
                        {	
                                arrTemp = object[i];
                                grdMaterial.AddRow();  
                                grdMaterial.SetGridText( grdMaterial.rows-1, 1 , txtProjectPK.text);//txtproject_pk                          
                                grdMaterial.SetGridText( grdMaterial.rows-1, 3, arrTemp[0]);//item_pk	    
                                grdMaterial.SetGridText( grdMaterial.rows-1, 4, arrTemp[1]);//item_code	    
                                grdMaterial.SetGridText( grdMaterial.rows-1, 5, arrTemp[2]);//item_name	    
                                grdMaterial.SetGridText( grdMaterial.rows-1, 6, arrTemp[5]);//item_uom
                                grdMaterial.SetGridText( grdMaterial.rows-1, 9 ,-1);//use yn
                        }		            
                 }
     } 
     else
     {
        alert("Please, choose project name.");
     }               
}
function OnSave()
{
   if(CheckSaveValid())
   {
        dsoMaterial.Call();
   }
}
function CheckSaveValid()
{
    for (var i = 1; i< grdMaterial.rows; i++)
    {
        if(grdMaterial.GetGridData(i,6) =="")
            {
                alert('Please, Input Unit.')
                 return false;
            }
        if(grdMaterial.GetGridData(i,7) =="")
            {
                alert('Please, Input Quantity.')
                 return false;
            }
    }
    return true;
}
function OnPopUp()
{
    fpath  = System.RootURL + "/form/bd/dp/bddp00012.aspx";
            oValue = System.OpenModal( fpath , 600 , 400 , 'resizable:yes;status:yes');
            
            if ( oValue != null )
            {
                txtProjectPK.text   = oValue[0]; 
                txtProjectName.text = oValue[2];
            }   
}
function OnProjectReset()
{
     txtProjectPK.text   =""; 
     txtProjectName.text ="";
}
function OnDataReceive(po_oData)
{
     switch(po_oData.id)
     {
        case "dsoMaterial":
            
        break;
     }
}
</script>

<body bgcolor='#F5F8FF'>
    <!----------------------------------------------------------------------------------------------->
    <gw:data id="dsoMaterial" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="grid"   parameter="0,1,2,3,4,5,6,7,8,9" function="acnt.sp_sel_agga00140" procedure="acnt.sp_upd_agga00140"> 
                <input bind="grdMaterial">                    
                    <input bind="txtProjectPK" /> 
                </input> 
                <output bind="grdMaterial" />
            </dso> 
        </xml> 
    </gw:data>
    <!----------------------------------------------------------------------------------------------->
    <table style="width: 100%; height: 100%">
        <tr>
            <td>
                <table style="width: 100%; height: 100%">
                    <tr style="height: 2%">
                        <td width="8%">
                            <b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp()"><b style="color: Red"></b>
                                Project</b>
                        </td>
                        <td width="32%">
                            <gw:textbox id="txtProjectName" readonly="T" />
                        </td>
                        <td width="5%">
                            <gw:imgbtn img="reset" id="idReset" alt="Reset" onclick="OnProjectReset()" />
                        </td>
                        <td width="43%">
                        </td>
                        <td style="width: 3%">
                           <gw:imgbtn id="btnSearch" img="search" onclick='OnSearch()' />
                        </td>
                        <td style="width: 3%">
                            <gw:imgbtn id="btnNew" img="new" alt="New" text="New" onclick="OnNew()" />
                        </td>
                        <td style="width: 3%">
                            <gw:imgbtn id="btnSave" img="save" alt="Save" text="Save" onclick="OnSave()" />
                        </td>
                        <td style="width: 3%">
                            <gw:imgbtn id="btnDelete" img="delete" alt="Delete" text="Delete" onclick="OnDelete()" />
                        </td>
                    </tr>
                    <tr style="height: 98%">
                        <td colspan="8">
                            <gw:grid id='grdMaterial' header='_PK|_TAC_ABPLCENTER_PK|Project|_TCO_ITEM_PK|Item Code|Item Name|Uom|Quantity|Description|Use YN'
                                format='0|0|0|0|0|0|0|0|0|3' aligns='0|0|0|0|0|0|0|0|0|0' defaults='|||||||||'
                                editcol='0|0|0|0|0|0|1|1|1|1' widths='400|1000|1200|2000|800|2000|1950|1000|1000|1000'
                                sorting='T' styles='width:100%; height:100%' autosize="T" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <gw:textbox id="txtProjectPK" style="display: none" />
</body>
