<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Tournament Result</title>
</head>
<%  ESysLib.SetUser("crm")%>

<script>
function BodyInit()
{
   var data = "<%=ESysLib.SetListDataSQL("SELECT CODE, NAME FROM COMM.TCO_COMMCODE WHERE DEL_IF = 0 AND PARENT_CODE = 'TNMFMT' order by ord " ) %>";	
	lstRankType.SetDataText(data);
	grdTournamentResult.SetComboFormat(7,"SELECT CODE, NAME FROM COMM.TCO_COMMCODE WHERE DEL_IF = 0 AND PARENT_CODE = 'TNMFMT'"); //ranktype
	
	data = "data |1|HDCP - A|2|HDCP -B|3|HDCP -C|4|Final Result|5|Novelty|6|HDCP - Lady|7|Peoria Detail"; 
	lstReportType.SetDataText(data);
	lstReportType.value=4;
	dsoTournamentList.Call("SELECT");
}
function OnSearch()
{
    if(lastMove == "SCORE"){
        txtScore.GetControl().focus();
    }
    else{
        txtHandicap.GetControl().focus();
    }
	dat_TeeTimeSheet.Call("SELECT");
}
var lastMove="SCORE";
function OnEnterKeyScore(obj){
    if(obj.text.length == 0){
        txtLocker.text = "";
        lastMove="SCORE";
        txtLocker.GetControl().focus();
        return;
    }

    if(obj.text.length != 3 && obj.text.length != 6){
        alert("You must input 3 digits or 6 digits in score field.");
        obj.text="";
        obj.GetControl().focus();
    }
    else{
        if(grdTournamentResult.row < 1){
            alert("Please select row in the grid to input score.");
            return;
        }
        var row = grdTournamentResult.row;
        var score = obj.text;
        obj.text="";
        if(isNaN(score)){
            alert("Score must be a number.");
            return;
        }
        var x=0;
		if(score.length == 3)
		{
			for(var i=11;i<=29;i++){
					if(grdTournamentResult.GetGridData(row,i) == "" && x<3 && i!=20){
					   grdTournamentResult.SetGridText(row,i,score.substr(x,1)); 
					   x++;
					}
			}
		}
		else{
			for(var i=11;i<=29;i++){
					if(grdTournamentResult.GetGridData(row,i) == "" && x<6 && i!=20){
					   grdTournamentResult.SetGridText(row,i,score.substr(x,2)); 
					   x+=2;
					}
			}
		}
        //sum total out
        var total_out=0;
        for(var j=11;j<20;j++){
            if(grdTournamentResult.GetGridData(row,j) > 0){
                total_out += Number(grdTournamentResult.GetGridData(row,j));
            }
        }
        grdTournamentResult.SetGridText(row,20,total_out);
        //sum total in
        var total_in=0;
        for(j=21;j<=29;j++){
            if(grdTournamentResult.GetGridData(row,j) > 0){
                total_in += Number(grdTournamentResult.GetGridData(row,j));
            }
        }
        grdTournamentResult.SetGridText(row,30,total_in);
        var total_gross=0;
        total_gross = total_out + total_in;
        grdTournamentResult.SetGridText(row,8,total_gross);
        var net=0;
        if(grdTournamentResult.GetGridData(grdTournamentResult.row,9) != "")//hdcp not null
        {
            net= total_gross - Number(grdTournamentResult.GetGridData(grdTournamentResult.row,9));
            grdTournamentResult.SetGridText(grdTournamentResult.row,10,net);
        }
        if(grdTournamentResult.GetGridData(row,29) !="" && (row < grdTournamentResult.rows-1)){
            grdTournamentResult.GetGridControl().row = row+1;
        }
        
    }
}
function OnEnterKeyHandicap(obj)
{
    if(obj.text.length == 0){
        txtLocker.text = "";
        lastMove="HDC";
        txtLocker.GetControl().focus();
        return;
    }
    var handicap = obj.text;
    if(isNaN(handicap) || handicap == ""){
        alert("Score must be a number.");
        return;
    }
    obj.text="";
    
    if(grdTournamentResult.GetGridData(grdTournamentResult.row,9) == "" || grdTournamentResult.GetGridData(grdTournamentResult.row,9) == 0){
       grdTournamentResult.SetGridText(grdTournamentResult.row,9,handicap); 
       
    }
    if(grdTournamentResult.row == (grdTournamentResult.rows-1))
    {
        return;
    }
    if(grdTournamentResult.GetGridData(grdTournamentResult.row,9) !="" && (grdTournamentResult.row < grdTournamentResult.rows-1)){
        grdTournamentResult.GetGridControl().row = grdTournamentResult.row+1;
    }
    
}
function OnReport()
 {
	if(lstReportType.value==4 && lstRankType.value==20)//callaway
	{
	     var url = '/reports/ja/bk/jabk0060_Callaway.aspx?p_rank_type='+ lstRankType.value + '&p_tournament=' + lstTourNament.value + '&p_locker_name=' + txtLocker.text;
	     System.OpenTargetPage( System.RootURL+url , "newform" );
	}
	if(lstReportType.value==4 && lstRankType.value==30)//peoria
	{
	     var url = '/reports/ja/bk/jabk0060_Peoria.aspx?p_rank_type='+ lstRankType.value + '&p_tournament=' + lstTourNament.value + '&p_locker_name=' + txtLocker.text;
	     System.OpenTargetPage( System.RootURL+url , "newform" );
	}
	if(lstReportType.value==4 && lstRankType.value==70)//double peoria
	{
	     var url = '/reports/ja/bk/jabk0060_Double_Peoria.aspx?p_rank_type='+ lstRankType.value + '&p_tournament=' + lstTourNament.value + '&p_locker_name=' + txtLocker.text;
	     System.OpenTargetPage( System.RootURL+url , "newform" );
	}
    if(lstReportType.value==1)//hcdp type A
	{
	     var url = '/reports/ja/bk/jabk0060_HCDP_A.aspx?p_rank_type='+ lstRankType.value + '&p_tournament=' + lstTourNament.value + '&p_locker_name=' + txtLocker.text;
	     System.OpenTargetPage( System.RootURL+url , "newform" );
	}
	if(lstReportType.value==2)//hcdp type B
	{
	     var url = '/reports/ja/bk/jabk0060_HCDP_B.aspx?p_rank_type='+ lstRankType.value + '&p_tournament=' + lstTourNament.value + '&p_locker_name=' + txtLocker.text;
	    System.OpenTargetPage( System.RootURL+url , "newform" );
	}
	if(lstReportType.value==3)//hcdp type C
	{
	     var url = '/reports/ja/bk/jabk0060_HCDP_C.aspx?p_rank_type='+ lstRankType.value + '&p_tournament=' + lstTourNament.value + '&p_locker_name=' + txtLocker.text;
	    System.OpenTargetPage( System.RootURL+url , "newform" );
	}
	if((lstReportType.value==4 && lstRankType.value==10)||(lstReportType.value==4 && lstRankType.value==40)||(lstReportType.value==4 && lstRankType.value==50)||(lstReportType.value==4 && lstRankType.value==60))//final sheet
	{
	     var url = '/reports/ja/bk/jabk0060_HCDP_Result.aspx?p_rank_type='+ lstRankType.value + '&p_tournament=' + lstTourNament.value + '&p_locker_name=' + txtLocker.text;
	    System.OpenTargetPage( System.RootURL+url , "newform" );//final result
	}
	if(lstReportType.value==5)//Novelty
	{
	     var url = '/reports/ja/bk/jabk0060_HCDP_Novelty.aspx?p_rank_type='+ lstRankType.value + '&p_tournament=' + lstTourNament.value + '&p_locker_name=' + txtLocker.text;
	    System.OpenTargetPage( System.RootURL+url , "newform" );
	}
	if(lstReportType.value==6)//Lady(woman)
	{
	     var url = '/reports/ja/bk/jabk0060_HDCP_Lady.aspx?p_rank_type='+ lstRankType.value + '&p_tournament=' + lstTourNament.value + '&p_locker_name=' + txtLocker.text;
	    System.OpenTargetPage( System.RootURL+url , "newform" );
	}
	if(lstReportType.value==7&& lstRankType.value==70)//Peoria detail(double)
	{
	     var url = '/reports/ja/bk/jabk0060_HCDP_Peoria_Detail.aspx?p_rank_type='+ lstRankType.value + '&p_tournament=' + lstTourNament.value + '&p_locker_name=' + txtLocker.text;
	    System.OpenTargetPage( System.RootURL+url , "newform" );
	}
	if(lstReportType.value==7&& lstRankType.value==30)//Peoria detail(Single)
	{
	     var url = '/reports/ja/bk/jabk0060_HCDP_Peoria_Detail_Single.aspx?p_rank_type='+ lstRankType.value + '&p_tournament=' + lstTourNament.value + '&p_locker_name=' + txtLocker.text;
	    System.OpenTargetPage( System.RootURL+url , "newform" );
	}
 }
 function Setcolor()
 {
	for(var i=2;i<=grdTournamentResult.rows-1;i++){
		if(grdTournamentResult.GetGridData(i,10) == grdTournamentResult.GetGridData(i-1,10)) //Net
		{
			if(grdTournamentResult.GetGridData(i,10) !="")
			{
			    grdTournamentResult.SetCellBgColor(i-1, 0, i-1, 30,0xA9EBD7); //0xB3B3D7
			    grdTournamentResult.SetCellBgColor(i, 0, i, 30, 0xA9EBD7);
			}
		}
		//not input all 18 hole
		if(grdTournamentResult.GetGridData(i,8) > 0) //Gross
		{
			if(grdTournamentResult.GetGridData(i,11) == "" || grdTournamentResult.GetGridData(i,12) == "" || grdTournamentResult.GetGridData(i,13) == ""
			|| grdTournamentResult.GetGridData(i,14) == "" || grdTournamentResult.GetGridData(i,15) == "" || grdTournamentResult.GetGridData(i,16) == ""
			|| grdTournamentResult.GetGridData(i,17) == "" || grdTournamentResult.GetGridData(i,18) == "" || grdTournamentResult.GetGridData(i,19) == ""
			|| grdTournamentResult.GetGridData(i,21) == "" || grdTournamentResult.GetGridData(i,22) == "" || grdTournamentResult.GetGridData(i,23) == ""
			|| grdTournamentResult.GetGridData(i,24) == "" || grdTournamentResult.GetGridData(i,25) == "" || grdTournamentResult.GetGridData(i,26) == ""
			|| grdTournamentResult.GetGridData(i,27) == "" || grdTournamentResult.GetGridData(i,28) == "" || grdTournamentResult.GetGridData(i,29) == "")
			{
			     grdTournamentResult.SetCellBgColor(i, 0, i, 30, 0xabcdef);
			}
		}
	}	
 }
 function OnDataReceive(obj)
 {
 var register=0,unregister=0;
    if(obj.id == 'dat_TeeTimeSheet')
    {
       for(var i=1;i<grdTournamentResult.rows;i++)
       {
           if(grdTournamentResult.GetGridData(i,8) > 0)
            {
              register++;
            } 
            else{
                unregister++;
            }
        }
        
        txtRegister.text = register;
        txtUnregister.text = unregister;
        
        if(grdTournamentResult.rows > 1){
            grdTournamentResult.GetGridControl().row = 1;
            Setcolor();
        }

    }
    else{
		OnSearch();
	}
}
function OnToggleGrid()
{
    if(imgMaster.status == "expand")
    {
        imgMaster.status = "collapse";

		grdTournamentResult.GetGridControl().ColHidden(4) = true ;	
        imgMaster.src = "../../../system/images/iconmaximize.gif";
		imgMaster.alt="Show all column";
		
    }
    else
    {
        imgMaster.status = "expand";
        
		grdTournamentResult.GetGridControl().ColHidden(4) = false ;		
        imgMaster.src = "../../../system/images/close_popup.gif";
		imgMaster.alt="Hide unuse column";
    }
}
</script>

