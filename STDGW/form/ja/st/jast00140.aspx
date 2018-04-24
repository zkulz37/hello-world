<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Untitled Document</title>
</head>
<%  ESysLib.SetUser("crm")%>
<script>
var    G_pk=0,
	   G_slip_no=1,
	   G_tour_date=2,
	   G_start_time=3,
	   G_num_of_guest=4, 
	   G_guest_type=5,
	   G_tour_fess=6,
	   G_free_yn=7,
	   G_group_name=8,
	   G_description=9,
	   G_marshall_pk=10, 
	   G_Marshall=11, 
	   G_receptionist_pk=12,
	   G_Reception=13,
	   G_Request_by=14;
function BodyInit()
{
    var data ="#10;Member|#20;Member Family|#30;Hotel guest|#40;Marketing Guests|#50;Company Guest|#60;Outside Guest"; 
        grdGreenFee.SetComboFormat(5,data);
		data ="data|10|Member|20|Member Family|30|Hotel guest|40|Marketing Guests|50|Company Guest|60|Outside Guest|ALL|Select All"; 
		lstGuestType.SetDataText(data);
		lstGuestType.value='ALL';
		var ctrl = grdGreenFee.GetGridControl();
		ctrl.ColEditMask(3) = "##:##";  
        OnSearch();
}
function OnAddnew()
{
    grdGreenFee.AddRow();
}
function OnSearch()
{
    dat_griddetail.Call("SELECT");
}
function OnDelete()
{
    if(confirm('Are you sure you want to delete ?'))
	{
        grdGreenFee.DeleteRow();
        dat_griddetail.Call();
    }
    else
    {
        dat_griddetail.Call("SELECT");
    }
}
function OnSave()
{
   if(CheckData())
    {
        dat_griddetail.Call();
    }
}
function CheckData()
{
    for(var i=1;i<grdGreenFee.rows;i++)
          {
            /*if(grdGreenFee.GetGridData(i,G_start_time) == "")
             {
                alert("Please input start time at row "+ i);  
                
                return false;
             }*/
             if(grdGreenFee.GetGridData(i,G_num_of_guest) == "")
             {
                alert("Please input num of guest at row "+i);
                return false;
             }
             if(grdGreenFee.GetGridData(i,G_guest_type) == "")
             {
                alert("Please input guest type at row "+i);
                return false;
             }
          }
          return true;
}

function OnPopup()
{
	if(grdGreenFee.col==G_Marshall) 
	{
		var url = '/form/sys/auth/wsyau00001_1.aspx' ;
		object = System.OpenModal( System.RootURL+ url , 700 , 500 , 'resizable:yes;status:yes') 
		if ( object != null )
		{       
			grdGreenFee.SetGridText(grdGreenFee.row,G_marshall_pk, object[0]);//
			grdGreenFee.SetGridText(grdGreenFee.row,G_Marshall, object[1]);//
		}	
	}
	if(grdGreenFee.col==G_Reception)
	{
		var url = '/form/sys/auth/wsyau00001_1.aspx' ;
		object = System.OpenModal( System.RootURL+ url , 700 , 500 , 'resizable:yes;status:yes') 
		if ( object != null )
		{       
			grdGreenFee.SetGridText(grdGreenFee.row,G_receptionist_pk, object[0]);//  
			grdGreenFee.SetGridText(grdGreenFee.row,G_Reception, object[1]);//
		}	
	}

}
function OnReport()
 {
	if(grdGreenFee.rows > 1)
	{
		if(grdGreenFee.row !=-1)
		{
			 var url = '/reports/ja/rc/rpt_jarc00110_tour_receipt.aspx?p_pk='+ grdGreenFee.GetGridData(grdGreenFee.row,G_pk);
			 System.OpenTargetPage( System.RootURL+url , "newform" );
		}
		else
		{
			alert("Please,choose one slip# to print.");
		}
	}
}

</script>
<body>
<!----------------------------------------------------------------------------------------------->
<gw:data id="dat_griddetail"  onreceive="" > 
    <xml> 
        <dso  type="grid"   parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14" function="CRM.sp_sel_jarc00110" procedure="CRM.sp_upd_jast00140"> 
            <input bind="grdGreenFee">                    
                <input bind="dtFrom" />
				<input bind="dtTo" />
				<input bind="lstGuestType" />
				<input bind="txtSlipNo" />				
            </input> 
            <output bind="grdGreenFee" />
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
													<td align="right" style="width: 5%">
														<b>Date</b>
													</td>
													<td style="width: 20%">
														<gw:datebox id="dtFrom" lang="1" styles="width:100%" onchange="OnSearch(1)" />
														~<gw:datebox id="dtTo" lang="1" styles="width:100%" onchange="OnSearch(1)" />
													</td>

                                                    <td width="9%">
                                                        Guest Type</td>
                                                    <td width="28%">
                                                        <gw:list id="lstGuestType" styles="background-color:#fffaaf" onchange="OnSearch()" />
                                                    </td>
													<td align="right" style="width: 8%; white-space: nowrap">
														Slip#
													</td>
													<td style="width: 12%;">
														<gw:textbox id="txtSlipNo" csstype="mandatory" styles="width:100%" onenterkey="OnSearch()" />
													</td>

                                                    <td width="3%"></td> 
                                                    <td width="3%">
                                                        <gw:imgbtn id="btnSearch1" img="search" width="100%" img="in" text="Process" onclick="OnSearch()" />
                                                    </td>
                                                    <td width="3%">
                                                        <gw:imgbtn id="btnSearch2" img="new" width="100%" img="in" style="display:none" text="Process" onclick="OnAddnew()" />
                                                    </td>
                                                    <td width="3%">
                                                        <gw:imgbtn id="btnSearch4" img="delete" width="100%" img="in" style="display:none" text="Process" onclick="OnDelete()" />
                                                    </td>
                                                    <td width="3%">
                                                        <gw:imgbtn id="btnSearch3" img="save" width="100%" img="in" text="Process" onclick="OnSave()" />
                                                    </td>
													<td width="3%" align="right">
                                                        <gw:imgbtn id="ibtnReport" img="printer" alt="Print" onclick="OnReport()" />
													</td>
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
                            
                            <gw:grid id="grdGreenFee" header="_pk|Slip#|Tour Date|Start Time|Num Of Guest|Guest Type|Tour Fess|Free Y/N|Group Name|Description|_marshall_pk|Marshall Name|_receptionist_pk|Receptionist Name|Request By"
                                format="0|0|4|0|-0|0|-0|3|0|0|0|0|0|0|0" aligns="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0" defaults="||||||||||||||" editcol="1|0|0|1|0|0|0|0|0|0|0|0|0|0|0"
                                widths="1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000" styles="width:100%; height:100%"
                                sorting="T"  autosize="T" oncelldblclick="OnPopup()"    />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <gw:textbox id="txt_pk"      style="display:none"/>
</body>
</html>
