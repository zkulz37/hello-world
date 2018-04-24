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
    txtHeader.text='<%=request.QueryString("p_header")%>';
    txtAnnounce_PK.text='<%=request.QueryString("p_thr_announcement_pk")%>';
    txtSearch_Key.text='<%=request.QueryString("p_search_key")%>';
    if (v_language!="ENG")
        System.Translate(document);	
     CreateGrid();
     OnBindOptions();
     datAnnounce_Data.Call("SELECT");
}
//----------------------------------

function OnDataReceive(obj)
{
         if (obj.id=="datAnnounce_Data")
       {
            lblRecord.text=grdData.rows-1 + " record(s).";
            auto_resize_column(grdData,0,grdData.cols-1,9);
            txtOptions_Tmp.GetControl().focus();
       }
       
}     
//------------------------------------------------------------------------------------
function OnSearch(iact)
{
    if (iact==1)
        datIns_Month.Call("SELECT");  
    else
    {
        datIns_Month_Sum.Call("SELECT");
    }
  
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
    var s_header;
    s_header= txtHeader.text;
    arr = s_header.split(",");
    var sHeader="_PK|CHECK"
    var sFormat="0|3"
    var sWidth="1000|1000"
    var sAlign="1|0"
   for (var i=0;i<arr.length;i++)
   {
        sHeader=sHeader + "|" + arr[i];
        sFormat=sFormat + "|0";
        sWidth=sWidth + "|1000";
        sAlign=sAlign + "|1";
   }     
   
   grdData.setHeader(sHeader);
   grdData.setFormat(sFormat);
   grdData.setWidth(sWidth);
   grdData.setAlign(sAlign);
   grdData.SetCellBold(0,1,0,grdData.cols-1,true);
   
}
//-------------------------
function OnBindOptions()
{
    var sSearch_Key;
    var sOptions;
    sSearch_Key= txtSearch_Key.text;
    var arr_key = sSearch_Key.split(",");
    for (var i=0;i<arr_key.length;i++)
   {
        var k=arr_key[i];
        sOptions=sOptions + "|" + arr_key[i] + "|" + arr[k-1];
        lstOptions.SetDataText(sOptions);
   } 
}
 //------------------------------------------
function OnSave()
{
    if (confirm("Do you want to save?"))
        datAnnounce_Data.Call();
}
//----------------------------------------------
function OnSearch()
{
    datAnnounce_Data.Call("SELECT");
}
//------------------------------------------------------------------------------------
function OnSetGrid(obj_checkbox,obj_grd,obj_col)
{	
    var tmp;
    if( obj_checkbox.GetData()=='T')
		tmp=-1;
	else
		tmp=0;
    var ctrl = obj_grd.GetGridControl();
    
    if (ctrl.SelectedRows>0)
    {
	    for ( var i =  0 ; i < ctrl.SelectedRows ; i++ )
		    {
			    var row = ctrl.SelectedRow(i);
			    if ( row > 0 )
			    {		
				    obj_grd.SetGridText(row,obj_col,tmp);
			    }
		    }
	}
	else
	{
	    for ( var i =  1 ; i < ctrl.rows ; i++ )
				    obj_grd.SetGridText(i,obj_col,tmp);
	}
}
</script>

<body>
<gw:data id="datAnnounce_Data" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid"  parameter="0,1" function="HR.sp_sel_announce_data_search " procedure="HR.sp_upd_announce_data_search " > 
                <input bind="grdData" >
                    <input bind="txtAnnounce_PK" />
                    <input bind="lstOptions" />
                    <input bind="txtOptions_Tmp" />
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
	                <td  style="border:0" align="center" width="5%"><gw:checkbox id="chkCheckReport" value="F" onclick="OnSetGrid(chkCheckReport,grdData,1)" ></gw:checkbox ></td>
	                <td  style="border:0" align="center" width="15%">Search Options</td>
	                <td  align="center"  style="border:0" width="15%"><gw:list id="lstOptions"  value="ALL" styles='width:100%'>	
							</gw:list > 	</td>
		             <td  align="center"  style="border:0" width="20%"><gw:textbox id="txtOptions_Tmp"  text="" styles='width:100%' onenterkey="OnSearch()" />	
								</td>		
			        <td id="Td3"  style="border:0" align="right" width="30%">
				        <gw:imgBtn id="ibtnSearch" alt="Search" img="search" text="" onclick="OnSearch()" />
			        </td>
			        <td id="Td4"  style="border:0" align="right" width="5%">
				        <gw:imgBtn id="ibtnSave" alt="Save" img="save" text="" onclick="OnSave()" />
			        </td>
			        <td id="Td2" style="border:0" align="right" width="10%">
				        <gw:label   id="lblRecord" text="" styles="width:100%" ></gw:label>
			        </td>
		        </tr>	
        	    <tr style="height:90%">
			        <td id="Td1" width="100%" colspan=8 >
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
<gw:textbox id="txtFlag" text="2" styles='width:100%;display:none'/>
<gw:textbox id="txtHeader" styles='width:100%;display:none' text=""/>	
<gw:textbox id="txtAnnounce_PK"  styles='width:100%;display:none' text=""/>	
<gw:textbox id="txtSearch_Key"  styles='width:100%;display:none' text=""/>
</body>
</html>