<body>
    <!----------------------------------------------------------------------------------------------->
    <gw:data id="dat_TeeTimeSheet" onreceive="OnDataReceive(this)"> 
    <xml> 
        <dso  type="grid" function="crm.sp_sel_jabk0130" > 
            <input bind="grdTournamentResult">                    
                <input bind="lstRankType" /> 
                <input bind="lstTourNament" /> 
                <input bind="txtLocker" /> 
                <input bind="lstReportType" />
            </input> 
            <output bind="grdTournamentResult" />
        </dso> 
    </xml> 
</gw:data>
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
													<td style="width: 5%" align="left">
														<img status="expand" id="imgMaster" alt="Show all column" src="../../../system/images/close_popup.gif"
														style="cursor: hand" onclick="OnToggleGrid()" />
													</td>
                                                    <td width="10%">
                                                        Rank Type</td>
                                                    <td width="30%">
                                                        <gw:list id="lstRankType" styles="background-color:#fffaaf" onchange="OnSearch()" />
                                                    </td>
													
                                                    <td width="7%">
                                                        Tournament</td>
                                                    <td width="34%">
                                                        <gw:list id="lstTourNament" styles="background-color:#fffaaf" onchange="OnSearch()" />
                                                    </td>
                                                    <td width="3%">
                                                        <gw:imgbtn id="btnSearch1" img="search" width="100%" img="in" text="Process" onclick="OnSearch()" />
                                                    </td>
                                                    
                                                    
                                                    <td width="3%" align="right">
                                                        <gw:imgbtn id="ibtnReport" img="printer" alt="Print" onclick="OnReport()" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="6">
                                                        <table border="0" width="100%;height: 100%">
                                                            <tr>
                                                                <td width="6%">
                                                                    Locker#</td>
                                                                <td width="7%">
                                                                    <gw:textbox id="txtLocker" onenterkey="OnSearch()" />
                                                                </td>
                                                                <td width="13%">
                                                                    Score#(3 or 6 digits)</td>
                                                                <td width="7%">
                                                                    <gw:textbox id="txtScore" maxlen="6" onenterkey="OnEnterKeyScore(this)" />
                                                                </td>
                                                                <td width="5%" >
                                                                    HDCP</td>
                                                                <td width="9%">
                                                                    <gw:textbox id="txtHandicap" maxlen="3" onenterkey="OnEnterKeyHandicap(this)" />
                                                                </td>
																<td width="7%">
																	Report</td>
																<td width="10%">
																	<gw:list id="lstReportType" styles="background-color:#fffaaf" onchange="OnSearch();" />
																</td>
                                                                <td align="right" style="width: 5%">
                                                                    <b>Register:</b></td>
                                                                <td style="width:3%">
                                                                    <gw:label id="txtRegister" />
                                                                </td>
                                                                <td align="right" style="width: 5%">
                                                                    <b>Unregister:</b></td>
                                                                <td style="width:3%">
                                                                    <gw:label id="txtUnregister" />
                                                                </td>
                                                            </tr>
                                                        </table>
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
                            <gw:grid id="grdTournamentResult" header="_PK|Rank|_Golfer_pk|Name|Birthday(YYYYMMDD)|Locker#|_Tournament|_Rank_Type|Gross|HDCP|NET|1|2|3|4|5|6|7|8|9|Out|10|11|12|13|14|15|16|17|18|In"
                                format="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0" aligns="0|3|0|0|0|0|0|0|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3"
                                defaults="||||||||||||||||||||||||||||||" editcol="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
                                widths="1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|100|100"
                                styles="width:100%; height:100%" sorting="T" autosize="T" />
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
