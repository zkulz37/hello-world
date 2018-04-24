<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Tournament Result</title>
</head>
<%  ESysLib.SetUser("crm")%>

<script>
function BodyInit()
{
  //alert("This is updating. Please comback later.");
   var data = "<%=ESysLib.SetListDataSQL("SELECT CODE, NAME FROM COMM.TCO_COMMCODE WHERE DEL_IF = 0 AND PARENT_CODE = 'TNMFMT' order by ord " ) %>";	
	lstRankType.SetDataText(data);
	grdTournamentResult.SetComboFormat(8,"SELECT CODE, NAME FROM COMM.TCO_COMMCODE WHERE DEL_IF = 0 AND PARENT_CODE = 'TNMFMT'"); //ranktype
	data = "data |1|HDCP - A|2|HDCP -B|3|HDCP -C|4|Final Result|5|Novelty|6|HDCP - Lady|7|Peoria Detail|8|Cut-Off- A|9|Cut-Off-B|10|Cut-Off-C"; 
	lstReportType.SetDataText(data);
	lstReportType.value=4;
	grdTournamentResult.GetGridControl().ColHidden(3) = true ;	
    grdTournamentResult.GetGridControl().ColHidden(32) = true ;	
	
	OnToggleGrid();
	dsoTournamentList.Call("SELECT");
}
function OnFreeNew(){
	 grdTournamentResult.AddRow()    	    
     grdTournamentResult.SetGridText(grdTournamentResult.rows -1,8,lstRankType.value);//lstRankType
     grdTournamentResult.SetGridText(grdTournamentResult.rows -1,7,lstTourNament.value);//lstTourNament
}
function OnAddnew()
{
    var path = System.RootURL + '/form/ja/bk/jabk0060_popup_checkin.aspx?p_lstRankType_pk='+lstRankType.value +'&p_tournament='+lstTourNament.value;
         var object = System.OpenModal( path ,850 , 600 ,  'resizable:yes;status:yes');
             if ( object != null )
             {
                    for( var i=0; i < object.length; i++)	  
                    {	
                            var arrTemp = object[i];
                                grdTournamentResult.AddRow()    	    
	                           grdTournamentResult.SetGridText(grdTournamentResult.rows -1,2,arrTemp[0])//member pk
                               grdTournamentResult.SetGridText(grdTournamentResult.rows -1,4 ,arrTemp[3])//name
                               grdTournamentResult.SetGridText(grdTournamentResult.rows -1,6 ,arrTemp[2])//locker
							   grdTournamentResult.SetGridText(grdTournamentResult.rows -1,10 ,arrTemp[4])//hdcp
                               grdTournamentResult.SetGridText(grdTournamentResult.rows -1,8,lstRankType.value);//4 is  lstRankType
                               grdTournamentResult.SetGridText(grdTournamentResult.rows -1,7,lstTourNament.value);//1 is  lstTourNament
							   txt_pk_tmp.text="";
	                              
                   }		            
             }
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
function OnDelete()
{
    if(confirm('Are you sure you want to delete ?'))
	{
        grdTournamentResult.DeleteRow();
        dat_TeeTimeSheet.Call();
    }
}
function OnSave()
{
   if(CheckDataIsValid()){
		dat_TeeTimeSheet.Call();
   }
}
function CheckDataIsValid(){
	for(var i=1;i<grdTournamentResult.rows;i++){
		if(grdTournamentResult.GetGridData(i,4) == ""){
			alert("Please input player name at row "+ i);
			grdTournamentResult.GetGridControl().row = i;
			return false;
		}
	}
	return true;
}
var lastMove="SCORE";
function OnEnterKeyScore(obj){
    if(obj.text.length == 0){
        txtLocker.text = "";
        lastMove="SCORE";
        txtLocker.GetControl().focus();
        return;
    }
	if(grdTournamentResult.row !='-1')
	{
		txt_pk_tmp.text=grdTournamentResult.GetGridData(grdTournamentResult.row,0)//pk
		//grdTournamentResult.SetGridText(grdTournamentResult.row,32,txt_pk_tmp.text);//pk_tmp
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
			for(var i=12;i<=30;i++){
					if(grdTournamentResult.GetGridData(row,i) == "" && x<3 && i!=21){
					   grdTournamentResult.SetGridText(row,i,score.substr(x,1)); 
					   x++;
					}
			}
		}
		else{
			for(var i=12;i<=30;i++){
					if(grdTournamentResult.GetGridData(row,i) == "" && x<6 && i!=21){
					   grdTournamentResult.SetGridText(row,i,score.substr(x,2)); 
					   x+=2;
					}
			}
		}
        //sum total out
        var total_out=0;
        for(var j=12;j<21;j++){
            if(grdTournamentResult.GetGridData(row,j) > 0){
                total_out += Number(grdTournamentResult.GetGridData(row,j));
            }
        }
        grdTournamentResult.SetGridText(row,21,total_out);
        //sum total in
        var total_in=0;
        for(j=22;j<=30;j++){
            if(grdTournamentResult.GetGridData(row,j) > 0){
                total_in += Number(grdTournamentResult.GetGridData(row,j));
            }
        }
        grdTournamentResult.SetGridText(row,31,total_in);
        var total_gross=0;
        total_gross = total_out + total_in;
        grdTournamentResult.SetGridText(row,9,total_gross);
        var net=0;
        if(grdTournamentResult.GetGridData(grdTournamentResult.row,10) != "")//hdcp not null
        {
            net= total_gross - Number(grdTournamentResult.GetGridData(grdTournamentResult.row,10));
            grdTournamentResult.SetGridText(grdTournamentResult.row,11,net);
        }
        if(grdTournamentResult.GetGridData(row,30) !="" && (row < grdTournamentResult.rows-1)){
            grdTournamentResult.GetGridControl().row = row+1;
        }
        //save
        OnSave();
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
	if(grdTournamentResult.row !='-1')
	{
		txt_pk_tmp.text=grdTournamentResult.GetGridData(grdTournamentResult.row,0)//pk
		//grdTournamentResult.SetGridText(grdTournamentResult.row,32,txt_pk_tmp.text);//pk_tmp
	}
    var handicap = obj.text;
    if(isNaN(handicap) || handicap == ""){
        alert("Score must be a number.");
        return;
    }
    obj.text="";
    
    if(grdTournamentResult.GetGridData(grdTournamentResult.row,10) == "" || grdTournamentResult.GetGridData(grdTournamentResult.row,10) == 0){
       grdTournamentResult.SetGridText(grdTournamentResult.row,10,handicap); 
       OnSave();
    }
    if(grdTournamentResult.row == (grdTournamentResult.rows-1))
    {
        return;
    }
    if(grdTournamentResult.GetGridData(grdTournamentResult.row,10) !="" && (grdTournamentResult.row < grdTournamentResult.rows-1)){
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
	if(lstReportType.value==4 && lstRankType.value==80)//Net Par
	{
	     var url = '/reports/ja/bk/jabk0060_HCDP_Result_Net_Par.aspx?p_rank_type='+ lstRankType.value + '&p_tournament=' + lstTourNament.value + '&p_locker_name=' + txtLocker.text;
	     System.OpenTargetPage( System.RootURL+url , "newform" );
	}
	if(lstReportType.value==4 && lstRankType.value==90)//Net Bogie
	{
	     var url = '/reports/ja/bk/jabk0060_HCDP_Result_Bogie_Net_Par.aspx?p_rank_type='+ lstRankType.value + '&p_tournament=' + lstTourNament.value + '&p_locker_name=' + txtLocker.text;
	     System.OpenTargetPage( System.RootURL+url , "newform" );
	}
    if(lstReportType.value==1 && lstRankType.value !=110)//hcdp type A
	{
	     var url = '/reports/ja/bk/jabk0060_HCDP_A.aspx?p_rank_type='+ lstRankType.value + '&p_tournament=' + lstTourNament.value + '&p_locker_name=' + txtLocker.text;
	     System.OpenTargetPage( System.RootURL+url , "newform" );
	}
	if(lstReportType.value==2 && lstRankType.value !=110)//hcdp type B
	{
	     var url = '/reports/ja/bk/jabk0060_HCDP_B.aspx?p_rank_type='+ lstRankType.value + '&p_tournament=' + lstTourNament.value + '&p_locker_name=' + txtLocker.text;
	    System.OpenTargetPage( System.RootURL+url , "newform" );
	}
	if(lstReportType.value==3 && lstRankType.value !=110)//hcdp type C
	{
	     var url = '/reports/ja/bk/jabk0060_HCDP_C.aspx?p_rank_type='+ lstRankType.value + '&p_tournament=' + lstTourNament.value + '&p_locker_name=' + txtLocker.text;
	    System.OpenTargetPage( System.RootURL+url , "newform" );
	}
	if(lstReportType.value==8)//hcdp cutoff type A
	{
	     var url = '/reports/ja/bk/jabk0060_HCDP_Cut_Off_A.aspx?p_rank_type='+ lstRankType.value + '&p_tournament=' + lstTourNament.value + '&p_locker_name=' + txtLocker.text;
	     System.OpenTargetPage( System.RootURL+url , "newform" );
	}
	if(lstReportType.value==9)//hcdp cutoff type B
	{
	     var url = '/reports/ja/bk/jabk0060_HCDP_Cut_Off_B.aspx?p_rank_type='+ lstRankType.value + '&p_tournament=' + lstTourNament.value + '&p_locker_name=' + txtLocker.text;
	    System.OpenTargetPage( System.RootURL+url , "newform" );
	}
	if(lstReportType.value==10)//hcdp cutoff type C
	{
	     var url = '/reports/ja/bk/jabk0060_HCDP_Cut_Off_C.aspx?p_rank_type='+ lstRankType.value + '&p_tournament=' + lstTourNament.value + '&p_locker_name=' + txtLocker.text;
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
	if(lstReportType.value==4 && lstRankType.value==140)//system 36
	{
	     /*var url = '/reports/ja/bk/jabk0060_HCDP_Result.aspx?p_rank_type='+ lstRankType.value + '&p_tournament=' + lstTourNament.value + '&p_locker_name=' + txtLocker.text;
	    System.OpenTargetPage( System.RootURL+url , "newform" );//final result*/
		var url = '/reports/ja/bk/jabk0060_HCDP_Result_System36.aspx?p_rank_type='+ lstRankType.value + '&p_tournament=' + lstTourNament.value + '&p_locker_name=' + txtLocker.text;
	    System.OpenTargetPage( System.RootURL+url , "newform" );//final result
	}
	if(lstReportType.value==4 && lstRankType.value==170)//team prize 
	{
	     /*var url = '/reports/ja/bk/rpt_jabk00060_team_prize.aspx?p_rank_type='+ lstRankType.value + '&p_tournament=' + lstTourNament.value + '&p_locker_name=' + txtLocker.text;
	    System.OpenTargetPage( System.RootURL+url , "newform" );//final result*/
		var url = '/reports/ja/bk/rpt_jabk00060_team_prize_new.aspx?p_rank_type='+ lstRankType.value + '&p_tournament=' + lstTourNament.value + '&p_locker_name=' + txtLocker.text;
	    System.OpenTargetPage( System.RootURL+url , "newform" );//final result 
	}
	if(lstReportType.value==4 && lstRankType.value==110)//fourball
	{
	    /*--chi hien 1 nguoi cua 1 group va nguoi do min(net)-- cam xoa var url = '/reports/ja/bk/rpt_jabk00060_fourball.aspx?p_rank_type='+ lstRankType.value + '&p_tournament=' + lstTourNament.value + '&p_locker_name=' + txtLocker.text;
	    System.OpenTargetPage( System.RootURL+url , "newform" );//final result cam xoa*/
		var url = '/reports/ja/bk/rpt_jabk00060_fourbal_2.aspx?p_rank_type='+ lstRankType.value + '&p_tournament=' + lstTourNament.value + '&p_locker_name=' + txtLocker.text;
	    System.OpenTargetPage( System.RootURL+url , "newform" );//final result
	}
	if(lstReportType.value==1 && lstRankType.value==110)//hcdp type A of fourball
	{
	     var url = '/reports/ja/bk/rpt_jabk00060_fourball_A.aspx?p_rank_type='+ lstRankType.value + '&p_tournament=' + lstTourNament.value + '&p_locker_name=' + txtLocker.text;
	     System.OpenTargetPage( System.RootURL+url , "newform" );
	}
	if(lstReportType.value==2 && lstRankType.value==110)//hcdp type B of fourball
	{
	     var url = '/reports/ja/bk/rpt_jabk00060_fourball_B.aspx?p_rank_type='+ lstRankType.value + '&p_tournament=' + lstTourNament.value + '&p_locker_name=' + txtLocker.text;
	     System.OpenTargetPage( System.RootURL+url , "newform" );
	}
	if(lstReportType.value==3 && lstRankType.value==110)//hcdp type C of fourball
	{
	     var url = '/reports/ja/bk/rpt_jabk00060_fourball_C.aspx?p_rank_type='+ lstRankType.value + '&p_tournament=' + lstTourNament.value + '&p_locker_name=' + txtLocker.text;
	     System.OpenTargetPage( System.RootURL+url , "newform" );
	}
	if(lstReportType.value==4 && lstRankType.value==100)//best ball
	{
	     var url = '/reports/ja/bk/rpt_jabk00060_bestball.aspx?p_rank_type='+ lstRankType.value + '&p_tournament=' + lstTourNament.value + '&p_locker_name=' + txtLocker.text;
	    System.OpenTargetPage( System.RootURL+url , "newform" );//final result
	}
	if(lstReportType.value==1 && lstRankType.value==100)//hcdp type A of bestball
	{
	     var url = '/reports/ja/bk/rpt_jabk00060_bestball_A.aspx?p_rank_type='+ lstRankType.value + '&p_tournament=' + lstTourNament.value + '&p_locker_name=' + txtLocker.text;
	     System.OpenTargetPage( System.RootURL+url , "newform" );
	}
	if(lstReportType.value==2 && lstRankType.value==100)//hcdp type B of bestball
	{
	     var url = '/reports/ja/bk/rpt_jabk00060_bestball_B.aspx?p_rank_type='+ lstRankType.value + '&p_tournament=' + lstTourNament.value + '&p_locker_name=' + txtLocker.text;
	     System.OpenTargetPage( System.RootURL+url , "newform" );
	}
	if(lstReportType.value==3 && lstRankType.value==100)//hcdp type C of bestball
	{
	     var url = '/reports/ja/bk/rpt_jabk00060_bestball_C.aspx?p_rank_type='+ lstRankType.value + '&p_tournament=' + lstTourNament.value + '&p_locker_name=' + txtLocker.text;
	     System.OpenTargetPage( System.RootURL+url , "newform" );
	}
 }
 function Setcolor()
 {
	for(var i=2;i<=grdTournamentResult.rows-1;i++){
		/*
		if(grdTournamentResult.GetGridData(i,11) == grdTournamentResult.GetGridData(i-1,11)) //Net
		{
			if(grdTournamentResult.GetGridData(i,11) !="")
			{
			    grdTournamentResult.SetCellBgColor(i-1, 0, i-1, 32,0xA9EBD7); //0xB3B3D7
			    grdTournamentResult.SetCellBgColor(i, 0, i, 32, 0xA9EBD7);
			}
		}
		*/
		//not input all 18 hole
		if(grdTournamentResult.GetGridData(i,9) > 0) //Gross
		{
			if(grdTournamentResult.GetGridData(i,12) == "" || grdTournamentResult.GetGridData(i,13) == "" || grdTournamentResult.GetGridData(i,14) == ""
			|| grdTournamentResult.GetGridData(i,15) == "" || grdTournamentResult.GetGridData(i,16) == "" || grdTournamentResult.GetGridData(i,17) == ""
			|| grdTournamentResult.GetGridData(i,18) == "" || grdTournamentResult.GetGridData(i,19) == "" || grdTournamentResult.GetGridData(i,20) == ""
			|| grdTournamentResult.GetGridData(i,22) == "" || grdTournamentResult.GetGridData(i,23) == "" || grdTournamentResult.GetGridData(i,24) == ""
			|| grdTournamentResult.GetGridData(i,25) == "" || grdTournamentResult.GetGridData(i,26) == "" || grdTournamentResult.GetGridData(i,27) == ""
			|| grdTournamentResult.GetGridData(i,28) == "" || grdTournamentResult.GetGridData(i,29) == "" || grdTournamentResult.GetGridData(i,30) == "")
			{
			     grdTournamentResult.SetCellBgColor(i, 0, i, 32, 0xabcdef);
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
           if(grdTournamentResult.GetGridData(i,0)==txt_pk_tmp.text)
		   {
				grdTournamentResult.GetGridControl().row = i;
			}
		   if(grdTournamentResult.GetGridData(i,9) > 0)
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
            //grdTournamentResult.GetGridControl().row = 1;
            Setcolor();
        }
        var fg = grdTournamentResult.GetGridControl();
		fg.MergeCells = 3;
		fg.MergeCol(1) = true;//rank
		fg.MergeCol(3) = true;//team name
		fg.MergeCol(32) = true;//total
		//grdTournamentResult.SetCellBold(0, 21, fg.rows, 21, true);
		//grdTournamentResult.SetCellBold(0, 31, fg.rows, 31, true);
    }
	else{
		OnSearch();
	}
    
}
function OnEditCell(obj){
   OnSave();
}
function CopyScorePopup()
{
	var path = System.RootURL + '/form/ja/bk/jabk0060_CopyScore.aspx?p_tournament_pk='+lstTourNament.value;;
         var object = System.OpenModal( path ,750 , 300 ,  'resizable:yes;status:yes');
}
function OnToggleGrid()
{
    if(imgMaster.status == "expand")
    {
        imgMaster.status = "collapse";

		grdTournamentResult.GetGridControl().ColHidden(5) = true ;	
        imgMaster.src = "../../../system/images/iconmaximize.gif";
		imgMaster.alt="Show all column";
		
    }
    else
    {
        imgMaster.status = "expand";
        
		grdTournamentResult.GetGridControl().ColHidden(5) = false ;		
        imgMaster.src = "../../../system/images/close_popup.gif";
		imgMaster.alt="Hide unuse column";
    }
}
function OnChangeRankType(obj){
	if(obj.value == "170" || obj.value == "100" || obj.value == "110"){
			grdTournamentResult.GetGridControl().ColHidden(3) = false;	
			grdTournamentResult.GetGridControl().ColHidden(32) = false ;	
	}
	else{
		    grdTournamentResult.GetGridControl().ColHidden(3) = true ;	
			grdTournamentResult.GetGridControl().ColHidden(32) = true ;	
	}
	OnSearch();
}
</script>

<body>
    <!----------------------------------------------------------------------------------------------->
    <gw:data id="dat_TeeTimeSheet" onreceive="OnDataReceive(this)"> 
    <xml> 
        <dso  type="grid"   parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31" function="crm.sp_sel_jabk00060" procedure="crm.sp_upd_jabk00060"> 
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
                                                    <td style="width: 3%" align="left">
														<img status="expand" id="imgMaster" alt="Show all column" src="../../../system/images/close_popup.gif"
														style="cursor: hand" onclick="OnToggleGrid()" />
													</td>
													<td width="10%">
                                                        Rank Type</td>
                                                    <td width="23%">
                                                        <gw:list id="lstRankType" styles="background-color:#fffaaf" onchange="OnChangeRankType(this)" />
                                                    </td>
													 <td width="8%" style="border: 0">
														<gw:icon id="ibtnCopyScore" alt="CopyScore" text="Copy Score" img="in" styles="width:100%"
															onclick="CopyScorePopup()" />
													</td>
                                                    <td width="7%">
                                                        Tournament</td>
                                                    <td width="27%">
                                                        <gw:list id="lstTourNament" styles="background-color:#fffaaf" onchange="OnSearch()" />
                                                    </td>
                                                    <td width="3%">
                                                        <gw:imgbtn id="btnSearch1" img="search" width="100%" img="in" text="Process" onclick="OnSearch()" />
                                                    </td>
                                                    <td width="3%">
                                                        <gw:imgbtn id="btnSearch2" img="popup" width="100%" alt="Get player from checkin" onclick="OnAddnew()" />
                                                    </td>
                                                    <td width="2%">
                                                        <gw:imgbtn id="btnSearch4" img="delete" width="100%" img="in" text="Process" onclick="OnDelete()" />
                                                    </td>
                                                    <td width="2%">
                                                        <gw:imgbtn id="btnSearch3" img="save" width="100%" img="in" text="Process" onclick="OnSave()" />
                                                    </td>
                                                    <td width="2%" align="right">
                                                        <gw:imgbtn id="ibtnReport" img="printer" alt="Print" onclick="OnReport()" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="9">
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
																<td width="3%">
																	<gw:imgbtn id="btnFreeNew" img="new" width="100%" img="in" text="Process" onclick="OnFreeNew()" />
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
                            <gw:grid id="grdTournamentResult" 
							    header="_PK|Rank|_Golfer_pk|Team Name|Name|Birthday(YYYYMMDD)|Locker#|_Tournament|_Rank_Type|Gross|HDCP|NET|1|2|3|4|5|6|7|8|9|Out|10|11|12|13|14|15|16|17|18|In|Total"
                                format="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
                                styles="width:100%; height:100%" sorting="T" autosize="T" onafteredit="OnEditCell(this)"/>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <gw:textbox id="txt_pk" style="display: none" />
	<gw:datebox id="dtDate" type="date" lang="1" style="display: none" />
	<gw:textbox id="txt_pk_tmp" style="display: none" />
</body>
</html>
