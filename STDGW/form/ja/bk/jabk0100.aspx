<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Untitled Document</title>
</head>
<%  ESysLib.SetUser("crm")%>

<script>
function BodyInit()
{
   var data = ""; 
	
	data = "<%=ESysLib.SetGridColumnDataSQL("SELECT A.PK,pk FROM CRM.TGM_TOURNAMENT A WHERE A.DEL_IF =0" )%>"; 
	grdTournamentSetup.SetComboFormat(1,data);
	
}
function OnAddnew()
{
    if ( txtTourPK.text == "" )
	{
		alert("Please,input tour name to add new. ");
		return;
	}  
	var path = System.RootURL + '/form/ja/bk/jabk0100_popup_checkin.aspx?p_tournament='+txtTourPK.text;
    var object = System.OpenModal( path ,600 , 600 ,  'resizable:yes;status:yes');
     if ( object != null )
     {
            for( var i=0; i < object.length; i++)	   
            {	
                var arrTemp = object[i];
                if(OnValid(arrTemp[0])){
                    grdTournamentSetup.AddRow();
                    //grdTournamentSetup.SetGridText(grdTournamentSetup.rows -1,1,lstTourNament.value);
					grdTournamentSetup.SetGridText(grdTournamentSetup.rows -1,1,txtTourPK.text);
                    grdTournamentSetup.SetGridText(grdTournamentSetup.rows -1,2,arrTemp[0]);
                    grdTournamentSetup.SetGridText(grdTournamentSetup.rows -1,3,arrTemp[3]);
                    grdTournamentSetup.SetGridText(grdTournamentSetup.rows -1,4,arrTemp[2]);
                }else alert("Golfer name : "+arrTemp[3]+" already exist!");
           }		            
     }
}

function OnSearch()
{
    if ( txtTourPK.text == "" )
	{
		alert("Please,input tour name to search. ");
		return;
	}  
	if(document.getElementById("tabSetup").style.display == "none")
        dat_TournamentReport.Call('SELECT');
    else 
	dat_TournamentSetup.Call('SELECT');
}
function OnDelete()
{
    if(confirm('Are you sure you want to delete ?'))
	{
        grdTournamentSetup.DeleteRow();
        dat_TournamentSetup.Call();
    }
}

function OnSave()
{
    dat_TournamentSetup.Call();
}

function OnReport()
{
    var url = System.RootURL + "/system/ReportEngine.aspx?export_pdf=Y&file=ja/bk/jabk0100.rpt&procedure=CRM.sp_sel_jabk0100_rpt&parameter=" + txtTourPK.text;
      System.OpenTargetPage(url);
}
function OnGroup(obj)
{
    document.getElementById("tabSetup").style.display     = (obj.value == 1) ? "block":"none";
    document.getElementById("tabReport").style.display    = (obj.value == 2) ? "block":"none";
    if(obj.value == 2)
        dat_TournamentReport.Call('SELECT');
}
function OnValid(pk){
    var result = true;
    if(grdTournamentSetup.rows > 1){
        for(var i=1;i<grdTournamentSetup.rows;i++)
            if(grdTournamentSetup.GetGridData(i,2) == pk){result = false; break;}
    }
    return result;
}

function OnDataReceive(obj)
{
    if(obj.id == 'dat_TournamentSetup')
    {
	   txtCount.text = grdTournamentSetup.rows-1 + " item(s).";
    }
	else if(obj.id == 'dat_TournamentReport'){
        grdTournamentReport.Subtotal( 1, 2, -1, '5!6!7!8!9');
    }
	else if(obj.id == 'dsoTournamentList'){
        OnSearch();
    }
}
function Popup()
{
	var path = System.RootURL + "/form/ja/bk/jabk0100_popup_tour.aspx?";
			var object = System.OpenModal( path ,800 , 500 ,  'resizable:yes;status:yes');
			if ( object != null )
			{
				txtTourPK.text   = object[0];
				txtTourName.text = object[2];
				dtFrom.value=object[1];
				OnSearch();
			}

}
</script>

