<!-- #include file="../../../system/lib/form.inc"  -->
 <%ESysLib.SetUser(Session("APP_DBUSER"))%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Untitled Page</title>
</head>
<script>
var arr;

var v_language = "<%=Session("SESSION_LANG")%>";
function BodyInit()
{
    if (v_language!="ENG")
        System.Translate(document);	
    CreateGrid();
    grdData.GetGridControl().FrozenCols =6;
    grdData.GetGridControl().ScrollTrack=true;
}
//----------------------------------

function OnDataReceive(obj)
{
         if (obj.id=="datUpload_Data")
       {
            lblRecord.text=grdData.rows-1 + " record(s).";
            if (grdData.rows >1)
                 grdData.SetCellBgColor(1,1,grdData.rows-1,1,0x99FF99);
            auto_resize_column(grdData,0,grdData.cols-1,9);
       }
       
}     
//------------------------------------------------------------------------------------
function OnSearch()
{
    datUpload_Data.Call("SELECT");  
  
}
//-----------------------------------------------
function auto_resize_column(obj,col1,col2,font_size)
{
  if(font_size!=0)
        obj.GetGridControl().FontSize =font_size;   
  obj.GetGridControl().AutoSize(col1,col2,false,0);  
}
//----------------------------------------
function CreateGrid()
{
    var sHeader="_PK|UPLOAD TYPE"
    var sFormat="0|0"
    var sWidth="1000|1000"
    var sAlign="1|0"
    var cobj=lstHeader.GetControl();
    
   for (var i=0;i<cobj.length;i++)
   {
        sHeader=sHeader + "|" + cobj.options.item(i).text;
        sFormat=sFormat + "|0";
        sWidth=sWidth + "|1000";
        sAlign=sAlign + "|2";
   }     
   grdData.setHeader(sHeader);
   grdData.setFormat(sFormat);
   grdData.setWidth(sWidth);
   grdData.setAlign(sAlign);
   grdData.SetCellBold(0,1,0,grdData.cols-1,true);
   
}
 //------------------------------------------
function OnSave()
{
    if (confirm("Do you want to save?"))
        datUpload_Data.Call();
}
//----------------------------------------------
function OnSearch()
{
    datUpload_Data.Call("SELECT");
}
//-------------------------------------------------
function OnSetGrid(obj_grd,obj_col,obj_value)
{
    var ctrl = obj_grd.GetGridControl();
	for ( var i =  0 ; i < ctrl.SelectedRows ; i++ )
		{
			var row = ctrl.SelectedRow(i);
			if ( row > 0 )
			{		
				obj_grd.SetGridText(row,obj_col,obj_value);
			}	
		}
}
</script>

<body>
<gw:data id="datUpload_Data" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid"  parameter="0,1,3,30" function="HR_SEL_80020017 " procedure="HR_UPD_80020017 " > 
                <input bind="grdData" >
                    <input bind="dtFrom_Dt" />
                    <input bind="dtTo_Dt" />
                    <input bind="txtEmp_ID" />
                    <input bind="lstUpload_S" />
                </input>
                <output  bind="grdData" />
            </dso> 
        </xml> 
</gw:data>
<table name="Summary" style="width:100%;height:100%" cellpadding="0" cellspacing="0" align="top" border="1" >
    <tr  style="width:100%;height:100%" cellpadding="0" cellspacing="0" align="top" border="1">
        <td>
	        <table id="Table1" style="width:100%;height:100%" cellpadding="0" cellspacing="0" valign="top" border="1" >	
	            <tr style="height:10%">
	                <td  style="border:0" align="left" width="10%"><gw:list  id="lstUpload" value="UPLOADING" styles='width:80%;color:green'><data>|UPLOADED|UPLOADED|UPLOADING|UPLOADING </data></gw:list></td>
	                <td id="Td5"  style="border:0" align="left" width="5%">
				        <gw:imgBtn img="set" id="ibtnSet"   alt="Set Grid"  onclick="OnSetGrid(grdData,1,lstUpload.value)"/>
			        </td>
			        <td  style="border:0" align="right" width="10%">Upload Date</td>
	                <td  style="border:0" align="left" width="10%"><gw:datebox id="dtFrom_Dt"  maxlen = "10" text="" styles='width:100%'lang="<%=Session("Lang")%>" /></td>
	                <td  align="left"  style="border:0" width="3%">~</td>
		            <td  align="left"  style="border:0" width="10%"><gw:datebox id="dtTo_Dt"  maxlen = "10" text="" styles='width:100%'lang="<%=Session("Lang")%>" /></td>		
			        <td  align="right"  style="border:0" width="9%">Upload Type</td>
			        <td  align="left"  style="border:0" width="10%"><gw:list  id="lstUpload_S" value="UPLOADED" styles='width:80%; :red'><data>|UPLOADED|UPLOADED|UPLOADING|UPLOADING|ALL|Select All </data></gw:list></td>
			        
			        <td  align="right"  style="border:0" width="5%">Emp ID</td>
			        <td  align="left"  style="border:0" width="10%"><gw:textbox id="txtEmp_ID"  maxlen = "60" text="" styles='width:100%;' csstype="mandatory" onkeypress="OnSearch()" /></td>
			        <td id="Td2" style="border:0" align="right" width="10%">
				        <gw:label   id="lblRecord" text="" styles="width:100%" ></gw:label>
			        </td>
			        <td id="Td3"  style="border:0" align="right" width="5%">
				        <gw:imgBtn id="ibtnSearch" alt="Search" img="search" text="" onclick="OnSearch()" />
			        </td>
			        <td id="Td4"  style="border:0" align="right" width="3%">
				        <gw:imgBtn id="ibtnSave" alt="Save" img="save" text="" onclick="OnSave()" />
			        </td>
			    </tr>	
        	    <tr style="height:90%">
			        <td id="Td1" width="100%" colspan=13 >
				        <gw:grid id='grdData'
                            sorting='T'
                            resize='T'
                            styles='width:100%; height:100%'
                            />
			        </td>
		        </tr>	
        		
	        </table>
	    </td>
	</tr>
</table>
<gw:list  id="lstHeader" value=" " styles='width:100%;display:none'>
<data>
    <%=ESysLib.SetListDataSQL("SELECT rownum,nvl(b.comments,a.column_name) as col_name FROM all_TAB_COLUMNS a,all_col_comments b WHERE a.table_name ='TB_S00_EMPL0001' and b.table_name(+)='TB_S00_EMPL0001' and a.owner='PEAI' and  b.owner(+)='PEAI' and a.column_name=b.column_name(+) AND A.column_name not in('UPLOADDATA_TYPE','PK') order by a.column_id")%>
</data>
</gw:list>
</body>
</html>

