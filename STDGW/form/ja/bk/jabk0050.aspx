<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Untitled Document</title>
</head>
<%  ESysLib.SetUser("crm")%>

<script>
function BodyInit()
{	var data ;
  data = "data |10|HANDICAP DIVISION|20|CALLAWAY DIVISION|30|BEST GROSS|40|NEAREST PIN|50|LONGEST DRIVE|60|Select All"; 
	lstRankType.SetDataText(data);
	grdTeeTimeSheet.SetComboFormat(4,'|#10;HANDICAP DIVISION|#20;CALLAWAY DIVISION|#30;BEST GROSS|#40;NEAREST PIN|#50;LONGEST DRIVE'); 
	dsoTournamentList.Call("SELECT");
	
}
function OnAddnew()
{
   if(lstRankType.value == 'ALL' || lstTourNament.value == 'ALL')
   {
        alert("Please, choose Rank type and TourNament.");
        return;
   }
   grdTeeTimeSheet.AddRow();
    for( i=1;i<grdTeeTimeSheet.rows;i++)
      {
           if(grdTeeTimeSheet.GetGridData(i,0)=="")
           {
                grdTeeTimeSheet.SetGridText(grdTeeTimeSheet.rows-1,1,grdTeeTimeSheet.rows-1);
                grdTeeTimeSheet.SetGridText(i,4,lstRankType.value);//4 is  lstRankType
                grdTeeTimeSheet.SetGridText(i,1,lstTourNament.value);//1 is  lstTourNament
            }
       }
}
function OnSearch()
{
    dat_TeeTimeSheet.Call("SELECT");
}
function OnDelete()
{
    if(confirm('Are you sure you want to delete ?'))
	{
        grdTeeTimeSheet.DeleteRow();
        dat_TeeTimeSheet.Call();
    }
}
function OnSave()
{
    if(CheckData())
    {
        dat_TeeTimeSheet.Call();
     }
}
function CheckData()
{
    for(var i=1;i<grdTeeTimeSheet.rows;i++)
          {
            if(grdTeeTimeSheet.GetGridData(i,2) == "")
             {
                alert("Please input rank id at row" +i);
                
                return false;
             }
             if(grdTeeTimeSheet.GetGridData(i,3) == "")
             {
                alert("Please input ramk name at row "+i);
                return false;
             }
             if(grdTeeTimeSheet.GetGridData(i,5) == "")
             {
                alert("Please input prizes at row "+i);
                return false;
             }
          }
          return true;
}
function OnReport()
 {
    var url = System.RootURL + "/system/ReportEngine.aspx?export_pdf=Y&file=ja/bk/jabk0050.rpt&procedure=crm.sp_sel_jabk00050&parameter="+lstRankType.value+","+lstTourNament.value;              
        System.OpenTargetPage(url); 
 }
 function OnDataReceive(obj)
 {
	if(obj.id=='dsoTournamentList')
	{
		dat_TeeTimeSheet.Call("SELECT");
	}
 }
</script>

<body>
	<gw:data id="dsoTournamentList" onreceive="OnDataReceive(this)"> 
		<xml> 
			<dso type="list" procedure="crm.sp_sel_jabk00060_list" > 
				<input>
					 <input bind="dtDate" /> 
				</input> 
				<output> 
					<output bind="lstTourNament"/>
				</output>
			</dso> 
		</xml> 
	</gw:data>
    <!----------------------------------------------------------------------------------------------->
    <gw:data id="dat_TeeTimeSheet" onreceive="OnDataReceive(this)"> 
    <xml> 
        <dso  type="grid"   parameter="0,1,2,3,4,5,6,7,8" function="crm.sp_sel_jabk00050" procedure="crm.sp_upd_jabk00050"> 
            <input bind="grdTeeTimeSheet">                    
                <input bind="lstRankType" /> 
                <input bind="lstTourNament" /> 
            </input> 
            <output bind="grdTeeTimeSheet" />
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
                                                    <td width="10%">
                                                        Rank Type</td>
                                                    <td width="25%">
                                                        <gw:list id="lstRankType" styles="background-color:#fffaaf" onchange="OnSearch()" />
                                                    </td>
                                                    <td width="10%">
                                                        TourNament</td>
                                                    <td width="25%">
                                                        <gw:list id="lstTourNament" styles="background-color:#fffaaf" onchange="OnSearch()" />
                                                    </td>
                                                    <td width="1%">
                                                    </td>
                                                    <td width="3%">
                                                        <gw:imgbtn id="btnSearch1" img="search" width="100%" img="in" text="Process" onclick="OnSearch()" />
                                                    </td>
                                                    <td width="3%">
                                                        <gw:imgbtn id="btnSearch2" img="new" width="100%" img="in" text="Process" onclick="OnAddnew()" />
                                                    </td>
                                                    <td width="3%">
                                                        <gw:imgbtn id="btnSearch4" img="delete" width="100%" img="in" text="Process" onclick="OnDelete()" />
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
                            <gw:grid id="grdTeeTimeSheet" header="_PK|_Tournament|Rank|Rank Name|_Rank Type|Prizes|Prizes LC|Prizes FR|_Name"
                                format="0|0|0|0|0|0|0|0|0" aligns="0|0|3|0|0|0|0|0|0" defaults="||||||||" editcol="1|1|1|1|1|1|1|1|1"
                                widths="1000|1000|1000|1000|1000|1000|1000|1000|1000" styles="width:100%; height:100%"
                                sorting="T" autosize="T" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <gw:textbox id="txt_pk" style="display: none" />
	<gw:datebox id="dtDate" type="date" lang="1" style="display: none" />
</body>
</html>