<body>
    <!----------------------------------------------------------------------------------------------->
    <gw:data id="dat_TournamentSetup" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="grid"   parameter="0,1,2,5,6,7,8" function="crm.sp_sel_jabk0100" procedure="crm.sp_upd_jabk0100"> 
                <input bind="grdTournamentSetup">                    
                    <input bind="txtTourPK" /> 
                </input> 
                <output bind="grdTournamentSetup" />
            </dso> 
        </xml> 
    </gw:data>
    <!----------------------------------------------------------------------------------------------->
    <gw:data id="dat_TournamentReport" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="grid"   parameter="" function="crm.sp_sel_jabk0100_rpt" procedure=""> 
                <input bind="grdTournamentReport">                    
                    <input bind="txtTourPK" /> 
                </input> 
                <output bind="grdTournamentReport" />
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
                                                    <td width="24%">
                                                       <input type="radio" name="TournamentType" value="1" checked="checked" onclick="OnGroup(this);" /> Payment setup
                                                       <input type="radio" name="TournamentType" value="2" onclick="OnGroup(this);"/> Sumary payment
                                                    </td>
                                                    <td width="9%">
                                                        <b style="color: #1b2ff2; cursor: hand" onclick="Popup()"><b style="color: Red">
														</b>Tour name</b></td>
														 <td style="width: 6%">
															<gw:datebox id="dtFrom" lang="1" onchange="" />
														 </td>
                                                    <td width="23%">
														<gw:textbox id="txtTourName" styles="width:100%" readonly="T" />  
                                                        
                                                    </td>
													<td style="width: 2%"><gw:imgbtn id="btnReset" img="reset" alt="Reset" onclick="txtTourName.text='';txtTourPK.text='';grdTournamentSetup.ClearData();" /></td>

                                                    <td align="center" style="width: 5%"><b>Total :</b></td>
                                                    <td align="left" style="width: 8%"><gw:label id="txtCount" /></td>
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
                                                    <td width="5%" align="right">
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
                <table id="tabSetup"  cellspacing="0" cellpadding="0" border="0" style="width: 100%;height: 100%;">
                    <tr>
                        <td width="100%" valign="top">
                            <gw:grid id ="grdTournamentSetup" 
                                header  ="_PK|_Tournament|_Golfer_pk|Golfer Name|Locker#|Green Fee|Caddie Fee|Cart Fee|F&B Fee"
                                format  ="0|0|0|0|0|3|3|3|3" 
                                aligns  ="0|0|0|0|1|1|1|1|1"
                                defaults="||||||||"
                                editcol ="0|0|0|0|0|0|0|0|0"
                                widths  ="1000|1000|1000|1000|1000|1000|1000|1000|1000"
                                styles  ="width:100%; height:100%" 
                                sorting ="T" 
                                autosize="T" 
                                />
                        </td>
                    </tr>
                </table>
                <table id="tabReport"  cellspacing="0" cellpadding="0" border="0" style="width: 100%;height: 100%;display:none">
                    <tr>
                        <td width="100%" valign="top">
                            <gw:grid id ="grdTournamentReport" 
                                header  ="_PK|_Tournament|_Golfer_pk|Golfer Name|Locker#|Green Fee|Caddie Fee|Cart Fee|F&B Fee|Total"
                                format  ="0|0|0|0|0|-2|-2|-2|-2|-2" 
                                aligns  ="0|0|0|0|1|0|0|0|0|0"
                                defaults="|||||||||"
                                editcol ="0|0|0|0|0|0|0|0|0|0"
                                widths  ="1000|1000|1000|1000|1000|1000|1000|1000|1000|1000"
                                styles  ="width:100%; height:100%" 
                                sorting ="T" 
                                autosize="T" 
                                />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <gw:textbox id="txt_pk" style="display: none" />
	<gw:datebox id="dtDate" style="display: none" />
	<gw:textbox id="txtTourPK" style="display: none" />
</body>
</html>
