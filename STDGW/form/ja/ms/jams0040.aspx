<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Student</title>
    <%  ESysLib.SetUser("crm")%>

    <script>
var col_pk=0,
	col_Date_Use=1,
	col_tco_item_pk=2,
	col_Item_Code=3,
	col_Item_Name=4,
	col_thr_employee_pk=5,
	col_Full_Name=6,
	col_Purpose=7,
	col_From_Time=8,
	col_Time_To=9,
	col_Holes=10,
	col_Total_Time=11,
	col_Start_Status=12,
	col_Finish_Status=13,   
	col_Description=14; 
function BodyInit()
{
    var data = '';
	var ctrl = grdCartInternalUse.GetGridControl();
			 ctrl.ColEditMask(col_From_Time) = "##:##";  
			 ctrl.ColEditMask(col_Time_To) = "##:##"; 
	 grdCartInternalUse.SetComboFormat(col_Holes,'#9;9|#18;18|#27;27|#36;36');
	 OnSearch();
}
function Binding()
{
    
}
function OnSearch(){
    dso_grdCartInternalUse.Call("SELECT");
}
function OnNew()
{
     var path = System.RootURL + '/form/ja/ms/jams0040_cart_popup.aspx?group_type=Y|Y|Y|Y|Y|Y';
             var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
             
             if ( object != null )
             {
                    var arrTemp
                    for( var i=0; i < object.length; i++)	  
                    {	
                            arrTemp = object[i];
                                
                            grdCartInternalUse.AddRow();

                            grdCartInternalUse.SetGridText( grdCartInternalUse.rows-1, col_tco_item_pk, arrTemp[0]);//item_pk	    
                            grdCartInternalUse.SetGridText( grdCartInternalUse.rows-1, col_Item_Code,   arrTemp[1]);//item_code	    
                            grdCartInternalUse.SetGridText( grdCartInternalUse.rows-1, col_Item_Name,   arrTemp[2]);//item_name	 
							grdCartInternalUse.SetGridText( grdCartInternalUse.rows-1, col_Date_Use,   dtfr.value);//date sysdate	 
                    }		            
             }        
}
function OnPopupEmp(pos)
{
    switch(pos)
    {
        case 'Emp':
			if(grdCartInternalUse.col==col_Full_Name)
			{
				var path = System.RootURL + '/form/ch/ae/chae00010_search_emp.aspx';
				var obj = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');

				if ( obj != null )
				{
					grdCartInternalUse.SetGridText( grdCartInternalUse.row, col_thr_employee_pk, obj[0]);//item_pk
					grdCartInternalUse.SetGridText( grdCartInternalUse.row, col_Full_Name, obj[2]);//name
				}
			}
        break;         
    }	       
}
function OnDelete()
{  
     if(confirm("Do you want to delete this item?"))
        {
           grdCartInternalUse.DeleteRow();
		   dso_grdCartInternalUse.Call();
        }
}
function CheckDataIsValid() 
        {
          for(var i=1;i<grdCartInternalUse.rows;i++)
          {
             if(grdCartInternalUse.GetGridData(i,col_Date_Use) == "")
             {
                alert("Please input date use  at  row "+i);    
                return false;
             }
			  if(grdCartInternalUse.GetGridData(i,col_Holes) == "")
             {
                alert("Please input holes at row  "+i);    
                return false;
             }
          }
          return true;
        }
