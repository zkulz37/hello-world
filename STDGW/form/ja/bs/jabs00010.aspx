<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Untitled Document</title>
</head>
<%  ESysLib.SetUser("crm")%>
<script>
function BodyInit()
{
    var data ="#9;9|#18;18|#27;27|#36;36"; 
        idgrid.SetComboFormat(6,data);
    dat_griddetail.Call("SELECT");
}
function OnAddnew()
{
    idgrid.AddRow();
    for(var i=1;i<idgrid.rows;i++)
          {
            if(idgrid.GetGridData(i,1) == "")
             {
                idgrid.SetGridText(i,1,idgrid.rows - 1);
                idgrid.SetGridText(i,7,'-1');
             }
          }
}
function OnSearch()
{
    dat_griddetail.Call("SELECT");
}
function OnDelete()
{
     if ( confirm( "Do you want item this row to delete?" ) ) 
			{
				idgrid.DeleteRow();
				dat_griddetail.Call();
			}
}
function OnSave()
{
    if(CheckData() && CheckDuplicate() == true)
    {
        dat_griddetail.Call();
     }
}
function CheckData()
{
    for(var i=1;i<idgrid.rows;i++)
          {
            if(idgrid.GetGridData(i,2) == "")
             {
                alert("Please input ID at row "+ i);
                
                return false;
             }
             if(idgrid.GetGridData(i,3) == "")
             {
                alert("Please input Name at row "+i);
                return false;
             }
             
          }
          return true;
}
function CheckDuplicate()
{  
    var gr ;
    if(idgrid.rows > 2)
    {  
        gr = idgrid.GetGridData(idgrid.rows -1, 2);    
       for(var i = 1; i < idgrid.rows - 1; i++)
        {
            if(idgrid.GetGridData(i, 2) == gr)
            {
                alert('ID is already. Please check again!!!'+ '\n' +'    ID này đã tồn tại. Yêu cầu kiểm tra lại!!!');             
                return false ;
            }
        }
    }    
    return true;   
}
</script>
<body>
<gw:data id="dat_griddetail"  onreceive="" > 
    <xml> 
        <dso  type="grid"   parameter="0,1,2,3,4,5,6,7,8" function="crm.sp_sel_bsab00010" procedure="CRM.sp_upd_bsab00010"   > 
            <input bind="idgrid">                    
                <input bind="txtCourse" /> 
            </input> 
            <output bind="idgrid"></output>
        </dso> 
    </xml> 
</gw:data>
<!----------------------------------------------------------------------------------------------->
    <table style="width: 100%; height: 100%" cellpadding="0" cellspacing="0" border="0">
        <tr style="width: 100%; height: 5%">
            <td width="100%">
                <table width="100%" cellpadding="0" cellspacing="0" border="0">
                    <tr>
                        <td>
                            <table border="0" width="100%" id="table1">
                                <tr>
                                    <td>
                                        <fieldset style="padding: 2; width: 100%; height: 100%">
                                            <table border="0" width="100%" id="table2">
                                                <tr>
                                                <td width="25%"></td>
                                                    <td align="right" width="10%">
                                                        Course</td>
                                                    <td width="40%">
                                                        <gw:textbox id="txtCourse" styles='width:100%' onenterkey="OnSearch()" />
                                                    </td>
                                                    <td>
                                                        <gw:imgbtn id="btnSearch1" img="search" width="100%" img="in" text="Process" onclick="OnSearch()" />
                                                    </td>
                                                    <td>
                                                        <gw:imgbtn id="btnSearch2" img="new" width="100%" img="in" text="Process" onclick="OnAddnew()" />
                                                    </td>
                                                    <td>
                                                        <gw:imgbtn id="btnSearch3" img="save" width="100%" img="in" text="Process" onclick="OnSave()" />
                                                    </td>
                                                    <td>
                                                        <gw:imgbtn id="btnSearch4" img="delete" width="100%" img="in" text="Process" onclick="OnDelete()" />
                                                    </td>
                                                    <td width="25%"></td>
                                                </tr>
                                            </table>
                                        </fieldset>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr style="width: 100%; height: 95%">
            <td width="100%">
                <table align="top" cellspacing="0" cellpadding="0" border="0" style="width: 100%;
                    height: 100%;">
                    <tr valign="top">
                        <td width="100%">
                            
                            <gw:grid id="idgrid" header="_pk|No|ID|Name|LName|FName|Hole|Active_YN|Description"
                                format="0|0|0|0|0|0|0|3|0" aligns="0|1|0|0|0|0|1|0|0" defaults="||||||||" editcol="1|0|1|1|1|1|1|1|1"
                                widths="0|600|1500|2000|2000|2000|1000|1000|3000" styles="width:100%; height:100%"
                                sorting="F"  onafteredit="CheckDuplicate()" autosize="T"/>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <gw:textbox id="txt_pk"      style="display:none"/>
</body>
</html>