function OnSave()
{
	if(CheckDataIsValid())
	{
		dso_grdCartInternalUse.Call();
	}
}
function OnDataReceive(obj)
{
    if(obj.id == "dso_grdCartInternalUse"){
       txtCount.text=grdCartInternalUse.rows-1 + " item(s).";
    }
}
function OnPrint()
{
	var url = '/reports/ja/ms/jams0040_rpt_cart_use_internal.aspx?p_dt_frm='+ dtfr.value+'&p_dt_to='+dtTo.value+'&p_name='+txtName.text;
	     System.OpenTargetPage( System.RootURL+url , "newform" );
}
/*function CheckStartTimeLessThanEndTime(col)
{   
    var hh,mm;   
    var s =grdCartInternalUse.GetGridData(grdCartInternalUse.row,col_From_Time);  
alert(s);	
    if(s == ""){
        return;
    }
    a = s.split(":");   
    hh = Number(a[0]);  
    mm = Number(a[1]);  
    if(hh > 24){
        alert("Hour must be smaller or equal to 24.");
        return;
    }	
    if( mm > 59){
        alert("Minute must be smaller or equal to 59.");
        return;
    }      
    if(hh < 10) 
        hh="0"+hh;
    if(mm < 10) 
        mm="0"+mm;
	//alert(hh+":"+mm);
    //grdCartInternalUse.SetGridText(grdCartInternalUse.row,col_From_Time,hh+":"+mm );
	
    return true;
	
	//col_From_Time=8,
	//col_Time_To=9,
}   
function OnAfterEditTime()
{
    var ctrl = grdCartInternalUse.GetGridControl();
			 ctrl.ColEditMask(col_From_Time) = "##:##";  
			 ctrl.ColEditMask(col_Time_To) = "##:##"; 
	CheckStartTimeLessThanEndTime();
	
}*/
</script>

</head>
<body>
    <gw:data id="dso_grdCartInternalUse" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="grid" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14" function="crm.sp_sel_jams0040_use_cart" procedure="CRM.sp_upd_jams0040_use_cart" >  
                <input bind="grdCartInternalUse" >  
                    <input bind="dtfr" /> 
                    <input bind="dtTo" /> 
                    <input bind="txtName" /> 	 															
                </input> 
                <output bind="grdCartInternalUse" /> 
            </dso> 
        </xml> 
    </gw:data>
    <table width="100%" style="height: 100%">
        <tr style="height: 2%">
            <td width="6%">
                Date</td>
            <td width="8%">
                <gw:datebox id="dtfr" lang="1" onchange="OnSearch()" />
            </td>
            <td width="2%">
                ~</td>
            <td width="8%">
                <gw:datebox id="dtTo" lang="1" onchange="OnSearch()" />
            </td>
			<td align="right" style="width: 10%">
                <b>Total Record</b></td>
            <td style="width: 10%" align="center">
                <gw:label id="txtCount" />
            </td>
            <td width="10%">
                Item Name:</td>
            <td width="25%">
                <gw:textbox id="txtName" onenterkey="OnSearch()" />
            </td>
			<td width="9%"></td>
            <td with="3%">
                <gw:imgbtn id="btnSearch" img="search" alt="Search" onclick="OnSearch()" />
            </td>
			<td style="width: 3%" align="right">
                    <gw:imgbtn img="new" alt="New" id="btnAddNew" onclick="OnNew()" />
            </td>
             <td style="width: 3%" align="right">
                        <gw:imgbtn img="delete" alt="Delete" id="btnDelete" onclick="OnDelete()" />
             </td>
             <td style="width: 3%" align="right">
                    <gw:imgbtn img="save" alt="Save" id="btnSave" onclick="OnSave()" />
              </td>
			  <td style="width: 3%" align="right">
							<gw:imgbtn id="ibtnReport" img="printer" alt="Print" onclick="OnPrint()" />
              </td>
        </tr>
        <tr style="height: 98%">
            <td colspan="14">
                <gw:grid id="grdCartInternalUse" header="_pk|*Date Use|_tco_item_pk|Item Code|Item Name|_thr_employee_pk|Full Name(Operator)|Purpose|From Time|Time To|*Holes|Total Time|Start Status|Finish Status|Description" 
					format="0|4|0|0|0|0|0|0|0|0|0|0|0|0|0"
                    aligns="0|0|0|0|0|0|0|0|1|1|0|0|0|0|0" editcol="1|1|1|0|0|1|0|1|1|1|1|0|1|1|1"
                    sorting='T' autosize='T' oncelldblclick="OnPopupEmp('Emp')" styles="width:100%; height:100%" onafteredit="OnAfterEditTime()" />
            </td>
        </tr>
        <tr>
        <td colspan="7"></td>
        </tr>
    </table>
    <gw:textbox id="txtMasterPK" style="display: none" />
</body>
</html>
